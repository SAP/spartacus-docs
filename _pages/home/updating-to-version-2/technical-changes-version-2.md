---
title: Technical Changes in Spartacus 2.0
---

## Breaking changes introduced in 2.0

### Cms Page Guard has less dependencies and all are public

Before 2.0 some dependencies of the `CmsPageGuard` were not public, so the guard was not easily customizable. Now most of the logic (and dependencies) are moved to a new service `CmsPageGuardService` and its dependencies are made public.

### Config Validation mechanism is now a separate module

Previously config validator logic was part of `ConfigModule`. If you are not using `StorefrontFoundationModule` or any of its descendants, it's required to import `ConfigValidatorModule.forRoot()` in order to make config validators run.

### Selectors removed from @spartacus/core

`ProductSelectors.getSelectedProductsFactory` was removed as it was outdated.

### Factories removed from @spartacus/storefront public API

`pwaConfigurationFactory`, `pwaFactory`, `getStructuredDataFactory` and `skipLinkFactory` were removed from storefront library public API.

### Bad Request handler

The `BadRequestHandler` handles 400 errors. Previously it was handling *not found* errors for OCC CMS pages, as these weren't returned as 404 errors. This was done in a generic way, by handling *all other errors*. Since the 1905 release of SAP Commerce, the OCC CMS returns a 404 error in case of a not found page. Therefor, we removed this special handling in the `BadRequestHandler`. This might affect custom implementations who relied on this behavior. In that case it is recommended to throw 404 errors from the backend you're using, or customize the `BadRequestHandler`.

### UrlMatcherFactoryService was renamed to UrlMatcherService and its methods were renamed

The service `UrlMatcherFactoryService` was renamed to `UrlMatcherService` and its methods were renamed as follows:
|  UrlMatcherFactoryService (removed) | UrlMatcherService (new counterpart) |
|-------|-----|
| getFalsyUrlMatcher | getFalsy |
| getMultiplePathsUrlMatcher | getFromPaths |
| getPathUrlMatcher | getFromPath |
| getOppositeUrlMatcher | getOpposite |
| getGlobUrlMatcher | getFromGlob |

### New way to opt-out from suffix routes for PDP and PLP

Before 2.0 the suffix routes (added for backward compatibility with accelerators) `**/p/:productCode` and `**/c/:categoryCode` were implemented in Spartacus using separate Angular `Routes` objects. To opt-out from then, it was needed to dismantle `ProductDetailsPageModule` (or relatively `ProductListingPageModule`) and reassemble again without defining suffix routes.

Now the separate objects for suffix routes were dropped they suffix mechanism in now implemented in the original `product` and `category` routes, thanks to the support of configurable Angular `UrlMatcher`s that arrived in Spartacus 2.0.

So the default config of Spartacus for the route `product` contains now a property `matchers` with an array containing `PRODUCT_DETAILS_URL_MATCHER` (relevantly `category` route's config has `PRODUCT_LISTING_URL_MATCHER` in the `matchers` array by default). Those matchers match both the `paths` from the routing config as well as the suffix patterns `**/p/:productCode` and `**/c/:categoryCode`. To opt-out from suffix patterns, please set the `matchers` routes' config explicitly to `null` or to array containing your custom matcher(s).

### Dropped functions in NavigationUIComponent

Since `isTabbable` was never called, it no longer exists in `NavigationUIComponent`. Also `getDepth` function was renamed to `getTotalDepth`.

### Anonymous consents feature

Anonymous consents feature is now part of the core features, and the `anonymousConsents` feature toggle has been removed.

### Changes in PaymentMethodComponent

Component is now more similar to other checkout components. Behavior is more aligned with `ShippingAddressComponent`.
Changes in public API:

- `setPaymentDetails` no longer have third parameter. It should be used only for creating new payment details.
- `createCard` method now have third parameter for selected payment details. Parameters are also now typed.
- `selectPaymentMethod` have different behavior now. It dispatches `CheckoutPaymentService` method for selecting payment. Previously it only modified local component state.
- `getCardContent` was removed and replaced with observable `cards$` emitting all payment details cards along with the payment details for each one.
- `selectedPayment` variable was replaced with observable `selectedMethod$`
- `allowRouting` variable renamed to `shouldRedirect`
- `deliveryAddress`, `checkoutStepUrlNext`, `checkoutStepUrlPrevious` are now protected variables (previously private)
- `next` method removed. Use `goNext` instead.
- `back` method removed. Use `goPrevious` instead.
- `paymentMethodSelected` method removed. Use `selectPaymentMethod` instead.

### Changes in DeliveryModeComponent

We didn't changed public API of this component, but behavior is now also more aligned with other checkout components. Each change immediately triggers update in API. Default value is also set on API during component initialization. Thanks to that order summary is updated after every delivery mode change. On clicking next button we set delivery mode one more time with the last selected value and only after update on the API you get redirected to the next step. Once we set delivery mode in order summary component you will see "shipping" instead of "estimated shipping".

### cmsPageLoadOnce feature flag

`cmsPageLoadOnce` feature flag has been removed. The same behavior is now achievable by configuring `routing.loadStrategy` as `RouteLoadStrategy.ONCE`.  

### Products endpoint configuration

The `backend.occ.endpoints.product_scopes` configuration key was merged into `backend.occ.endpoints.product` key.

### Launched in smart edit detection

Method `isLaunchInSmartEdit` was removed from `CmsService`. Instead use new method `isLaunchedInSmartEdit` from `SmartEditService`.

### DynamicAttributeService

Method `addDynamicAttributes` now has a different parameter order. Parameter `cmsRenderingContext` is now the last parameter and it has a type.

### CmsActions and CmsSelectors

`CmsActions` now have only parameter: `payload`. Other parameters are now part of `payload`.

`getComponentState`, `getComponentEntities`, `componentStateSelectorFactory` and `componentSelectorFactory` were removed from `CmsSelectors`. Use cms selector factories instead.

### Default occ prefix

Default value for `backend.occ.prefix` configuration key is now `/occ/v2/`. This is the default value for 2005 release.

### Cart components changes

Methods `removeEntry` and `updateEntry` were removed from `AddedToCartDialogComponent` component. It's logic is now contained in `getQuantityControl` method.

Methods `updateItem` and `isSaveForLaterEnabled` were removed from `CartItemComponent` component. Outputs `remove` and `update` were also removed. Input `isReadOnly` renamed to `readonly`. Inputs `cartIsLoading`, `parent` and `potentialProductPromotions` were removed. New input `quantityControl` added to this component.

Methods `ngOnInit`, `isSaveForLaterEnabled`, `updateEntry` and `getPotentialProductPromotionsForItem` were removed from `CartItemListComponent` component. Input `potentialProductPromotions` was removed.

### Skip link changes

`SkipLinkComponent` methods `blur`, `tabNext` and `tabPrev` were removed.

Skip link default configuration was simplified. Previously by default there were skip links for top header, bottom header, facets, product list and footer. Now it's only header, main content and footer.

### Product list component service

Method `clearSearchResults` was removed from `ProductListComponentService`. The method was not needed in `ProductListComponent` anymore since the data
will refresh on currency change. Instead you can use `clearResults` in `ProductSearchService`.

### Context change action not dispatched on the initial setting the value

Before 2.0, the `LanguageChange` ngrx action was dispatched on setting the initial value (same for `CurrencyChange`). Moreover, the language (and currency) sometimes was initialized multiple times by the competing sources of truth (i.e. routing, session storage, default config), which caused fake multiple language change actions in some circumstances (combinations of configuration and user journey).

Now the language change action is not dispatched on application start (same for currency). The language is initialized only once, using one source of truth (the first matched condition wins):

1. If SSR transferred state is present, take value from there. OR
1. If param was configured to be persisted from URL, take value from there. (When the value is not present in the  current URL, the URL is updated using default configured value and then we use this value.) OR
1. If value can be retrieved from session storage, take value from there OR
1. Otherwise take the static default value from config

The same priorities hold for currency. However, for base site have only 1, 2 and 4 apply (there is no session storage as source).

### WebComponentHandler is not provided by default

To enable Web Components support for cms component you have to provide it in your app:

```
    {
      provide: ComponentHandler,
      useExisting: WebComponentHandler,
      multi: true,
    },
``` 

### Deprecated since 1.1

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| `cxApi.CmsComponentData` | cxApi.cmsComponentData | - |
| `OccCartEntryAdapter.getCartEndpoint` | Use configurable endpoints | - |
| `OccCartAdapter.getCartEndpoint` | Use configurable endpoints | - |
| `OccUserOrderAdapter.getOrderEndpoint` | Use configurable endpoints | - |

### Shipping Address component variables and methods removed

Support for declared variables dropped:

- `cards` This variable will no longer be in use. Use cards$ observable instead.
- `goTo` This variable will no longer be in use. Avoid using it.
- `setAddress` This variable will no longer be in use. Use selectAddress(address: Address) instead.
- `setAddressSub` This variable will no longer be in use. Avoid using it.
- `selectedAddressSub` This variable will no longer be in use. Use selectedAddress$ observable instead.
- `checkoutStepUrlNext` This variable will no longer be in use. Use CheckoutConfigService.getNextCheckoutStepUrl(this.activatedRoute) instead.
- `checkoutStepUrlPrevious` This variable will no longer be in use. Use CheckoutConfigService.getPreviousCheckoutStepUrl(this.activatedRoute) instead.
- `selectedAddress` This variable will no longer be in use. Use selectedAddress$ observable instead.

Support for functions dropped:

- `addressSelected` This method will no longer be in use. Use selectAddress(address: Address) instead.
- `back` This method will no longer be in use. Use goPrevious() instead.
- `next` This method will no longer be in use. Use goNext() instead.
- `addNewAddress` This method will no longer be in use. Use addAddress(address: Address) instead.
- `ngOnDestroy` This method will no longer be in use. Remove.

### Deprecated since 1.2

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| CheckoutActions.ClearCheckoutDeliveryModeSuccess() | CheckoutActions.ClearCheckoutDeliveryModeSuccess(payload) | The `ClearCheckoutDeliveryModeSuccess` action requires payload. `CheckoutActions.ClearCheckoutDeliveryModeSuccess(payload: { userId: string; cartId: string })` |
| `ANONYMOUS_USERID` | `OCC_USER_ID_ANONYMOUS` | OCC constants are now available under `OCC` prefix to make it more clear that these variables are related to `OCC`.
| AddressBookComponentService.addUserAddress(userAddressService: UserAddressService) | AddressBookComponentService(userAddressService, checkoutDeliveryService) | The constructor now uses also CheckoutDeliveryService. `AddressBookComponentService(userAddressService: UserAddressService, checkoutDeliveryService: CheckoutDeliveryService)` |
| CheckoutGuard(router: Router, config: CheckoutConfig, routingConfigService: RoutingConfigService) | CheckoutGuard(router, routingConfigService, checkoutConfigService, expressCheckoutService, cartService) | The constructor now uses new dependencies. `CheckoutGuard(router: Router, routingConfigService: RoutingConfigService, checkoutConfigService: CheckoutConfigService, expressCheckoutService: ExpressCheckoutService, cartService: ActiveCartService)` |

### Deprecated since 1.3

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| PageMetaResolver.resolve() | Use individual resolvers | The caller `PageMetaService` service is improved to expect all individual resolvers instead, so that the code is easier extensible. |
| `initSiteContextRoutesHandler`, `siteContextParamsProviders` | - | the constants were not meant to be exported in public API |
| `inititializeContext`, `contextServiceProviders` | - | the constants were not meant to be exported in public API |

### Deprecated since 1.4

| API                               | Replacement | Notes                                                                          |
| --------------------------------- | ----------- | ------------------------------------------------------------------------------ |
| config `i18n.backend.crossDomain` | -           | it's not needed anymore since using Angular HttpClient for loading i18n assets |
| `CartService` removed | Use `ActiveCartService` instead | `ActiveCartService` have exactly the same name, arguments and return type for most of the methods from `CartService`. One function was renamed - `getLoaded` changed to `isStable` to better describe function behavior. Two methods are not present in `ActiveCartService`. Method `getCartMergeComplete` was removed on purpose. Cart merging is an implementation detail of OCC and we don't consider that information useful. Instead you can rely on `isStable` method that will correctly present state of the cart. During cart merge it will emit `false` values. Rule of thumb is to only dispatch cart modifications (eg. addEntry, addEmail) when `isStable` emits `true`. Method `addVoucher` is also not available in `ActiveCartService`. Instead use `CartVoucherService.addVoucher` method. |
| `CartDataService` removed | Use methods from `ActiveCartService` and `AuthService` | Our libraries are generally moving towards reactive programming and observables. `CartDataService` used completely different patterns and it was hard to follow if data there was already updated or represented previous cart state. Replacements for `CartDataService` properties: `userId` -> replace usage with `AuthService.getOccUserId()`, `cart` -> replace usage with `ActiveCartService.getActive()`, `cartId` -> replace usage with `ActiveCartService.getActiveCartId()`, `isGuestCart` -> replace usage with `ActiveCartService.isGuestCart()`. Property `hasCart` doesn't have direct replacement. Instead you can look into `ActiveCartService.getActive()` method output to see if it emitted empty object (which means that there is no cart). |
| `ProductService` and `CurrentProductService` use product scopes | - | In some cases current product won't return full product model. You should use scopes to optimize backend calls related to product data. |
| `withCredentialsInterceptorProvider` | It is provided by default in `OccModule` | - |

### Deprecated since 1.5

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| WishlistEffects, CartEffects, CartVoucherEffects, CartEntryEffects, effects | Create your own effects in separate class and take into account default behavior from effects | We didn't plan to export effects in the first place. Cart effects in public API were a mistake. If you extended this class, you should move your effects to separate class and keep in mind that default effects will be working. |
| getReducers, reducerToken, reducerProvider, clearCartState, metaReducers, clearMultiCartState, multiCartMetaReducers, multiCartReducerToken, getMultiCartReducers, multiCartReducerProvider | Extend cart behavior in higher level (facade) or use custom actions for your specific use case | We didn't plan to export reducers and utilities for reducers in the first place. Cart reducers in public API were a mistake. Any changes to reducers should be handled in different layer (facade) or separate store module. Keep in mind that default reducer behavior will be working under the hood.|
| `CartDetailsComponent.getAllPromotionsForCart` method removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information you should use this service. |
| `OrderDetailItemsComponent.getConsignmentProducts` method removed | Use `OrderConsignedEntriesComponent` instead | This functionality has been extracted into separate component. |
| `CartItemComponent.potentialProductPromotions` input removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information you should use this service. |
| `CartItemListComponent.potentialProductPromotions` input removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information you should use this service. |
| `CartItemListComponent.getPotentialProductPromotionsForItem` method removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information you should use this service. |
| `ProductImagesComponent.isThumbsEmpty` property removed | Use `thumbs$` observable instead | - |
| `KymaServices` const removed | Use `OpenIdAuthenticationTokenService` directly | - |

## Automated migrations for Version 2

- `CheckoutService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided to `CheckoutService`.
- `CheckoutPaymentService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided for `CheckoutPaymentService`.
- `CheckoutDeliveryService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided for `CheckoutDeliveryService`.
- `CheckoutGuard` no longer uses `CheckoutConfig`. This config usage was replaced with corresponding methods from `CheckoutConfigService`, `ExpressCheckoutService`, `ActiveCartService`. These services needs to be provided for `CheckoutGuard`.
- `AddressBookComponentService` uses now `CheckoutDeliveryService`. This service needs to be provided for `AddressBookComponentService`.
- `PromotionService` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `PromotionService`.
- `CheckoutLoginComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutLoginComponent`.
- `CheckoutDetailsService` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutDetailsService`.
- `NotCheckoutAuthGuard` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `NotCheckoutAuthGuard`.
- `ShippingAddressComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `ShippingAddressComponent`.
- `CheckoutPageMetaResolver` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutPageMetaResolver`.
- `AddToCartComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `AddToCartComponent`.
- `CartNotEmptyGuard` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CartNotEmptyGuard`.
- `CartTotalsComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CartTotalsComponent`.
- `MiniCartComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `MiniCartComponent`.
- `CheckoutOrderSummaryComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutOrderSummaryComponent`.
- `CheckoutProgressMobileTopComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutProgressMobileTopComponent`.
- `PaymentMethodComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `PaymentMethodComponent`.
- `CheckoutAuthGuard` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. This service needs to be provided for `CheckoutAuthGuard`.
- `CartPageLayoutHandler` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `ActiveCartService` and `SelectiveCartService` needs to be provided in `CartPageLayoutHandler`.
- `SpartacusEventService` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService.` This service needs to be provided for `SpartacusEventService`.
- `ClientAuthenticationTokenService` uses now `OccEndpointsService`. This service needs to be provided for `ClientAuthenticationTokenService`.
- `UserAuthenticationTokenService` uses now `OccEndpointsService`. This service needs to be provided for `UserAuthenticationTokenService`.
- `OccCartEntryAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyAdd`, `legacyRemove`, and `legacyUpdate`, and needs to be provided for `OccCartEntryAdapter`.
- `OccCartAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyLoadAll`, `legacyLoad`, and `legacyCreate`, and needs to be provided for `OccCartAdapter`.
- `OccUserOrderAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyLoad` and `legacyLoadHistory`, and needs to be provided for `OccUserOrderAdapter`.
- `UserConsentService` uses now `AuthService`. This service needs to be provided for `UserConsentService`.
- `UserOrderService` uses now `AuthService`. This service needs to be provided for `UserOrderService`.
- `UserPaymentService` uses now `AuthService`. This service needs to be provided for `UserPaymentService`.
- `UserService` uses now `AuthService`. This service needs to be provided for `UserService`.
- `AddedToCartDialogComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. Also `PromotionService` is now required parameter. These services needs to be provided for `AddedToCartDialogComponent`. `FormBuilder` no longer needs to be provided for this component.
- `CartDetailsComponent` no longer uses `CartService` and `FeatureConfigService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `PromotionService`, `SelectiveCartService`, `AuthService` and  `RoutingService` are now required parameters. These services needs to be provided for `CartDetailsComponent`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `ReviewSubmitComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `CheckoutConfigService` and `PromotionService` are now required parameters. These services needs to be provided for `ReviewSubmitComponent`.
- `OrderDetailItemsComponent` now requires `PromotionService`. This service needs to be provided for `OrderDetailItemsComponent`.
- `OrderConfirmationItemsComponent` now requires `PromotionService`. This service needs to be provided for `OrderConfirmationItemsComponent`.
- `CartVoucherService` now requires new parameter `ActiveCartService`. This service needs to be provided for `CartVoucherService`.
- `CartCouponComponent` no longer uses `AuthService`, `FeatureConfigService` and `CartService`. `CartService` service usage was replaced with corresponding methods from `ActiveCartService`. Also `CustomerCouponService` is now required parameter. These services needs to be provided for `CartCouponComponent`.
- `LogoutGuard` no longer uses `FeatureConfigService` as it was used previously to determine the feature flag.
- `LoginFormComponent` requires new parameters now: `WindowRef`, `ActivatedRoute` and `CheckoutConfigService`.
- `RegisterComponent` no longer uses `FeatureConfigService`, `AuthService` and `AuthRedirectService`. Also `RoutingService`, `AnonymousConsentsService` and `AnonymousConsentsConfig` are now required parameters.
- `StarRatingComponent` now requires new parameter `Renderer2`. This service needs to be provided for `StarRatingComponent`.
- `ProductService` now requires `ProductLoadingService`.
- `ProductCarouselComponent` no longer requires `FeatureConfigService`.
- `CurrentProductService` no longer requires `FeatureConfigService`.
- `ProductPageMetaResolver` no longer requires `FeatureConfigService`.
- `ProductListComponent` now requires new parameter `ViewConfig`. This config needs to be provided for `ProductListComponent`. Method `viewPage` was removed.
- `ProductScrollComponent` The deprecated method `isSamePage` is removed with 2.0.
- `ConfigurableRoutesService` no longer uses `UrlMatcherFactoryService`, but its counterpart `UrlMatcherService`.
- `ExternalRoutesService` no longer uses `UrlMatcherFactoryService`, but its counterpart `UrlMatcherService`.
- `OutletDirective` now requires new parameters `DeferLoaderService` and `OutletRendererService`. This services needs to be provided for `OutletDirective`.
- `ConsentManagementComponent` now requires parameters `AnonymousConsentsConfig`, `AnonymousConsentsService` and `AuthService`.
- `ConsentManagementComponent` no longer uses `isLevel13` and `isAnonymousConsentsEnabled` properties.
- `ConsentManagementFormComponent` no longer uses `isLevel13` and `isAnonymousConsentsEnabled` properties.
- `AnonymousConsentDialogComponent` no longer uses `isLevel13` property.
- `PlaceOrderComponent` requires new parameter now: `FormBuilder`.
- `CustomerCouponService` now requires new parameter `AuthService`. This service needs to be provided for `CustomerCouponService`.
- `UserInterestsService` now requires new parameter `AuthService`. This service needs to be provided for `UserInterestsService`.
- `UserNotificationPreferenceService` now requires new parameter `AuthService`. This service needs to be provided for `UserNotificationPreferenceService`.
- `UserAddressService` now requires new parameter `AuthService`. This service needs to be provided for `UserAddressService`.
- `ProductReviewsComponent` now requires new parameter `ChangeDetectorRef`. This service needs to be provided for `ProductReviewsComponent`.
- `SearchBoxComponent` now requires new parameter `WindowRef`. This service needs to be provided for `SearchBoxComponent`.
- `AddressBookComponent` now requires new parameters `TranslationService`, `UserAddressService` and `CheckoutDeliveryService`. These services need to be provided for `AddressBookComponent`
- `CartItemListComponent` no longer requires `FormBuilder`, `FeatureConfigService` and  `CartService`. `CartService` was replaced with corresponding methods from `ActiveCartService`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `CartItemComponent` no longer uses `FeatureConfigService`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `PaymentFormComponent` requires new parameter now: `UserAddressService`.
- `ComponentWrapperDirective` no longer uses `CmsService` param.
- `DynamicAttributeService` requires a new parameter now: `SmartEditService`.
- `NavigationUIComponent` no longer uses `allowAlignToRight` property.
- `StoreFinderSearchResultComponent` now requires new parameter `StoreFinderConfig`. This service needs to be provided for `StoreFinderSearchResultComponent`.
- `PageSlotComponent` now requires new parameter `CmsComponentsService` and `ChangeDetectorRef`. The `CmsComponentsService` is used to read the configurable _page fold_ from the layout configuration. The `ChangeDetectorRef` is needed to update the slot pending state asynchronously.
- `TabParagraphContainerComponent` now requires new parameter `WindowRef`. This service needs to be provided for `TabParagraphContainerComponent`.
- `SelectiveCartService` requires new parameter now: `CartConfigService`.
- `QualtricsLoaderService` now requires Angular's core `RendererFactory2` and no longer uses the `QualtricsConfig`. The service has been refactored for better extensibility and reuse.
- `QualtricsComponent` now requires the `QualtricsConfig` to load the global qualtrics deployments script. This was a dependency in the `QualtricsLoaderService` in 1.x. Also, the component no longer uses 'qualtricsEnabled$' property.
- `AmendOrderActionsComponent` requires now new parameter: `RoutingService`.
- `FooterNavigationComponent` no longer requires `AnonymousConsentsConfig` parameter.
- `ProductFacetNavigationComponent` no longer requires `ModalService`, `ActivatedRoute` and `ProductListComponentService`. It now requires `BreakpointService`.
- `StoreFinderGridComponent` no longer requires `RoutingService`. Methods `viewStore` and `prepareRouteUrl` were removed.
- `SkipLinkService` requires new parameter: `KeyboardFocusService`.
- `StorefrontComponent` requires new parameters: `ElementRef` and `KeyboardFocusService`.
- `AutoFocusDirective`, `AutoFocusDirectiveModule`, `OnlyNumberDirective`, `OnlyNumberDirectiveModule` and `FormUtils` were removed.
- `authentication.kyma_enabled` configuration option has been removed. Kyma is now enabled by importing `KymaModule`.
- `features.anonymousConsents` configuration option has been removed. This feature is now part of the core set of features, and it's enabled by default.

### State utility changes

- `LoaderState`, `ProcessesLoaderState`, `EntityState`, `EntityLoaderState`, `EntityProcessesLoaderState` were moved under `StateUtils` namespace.
- `StateLoaderActions`, `StateProcessesLoaderActions`, `StateEntityActions`, `StateEntityLoaderActions`, `StateEntityProcessesLoaderActions` were removed. All actions are now accessible from `StateUtils`.
- `StateLoaderSelectors`, `StateProcessesLoaderSelectors`, `StateEntitySelectors`, `StateEntityLoaderSelectors`, `StateEntityProcessesLoaderSelectors` were removed. All selectors are now accessible from `StateUtils`.
- `loaderReducer`, `processesLoaderReducer`, `entityReducer`, `entityLoaderReducer`, `entityProcessesLoaderReducer`, `initialEntityState`, `initialLoaderState`, `initialProcessesState`, `getStateSlice` were moved under `StateUtils` namespace.
- `ofLoaderLoad`, `ofLoaderFail`, `ofLoaderSuccess` methods were removed and are no longer available.
- `entityStateSelector` was renamed to `entityLoaderStateSelector`.
- `EntityResetAction` was renamed to `EntityLoaderResetAction`.
  
### Automated migrations of page meta resolvers

The implementation of page meta data resolvers has been changed with 2.0. Previously, each meta resolver implementation has been responsible to resolve all page data, by implementing the abstract `resolve` method from the abstract `PageMetaResolver`. To allow for more flexibility and simplify customizations, the individual implementations no longer implement the resolve method. Only a specific *resolver* is required, such as the `PageTitleResolver`. The `PageMetaService` will invoke the specific resolvers when available. This is done by the registered `resolverMethods`. You can further extend the list of `resolverMethods` without changing the implementation of `PageMetaService.resolve`.

These changes have been introduced under a feature flag in version 1.3, and are standardized in 2.0. The `FeatureConfigService` was used for this feature flag, and has been dropped from all constructors with version 2.0. This change will be migrated automatically.

The individual changes for 2.0 per class are:

- `PageMetaService`  
  The `resolverMethods` access modifier changed from *public* to *protected*. The `resolve` method will invoke individual resolvers by iterating over the `resolverMethods`.
- `ContentPageMetaResolver`  
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveTitle` and `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers no longer receive arguments, but use the local `cms$` observable to resolve the required data.
- `ProductPageMetaResolver`  
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveHeading`, `resolveTitle`, `resolveDescription`, `resolveBreadcrumbs`, `resolveImage` and `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers no longer receive arguments, but use the local `product$` observable to resolve the required data.
- `CategoryPageMetaResolver`
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveTitle` and `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveBreadcrumbs`) no longer receive arguments, but use the local `searchPage$` observable to resolve the required data.
- `SearchPageMetaResolver`
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as the individual resolve method (`resolveTitle`) is invoked by the `PageMetaService` directly. The individual resolver (`resolveTitle`) no longer receive arguments, but use the local `query$` observable to resolve the required data.
- `CartPageMetaResolver`  
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveTitle`, `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveRobots`) no longer receive arguments, but use the local `cms$` observable to resolve the required data.
- `CheckoutPageMetaResolver`  
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveTitle`, `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveRobots`) no longer receive arguments, but use the local `cart$` observable to resolve the required data.
- `CouponSearchPageResolver` ~~`FindProductPageMetaResolver`~~  
  The ~~`FindProductPageMetaResolver`~~ was introduced with in version 1.5, and has been renamed to `CouponSearchPageResolver` in version 2.0.
  
  The deprecated method `resolve` is removed with 2.0. This method is no longer supported as individual resolve methods (`resolveTitle`, `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveBreadcrumbs`) no longer receive arguments, but use the local `total$` observable to resolve the required data.

  The `score` method was refactored heavily to better cope with synchronize router state. This resulted in a change in the constructor which should be migrated automatically.
  
## Larger refactoring for 2.0

### Components

#### Pagination Component

The reusable `PaginationComponent` has been completely refactored for 2.0. The pagination component had various flaws in version 1 and the implementation wasn't great either. The new version is fully configurable and easily extensible as the *build* logic is solely delegated to the new `PaginationBuilder`.
The default configuration is more concise and shows maximum 3 pages with a start and end link.

The HTML and companied CSS is refactored as well. A clean DOM exists of only anchor links, nothing more. The availability and order of pagination links is driven by the configuration. The component is fully accessible and prepared for directionality as well.

Using anchor links is the preferred action for pagination links, but action links (using `click` events) are still supported and used in various areas in Spartacus. The product listing page however is using anchor links.

The component is fully [documented](https://sap.github.io/spartacus-docs/pagination/).

If you have used the pagination component directly, you should refactor the implementation, as the inputs have changed. 

### Payment Form Component

The method `isContinueButtonDisabled()` has been removed as the submission button is no longer disabled by default.

### Address Card Component

The component `AddressCardComponent` has been completely removed and is replaced by `CardComponent`. Use `CardComponent` instead.

### Cart changes

#### Storage sync mechanism change in multi cart

Storage synchronization mechanism previously used to persist active cart id had some limitations that caused bugs on multi site stores (issue: [https://github.com/SAP/spartacus/issues/6215](https://github.com/SAP/spartacus/issues/6215)).
Default storage sync configuration was removed from `MultiCartStoreModule`. Instead state persistence mechanism have been added for multi cart to provide the same behavior and to support multi site stores. It is build on top of `StatePersistenceService`. This is a new and recommended way to synchronize state to browser storage. Head to docs (TODO: add link to state persistence doc when it will be published) for more information.

#### Cart state and selectors removed

We are replacing old `cart` store feature (`CART_DATA`, `StateWithCart`, `CartsState`, `CART_FEATURE`, `CartState`) along with it's selectors (`CartSelectors`) with new cart state available in previous version under `multi-cart`. We recommend working with `ActiveCartService` and `MultiCartService` which uses under the hood new `cart` store feature. It allows us to support more carts (eg. wishlist, saved carts).

#### Typed payloads in ngrx actions

To avoid one type of bugs (missing parameters) when dispatching ngrx actions we added types to their payload. We want to be sure that we always have all required parameters. Additionally with types creating new actions is easier, as you get better editor support when specifying payload.

List of actions with changed payload type: `CartAddEntry`, `CartAddEntrySuccess`, `CartRemoveEntry`, `CartRemoveEntrySuccess`, `CartUpdateEntry`, `CartUpdateEntrySuccess`, `AddEmailToCartSuccess`, `MergeCartSuccess`, `CartAddEntryFail`, `CartRemoveEntryFail`, `CartUpdateEntryFail`, `CartRemoveVoucherFail`, `CartRemoveVoucherSuccess`, `CartAddVoucherFail`, `CartAddVoucherSuccess`, `CreateCart`, `CreateCartFail`, `CreateCartSuccess`, `LoadCart`, `LoadCartFail`, `LoadCartSuccess`, `LoadWishList`, `LoadWishListSuccess`, `AddEmailToCart`, `AddEmailToCartFail`, `MergeCart`, `DeleteCartFail`, `ClearCheckoutDeliveryModeFail`.

Removed actions: `CreateMultiCart`, `CreateMultiCartFail`, `CreateMultiCartSuccess`, `LoadMultiCart`, `LoadMultiCartFail`, `LoadMultiCartSuccess`, `AddEmailToMultiCart`, `AddEmailToMultiCartSuccess`, `AddEmailToMultiCartFail`, `MergeMultiCart`, `MergeMultiCartSuccess`, `ResetMultiCartDetails`, `ClearCart`, `RemoveTempCart`, `ClearExpiredCoupons`.

Renamed actions: `ClearMultiCartState` -> `ClearCartState`

New actions:

- `LoadWishListFail` - for consistency in wishlist it now have dedicated fail action. It will be dispatched in wishlist effects instead of `LoadCartFail` action.
- `DeleteCartSuccess` - for consistency in delete cart effect. It will be dispatched after DeleteCart action will successfully delete cart in backend.
- `SetActiveCartId` - to set active cart id from state persistence service.

#### Services changes

`MultiCartService.createCart` and `MultiCartService.mergeToCurrentCart` now have more strict types for parameters.

### New deprecations

- `ADD_VOUCHER_PROCESS_ID` const, `CartResetAddVoucher` action - we plan to migrate from add voucher process to cart voucher events
- `CartProcessesIncrement` and `CartProcessesDecrement` - instead extend EntityProcesses in actions
- `CartVoucherService` methods: `getAddVoucherResultError`, `getAddVoucherResultSuccess`, `getAddVoucherResultLoading` and `resetAddVoucherProcessingState`. Those methods will be replaced with event listeners.

## Forms changes

### Naming convention

From 2.0, FormGroups will be named accordingly to components they are used in, eg. FormGroup in `loginComponent` will be named `loginForm`.

### New FormGroup list

| Component name | Old FormGroup | New FormGroup | Notes |
| - | - | - | - |
| `PlaceOrderComponent` | - | `checkoutSubmitForm` | new FormGroup added |
| `AddressFormComponent` | `address` | `addressForm` |
| `PaymentFormComponent` | `billingAddress` | `billingAddressForm` | `BillingAddressComponent` was removed (read more below)
| `PaymentFormComponent` | `payment` | `paymentForm` |
| `RegisterComponent` | `userRegistrationForm` | `registerForm` |
| `CSAgentLoginFormComponent` | `form` | `csAgentLoginForm` |
| `CustomerSelectionComponent` | `form` | `customerSelectionForm` |
| `CartCouponComponent` | `form` | `couponForm` |
| `ForgotPasswordComponent` | `form` | `forgotPasswordForm` |
| `ResetPasswordFormComponent` | `form` | `resetPasswordForm` |
| `UpdateEmailFormComponent` | `form` | `updateEmailForm` |
| `UpdatePasswordFormComponent` | `form` | `updatePasswordForm` |
| `UpdateProfileFormComponent` | `form` | `updateProfileForm` |
| `CheckoutLoginComponent` | `form` | `checkoutLoginForm` |
| `LoginFormComponent` | `form` | `loginForm` |

### Files removal

Due to changes in forms and form-related functionalities, `form-utils` file was removed completely - its functionalities are handled by `FormErrorsComponent`. Also due to aforementioned changes, `BillingAddressFormComponent` was removed and its functionalities were moved to `PaymentFormComponent`. The same with his module - instead of `BillingAddressFormModule` use `PaymentFormModule`.

### How to use `FormErrorsComponent`

#### Preface

This component was created with easy usage in mind. The only thing you have to do is pass a form control to it as an attribute `[control]` and the component will handle everything for you - rendering icon, message, showing/hiding validation error, etc.

#### Useful information

- You can use `FormErrors` component in any place you want, you don't have to place it right after a related control element - eg. you can place it in a custom popup
- `FormErrors` component uses translation keys from `common` chunk
- Each translation is mapped to specific validation error names, eg. `cxPasswordsMustMatch`
- Controls' visuals (red border) is fully handled by CSS - it takes advantage of `ng-...` form CSS classes (valid, dirty, touched)
- `FormErrors` visibility is also relaying on similar CSS classes (`.control-valid`, `.control-dirty`, `.control-touched`) - thanks to this, you can use it in any place you want

#### Example

```html
<form [formGroup]="testForm">
  <input formControlName="myInput" />
  <cx-form-errors [control]="testForm.get('myInput')"> <!-- pass the control -->
</form>

<cx-form-errors [control]="testForm.get('myInput')"> <!-- this will also work -->
```

### Changes to components' variables, methods, etc

| Component | Change type | Old value | New value |
| - | - | - | - |
| `PlaceOrderComponent` | variable | `tAndCToggler` | removed |
| `PlaceOrderComponent` | method | `toggleTAndC` | removed |
| `PlaceOrderComponent` | method | `placeOrder` | `submitForm` |
| `ForgotPasswordComponent` | variable | `submited` | removed |
| `ResetPasswordFormComponent` | variable | `submited` | removed |
| `UpdateEmailFormComponent` | variable | `submited` | removed |
| `UpdateEmailFormComponent` | method | `isEmailConfirmNotValid` | removed |
| `UpdateEmailFormComponent` | method | `isNotValid` | removed |
| `UpdatePasswordFormComponent` | output | `submited` | `submitted` |
| `UpdatePasswordFormComponent` | method | `isNotValid` | removed |
| `UpdatePasswordFormComponent` | method | `isPasswordConfirmNotValid` | removed |
| `UpdateProfileFormComponent` | output | `submited` | `submitted` |
| `UpdateProfileFormComponent` | method | `isNotValid` | removed |
| `CSAgentLoginFormComponent` | method | `isNotValid` | removed |
| `CheckoutLoginComponent` | method | `isNotValid` | removed |
| `CheckoutLoginComponent` | method | `isEmailConfirmInvalid` | removed |
| `LoginFormComponent` | method | `login` | `submitForm` |
| `LoginFormComponent` | method | - | `loginUser` |
| `RegisterComponent` | method | `submit` | `submitForm` |
| `RegisterComponent` | method | - | `registerUser` |
| `RegisterComponent` | variable | `isNewRegisterFlowEnabled` | removed |
| `RegisterComponent` | variable | `isAnonymousConsentEnabled` | removed |
| `CustomFormValidators` | validator | `emailDomainValidator` | removed |
| `CustomFormValidators` | validator | `matchPassword` | removed |
| `AmendOrderActionsComponent` | input | `isValid` | `amendOrderForm` |
| `PaymentFormComponent` | method | `showSameAsShippingAddressCheckbox` | replaced with observable `showSameAsShippingAddressCheckbox$` |

## Store Finder Changes

Parameter `radius` of `googleMaps?` parameter in `StoreFinderConfig` is now configurable.

## Save for later configuration

Feature flag `saveForLater` was removed.
Instead use cart configuration to enable/disable saveForLater feature.

``` ts
cart: {
  selectiveCart: {
    enabled: true|false
  }
}
```

## Translations updates

New translations added, small stylistic changes in `loginForm.dontHaveAccount`, `productList.appliedFilter`, `productFacetNavigation.appliedFilter` default values and new translation group `formErrors` added to `common` chunk.

## CDS library breaking changes

- Enum `ProfileTagEventNames.LOADED` value removed.
- `ProfileTagEventService.addTracker` now returns `Observable<string>` instead of `Observable<Event>`.

## Peer dependencies

We updated peerDependencies for every library to correctly list all dependencies if you don't use storefront library. Previously we only maintained that list for `@spartacus/storefront`.
Now you will see during any library installation which other packages you have to install in the project.
