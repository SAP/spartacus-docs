---
title: Technical Changes in Spartacus 2.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Breaking Changes Introduced in 2.0

### CMS page guard has less dependencies and all are public

Before 2.0, some dependencies of the `CmsPageGuard` were not public, so the guard was not easily customizable. Now most of the logic (and dependencies) are moved to a new service called `CmsPageGuardService`, and its dependencies are made public.

### Config validation mechanism is now a separate module

Previously, config validator logic was part of `ConfigModule`. If you are not using `StorefrontFoundationModule` or any of its descendants, it's required to import `ConfigValidatorModule.forRoot()` in order to make config validators run.

### Selectors removed from @spartacus/core

The `ProductSelectors.getSelectedProductsFactory` was removed because it was outdated.

### Factories removed from @spartacus/storefront public API

The `pwaConfigurationFactory`, `pwaFactory`, `getStructuredDataFactory` and `skipLinkFactory` were removed from the storefront library public API.

### Bad Request Handler

The `BadRequestHandler` handles 400 errors. Previously, it was handling `not found` errors for OCC CMS pages because these were not returned as 404 errors. This was done in a generic way, by handling *all other errors*. Since the 1905 release of SAP Commerce Cloud, the OCC CMS returns a 404 error if a page is not found. Accordingly, we removed this special handling in the `BadRequestHandler`. This might affect custom implementations that relied on this behavior, and in these cases, it is recommended to throw 404 errors from your back end, or to customize the `BadRequestHandler`.

### UrlMatcherFactoryService was renamed to UrlMatcherService and its methods were renamed

The service `UrlMatcherFactoryService` was renamed to `UrlMatcherService` and its methods were renamed as follows:

| UrlMatcherFactoryService (removed) | UrlMatcherService (new counterpart) |
| - | - |
| getFalsyUrlMatcher | getFalsy |
| getMultiplePathsUrlMatcher | getFromPaths |
| getPathUrlMatcher | getFromPath |
| getOppositeUrlMatcher | getOpposite |
| getGlobUrlMatcher | getFromGlob |

### New way to opt out from suffix routes for PDP and PLP

Before 2.0, the suffix routes `**/p/:productCode` and `**/c/:categoryCode` (added for backwards compatibility with Accelerators) were implemented in Spartacus using separate Angular `Routes` objects. To opt out from them, you needed to dismantle the `ProductDetailsPageModule` or the `ProductListingPageModule` (or both), and reassemble them again without defining suffix routes.

Now that the separate objects for suffix routes were dropped, the suffix mechanism is now implemented in the original `product` and `category` routes, thanks to the support of the configurable Angular `UrlMatcher` that arrived in Spartacus 2.0.

So the default config of Spartacus for the `product` route now contains a `matchers` property with an array containing `PRODUCT_DETAILS_URL_MATCHER`, and the config for the `category` route has `PRODUCT_LISTING_URL_MATCHER` in the `matchers` array by default. These matchers match both the `paths` from the routing config as well as the suffix patterns `**/p/:productCode` and `**/c/:categoryCode`. To opt out from suffix patterns, set the config of the `matchers` routes explicitly to `null`, or to an array containing your custom matcher (or matchers).

### Dropped functions in NavigationUIComponent

Since `isTabbable` was never called, it no longer exists in the `NavigationUIComponent`. Also, the `getDepth` function was renamed to `getTotalDepth`.

### Anonymous consents feature toggle

The anonymous consents feature is now part of the core features, and the `anonymousConsents` feature toggle has been removed.

### Changes in PaymentMethodComponent

The `PaymentMethodComponent` is now more similar to other checkout components, and the behavior is more aligned with the `ShippingAddressComponent`. The changes to the public API are as follows:

- `setPaymentDetails` no longer has a third parameter. It should be used only for creating new payment details.
- `createCard` method now has a third parameter for selected payment details. Parameters are also now typed.
- `selectPaymentMethod` has different behavior now. It dispatches the `CheckoutPaymentService` method for selecting the payment. Previously, it only modified the local component state.
- `getCardContent` was removed and replaced with the `cards$` observable, which emits all payment details cards, along with the payment details for each one.
- `selectedPayment` variable was replaced with the `selectedMethod$` observable.
- `allowRouting` variable renamed to `shouldRedirect`.
- `deliveryAddress`, `checkoutStepUrlNext`, and `checkoutStepUrlPrevious` are now protected variables. Previously, the were private.
- `next` method has been removed. Use `goNext` instead.
- `back` method has been removed. Use `goPrevious` instead.
- `paymentMethodSelected` method has been removed. Use `selectPaymentMethod` instead.

### Changes in DeliveryModeComponent

The public API of this component has not been changed, but the behavior is now more aligned with other checkout components. Each change immediately triggers an update in the API. The default value is also set on the API during component initialization. As a result, the order summary is updated after every delivery mode change. On clicking the "next" button, the delivery mode is set one more time with the last selected value, and you get redirected to the next step only after an update has occurred on the API . When the delivery mode is set in the order summary component, you will see "shipping" instead of "estimated shipping".

### Removal of cmsPageLoadOnce feature flag

The `cmsPageLoadOnce` feature flag has been removed. The same behavior is now achievable by configuring `routing.loadStrategy` as `RouteLoadStrategy.ONCE`.  

### Products endpoint configuration

The `backend.occ.endpoints.product_scopes` configuration key was merged into the `backend.occ.endpoints.product` key.

### Launched in Smart Edit detection

The `isLaunchInSmartEdit` method was removed from `CmsService`. Instead, use the new `isLaunchedInSmartEdit` method from `SmartEditService`.

### DynamicAttributeService

The `addDynamicAttributes` method now has a different parameter order. The `cmsRenderingContext` parameter is now the last parameter and it has a type.

### CmsActions and CmsSelectors

The `CmsActions` now have only parameter: `payload`. Other parameters are now part of `payload`.

The `getComponentState`, `getComponentEntities`, `componentStateSelectorFactory` and `componentSelectorFactory` were removed from `CmsSelectors`. Use CMS selector factories instead.

### Default OCC prefix

The default value for the `backend.occ.prefix` configuration key is now `/occ/v2/`. This is the default value for the 2005 release of SAP Commerce Cloud.

### Cart components changes

The `removeEntry` and `updateEntry` methods were removed from the `AddedToCartDialogComponent` component. Its logic is now contained in the `getQuantityControl` method.

The `updateItem` and `isSaveForLaterEnabled` methods were removed from the `CartItemComponent` component. The `remove` and `update` outputs were also removed. The `isReadOnly` input is renamed to `readonly`. The `cartIsLoading`, `parent` and `potentialProductPromotions` inputs were removed. The new `quantityControl`  input was added to this component.

The `ngOnInit`, `isSaveForLaterEnabled`, `updateEntry` and `getPotentialProductPromotionsForItem` methods were removed from the `CartItemListComponent` component. The `potentialProductPromotions` input was removed.

### Skip link changes

The `SkipLinkComponent` methods `blur`, `tabNext` and `tabPrev` were removed.

The skip link default configuration was simplified. Previously, by default, there were skip links for the top header, bottom header, facets, product list, and footer. Now there are default skip links only for the header, main content, and footer.

### Product list component service

The `clearSearchResults` method was removed from the `ProductListComponentService`. The method was not needed in the `ProductListComponent` anymore since the data will refresh on currency change. Instead, you can use `clearResults` in `ProductSearchService`.

### Context change action not dispatched on the initial setting of the value

Before 2.0, the `LanguageChange` NgRx action was dispatched on setting the initial value (as was also the case for `CurrencyChange`). Moreover, the language (and currency) sometimes was initialized multiple times by the competing sources of truth (for example, routing, session storage, default config), which caused fake multiple language change actions in some circumstances (combinations of configuration and user journey).

Now the language change action is not dispatched on application start (and the same is true for currency). The language is initialized only once, using one source of truth. The first matched condition wins, according to the following order of priority:

1. If the SSR transferred state is present, take the value from there. If not, proceed to the next condition.
1. If the param was configured to be persisted from the URL, take the value from there. If not, proceed to the next condition. (When the value is not present in the current URL, the URL is updated using the default configured value and then we use this value.)
1. If the value can be retrieved from session storage, take the value from there. If not, proceed to the next condition.
1. Take the static default value from the config.

The same order of priority holds for currency. For base sites, however, only the first, second and fourth conditions apply, because there is no session storage as source.

### WebComponentHandler is not provided by default

To enable Web Components support for CMS components, you have to provide the support in your app. The following is an example:

```ts
    {
      provide: ComponentHandler,
      useExisting: WebComponentHandler,
      multi: true,
    },
```

## Automated Migrations for Version 2

- `CheckoutService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided to `CheckoutService`.
- `CheckoutPaymentService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided for `CheckoutPaymentService`.
- `CheckoutDeliveryService` no longer uses `CartDataService`. This service usage was replaced with corresponding methods from `ActiveCartService` (and `AuthService`). These services needs to be provided for `CheckoutDeliveryService`.
- `CheckoutGuard` no longer uses `CheckoutConfig`. This config usage was replaced with corresponding methods from `CheckoutConfigService`, `ExpressCheckoutService`, `ActiveCartService`. These services needs to be provided for `CheckoutGuard`.
- `AddressBookComponentService` now uses `CheckoutDeliveryService`. This service needs to be provided for `AddressBookComponentService`.
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
- `CartPageLayoutHandler` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `ActiveCartService` and `SelectiveCartService` need to be provided in `CartPageLayoutHandler`.
- `SpartacusEventService` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService.` This service needs to be provided for `SpartacusEventService`.
- `ClientAuthenticationTokenService` now uses `OccEndpointsService`. This service needs to be provided for `ClientAuthenticationTokenService`.
- `UserAuthenticationTokenService` now uses `OccEndpointsService`. This service needs to be provided for `UserAuthenticationTokenService`.
- `OccCartEntryAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyAdd`, `legacyRemove`, and `legacyUpdate`, and needs to be provided for `OccCartEntryAdapter`.
- `OccCartAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyLoadAll`, `legacyLoad`, and `legacyCreate`, and needs to be provided for `OccCartAdapter`.
- `OccUserOrderAdapter` no longer uses `FeatureConfigService`. This service usage no longer uses the legacy methods: `legacyLoad` and `legacyLoadHistory`, and needs to be provided for `OccUserOrderAdapter`.
- `UserConsentService` now uses `AuthService`. This service needs to be provided for `UserConsentService`.
- `UserOrderService` now uses `AuthService`. This service needs to be provided for `UserOrderService`.
- `UserPaymentService` now uses `AuthService`. This service needs to be provided for `UserPaymentService`.
- `UserService` now uses `AuthService`. This service needs to be provided for `UserService`.
- `AddedToCartDialogComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. Also `PromotionService` is now a required parameter. These services need to be provided for `AddedToCartDialogComponent`. `FormBuilder` no longer needs to be provided for this component.
- `CartDetailsComponent` no longer uses `CartService` and `FeatureConfigService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `PromotionService`, `SelectiveCartService`, `AuthService` and  `RoutingService` are now required parameters. These services need to be provided for `CartDetailsComponent`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `ReviewSubmitComponent` no longer uses `CartService`. This service usage was replaced with corresponding methods from `ActiveCartService`. `CheckoutConfigService` and `PromotionService` are now required parameters. These services need to be provided for `ReviewSubmitComponent`.
- `OrderDetailItemsComponent` now requires `PromotionService`. This service needs to be provided for `OrderDetailItemsComponent`.
- `OrderConfirmationItemsComponent` now requires `PromotionService`. This service needs to be provided for `OrderConfirmationItemsComponent`.
- `CartVoucherService` now requires the new `ActiveCartService` parameter. This service needs to be provided for `CartVoucherService`.
- `CartCouponComponent` no longer uses `AuthService`, `FeatureConfigService` and `CartService`. `CartService` service usage was replaced with corresponding methods from `ActiveCartService`. Also, `CustomerCouponService` is now a required parameter. These services need to be provided for `CartCouponComponent`.
- `LogoutGuard` no longer uses `FeatureConfigService`, which was used previously to determine the feature flag.
- `LoginFormComponent` now requires the following new parameters: `WindowRef`, `ActivatedRoute` and `CheckoutConfigService`.
- `RegisterComponent` no longer uses `FeatureConfigService`, `AuthService` and `AuthRedirectService`. Also `RoutingService`, `AnonymousConsentsService` and `AnonymousConsentsConfig` are now required parameters.
- `StarRatingComponent` now requires the new `Renderer2` parameter. This service needs to be provided for `StarRatingComponent`.
- `ProductService` now requires `ProductLoadingService`.
- `ProductCarouselComponent` no longer requires `FeatureConfigService`.
- `CurrentProductService` no longer requires `FeatureConfigService`.
- `ProductPageMetaResolver` no longer requires `FeatureConfigService`.
- `ProductListComponent` now requires the new `ViewConfig` parameter. This config needs to be provided for `ProductListComponent`. The `viewPage` method was removed.
- `isSamePage` is removed from the `ProductScrollComponent` because it is a deprecated method.
- `ConfigurableRoutesService` no longer uses `UrlMatcherFactoryService`, but instead uses its counterpart, `UrlMatcherService`.
- `ExternalRoutesService` no longer uses `UrlMatcherFactoryService`, but instead uses its counterpart, `UrlMatcherService`.
- `OutletDirective` now requires new `DeferLoaderService` and `OutletRendererService` parameters. These services needs to be provided for `OutletDirective`.
- `ConsentManagementComponent` now requires the `AnonymousConsentsConfig`, `AnonymousConsentsService` and `AuthService` parameters.
- `ConsentManagementComponent` no longer uses the `isLevel13` and `isAnonymousConsentsEnabled` properties.
- `ConsentManagementFormComponent` no longer uses the `isLevel13` and `isAnonymousConsentsEnabled` properties.
- `AnonymousConsentDialogComponent` no longer uses the `isLevel13` property.
- `PlaceOrderComponent` now requires the new `FormBuilder` parameter.
- `CustomerCouponService` now requires the new `AuthService` parameter. This service needs to be provided for `CustomerCouponService`.
- `UserInterestsService` now requires the new `AuthService` parameter. This service needs to be provided for `UserInterestsService`.
- `UserNotificationPreferenceService` now requires the new `AuthService` parameter. This service needs to be provided for `UserNotificationPreferenceService`.
- `UserAddressService` now requires the new `AuthService` parameter. This service needs to be provided for `UserAddressService`.
- `ProductReviewsComponent` now requires the new `ChangeDetectorRef` parameter. This service needs to be provided for `ProductReviewsComponent`.
- `SearchBoxComponent` now requires the new `WindowRef` parameter. This service needs to be provided for `SearchBoxComponent`.
- `AddressBookComponent` now requires new `TranslationService`, `UserAddressService` and `CheckoutDeliveryService` parameters. These services need to be provided for `AddressBookComponent`.
- `CartItemListComponent` no longer requires `FormBuilder`, `FeatureConfigService` and  `CartService`. `CartService` was replaced with corresponding methods from `ActiveCartService`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `CartItemComponent` no longer uses `FeatureConfigService`. The deprecated method `isSaveForLaterEnabled()` was removed.
- `PaymentFormComponent` now requires the new `UserAddressService` parameter.
- `ComponentWrapperDirective` no longer uses the `CmsService` param.
- `DynamicAttributeService` requires the new `SmartEditService` parameter.
- `NavigationUIComponent` no longer uses the `allowAlignToRight` property.
- `StoreFinderSearchResultComponent` now requires the new `StoreFinderConfig` parameter. This service needs to be provided for `StoreFinderSearchResultComponent`.
- `PageSlotComponent` now requires the new `CmsComponentsService` and `ChangeDetectorRef` parameters. The `CmsComponentsService` is used to read the configurable _page fold_ from the layout configuration. The `ChangeDetectorRef` is needed to update the slot pending state asynchronously.
- `TabParagraphContainerComponent` now requires the new `WindowRef` parameter. This service needs to be provided for `TabParagraphContainerComponent`.
- `SelectiveCartService` now requires the new `CartConfigService` parameter.
- `QualtricsLoaderService` now requires Angular's core `RendererFactory2` and no longer uses the `QualtricsConfig`. The service has been refactored for better extensibility and reuse.
- `QualtricsComponent` now requires the `QualtricsConfig` to load the global qualtrics deployments script. This was a dependency in the `QualtricsLoaderService` in 1.x. Also, the component no longer uses the `qualtricsEnabled$` property.
- `AmendOrderActionsComponent` now requires the new `RoutingService` parameter.
- `FooterNavigationComponent` no longer requires the `AnonymousConsentsConfig` parameter.
- `ProductFacetNavigationComponent` no longer requires `ModalService`, `ActivatedRoute` and `ProductListComponentService`. It now requires `BreakpointService`.
- `StoreFinderGridComponent` no longer requires `RoutingService`. The `viewStore` and `prepareRouteUrl` methods were removed.
- `SkipLinkService` requires the new `KeyboardFocusService` parameter.
- `StorefrontComponent` requires the new `ElementRef` and `KeyboardFocusService` parameters.
- `AutoFocusDirective`, `AutoFocusDirectiveModule`, `OnlyNumberDirective`, `OnlyNumberDirectiveModule` and `FormUtils` were removed.
- `authentication.kyma_enabled` configuration option has been removed. Kyma is now enabled by importing `KymaModule`.
- `features.anonymousConsents` configuration option has been removed. This feature is now part of the core set of features, and it is enabled by default.

### State utility changes

- `LoaderState`, `ProcessesLoaderState`, `EntityState`, `EntityLoaderState`, `EntityProcessesLoaderState` were moved under the `StateUtils` namespace.
- `StateLoaderActions`, `StateProcessesLoaderActions`, `StateEntityActions`, `StateEntityLoaderActions`, `StateEntityProcessesLoaderActions` were removed. All actions are now accessible from `StateUtils`.
- `StateLoaderSelectors`, `StateProcessesLoaderSelectors`, `StateEntitySelectors`, `StateEntityLoaderSelectors`, `StateEntityProcessesLoaderSelectors` were removed. All selectors are now accessible from `StateUtils`.
- `loaderReducer`, `processesLoaderReducer`, `entityReducer`, `entityLoaderReducer`, `entityProcessesLoaderReducer`, `initialEntityState`, `initialLoaderState`, `initialProcessesState`, `getStateSlice` were moved under the `StateUtils` namespace.
- `ofLoaderLoad`, `ofLoaderFail`, `ofLoaderSuccess` methods were removed and are no longer available.
- `entityStateSelector` was renamed to `entityLoaderStateSelector`.
- `EntityResetAction` was renamed to `EntityLoaderResetAction`.
  
### Automated migrations of page meta resolvers

The implementation of page meta data resolvers has been changed with 2.0. Previously, each meta resolver implementation had been responsible for resolving all page data, by implementing the abstract `resolve` method from the abstract `PageMetaResolver`. To allow for more flexibility and to simplify customizations, the individual implementations no longer implement the `resolve` method. Only a specific *resolver* is required, such as the `PageTitleResolver`. The `PageMetaService` will invoke the specific resolvers when available. This is done by the registered `resolverMethods`. You can further extend the list of `resolverMethods` without changing the implementation of `PageMetaService.resolve`.

These changes were introduced under a feature flag in version 1.3, and are standardized in 2.0. The `FeatureConfigService` was used for this feature flag, and has been dropped from all constructors with version 2.0. This change will be migrated automatically.

The individual changes per class for 2.0 are the following:

- `PageMetaService`  
  The `resolverMethods` access modifier changed from *public* to *protected*. The `resolve` method will invoke individual resolvers by iterating over the `resolverMethods`.
- `ContentPageMetaResolver`  
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveTitle` and `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers no longer receive arguments, but use the local `cms$` observable to resolve the required data.
- `ProductPageMetaResolver`  
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveHeading`, `resolveTitle`, `resolveDescription`, `resolveBreadcrumbs`, `resolveImage` and `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers no longer receive arguments, but use the local `product$` observable to resolve the required data.
- `CategoryPageMetaResolver`
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveTitle` and `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveBreadcrumbs`) no longer receive arguments, but use the local `searchPage$` observable to resolve the required data.
- `SearchPageMetaResolver`
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because the individual resolve method (`resolveTitle`) is invoked by the `PageMetaService` directly. The individual resolver (`resolveTitle`) no longer receives arguments, but uses the local `query$` observable to resolve the required data.
- `CartPageMetaResolver`  
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveTitle`, `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveRobots`) no longer receive arguments, but use the local `cms$` observable to resolve the required data.
- `CheckoutPageMetaResolver`  
  The deprecated method `resolve` is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveTitle`, `resolveRobots`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveRobots`) no longer receive arguments, but use the local `cart$` observable to resolve the required data.
- `CouponSearchPageResolver` ~~`FindProductPageMetaResolver`~~  
  The ~~`FindProductPageMetaResolver`~~ was introduced in version 1.5, and has been renamed to `CouponSearchPageResolver` in version 2.0.
  
  The deprecated `resolve` method is removed in 2.0. This method is no longer supported because individual resolve methods (`resolveTitle`, `resolveBreadcrumbs`) are invoked by the `PageMetaService` directly. The individual resolvers (`resolveTitle`, `resolveBreadcrumbs`) no longer receive arguments, but use the local `total$` observable to resolve the required data.

  The `score` method was refactored heavily to better cope with synchronize router state. This resulted in a change in the constructor which should be migrated automatically.
  
## Larger Refactoring for 2.0

### Pagination Component

The reusable `PaginationComponent` has been completely refactored for 2.0. The pagination component had various flaws in version 1 and the implementation wasn't great either. The new version is fully configurable and easily extensible as the *build* logic is solely delegated to the new `PaginationBuilder`.
The default configuration is more concise and shows a maximum of three pages with a start and end link.

The HTML and accompanying CSS is refactored as well. A clean DOM consists of only anchor links, nothing more. The availability and order of pagination links is driven by the configuration. The component is fully accessible and prepared for directionality as well.

Using anchor links is the preferred action for pagination links, but action links (using `click` events) are still supported and used in various areas in Spartacus. The product listing page, however, is using anchor links.

For more information, see [{% assign linkedpage = site.pages | where: "name", "pagination.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/shared-components/pagination.md %}).

If you have used the pagination component directly, you should refactor the implementation, as the inputs have changed.

### Payment Form Component

The method `isContinueButtonDisabled()` because been removed as the submission button is no longer disabled by default.

### Address Card Component

The component `AddressCardComponent` has been completely removed and is replaced by `CardComponent`. Use `CardComponent` instead.

### Storage sync mechanism change in multi-cart

The storage synchronization mechanism previously used to persist the active cart id had some limitations that caused bugs on multi-site stores (issue: [https://github.com/SAP/spartacus/issues/6215](https://github.com/SAP/spartacus/issues/6215)).

The default storage sync configuration was removed from `MultiCartStoreModule`. Instead, a state persistence mechanism has been added for multi-cart to provide the same behavior and to support multi-site stores. It is build on top of `StatePersistenceService`. This is a new and recommended way to synchronize state to browser storage. For more information, see [{% assign linkedpage = site.pages | where: "name", "state-persistence.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/state-persistence.md %}).

### Cart state and selectors removed

We are replacing the old `cart` store feature (`CART_DATA`, `StateWithCart`, `CartsState`, `CART_FEATURE`, `CartState`), along with its selectors (`CartSelectors`), with a new cart state that was available in previous versions under `multi-cart`. We recommend working with `ActiveCartService` and `MultiCartService`, which use the new `cart` store feature under the hood. This allows us to support more carts (for example, wishlist, saved carts, and so on).

### Typed payloads in NgRx actions

To avoid one type of bug (missing parameters) when dispatching NgRx actions, we added types to their payload. We want to be sure that we always have all required parameters. Additionally, creating new actions is easier with types, as you get better editor support when specifying the payload.

The following is a list of actions with changed payload type: `CartAddEntry`, `CartAddEntrySuccess`, `CartRemoveEntry`, `CartRemoveEntrySuccess`, `CartUpdateEntry`, `CartUpdateEntrySuccess`, `AddEmailToCartSuccess`, `MergeCartSuccess`, `CartAddEntryFail`, `CartRemoveEntryFail`, `CartUpdateEntryFail`, `CartRemoveVoucherFail`, `CartRemoveVoucherSuccess`, `CartAddVoucherFail`, `CartAddVoucherSuccess`, `CreateCart`, `CreateCartFail`, `CreateCartSuccess`, `LoadCart`, `LoadCartFail`, `LoadCartSuccess`, `LoadWishList`, `LoadWishListSuccess`, `AddEmailToCart`, `AddEmailToCartFail`, `MergeCart`, `DeleteCartFail`, `ClearCheckoutDeliveryModeFail`.

The following are removed actions: `CreateMultiCart`, `CreateMultiCartFail`, `CreateMultiCartSuccess`, `LoadMultiCart`, `LoadMultiCartFail`, `LoadMultiCartSuccess`, `AddEmailToMultiCart`, `AddEmailToMultiCartSuccess`, `AddEmailToMultiCartFail`, `MergeMultiCart`, `MergeMultiCartSuccess`, `ResetMultiCartDetails`, `ClearCart`, `RemoveTempCart`, `ClearExpiredCoupons`.

The following are renamed actions: `ClearMultiCartState` -> `ClearCartState`

The following are new actions:

- `LoadWishListFail`  
    A dedicated `LoadWishListFail` action was added to maintain consistency in the wishlist. It is dispatched in the wishlist effects instead of the `LoadCartFail` action.

- `DeleteCartSuccess`  
    The `DeleteCartSuccess` action was added to maintain consistency in the delete cart effect. It will be dispatched after DeleteCart action will successfully delete cart in backend.

- `SetActiveCartId`  
    The `SetActiveCartId` action was added to set the active cart id from the state persistence service.

### Services changes

`MultiCartService.createCart` and `MultiCartService.mergeToCurrentCart` now have more strict types for parameters.

## New Deprecations

- `ADD_VOUCHER_PROCESS_ID` const, `CartResetAddVoucher` action: we plan to migrate from the add voucher process to cart voucher events
- `CartProcessesIncrement` and `CartProcessesDecrement`: instead, extend EntityProcesses in actions
- `CartVoucherService` methods: `getAddVoucherResultError`, `getAddVoucherResultSuccess`, `getAddVoucherResultLoading` and `resetAddVoucherProcessingState`. These methods are replaced with event listeners.

## Forms Changes

### Naming convention

From 2.0, `FormGroups` will be named according to the components they are used in. For example, `FormGroup` in `loginComponent` will be named `loginForm`.

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

### File removals

Due to changes in forms and form-related functionalities, the `form-utils` file was removed completely, and its functionalities are now handled by `FormErrorsComponent`. Also due to the aforementioned changes, `BillingAddressFormComponent` was removed and its functionalities were moved to `PaymentFormComponent`. The same is true for the module: instead of `BillingAddressFormModule`, use `PaymentFormModule`.

## How to Use FormErrorsComponent

### Preface

This component was created with easy usage in mind. The only thing you have to do is pass a form control to it as an attribute `[control]` and the component will handle everything for you, such as icon rendering, message, showing/hiding validation error, and so on.

### Useful information

- You can use the `FormErrors` component in any place you want, so you do not have to place it right after a related control element. For example, you can place it in a custom popup.
- The `FormErrors` component uses translation keys from the `common` chunk.
- Each translation is mapped to specific validation error names, such as `cxPasswordsMustMatch`, for example.
- The visuals of the controls (red border) are fully handled by CSS. They take advantage of the `ng-...` form CSS classes (valid, dirty, touched).
- `FormErrors` visibility is also relying on similar CSS classes (`.control-valid`, `.control-dirty`, `.control-touched`). As a result, you can use it in any place you want.

### Example

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
| `ForgotPasswordComponent` | variable | `submitted` | removed |
| `ResetPasswordFormComponent` | variable | `submitted` | removed |
| `UpdateEmailFormComponent` | variable | `submitted` | removed |
| `UpdateEmailFormComponent` | method | `isEmailConfirmNotValid` | removed |
| `UpdateEmailFormComponent` | method | `isNotValid` | removed |
| `UpdatePasswordFormComponent` | output | `submitted` | `submitted` |
| `UpdatePasswordFormComponent` | method | `isNotValid` | removed |
| `UpdatePasswordFormComponent` | method | `isPasswordConfirmNotValid` | removed |
| `UpdateProfileFormComponent` | output | `submitted` | `submitted` |
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

In `StoreFinderConfig`, the `radius` parameter of the `googleMaps?` parameter is now configurable.

## Save for Later Configuration

The `saveForLater` feature flag was removed.

Instead, use cart configuration to enable/disable saveForLater feature. The following is an example:

```ts
cart: {
  selectiveCart: {
    enabled: true|false
  }
}
```

## Translations Updates

New translations have been added: small stylistic changes in the default values of `loginForm.dontHaveAccount`, `productList.appliedFilter`, and `productFacetNavigation.appliedFilter`, and a new `formErrors` translation group was added to the `common` chunk.

## CDS Library Breaking Changes

- Enum `ProfileTagEventNames.LOADED` value was removed.
- `ProfileTagEventService.addTracker` now returns `Observable<string>` instead of `Observable<Event>`.

## Peer Dependencies

We updated peer dependencies for every library to correctly list all dependencies if you don't use the storefront library. Previously, we only maintained this list for `@spartacus/storefront`.

Now, during any library installation, you will see which other packages you have to install in the project.

## Deprecated Since 1.5

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| WishlistEffects, CartEffects, CartVoucherEffects, CartEntryEffects, effects | Create your own effects in a separate class and take into account the default behavior from effects | We didn't plan to export effects in the first place. Cart effects in the public API were a mistake. If you extended this class, you should move your effects to a separate class and keep in mind that default effects will be working. |
| getReducers, reducerToken, reducerProvider, clearCartState, metaReducers, clearMultiCartState, multiCartMetaReducers, multiCartReducerToken, getMultiCartReducers, multiCartReducerProvider | Extend cart behavior in higher level (facade) or use custom actions for your specific use case | We didn't plan to export reducers and utilities for reducers in the first place. Cart reducers in the public API were a mistake. Any changes to reducers should be handled in a different layer (facade) or separate store module. Keep in mind that default reducer behavior will be working under the hood.|
| `CartDetailsComponent.getAllPromotionsForCart` method removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information, you should use this service. |
| `OrderDetailItemsComponent.getConsignmentProducts` method removed | Use `OrderConsignedEntriesComponent` instead | This functionality has been extracted into a separate component. |
| `CartItemComponent.potentialProductPromotions` input removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information, you should use this service. |
| `CartItemListComponent.potentialProductPromotions` input removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information, you should use this service. |
| `CartItemListComponent.getPotentialProductPromotionsForItem` method removed | Use `PromotionService` | `PromotionService` is now the main promotion data source. Whenever you need promotions information, you should use this service. |
| `ProductImagesComponent.isThumbsEmpty` property removed | Use `thumbs$` observable instead | - |
| `KymaServices` const removed | Use `OpenIdAuthenticationTokenService` directly | - |

## Deprecated Since 1.4

| API                               | Replacement | Notes                                                                          |
| --------------------------------- | ----------- | ------------------------------------------------------------------------------ |
| config `i18n.backend.crossDomain` | -           | It is not needed anymore since using Angular HttpClient for loading i18n assets |
| `CartService` removed | Use `ActiveCartService` instead | `ActiveCartService` has exactly the same name, arguments and return type for most of the methods from `CartService`. One function was renamed: `getLoaded` is changed to `isStable` to better describe function behavior. Two methods are not present in `ActiveCartService`. The `getCartMergeComplete` method was removed on purpose. Cart merging is an implementation detail of OCC and we don't consider that information useful. Instead, you can rely on the `isStable` method that will correctly present the state of the cart. During cart merge, it will emit `false` values. A rule of thumb is to only dispatch cart modifications (for example, `addEntry`, `addEmail`) when `isStable` emits `true`. The `addVoucher` method is also not available in `ActiveCartService`. Instead, use the `CartVoucherService.addVoucher` method. |
| `CartDataService` removed | Use methods from `ActiveCartService` and `AuthService` | Our libraries are generally moving towards reactive programming and observables. `CartDataService` used completely different patterns and it was hard to follow if existing data was already updated, or represented a previous cart state. The following are replacements for `CartDataService` properties: `userId` -> replace usage with `AuthService.getOccUserId()`; `cart` -> replace usage with `ActiveCartService.getActive()`; `cartId` -> replace usage with `ActiveCartService.getActiveCartId()`; `isGuestCart` -> replace usage with `ActiveCartService.isGuestCart()`. The `hasCart` property doesn't have a direct replacement. Instead, you can look into the `ActiveCartService.getActive()` method output to see if it emitted an empty object (which means that there is no cart). |
| `ProductService` and `CurrentProductService` use product scopes | - | In some cases, the current product won't return the full product model. You should use scopes to optimize back end calls related to product data. |
| `withCredentialsInterceptorProvider` | It is provided by default in `OccModule` | - |

## Deprecated Since 1.3

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| PageMetaResolver.resolve() | Use individual resolvers | The caller `PageMetaService` service is improved to expect all individual resolvers instead, so that the code is more easily extensible. |
| `initSiteContextRoutesHandler`, `siteContextParamsProviders` | - | The constants were not meant to be exported in the public API. |
| `inititializeContext`, `contextServiceProviders` | - | The constants were not meant to be exported in the public API. |

## Deprecated Since 1.2

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| CheckoutActions.ClearCheckoutDeliveryModeSuccess() | CheckoutActions.ClearCheckoutDeliveryModeSuccess(payload) | The `ClearCheckoutDeliveryModeSuccess` action requires a payload. `CheckoutActions.ClearCheckoutDeliveryModeSuccess(payload: { userId: string; cartId: string })` |
| `ANONYMOUS_USERID` | `OCC_USER_ID_ANONYMOUS` | OCC constants are now available under the `OCC` prefix to make it more clear that these variables are related to `OCC`.
| AddressBookComponentService.addUserAddress(userAddressService: UserAddressService) | AddressBookComponentService(userAddressService, checkoutDeliveryService) | The constructor now also uses the `CheckoutDeliveryService`. `AddressBookComponentService(userAddressService: UserAddressService, checkoutDeliveryService: CheckoutDeliveryService)` |
| CheckoutGuard(router: Router, config: CheckoutConfig, routingConfigService: RoutingConfigService) | CheckoutGuard(router, routingConfigService, checkoutConfigService, expressCheckoutService, cartService) | The constructor now uses new dependencies. `CheckoutGuard(router: Router, routingConfigService: RoutingConfigService, checkoutConfigService: CheckoutConfigService, expressCheckoutService: ExpressCheckoutService, cartService: ActiveCartService)` |

## Deprecated Since 1.1

|  API  | Replacement |  Notes  |
|-------|-------------|---------|
| `cxApi.CmsComponentData` | cxApi.cmsComponentData | - |
| `OccCartEntryAdapter.getCartEndpoint` | Use configurable endpoints | - |
| `OccCartAdapter.getCartEndpoint` | Use configurable endpoints | - |
| `OccUserOrderAdapter.getOrderEndpoint` | Use configurable endpoints | - |

### Shipping Address component variables and methods removed

Support for declared variables dropped:

- `cards` This variable will no longer be in use. Use the `cards$` observable instead.
- `goTo` This variable will no longer be in use. Avoid using it.
- `setAddress` This variable will no longer be in use. Use `selectAddress(address: Address)` instead.
- `setAddressSub` This variable will no longer be in use. Avoid using it.
- `selectedAddressSub` This variable will no longer be in use. Use the `selectedAddress$` observable instead.
- `checkoutStepUrlNext` This variable will no longer be in use. Use `CheckoutConfigService.getNextCheckoutStepUrl(this.activatedRoute)` instead.
- `checkoutStepUrlPrevious` This variable will no longer be in use. Use `CheckoutConfigService.getPreviousCheckoutStepUrl(this.activatedRoute)` instead.
- `selectedAddress` This variable will no longer be in use. Use `selectedAddress$` observable instead.

Support for functions dropped:

- `addressSelected` This method will no longer be in use. Use `selectAddress(address: Address)` instead.
- `back` This method will no longer be in use. Use `goPrevious()` instead.
- `next` This method will no longer be in use. Use `goNext()` instead.
- `addNewAddress` This method will no longer be in use. Use `addAddress(address: Address)` instead.
- `ngOnDestroy` This method will no longer be in use. Remove.
