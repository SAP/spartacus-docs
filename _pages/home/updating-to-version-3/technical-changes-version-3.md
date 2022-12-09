---
title: Technical Changes in Spartacus 3.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Breaking Changes Introduced in 3.0

### Translations (i18n) changed

- fixed the typo in the key `user.register.managementInMyAccount` (previously ...`managmentInMyAccount`)
- key `checkout.checkoutReview.editShippingMethod` was removed
- key `checkout.checkoutReview.editPaymentMethod` was removed

### Default router options changed

The Angular router can be initialized with so-called `ExtraOptions` in the `forRoot` method of the `RouterModule`. For more information, see [https://angular.io/api/router/ExtraOptions](https://angular.io/api/router/ExtraOptions).

The default `ExtraOptions` have changed with 3.0. Before 3.0, Spartacus set the `anchorScrolling` and `scrollPositionRestoration` options. In Spartacus 3.0, the `scrollPositionRestoration` was removed, and the `relativeLinkResolution` and `initialNavigation` have been added. See the following table for the actual values and reasoning:

| Option                      | < 3.0 | ≥ 3.0       |
| --------------------------- | ----------- | ------------- |
| `anchorScrolling`           | `'enabled'` | `'enabled'`   |
| `scrollPositionRestoration` | `'enabled'` | (removed)     |
| `relativeLinkResolution`    | n/a         | `'corrected'` |
| `initialNavigation`         | n/a         | `'enabled'`   |

The enabled `scrollPositionRestoration` was causing a bad experience in most cases, as it would scroll the page to the top on each route change. This is unexpected in a single page experience.

The corrected `relativeLinkResolution` is used to opt-in to [a fix](https://github.com/angular/angular/issues/37355) that was added in Angular. This will become the default from Angular 11 onwards.

The enabled `initialNavigation` provides a better experience with server-side rendering, which starts initial navigation before the root component is created and blocks bootstrap until the initial navigation is complete. For more information, see the [Angular documentation](https://angular.io/api/router/InitialNavigation).

The `RouterModule.forRoot()` method can actually be called only *once* in an Angular application. This makes the default options rather opinionated, which is why the default configurations are carefully selected in Spartacus. The options that have been added or removed can be provided in your custom application with the Angular `ROUTER_CONFIGURATION` injection token. The following is an example:

```typescript
providers: [
  {
    provide: ROUTER_CONFIGURATION,
    useValue: {
      scrollPositionRestoration: 'enabled',
    },
  },
];
```

There is no automation (schematics) planned for this change.

### Page Layout

With version 2.1, we started to add the page layout-based style class to the root element of the application (`cx-storefront`). This was done in addition to the style class being added by the `PageLayoutComponent`. The style class on the `PageLayoutComponent` was considered to be too limited, as it would not affect selectors outside the page template component.

The implementation of the page layout-based style class has moved from the `PageLayoutComponent` to the `PageTemplateDirective`. This results in a cleaner `PageLayoutComponent` with a constructor that no longer requires the lower level `Renderer2` service and `ElementRef`. The constructor reduces to the following signature:

```ts
constructor(protected pageLayoutService: PageLayoutService) {}
```

We've also made the `PageLayoutService` a *protected* argument, so that it is extensible.

There is no automation (schematics) planned to migrate constructors automatically.

### Static CMS structure config changes

The `default-header-config` and `default-cms-content-config` have been removed. To create CMS content, use the `defaultCmsContentProviders` instead.

### OCC prefix

The default value for the `backend.occ.prefix` configuration option was changed from `/rest/v2/` to `/occ/v2/`.

### Storefront config

The new config `SeoConfig` is imported.

### JSON-LD schemas

To continue using JSON-LD schemas in Spartacus, or to start using JSON-LD schemas in Spartacus, you need to import the `JsonLdBuilderModule` to your application.

### ContentPageMetaResolver

The `ContentPageMetaResolver` has a new required constructor dependency `RoutingPageMetaResolver`.

### LoginFormComponent

It is no longer the responsibility of the `LoginFormComponent` to redirect to the anticipated page (it no longer calls the method `AuthRedirectService.redirect`). Now the redirecting logic is placed inside the core `AuthService` to support more OAuth flows.

The `LoginFormComponent` no longer has the `loginAsGuest` and `sub` properties, and the `ngOnDestroy` method was removed as well.

### HttpClientModule is not imported in feature libraries

In most cases, the `HttpClientModule` should only be imported in the root app module, because importing it in lazy-loaded modules can
cause unexpected side effects regarding the visibility of `HTTP_INTERCEPTORS`, and so on. To fix this, we removed all `HttpClientModule` imports from all of our feature libraries and moved them to recipes.

There is no automation (schematics) planned for this change.

### SSR engine optimizations

The `NgExpressEngineDecorator` now adds SSR optimization logic on top of the universal engine by default.

The `NgExpressEngineDecorator` was moved from `@spartacus/core` to `@spartacus/setup/ssr`. Also, the `NgExpressEngineDecorator.get()` method now accepts an additional second parameter to fine-tune SSR optimizations. Passing `null` there will turn off optimizations by removing the optimization layer completely (which brings back default 2.x behavior).

### Store finder functionality was moved to a new library

The store finder logic from `@spartacus/core` and the store finder components from `@spartacus/storefront` were moved to respective entry points in the `@spartacus/storefinder` library. Store finder translations (`storeFinderTranslations`) and translation chunks (`storeFinderTranslationChunksConfig`) were moved to `@spartacus/storefinder/assets`.

Store finder functionality is now also lazy-loadable out of the box.

### StockNotificationComponent

The `StockNotificationComponent` has a new required `UserIdService` dependency, but no longer depends on `AuthService`.

### CmsComponentsService

The return type for the `CmsComponentsService.getChildRoutes` method has changed from `Route[]` to `CmsComponentChildRoutesConfig`.

### Config cmsComponents

The `childRoutes` property of the `cmsComponents` config changed type from `Route[]` to `Route[] | CmsComponentChildRoutesConfig`.

### PageMetaService lazy-loading related changes

- The return type for the `PageMetaService.getMeta` method changed from `Observable<PageMeta>` to `Observable<PageMeta | null>` so it can take into account page meta resolvers from lazy-loaded features.
- The return type for the `PageMetaService.getMetaResolver` protected method changed from `PageMateResolver` to `Observable<PageMetaResolver>` so it can take into account page meta resolvers from lazy-loaded features.
- The constructor for `PageMetaService` now uses the `UnifiedInjector` instead of injecting the `PageMetaResolver` token directly.

### ConverterService lazy-loading related changes

The constructor for `ConverterService` now uses the `UnifiedInjector` instead of the standard `Injector`.

### Payload for constructor of PlaceOrder class from Checkout actions requires an additional property

The `Checkout.action` constructor payload now needs an additional `termsChecked` property.

### PlaceOrderComponent

- The `placeOrderSubscription` property was removed. There is no replacement.
- The component has the following new, required constructor dependencies: `CheckoutReplenishmentFormService`, `LaunchDialogService` and `ViewContainerRef`.

### Property renamed in SearchConfig interface

The `sortCode` property in the `SearchConfig` interface was renamed to `sort`.

### Changes in CheckoutStepsState interface

- The `CheckoutStepsState` interface has a new, required property: `poNumber: { po: string; costCenter: string; };`
- The type for the `orderDetails` property was changed from `Order` to `Order | ReplenishmentOrder`

### Changes in CheckoutState interface

The `CheckoutState` interface has the following new, required properties:

- `paymentTypes: PaymentTypesState;`
- `orderType: OrderTypesState;`
  
### OutletRefDirective unregisters template on destroy

The directive's template in unregistered from the outlet on directive destroy.

Before v3.0, when an instance of `OutletRefDirective` was destroyed (removed from the DOM), its template remained registered for the outlet, which could cause the same template to be rendered multiple times if the same `[cxOutletRef]` was created again later on. This has now been fixed.

### CartItemComponent lost members

The `@Output()` `view` and `viewItem()` members of the `CartItemComponent` have been removed. Use the `[cxModal]` directive instead to close modals on link click.

### CartItemListComponent

There can be more than one cart entry with the same product code. So now they are referenced by the `entryNumber` property instead of the product code in the `CartItemListComponent`.

### AddToCartComponent

The `AddToCartComponent` lost the following members:

- `increment` - use the new `numberOfEntriesBeforeAdd` instead
- `cartEntry$` - use `activeCartService.getLastEntry(productCode)` instead

### Auth module refactor

The `@spartacus/core` library has a new dependency on the `angular-oauth2-oidc` library. It is used to handle OAuth login and logout flows in Spartacus.

#### Store

- `AuthSelectors` were removed. Selectors related to the client token were moved under `ClientAuthSelectors`. The user token is no longer stored in NgRx Store. To get the token, use the `AuthStorageService.getToken` method.
- `StateWithAuth` was removed. The state related to the client token was moved to `StateWithClientAuth`. Data related to the user token are stored in `AuthStorageService` and `UserIdService`.
- `AuthState` was removed. The state related to the client token was moved to `ClientAuthState`. Data related to the user token are stored in `AuthStorageService` and `UserIdService`.
- `UserTokenState` was removed. Data related to the user token are no longer stored in NgRx Store. The user token is stored in `AuthStorageService` and the user id is stored in `UserIdService`.
- `AUTH_FEATURE` was removed. The client token state is under the key from the `CLIENT_AUTH_FEATURE` variable.
- The value of the `CLIENT_TOKEN_DATA` variable changed to `[Client auth] Client Token Data`. Previously, it was `[Auth] Client Token Data`.
- `AuthActions` now only contains `Login` and `Logout` action classes and `LOGIN` and `LOGOUT` variables with action type. Actions related to the client token (`LoadClientToken...`) are now available under `ClientAuthActions` export. The `LOGOUT_CUSTOMER_SUPPORT_AGENT` constant is available in `AsmActions` export. Actions related to the user token were removed (`LOAD_USER_TOKEN`, `LOAD_USER_TOKEN_FAIL`, `LOAD_USER_TOKEN_SUCCESS`, `REFRESH_USER_TOKEN`, `REFRESH_USER_TOKEN_FAIL`, `REFRESH_USER_TOKEN_SUCCESS`, `REVOKE_USER_TOKEN`, `REVOKE_USER_TOKEN_FAIL`, `REVOKE_USER_TOKEN_SUCCESS`, `LoadUserToken`, `LoadUserTokenFail`, `LoadUserTokenSuccess`, `RefreshUserToken`, `RefreshUserTokenSuccess`, `RefreshUserTokenFail`, `RevokeUserToken`, `RevokeUserTokenSuccess` and `RevokeUserTokenFail`). Instead, initialize the user token load, and refresh or revoke with methods exposed in `AuthService` and `OAuthLibWrapperService`.

#### Models

- The `UserToken` interface was replaced with the `AuthToken` interface. The new interface contains different properties from the previous interface in order to match the requirements of the `angular-oauth2-oidc` library.
- The `AuthenticationToken` interface was removed. Use `AuthToken` or `ClientToken` directly.
- The `Occ.UserGroupList` interface was removed.
- The `Occ.UserSignUp` interface was removed.

#### Guards

- `NotAuthGuard` now returns `Observable<UrlTree>` as the homepage for logged-in users, instead of invoking a redirect. The constructor also changed for this guard. The `RoutingService` is no longer needed, but `SemanticPathService` and `Router` are now required.
- `AuthGuard` now returns `Observable<UrlTree>` as the login page for anonymous users, instead of invoking a redirect. The constructor also changed for this guard. The `RoutingService` is no longer needed, but `SemanticPathService` is now required.

#### Services

- `AuthRedirectService` now requires `AuthRedirectStorageService`. Please ensure to provide it. It is a replacement for the `redirectUrl` private variable.
- `AuthService` now requires `UserIdService`, `OAuthLibWrapperService`, `AuthStorageService`, `AuthRedirectService` and `RoutingService`.
- `AuthService.authorize` was renamed to `loginWithCredentials`. It returns a Promise that resolves after the login procedure completes. Instead of dispatching an action, the method now invokes the login method from the OAuth library and sets the correct userId, dispatches the `Login` action, and redirects to the previously-visited page.
- `AuthService.getOccUserId` was removed from `AuthService`. Use the `UserIdService.getUserId` method instead. It is the direct replacement.
- `AuthService.invokeWithUserId` was moved to `UserIdService`. It is available under the same name.
- `AuthService.getUserToken` was removed. To check if a user is logged in, use `isUserLoggedIn`, and to get the user id, use `UserIdService.getUserId`. If you need access to tokens, use `AuthStorageService.getToken`.
- `AuthService.refreshUserToken` was moved and renamed to `OAuthLibWrapperService.refreshToken`. The behavior changed as well. It not only dispatches actions, but performs a complete token refresh procedure from the OAuth library.
- `AuthService.authorizeWithToken` was removed. Instead, you can create an object of the shape `AuthToken` and pass it to `AuthStorageService.setToken`.
- The `AuthService.logout` method changed behavior to redirect to the `logout` page. Then the method `AuthService.coreLogout` is dispatched and performs operations previously done by the `logout` method (Logout action dispatch, clearing local state, revoking tokens).
- `AuthService.getClientToken`, `AuthService.refreshClientToken` and `AuthService.isClientTokenLoaded` were moved to `ClientTokenService`.

#### Config

- `AuthConfig` no longer extends `OccConfig`.
- The `login` and `revoke` endpoints were removed from `OccConfig`. The `login` endpoint is now available under the `tokenEndpoint` property in `AuthConfig`. The `revoke` endpoint is available under the `revokeEndpoint` property in `AuthConfig`.
- The `storageSync` configuration for the `auth` branch in NgRx Store was removed. The state of the token and userId is now synchronized with `AuthStatePersistenceService`. Override this service if you want to sync more properties to `localStorage` (for example, `refresh_token`).
- The `storageSync` configuration for the `anonymous-consents` branch in NgRx Store was removed. The state is now synchronized with `AnonymousConsentsStatePersistenceService`. Override this service if you want to sync more or less properties to `localStorage`.

### KymaModule

The `KymaModule` was removed with all its code. We expose the same functionality through configuration of auth.

To fetch the `OpenId` token along with the access token in Resource Owner Password Flow, you have to use following configuration:

```ts
authentication: {
  client_id: 'client4kyma',
  client_secret: 'secret',
  OAuthLibConfig: {
    responseType: 'id_token',
    scope: 'openid',
    customTokenParameters: ['token_type', 'id_token'],
  }
}
```

Then you can access the `OpenId` token with the `OAuthLibWrapperService.getIdToken` method. For more options related to the `OpenId` token, look into the `angular-oauth2-oidc` [library documentation](https://github.com/manfredsteyer/angular-oauth2-oidc).

### ASM module refactor

- `getCustomerSupportAgentTokenState`, `getCustomerSupportAgentToken` and `getCustomerSupportAgentTokenLoading` were removed from `AsmSelectors`. To get a token, use `AuthStorageService.getToken` and `AsmAuthStorageService.getTokenTarget` to check if it belongs to the CS agent.
- Effects in `AsmModule` now use `normalizeHttpError` instead of `makeErrorSerializable` for error transformation.
- The `storageSync` configuration for the `asm` branch in NgRx Store was removed. The state of the ASM UI and tokens is now synchronized with `AsmStatePersistenceService`.
- The `CSAGENT_TOKEN_DATA` variable was removed.
- The `AsmState.csagentToken` was removed. The token is now stored in `AuthStorageService`. Check `AsmAuthStorageService.getTokenTarget` to validate if the token belongs to the CS agent.
- `AsmActions` no longer contains actions related to the customer agent token (`LoadCustomerSupportAgentToken`, `LoadCustomerSupportAgentTokenFail`, `LoadCustomerSupportAgentTokenSuccess`). Instead, interact directly with `CsAgentAuthService`.
- The `CustomerSupportAgentTokenInterceptor` interceptor was removed. Token and error handling for CS agent requests are now handled by `AuthInterceptor` and `AsmAuthHttpHeaderService`.

#### AsmAuthService

The `AsmAuthService` was renamed to `CsAgentAuthService`. This service is now responsible for making the `AuthService` aware of ASM, and adjusts it for CS agent support.

- `AsmAuthService.authorizeCustomerSupportAgent` was moved to `CsAgentAuthService`. It now performs full login flow for the CS agent and resolves when it completes.
- `AsmAuthService.startCustomerEmulationSession` was moved to `CsAgentAuthService`. Behavior has not changed.
- `AsmAuthService.isCustomerEmulationToken` was removed. To check the token, use `AuthStorageService.getToken`, and to check if it belongs to the CS agent, use `AsmAuthStorageService.getTokenTarget`.
- `AsmAuthService.getCustomerSupportAgentToken` was removed. To check the token, use `AuthStorageService.getToken` and to check if it belongs to the CS agent, use `AsmAuthStorageService.getTokenTarget`.
- `AsmAuthService.getCustomerSupportAgentTokenLoading` was moved to `CsAgentAuthService`.

  **Note:** It is not implemented there yet.
- `AsmAuthService.logoutCustomerSupportAgent` was moved to `CsAgentAuthService`. It performs the logout procedure for the CS agent and resolves when it completes.

### CDC library

- `CdcUserTokenEffects` now uses `normalizeHttpError` for error serialization.
- The `CdcUserTokenEffects.loadCdcUserToken$` effect now calls `CdcAuthService.loginWithToken` instead of dispatching `AuthActions.LoadUserTokenSuccess` action.
- `CdcAuthService` no longer extends `AuthService`.
- `CdcAuthService` has the following new, required dependencies: `AuthStorageService`, `UserIdService`, `GlobalMessageService` and `AuthRedirectService` need to provided.
- The `CdcAuthService.authorizeWithCustomCdcFlow` method was renamed to `loginWithCustomCdcFlow`.
- The `CdcAuthService.logout` method was removed. Now CDC hooks into the logout process by providing `CdcLogoutGuard` as `LogoutGuard`.
- `CdcJsService` now requires `AuthService` because `CdcAuthService` no longer extends it. `AuthService` should be passed after `CdcAuthService`. `CdcAuthService` is available in the service under `cdcAuth` and `AuthService` is available under the `auth` property. Additionally, `GlobalMessageService` and `AuthRedirectService` are not longer required. Note that we do not provide automatic migration for that constructor change.

### OrderDetailHeadlineComponent

The `OrderDetailHeadlineComponent` was removed.

### OrderDetailShippingComponent

The following functions have been removed from the `OrderDetailShippingComponent` component:

- `getAddressCardContent()`
- `getBillingAddressCardContent()`
- `getPaymentCardContent()`
- `getShippingMethodCardContent()`

You can use the `OrderOverviewComponent` instead.

### OrderConfirmationOverviewComponent

The following functions have been removed from the `OrderConfirmationOverviewComponent` component:

- `getAddressCardContent()`
- `getDeliveryModeCardContent()`
- `getPaymentInfoCardContent()`
- `getBillingAddressCardContent()`

The return type for `order$` was changed from `Observable<Order>` to `Observable<any>`.

### BaseSiteService

The `BaseSiteService` type is changed from `BaseSiteService implements SiteContext<string>` to `BaseSiteService implements SiteContext<BaseSite>`.

The return type of the `getAll()` function is changed from `getAll(): Observable<string[]>` to `getAll(): Observable<BaseSite[]>`.

The return type of the `setActive(baseSite: string)` function is changed from `setActive(baseSite: string): Subscription` to `setActive(baseSite: string): void`.

### ConfigInitializerService constructor

An additional parameter was added to the `ConfigInitializerService` constructor. Before 3.0, it was the following:

```ts
  constructor(
    @Inject(Config) protected config: any,
    @Optional()
    @Inject(CONFIG_INITIALIZER_FORROOT_GUARD)
    protected initializerGuard
  ) {}
```

In Spartacus 3.0, it is the following:

```ts
  constructor(
    @Inject(Config) protected config: any,
    @Optional()
    @Inject(CONFIG_INITIALIZER_FORROOT_GUARD)
    protected initializerGuard,
    @Inject(RootConfig) protected rootConfig: any
```

### CmsComponentsService constructor

An additional parameter was added to the `CmsComponentsService` constructor. Before 3.0, it was the following:

```ts
  constructor(
    protected config: CmsConfig,
    @Inject(PLATFORM_ID) protected platformId: Object
  ) {}
```

In Spartacus 3.0, it is the following:

```ts
  constructor(
    protected config: CmsConfig,
    @Inject(PLATFORM_ID) protected platformId: Object,
    protected featureModules?: FeatureModulesService
  ) {}
```

#### The configurationFactory was removed

The configuration merging logic now uses separate tokens for the default configuration and the user configuration.

### CheckoutProgressMobileBottomComponent

- The `routerState$` property was removed. This logic is now handled by `checkoutStepService`.
- The `activeStepUrl` property was removed. This logic is now handled by `checkoutStepService`.
- The `steps` property was removed. Use `steps$` instead.

### CheckoutProgressMobileTopComponent

- The `routerState$` property was removed. This logic is now handled by `checkoutStepService`.
- The `activeStepUrl` property was removed. This logic is now handled by `checkoutStepService`.
- The `steps` property was removed. Use `steps$` instead.

### CheckoutProgressComponent

- The `routerState$` property was removed. This logic is now handled by `checkoutStepService`.
- The `activeStepUrl` property was removed. This logic is now handled by `checkoutStepService`.
- The `steps` property was removed. Use `steps$` instead.

### DeliveryModeComponent

- The `checkoutStepUrlNext` property was removed. This logic is now handled by `checkoutStepService`.
- The `checkoutStepUrlPrevious` property was removed. This logic is now handled by `checkoutStepService`.
- The `currentDeliveryModeId` property was removed. The current delivery mode selection is stored in a form called "mode" in the "deliveryModeId" input field. Also, you can use `CheckoutDeliveryService.getSelectedDeliveryMode()` to access the selected delivery mode in the checkout state.
- The `supportedDeliveryModes$` property was modified. This observable will now only emit when the data in the list of supported delivery modes changes.
- The `next()` function does not update the delivery mode on the cart because the delivery mode is already updated on the cart when the component initializes, and when a choice is made in the delivery mode form.

### PaymentMethodComponent

- The `checkoutStepUrlNext` property was removed. This logic is now handled by `checkoutStepService`.
- The `checkoutStepUrlPrevious` property was removed. This logic is now handled by `checkoutStepService`.
- The `goNext` method was renamed to `next`.
- The `goPrevious` method was renamed to `back`.

### ShippingAddressComponent

- The `existingAddresses$` property was removed.
- The `newAddressFormManuallyOpened` property was renamed to `addressFormOpened`.
- The `goNext` method was renamed to `next`.
- The `goPrevious` method was renamed to `back`.
- The `ShippingAddressComponent` now implements `OnDestroy`.

### CheckoutAuthGuard

The `canActivate` method now returns the type `Observable<boolean | UrlTree`.

### CheckoutConfigService

- The `steps` property was removed. Use `checkoutStepService` instead.
- The `checkoutStepService` method was removed. Use the `checkoutStepRoute` method in `checkoutStepService` instead.
- The `getFirstCheckoutStepRoute` method was removed. Use the `getFirstCheckoutStepRoute` method in `checkoutStepService` instead.
- The `getFirstCheckoutStepRoute` method was removed. Use the `getFirstCheckoutStepRoute` method in `checkoutStepService` instead.
- The `getNextCheckoutStepUrl` method was removed. Use the `getNextCheckoutStepUrl` method in `checkoutStepService` instead.
- The `getPreviousCheckoutStepUrl` method was removed. Use the `getPreviousCheckoutStepUrl` method in `checkoutStepService` instead.
- The `getCurrentStepIndex` method was removed. Use the `getCurrentStepIndex` method in `checkoutStepService` instead.
- The `CheckoutConfigService` no longer uses `RoutingConfigService`.

### The placeOrder method for CheckoutAdapter, OccCheckoutAdapter and CheckoutConnector

The `placeOrder` method for `CheckoutAdapter`, `OccCheckoutAdapter` and `CheckoutConnector` now has a new, third, required argument: `termsChecked: boolean`.

### BreakpointService

- The public `window()` getter method was removed. Instead, you can directly reference the `windowRef`.
- The protected `getClosest` method was removed. Instead, use the `getBreakpoint` method.
- The `_breakpoints` property was removed.
- The public `breakpoint$` getter was removed. Instead, use the `breakpoint$` property.
- The `BreakpointService` has a new, required `platform` dependency.

### ProtectedRoutesGuard

The return type of the `ProtectedRoutesGuard.canActivate` method changed from `Observable<boolean>` to `Observable<boolean | UrlTree>`.

### ItemCounterComponent

The `ItemCounterComponent` component now implements `OnInit` and `OnDestroy`.

### ViewComponent

The protected `splitViewCount` getter method was removed.

### UpdateEmailComponent

The return type of the `onSuccess` method was changed from `void` to `Promise<void>` in order to wait for the logout to complete before updating the email.

### StorefrontComponent

The param type of the `collapseMenuIfClickOutside` method was changed from `MouseEvent` to `any`. The behavior has also been modified to only trigger when the header element is passed to the function.

### StarRatingComponent

- The `StarRatingComponent` uses `HostBinding` to bind to CSS custom properties (available since angular 9), which is why we no longer need the `ElementRef` and `Renderer2` in the constructor. There is an automated constructor migration added for the 3.0 release.
- `ngOnInit` is no longer used.
- The `setRate` no longer requires a second argument (`force`).
- The `setRateOnEvent()` method is replaced by reusing the `setRate()` (which also fixes a bug). We now bind `keydown.space` directly from the view. The more generic `keydown` output binding was removed.

### CartNotEmptyGuard

- The return type of the `canActivate` method was changed from `Observable<boolean>` to `Observable<boolean | UrlTree>` to support OAuth flows.
- `SemanticPathService` is a new, required constructor dependency.
- `Router` is new, required constructor dependency.
- `CartNotEmptyGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router` and `SemanticPathService`.

### NotCheckoutAuthGuard

The return type of the `canActivate` method was changed from `Observable<boolean>` to `Observable<boolean | UrlTree>` to support OAuth flows.

### ProductVariantGuard

- The `canActivate` method now requires a parameter of type `ActivatedRouteSnapshot`.

### LogoutGuard

- The return type of the `canActivate` method was changed from `Observable<boolean>` to `Observable<boolean | UrlTree>` to support OAuth flows.
- The return type of the `logout` method was changed from `void` to `Promise<any>` to support OAuth flows.
- The `redirect` method was removed. Use `getRedirectUrl` instead.

### CurrentProductService

The `getProduct` method now only emits distinct products.

### MultiCartStatePersistenceService

The `sync` method was renamed to `initSync`.

### ProductReferenceService

The `get` method was removed. Use the `getProductReferences` and `loadProductReferences` methods instead.

### LanguageService

The return type of the `setActive` method was changed from `Subscription` to `void`.

### CurrencyService

The return type of the `setActive` method was changed from `Subscription` to `void`.

### OccCmsComponentAdapter

The OCC CMS component API in SAP Commerce Cloud before version 1905 was using a POST method. This was changed in 1905 to use a GET method instead. Spartacus has supported both version from version 1.0 by using a `legacy` flag to distinguish this back end API behavior. With the release of Spartacus 3.0, we maintain the support for the pre-1905 CMS component API, but the implementation was moved to a separate adapter (`LegacyOccCmsComponentAdapter`). With that change, we are also dropping the `legacy` flag in the OCC configuration.

### UserState

The interface for the `UserState` NgRx state now has the following new, required properties: `replenishmentOrders`, `replenishmentOrder` and `costCenters`.

### CloseAccountModalComponent

The `userToken$` property of the `CloseAccountModalComponent` was replaced with `isLoggedIn$` of type `Observable<boolean>`.

### BaseSiteState

The `BaseSiteState` interface has now a new, required `entities: BaseSiteEntities` property.

### UserService

The `loadOrderList` method of the `UserService` also loads replenishment orders when the URL contains a replenishment code.

### UserOrderService

The `getTitles` method of the `UserOrderService` will load titles when it is empty.

### Checkout selectors

The `MemoizedSelector` return type of the `getCheckoutOrderDetails` selector was changed from `Order` to `Order | ReplenishmentOrder`.

### ProductListComponentService

- The `sub` property was removed from `ProductListComponentService`. It is no longer used.
- The `setQuery` method was removed from `ProductListComponentService`. It is no longer used.
- The `viewPage` method was removed from `ProductListComponentService`. It is no longer used.

### ProductCarouselService

The `getProductReferences()` function was removed.

### CheckoutService

- The `placeOrder` method of the `CheckoutService` now requires a `termsChecked` parameter.
- The return type of the `getOrderDetails` method was changed from `Observable<Order>` to `Observable<Order | ReplenishmentOrder>`.

### AnonymousConsentTemplatesAdapter

The `loadAnonymousConsents` method of `AnonymousConsentTemplatesAdapter` is no longer optional.

### AnonymousConsentTemplatesConnector

The return type of the `loadAnonymousConsents` method of the `AnonymousConsentTemplatesConnector` was changed from `Observable<AnonymousConsent[] | null>` to `Observable<AnonymousConsent[]>`.

### SplitViewComponent

The `subscription` property of the `SplitViewComponent` is no longer protected. It is private now.

### Error payload of LOAD FAIL actions has changed in `@spartacus/core`

It now has a consistent shape of `HttpErrorModel` or is `undefined`.

## Automated Migrations for Version 3.0

- `CheckoutProgressMobileBottomComponent` no longer uses `CheckoutConfig`, `RoutingService` and `RoutingConfigService`. The use of these services was replaced with the corresponding methods from the `CheckoutStepService`. This service needs to be provided to the `CheckoutProgressMobileBottomComponent`.
- `CheckoutAuthGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router` and `SemanticPathService`. The additional `UserService` and `GlobalMessageService` services also need to be provided to `CheckoutAuthGuard`.
- `CheckoutProgressMobileTopComponent` no longer uses `CheckoutConfig`, `RoutingService` and `RoutingConfigService`. The use of these services was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `CheckoutProgressMobileTopComponent`.
- `CheckoutProgressComponent` no longer uses `CheckoutConfig`, `RoutingService` and `RoutingConfigService`. The use of these services was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `CheckoutProgressComponent`.
- `DeliveryModeSetGuard` no longer uses `CheckoutConfigService`. The use of this service was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `DeliveryModeSetGuard`.
- `DeliveryModeComponent` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `DeliveryModeComponent`.
- `LoginFormComponent` no longer uses `ActivatedRoute`, `CheckoutConfigService` and `AuthRedirectService`. The logic that used these services was moved to a different component.
- `OrderDetailShippingComponent` no longer uses `TranslationService`. The logic that used this service was moved to `OrderDetailShippingComponent`.
- `PaymentDetailsSetGuard` no longer uses `CheckoutConfigService`. The use of this service was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `PaymentDetailsSetGuard`.
- `PaymentMethodComponent` no longer uses `CheckoutConfigService` and `RoutingService`. The use of these services was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `PaymentMethodComponent`.
- `ReviewSubmitComponent` no longer uses `CheckoutConfigService`. The use of this service was replaced with the corresponding methods from `CheckoutStepService`. In addition, `PaymentTypeService`, `CheckoutCostCenterService` and `UserCostCenterService` need to be provided to `ReviewSubmitComponent`.
- `ShippingAddressSetGuard` no longer uses `CheckoutConfigService`. The use of this service was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `ShippingAddressSetGuard`.
- `ShippingAddressComponent` no longer uses `CheckoutConfigService` and `RoutingService`. The use of these services was replaced with the corresponding methods from `CheckoutStepService`. This service needs to be provided to `ShippingAddressComponent`.
- `MultiCartService` now requires the additional provider `UserIdService`.
- `PageSlotComponent` no longer uses `CmsComponentsService`. The use of this service was replaced with the `PageSlotService`.
- `ForbiddenHandler` now uses `GlobalMessageService`, `AuthService`, and `OccEndpointsService`.
- `CheckoutPaymentService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `CheckoutService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `CustomerCouponService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `OrderReturnRequestService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `UserAddressService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `UserConsentService` now also requires `UserIdService`.
- `UserInterestsService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `UserNotificationPreferenceService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `UserOrderService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`. It now also requires `RoutingService`.
- `UserPaymentService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `UserService` no longer uses `AuthService`. The use of this service was replaced with the corresponding methods from `UserIdService`.
- `ActiveCartService` no longer uses `AuthService`. The use of this service was replaced with the `UserIdService`.
- `CartVoucherService` no longer uses `AuthService`. The use of this service was replaced with the `UserIdService`.
- `SelectiveCartService` no longer uses `AuthService`. The use of this service was replaced with the `UserIdService`.
- `WishListService` no longer uses `AuthService`. The use of this service was replaced with the `UserIdService`.
- `CheckoutDeliveryService` no longer uses `AuthService`. The use of this service was replaced with the `UserIdService`.
- `UnauthorizedErrorHandler` was removed.
- `StarRatingComponent` no longer uses `ElementRef` and `Renderer2`.
- `ProductCarouselService` no longer uses `ProductReferenceService`.
- `NotCheckoutAuthGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `SemanticPathService` and `Router`.
- `StoreFinderSearchConfig` was removed. `SearchConfig` should be used instead.
- `ForgotPasswordComponent` now also requires `AuthConfigService`.
- `OrderHistoryComponent` now also requires `UserReplenishmentOrderService`.
- `OrderReturnGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router` and `SemanticPathService`.
- `OrderCancellationGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router` and `SemanticPathService`.
- `OutletRefDirective` no longer uses `FeatureConfigService`.
- `OutletService` no longer uses `FeatureConfigService`.
- `RoutingService` now also requires `RoutingParamsService`.
- `TOKEN_REVOCATION_HEADER` was removed.
- `JsonLdScriptFactory` now also requires `SeoConfig`.
- `LogoutGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router`.
- `ProductVariantGuard` no longer uses `RoutingService`. The use of this service was replaced with the corresponding methods from `Router` and `SemanticPathService`.
- `FeatureModulesService` no longer has the `getInjectors` method.
- `CmsComponentsService` no longer has the `getInjectors` method.
- `ViewComponent` now also requires `ChangeDetectorRef`.
- `SplitViewDeactivateGuard` was removed.
- `FeatureModulesService` no longer uses `Compiler`. The newly-added `getModule` method does not need it anymore.
- `FeatureModulesService` no longer uses `Injector`. The newly-added `getModule` method does not need it anymore.
- `FeatureModulesService` now uses `LazyModulesService`.
- `JsonLdProductReviewBuilder` now uses `SeoConfig`.
- `RegisterComponent` now uses `AuthConfigService`.
- `SplitViewComponent` now also requires `BreakpointService` and `ElementRef`.
- `CheckoutGuard` now also requires `CheckoutStepService`.
- `OrderConfirmationOverviewComponent` no longer uses `TranslationService`. The logic using this service was moved to the `OrderOverviewComponent`.
