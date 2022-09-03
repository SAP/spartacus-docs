---
title: Technical Changes in Spartacus 4.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Config Interface Augmentation

Spartacus exposes a lot of methods that accept configuration, and with release 4.0, Spartacus improves the way it types those methods. In previous versions, configurations were often provided with type assertions (such as, `provideConfig(<I18nConfig>{i18n: {...}})`) to improve type safety and autocomplete functionality.

In version 4.0, Spartacus has changed the way it works with the `Config` interface, and each feature contributes to this interface using TypeScript module augmentation. As a result, the `Config` interface now correctly describes all of the configuration options that you can pass to Spartacus.

Furthermore, the type for all methods that accept configuration has been changed from `any` to `Config`, and as a result, you no longer need to use type assertion to benefit from better type safety and a better developer experience.

The individual configs still exist (such as, `I18nConfig`, `AsmConfig`, `AuthConfig`, and so on), but all of these interfaces also contribute to the `Config` interface.

When you need to access a configuration object, you still can by using the following syntax in the constructor:

```ts
protected config: AsmConfig
```

This will only provide hints about the `AsmConfig` properties, but you now have the option to do it as follows:

```ts
protected config: Config
```

Doing it this way is recommended when you want to access a complete configuration with type safety (for example, `FeatureConfig` and `MediaConfig` at the same time).

This change should be seamless for most users, but it will affect you if you have custom configurations in your application.

This can be illustrated by looking at an example with a special configuration for theme:

```ts
// existing code
@Injectable({
  providedIn: 'root',
  useExisting: Config,
})
export abstract class ThemeConfig {
  theme?: {
    dark?: boolean;
  };
}

// Required Changes

// You need to augment the `Config` interface from `@spartacus/core` to be able to
// provide this config with the `provideConfig` method

declare module '@spartacus/core' {
  interface Config extends ThemeConfig {}
}
```

You do not need to change anything in places where you use this config, but anywhere that you declare your custom config, you have to instruct TypeScript that the `Config` interface also has a `theme` property with a `dark` option. Otherwise, TypeScript complains that you are trying to pass properties that are not part of `Config`.

It is recommended that you make top-level configuration properties optional, so that you can pass the configuration in multiple chunks, and not in a single place.

For more information on module augmentation in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "type-augmentation.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/type-augmentation.md %}).

## Detailed List of Changes

### Config providers

- The first parameter of the `provideConfig` function changed type from `any` to `Config`.
- The first parameter of the `provideDefaultConfig` function changed type from `any` to `Config`.

### ConfigModule

- The parameter of the `withConfig` method changed type from `object` to `Config`.
- The parameter of the `forRoot` method changed type from `any` to `Config`.

### Config Injection Tokens

- The `Config` injection token was replaced with an injectable `Config` abstract class.
- The `ConfigChunk` injection token changed type from `object[]` to `Config[]`.
- The `DefaultConfigChunk` injection token changed type from `object[]` to `Config[]`.

### StorefrontConfig

This type was removed, as its purpose is now covered with the augmentable `Config` interface. Replace usage of `StorefrontConfig` with `Config`.

### ConfigInitializerService

Prior to 4.0, the constructor appeared as follows:

```ts
constructor(
    @Inject(Config) protected config: any,
    @Optional()
    @Inject(CONFIG_INITIALIZER_FORROOT_GUARD)
    protected initializerGuard,
    @Inject(RootConfig) protected rootConfig: any
  ) {}
```

The constructor now appears as follows:

```ts
constructor(
    protected config: Config,
    @Optional()
    @Inject(CONFIG_INITIALIZER_FORROOT_GUARD)
    protected initializerGuard: any,
    @Inject(RootConfig) protected rootConfig: Config
  ) {}
```

- The `getStable` method's return signature has changed from `Observable<any>` to `Observable<Config>`.
- The `getStableConfig` method's return signature has changed from `Promise<any>` to `Promise<Config>`.

### Config Validators

- The `ConfigValidator` type changed from `(config: any) => string | void` to `(config: Config) => string | void`.
- The first parameter of the `validateConfig` function changed from `any` to `Config`.

### ConfigInitializer

- The `ConfigInitializer.configFactory` signature changed from `() => Promise<any>` to `() => Promise<Config>`.

### ConfigurationService

- The `unifiedConfig$` type changed from `Observable<any>` to `Observable<Config>`.
- The `config` type changed from `any` to `Config`.
- Prior to 4.0, the constructor appeared as follows:

   ```ts
   constructor(
     @Inject(RootConfig) protected rootConfig: any,
     @Inject(DefaultConfig) protected defaultConfig: any,
     protected unifiedInjector: UnifiedInjector,
     @Inject(Config) config: any
   )
   ```

- The constructor now appears as follows:

   ```ts
   constructor(
     @Inject(RootConfig) protected rootConfig: Config,
     @Inject(DefaultConfig) protected defaultConfig: Config,
     protected unifiedInjector: UnifiedInjector,
     config: Config
   )
   ```

### Feature Config Utils

- The first parameter type of `isFeatureLevel` changed from `unknown` to `Config`.
- The first parameter type of `isFeatureEnabled` changed from `unknown` to `Config`.

### MediaService

- Prior to 4.0, the constructor appeared as follows:

    ```ts
    constructor(
      @Inject(Config) protected config: StorefrontConfig,
      protected breakpointService: BreakpointService
    ) {}
    ```

- The constructor now appears as follows:

    ```ts
    constructor(
      protected config: Config
    ) {}
    ```

- The `getMedia` method now supports the `role` attribute

### ModalService

- The `ModalService` no longer depends on the `FeatureConfigService`, but the `ApplicationRef` is now a new required dependency.

#### Product Configurator Configuration

- The `productConfigurator` configuration option is now optional (the `updateDebounceTime` and `cpq` properties from this option are now also optional).
- The `backend.cpq` configuration option is now optional.

#### SmartEditConfig

- The `smartEdit` property is optional.
- The `smartEdit.storefrontPreviewRoute` property is optional.
- The `smartEdit.allowOrigin` property is optional.

#### PersonalizationConfig

- The `personalization` property is optional.

#### CmsStructureConfig

- The `cmsStructure` property is optional.

#### PageComponentModule

- The `forRoot()` method is exposed to minimize side-effects of frequent imports in dependant modules. The `PageComponentModule.forRoot()` is now imported in `BaseStorefrontModule`.

## New Checkout Library

Spartacus 4.0 introduces the checkout library. The code related to checkout is moved out of `@spartacus/core` and `@spartacus/storefrontlib` and into one of the entry points of the new checkout library.  The checkout library is split into the following entry points:

```text
@spartacus/checkout/assets 
The checkout related i18n keys are moved here.

@spartacus/checkout/components
The checkout related UI code is moved here. This includes components, guards and ui services.

@spartacus/checkout/core
The checkout facade API implementation is moved here, as well as connectors, event builder, event listener, models, other services, and state management.

@spartacus/checkout/occ
The checkout related OCC code is moved here. This includes the checkout related adapters and converters.

@spartacus/checkout/root
The root entry point is, by convention, meant to always be eager loaded.  It contains the config, events, facades, http interceptors and models.

@spartacus/checkout/styles
The checkout related scss styles are moved here.
```

Most of the code is moved unchanged, but some classes required changes after they were moved.  See the following sections for more details.

### Use Facades Instead of Services

Some services are now available through facades. Facades should be used instead. The main advantage to using facades instead of their service implementation is that the facades support lazy loading. Facades are imported from `@spartacus/checkout/root`.

- `CheckoutCostCenterFacade` should be used instead of `CheckoutCostCenterService`.
- `CheckoutDeliveryFacade` should be used instead of `CheckoutDeliveryService`.
- `CheckoutPaymentFacade` should be used instead of `CheckoutPaymentService`.
- `CheckoutFacade` should be used instead of `CheckoutService`.
- `PaymentTypeFacade` should be used instead of `PaymentTypeService`.
- `ClearCheckoutFacade` should be used instead of `ClearCheckoutService`.

#### ExpressCheckoutService

- The service moved from the `@spartacus/storefront` entry point to `@spartacus/checkout/components`.
- The `CheckoutDeliveryService` constructor parameter is replaced with the `CheckoutDeliveryFacade` from `@spartacus/checkout/root`.
- The `CheckoutPaymentService` constructor parameter is replaced with the `CheckoutPaymentFacade` from `@spartacus/checkout/root`.
- The `CheckoutDetailsService` constructor parameter is now imported from `@spartacus/checkout/components`.
- The `CheckoutConfigService` constructor parameter is now imported from `@spartacus/checkout/components`.
- The `ClearCheckoutService` constructor parameter is replaced with the required `ClearCheckoutFacade` from `@spartacus/checkout/root`.
- The `resetCheckoutProcesses` method was removed. Use the `resetCheckoutProcesses` method from the `ClearCheckoutFacade` instead.

### CostCenterComponent

- The constructor parameter changed type from `CheckoutCostCenterService` to `CheckoutCostCenterFacade`.
- The constructor parameter changed type from `PaymentTypeService` to `PaymentTypeFacade`.

### DeliveryModeComponent

- The constructor parameter changed type from `CheckoutDeliveryService` to `CheckoutDeliveryFacade`.

### PaymentMethodComponent

- The constructor parameter changed type from `CheckoutService` to `CheckoutFacade`.
- The constructor parameter changed type from `CheckoutDeliveryService` to `CheckoutDeliveryFacade`.
- The constructor parameter changed type from `CheckoutPaymentService` to `CheckoutPaymentFacade`.

### PaymentFormComponent

- The constructor parameter changed type `CheckoutPaymentService` to `CheckoutPaymentFacade`.
- The constructor parameter changed type from `CheckoutDeliveryService` to `CheckoutDeliveryFacade`.
- The `PaymentFormComponent` does not implement `OnDestroy` anymore.
- The `ngOnDestroy()` method was removed.
- Address verification uses a new `UserAddressService.verifyAddress` function instead of `CheckoutDeliveryService.verifyAddress`.
- The expiration date has been wrapped to `fieldset` instead of `label`. The `span` has been replaced by `legend` and there are new `label` instead of `div` for every form control (expiration month, expiration year).

### PaymentTypeComponent

- The constructor parameter changed type from `PaymentTypeService` to `PaymentTypeFacade`.

### PlaceOrderComponent

- The constructor parameter changed type from `CheckoutService` to `CheckoutFacade`.

### ReviewSubmitComponent

- The constructor parameter changed type from `CheckoutDeliveryService` to `CheckoutDeliveryFacade`.
- The constructor parameter changed type from `CheckoutPaymentService` to `CheckoutPaymentFacade`.
- The constructor parameter changed type from `PaymentTypeService` to `PaymentTypeFacade`.
- The constructor parameter changed type from `CheckoutCostCenterService` to `CheckoutCostCenterFacade`.
- The `PromotionService` constructor parameter was removed.
- The `orderPromotions$` attribute was removed.
- The component gets promotions directly from the cart in the HTML template.

### ScheduleReplenishmentOrderComponent

- The constructor parameter changed type from `CheckoutService` to `CheckoutFacade`.

### ShippingAddressComponent

- The constructor parameter changed type from `CheckoutDeliveryService` to `CheckoutDeliveryFacade`.
- The constructor parameter changed type from `PaymentTypeService` to `PaymentTypeFacade`.
- The constructor parameter changed type from `CheckoutCostCenterService` to `CheckoutCostCenterFacade`.

### CheckoutEventModule

The `CheckoutEventModule` has one new required constructor parameter: `_checkoutEventListener: CheckoutEventListener`.

To split out the checkout code in the checkout library, the address verification functionality was moved to the `UserAddressService` in the `@spartacus/core` library. The address verification related functions in `CheckoutDeliveryService` and NgRx supporting classes are not present in the checkout library.

### CheckoutDeliveryService

A new `processStateStore: Store<StateWithCheckout>` property is added into the constructor.

The following functions are not present in the checkout library:

- `getAddressVerificationResults(): Observable<AddressValidation | string>`
- `verifyAddress(address: Address): void`
- `clearAddressVerificationResults(): void`

These functions are also not present in the corresponding `CheckoutDeliveryFacade` facade.

### CheckoutState

- The `addressVerification: AddressVerificationState` property is removed from the `CheckoutState` class in the checkout library.

### AddressVerificationState

- The `AddressVerificationState` class is not carried over to the checkout library.

### CheckoutPaymentService

A new `processStateStore: Store<StateWithCheckout>` property is added into the constructor.

### CheckoutService

A new `processStateStore: Store<StateWithCheckout>` property is added into the constructor.

### PaymentTypeService

A new `processStateStore: Store<StateWithCheckout>` property is added into the constructor.

### OrderConfirmationItemsComponent

- The `PromotionService` constructor parameter was removed.
- The `orderPromotions$` attribute was removed.
- The component gets promotions directly from the order in the HTML template.

### OccCheckoutAdapter

- The protected `getEndpoint` method has been removed.
- The following are new methods:
  - `getPlaceOrderEndpoint`
  - `getRemoveDeliveryAddressEndpoint`
  - `getClearDeliveryModeEndpoint`
  - `getLoadCheckoutDetailsEndpoint`

### OccCheckoutPaymentAdapter

- The protected `getCartEndpoint` method has been removed.
- The following are new methods:
  - `getCardTypesEndpoint`
  - `getCreatePaymentDetailsEndpoint`
  - `getPaymentProviderSubInfoEndpoint`
  - `getSetPaymentDetailsEndpoint`

### OccCheckoutCostCenterAdapter

- The protected `getCartEndpoint` method has been removed.
- The new method is `getSetCartCostCenterEndpoint`.

### OccCheckoutDeliveryAdapter

- The protected `getCartEndpoint` method has been removed.
- The following are new methods:
  - `getCreateDeliveryAddressEndpoint`
  - `getDeliveryModeEndpoint`
  - `getDeliveryModesEndpoint`
  - `getSetDeliveryAddressEndpoint`
  - `getSetDeliveryModeEndpoint`

### OccCheckoutPaymentTypeAdapter

- The protected `getCartEndpoint` method has been removed.
- The following are new methods:
  - `getPaymentTypesEndpoint`
  - `getSetCartPaymentTypeEndpoint`

### OccCheckoutReplenishmentOrderAdapter

- The new method is `getScheduleReplenishmentOrderEndpoint`.

### CheckoutComponentModule

The `CheckoutComponentModule` was moved and renamed to `CheckoutComponentsModule`. It was moved to `@spartacus/checkout/components`.  The new module is not exactly the same as the previous one, but the new one should essentially be a superset of the previous one.

### CheckoutModule

The `CheckoutModule` from `@spartacus/core` became `CheckoutCoreModule` in `@spartacus/checkout/core`. The `CheckoutCoreModule` from `@spartacus/checkout/core` fills a similar role as the previous `CheckoutModule` from `@spartacus/core`.  One exception is providing the `CheckoutCartInterceptor`, which is now done in `CheckoutRootModule` from `@spartacus/checkout/root` instead.

**Note:** The new `CheckoutCoreModule` does not have the `forRoot()` method. Just import the `CheckoutCoreModule` instead.

There is still a `CheckoutModule` in `@spartacus/checkout`.  While its name is the same as the previous module from `@spartacus/core`,  it has a different role.  It imports other new checkout library modules: `CheckoutComponentsModule`, `CheckoutCoreModule`, `CheckoutOccModule`.  The new module naming changes might seem confusing at first sight, but the choice of the new names was made to align with the feature library module naming convention in Spartacus.

## Complete List of Symbols (Class, Interface, Const) Moved to the Checkout Library

Imports for these symbols must be updated in custom code.

| Name  | Moved From | Moved To | Renamed To
| ------------- | ------------- | ------------- | ------------- |
| CheckoutLoginComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutLoginModule | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationModule | @spartacus/storefront | @spartacus/checkout/components | - |
| ReplenishmentOrderConfirmationModule | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationGuard | @spartacus/storefront | @spartacus/checkout/components | - |
| GuestRegisterFormComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationItemsComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationOverviewComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationThankYouMessageComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| OrderConfirmationTotalsComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutComponentModule | @spartacus/storefront | @spartacus/checkout/components | CheckoutComponentsModule |
| CheckoutOrchestratorComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutOrchestratorModule | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutOrderSummaryComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutOrderSummaryModule | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressModule | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressMobileBottomComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressMobileBottomModule | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressMobileTopComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutProgressMobileTopModule | @spartacus/storefront | @spartacus/checkout/components | - |
| DeliveryModeComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| DeliveryModeModule | @spartacus/storefront | @spartacus/checkout/components | - |
| PaymentMethodComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| PaymentMethodModule | @spartacus/storefront | @spartacus/checkout/components | - |
| PaymentFormComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| PaymentFormModule | @spartacus/storefront | @spartacus/checkout/components | - |
| PlaceOrderComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| PlaceOrderModule | @spartacus/storefront | @spartacus/checkout/components | - |
| ReviewSubmitComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| ReviewSubmitModule | @spartacus/storefront | @spartacus/checkout/components | - |
| ScheduleReplenishmentOrderComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| ScheduleReplenishmentOrderModule | @spartacus/storefront | @spartacus/checkout/components | - |
| CardWithAddress | @spartacus/storefront | @spartacus/checkout/components | - |
| ShippingAddressComponent | @spartacus/storefront | @spartacus/checkout/components | - |
| ShippingAddressModule | @spartacus/storefront | @spartacus/checkout/components | - |
| DeliveryModePreferences | @spartacus/storefront | @spartacus/checkout/root | - |
| CheckoutConfig | @spartacus/storefront | @spartacus/checkout/root | - |
| CheckoutAuthGuard | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutStepsSetGuard | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutGuard | @spartacus/storefront | @spartacus/checkout/components | - |
| NotCheckoutAuthGuard | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutStepType | @spartacus/storefront | @spartacus/checkout/root | - |
| checkoutShippingSteps | @spartacus/storefront | @spartacus/checkout/root | - |
| checkoutPaymentSteps | @spartacus/storefront | @spartacus/checkout/root | - |
| CheckoutStep | @spartacus/storefront | @spartacus/checkout/root | - |
| CheckoutConfigService | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutDetailsService | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutReplenishmentFormService | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutStepService | @spartacus/storefront | @spartacus/checkout/components | - |
| ExpressCheckoutService | @spartacus/storefront | @spartacus/checkout/components | - |
| CheckoutOccModule | @spartacus/core | @spartacus/checkout/occ | - |
| OccCheckoutCostCenterAdapter | @spartacus/core | @spartacus/checkout/occ | - |
| OccCheckoutDeliveryAdapter | @spartacus/core | @spartacus/checkout/occ | - |
| OccCheckoutPaymentTypeAdapter | @spartacus/core | @spartacus/checkout/occ | - |
| OccCheckoutPaymentAdapter | @spartacus/core | @spartacus/checkout/occ | - |
| OccCheckoutReplenishmentOrderAdapter | @spartacus/core | @spartacus/checkout/occ | -  
| OccCheckoutAdapter | @spartacus/core | @spartacus/checkout/occ | - |
| OccReplenishmentOrderFormSerializer | @spartacus/core | @spartacus/checkout/occ | - |
| CheckoutModule | @spartacus/core | @spartacus/checkout/core | CheckoutCoreModule |
| CheckoutAdapter | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutConnector | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutCostCenterAdapter | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutCostCenterConnector | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutDeliveryAdapter | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutDeliveryConnector | @spartacus/core | @spartacus/checkout/core | - |
| DELIVERY_MODE_NORMALIZER | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutPaymentAdapter | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutPaymentConnector | @spartacus/core | @spartacus/checkout/core | - |
| PAYMENT_DETAILS_SERIALIZER | @spartacus/core | @spartacus/checkout/core | - |
| CARD_TYPE_NORMALIZER | @spartacus/core | @spartacus/checkout/core | - |
| PAYMENT_TYPE_NORMALIZER | @spartacus/core | @spartacus/checkout/core | - |
| PaymentTypeAdapter | @spartacus/core | @spartacus/checkout/core | - |
| PaymentTypeConnector | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutReplenishmentOrderAdapter | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutReplenishmentOrderConnector | @spartacus/core | @spartacus/checkout/core | - |
| REPLENISHMENT_ORDER_FORM_SERIALIZER | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutEventBuilder | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutEventModule | @spartacus/core | @spartacus/checkout/core | - |
| OrderPlacedEvent | @spartacus/core | @spartacus/checkout/root | - |
| CheckoutCostCenterService | @spartacus/core | @spartacus/checkout/root | CheckoutCostCenterFacade |
| CheckoutDeliveryService | @spartacus/core | @spartacus/checkout/root | CheckoutDeliveryFacade |
| CheckoutPaymentService | @spartacus/core | @spartacus/checkout/root | CheckoutPaymentFacade |
| CheckoutService | @spartacus/core | @spartacus/checkout/root | CheckoutFacade |
| PaymentTypeService | @spartacus/core | @spartacus/checkout/root | PaymentTypeFacade |
| ClearCheckoutService | @spartacus/core | @spartacus/checkout/root | ClearCheckoutFacade |
| CheckoutDetails | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutPageMetaResolver | @spartacus/core | @spartacus/checkout/core | - |
| CHECKOUT_FEATURE | @spartacus/core | @spartacus/checkout/core | - |
| CHECKOUT_DETAILS | @spartacus/core | @spartacus/checkout/core | - |
| SET_DELIVERY_ADDRESS_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| SET_DELIVERY_MODE_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| SET_SUPPORTED_DELIVERY_MODE_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| SET_PAYMENT_DETAILS_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| GET_PAYMENT_TYPES_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| SET_COST_CENTER_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| PLACED_ORDER_PROCESS_ID | @spartacus/core | @spartacus/checkout/core | - |
| StateWithCheckout | @spartacus/core | @spartacus/checkout/core | - |
| CardTypesState | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutStepsState | @spartacus/core | @spartacus/checkout/core | - |
| PaymentTypesState | @spartacus/core | @spartacus/checkout/core | - |
| OrderTypesState | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutState | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutActions | @spartacus/core | @spartacus/checkout/core | - |
| CheckoutSelectors | @spartacus/core | @spartacus/checkout/core | - |

## Breaking Changes Introduced in 4.0

### StoreFinderService

- The `platformId` injection was added to the constructor.
- The `getStoreLatitude()` and `getStoreLongitude()` methods have been moved to this service from `StoreDataService`, which has been removed.

### StoreDataService

- The service has been removed and the functions have been moved to `StoreFinderService`.

### AbstractStoreItemComponent

- The `StoreDataService` has been replaced by the `StoreFinderService`.

### StoreFinderListItemComponent

- The `StoreDataService` has been replaced by the `StoreFinderService`.

### StoreFinderListComponent

- The `StoreDataService` has been replaced by the `StoreFinderService`.

### StoreFinderStoreDescriptionComponent

- The `StoreDataService` has been replaced by the `StoreFinderService`.

### GoogleMapRendererService

- The `StoreDataService` has been replaced by the `StoreFinderService`.
- The `ExternalJsFileLoader` has been replaced by the `ScriptLoader`.

### ScheduleComponent

- The `ngOnChanges()` method has been changed to the `ngOnInit()` method, along with the corresponding class implementations (for example, implements `OnChanges` to `OnInit`).
- The `displayDays` variable has been removed. Use `weekDays` instead.
- The `StoreDataService` has been removed`.
- The `getStoreOpeningTime()`, `getStoreClosingTime()`, and `getInitialDate()` methods have been removed. Use `weekDayOpeningList` from `location` instead.

### PromotionService

The `PromotionService` is deleted. The promotions can directly be found on the order or cart. Use other existing services to retrieve the order or cart.

The order promotions are in the order and cart attributes `appliedOrderPromotions` and `potentialOrderPromotions`.

The product promotions for order and cart entries are now available with the `entries[].promotions` attribute.

### SavedCartDetailsActionComponent

- The `ClearCheckoutService` was removed from the constructor.

### SavedCartListComponent

- The `ClearCheckoutService` was removed from the constructor.

### SavedCartFormDialogComponent

- The `ClearCheckoutService` was removed from the constructor.

### AddressBookComponentService

Library: `@spartacus/core`

Class: `AddressBookComponentService`

Change: The `checkoutDeliveryService: CheckoutDeliveryService` constructor parameter is removed.
Instead, the `CheckoutEventListener` from the checkout library listens for the new address change events and resets the checkout delivery accordingly.

### AddressBookComponent

Library: `@spartacus/core`

Class: `AddressBookComponent`

Change: Two constructor parameters are removed. The first is the `checkoutDeliveryService: CheckoutDeliveryService` constructor parameter that has been removed. The `AddressBookComponent` does not call `CheckoutDeliveryService.clearCheckoutDeliveryDetails()` anymore when an address is changed. Instead, the `AddressBookComponentService` fires events. See `AddressBookComponentService` entry above for more information.

The second constructor parameter that is removed is `userAddressService: UserAddressService`. The `UserAddressService` interactions are now encapsulated in `AddressBookComponentService`.

### AddressFormComponent

Library: `@spartacus/core`

Change: The `checkoutDeliveryService: CheckoutDeliveryService` constructor parameter is removed.

The `AddressFormComponent` now uses the new `verifyAddress` address verification function from  `UserAddressService`, instead of the `verifyAddress` function from `CheckoutDeliveryService`. The `UserAddressService.verifyAddress` does not use the NgRx store under the hood.

Change: `TranslationService` is a new, required constructor dependency.

The `AddressFormComponent` now uses translations to show a configurable default title option instead of a hard-coded title.

### UserAddressService

Library: `@spartacus/core`

Change: There are two new required constructor parameters: `userAddressConnector: UserAddressConnector` and `command: CommandService`

### CheckoutDetailsLoadedGuard

Library: `@spartacus/storefront`

The `CheckoutDetailsLoadedGuard` was not used and is now removed.

### PaymentDetailsSetGuard

Library: `@spartacus/storefront`

The `PaymentDetailsSetGuard` was not used and is now removed.

### ShippingAddressSetGuard

Library: `@spartacus/storefront`

The `ShippingAddressSetGuard` was not used and is now removed.

### DeliveryModeSetGuard

Library: `@spartacus/storefront`

The `DeliveryModeSetGuard` was not used and is now removed.

### AddedToCartDialogComponent

- The `PromotionService` constructor parameter was removed.
- The `orderPromotions$` attribute was removed.
- The component gets promotions directly from the cart in the HTML template.
- The `increment` property was removed. Use the `numberOfEntriesBeforeAdd` property instead.

### CartDetailsComponent

- The `PromotionService` constructor parameter was removed.
- The `orderPromotions$` and `promotions$` attributes were removed.
- The component gets promotions directly from the cart in the HTML template.

### CartItemComponent

- The `PromotionService` constructor parameter was removed.
- The component gets product promotions directly from the cart entry data.
- The `ngOnInit()` method was removed
- The `appliedProductPromotions$` attribute was removed.

### CartItemListComponent

- The `FeatureConfigService` constructor dependency was removed.
- New required constructor dependencies were added: `UserIdService` and `MultiCartService`.

### OrderDetailItemsComponent

- The `PromotionService` constructor parameter was removed.
- The `orderPromotions$` attribute was removed.
- The component gets promotions directly from the order in the HTML template.

### SuggestedAddressDialogComponent

The `SuggestedAddressDialogComponent` uses different translation label keys:

- The `checkoutAddress.verifyYourAddress` key is replaced by `addressSuggestion.verifyYourAddress`.
- The `checkoutAddress.ensureAccuracySuggestChange` key is replaced by `addressSuggestion.ensureAccuracySuggestChange`.
- The `checkoutAddress.chooseAddressToUse` key is replaced by `addressSuggestion.chooseAddressToUse`.
- The `checkoutAddress.suggestedAddress` key is replaced by `addressSuggestion.suggestedAddress`.
- The `checkoutAddress.enteredAddress` key is replaced by `addressSuggestion.enteredAddress`.
- The `checkoutAddress.editAddress` key is replaced by `addressSuggestion.editAddress`.
- The `checkoutAddress.saveAddress` key is replaced by `addressSuggestion.saveAddress`.

### OrderOverviewComponent

The `OrderOverviewComponent` uses different translation label keys:

- The `checkoutOrderConfirmation.replenishmentNumber` key is replaced by `orderDetails.replenishmentId`.
- The `checkoutOrderConfirmation.status` key is replaced by `orderDetails.status`.
- The `checkoutOrderConfirmation.active` key is replaced by `orderDetails.active`.
- The `checkoutOrderConfirmation.cancelled` key is replaced by `orderDetails.cancelled`.
- The `checkoutReview.startOn` key is replaced by `orderDetails.startOn`.
- The `checkoutOrderConfirmation.frequency` key is replaced by `orderDetails.frequency`.
- The `checkoutOrderConfirmation.nextOrderDate` key is replaced by `orderDetails.nextOrderDate`.
- The `checkoutOrderConfirmation.orderNumber` key is replaced by `orderDetails.orderNumber`.
- The `checkoutOrderConfirmation.placedOn` key is replaced by `orderDetails.placedOn`.
- The `checkoutReview.poNumber` key is replaced by `orderDetails.purchaseOrderNumber`.
- The `checkoutPO.noPoNumber` key is replaced by `orderDetails.emptyPurchaseOrderId`.
- The `checkoutProgress.methodOfPayment` key is replaced by `orderDetails.methodOfPayment`.
- The `checkoutPO.costCenter` key is replaced by `orderDetails.costCenter`.
- The `checkoutShipping.shippingMethod` key is replaced by `orderDetails.shippingMethod`.
- The `getOrderCurrentDateCardContent` method requires the `isoDate` parameter. It is no longer optional.

### Qualtrics Changes

- `QualtricsConfig` was removed from the `@spartacus/storefrontlib`. Use `@spartacus/qualtrics/components` instead.
- `QUALTRICS_EVENT_NAME` was removed from the `@spartacus/storefrontlib`. Use `@spartacus/qualtrics/components` instead.
- `QualtricsLoaderService` was removed from `@spartacus/storefrontlib`. Use `@spartacus/qualtrics/components` instead.
- `QualtricsLoaderService` from the feature library no longer requires `RendererFactory2`. It has been replaced by `ScriptLoader`.
- `QualtricsComponent` was removed from `@spartacus/storefrontlib`. Use `@spartacus/qualtrics/components` instead.
- `QualtricsModule` was removed from `@spartacus/storefrontlib`, and renamed `QualtricsComponentsModule`. Use `@spartacus/qualtrics/components` instead.

### OccConfigLoaderModule

- The `OccConfigLoaderModule` was removed. Use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccConfigLoaderService

- The `OccConfigLoaderService` was removed. Use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccLoadedConfigConverter

- The `OccLoadedConfigConverter` was removed. Use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccLoadedConfig

- The `OccLoadedConfig` was removed. Use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccSitesConfigLoader

- The `OccSitesConfigLoader`was removed. Use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccEndpoints

The `backend.occ.endpoints.baseSitesForConfig` config property has been removed. Use `backend.occ.endpoints.baseSites` instead.

#### NavigationUIComponent

- The `HamburgerMenuService` was added to the constructor.

### Removal of Grouping Modules

In release 4.0, a number of modules that grouped feature modules and provided some default configuration were removed.

- The `B2cStorefrontModule` was removed from `@spartacus/storefront`
- The `B2bStorefrontModule` was removed from `@spartacus/setup`
- The `StorefrontModule` was removed from `@spartacus/storefront`
- The `CmsLibModule` was removed from `@spartacus/storefront`
- The `MainModule` was removed from `@spartacus/storefront`
- The `StorefrontFoundationModule` was removed from `@spartacus/storefront`
- The `OccModule` was removed from `@spartacus/core`
- The `EventsModule` was removed from `@spartacus/storefront`

For more information, see [{% assign linkedpage = site.pages | where: "name", "updating-to-version-4.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-4/updating-to-version-4.md %}).

### ViewConfigModule Removed

- This module only provided empty default configuration that is not needed.

### EventService

- The `EventService` now registers the parent of an event as an event. For more information, see [Event Type Inheritance]({{ site.baseurl }}/event-service/#event-type-inheritance).

### Changes in the Product Configurator Feature Library

#### MessageConfig

The `MessageConfig` has been renamed to `ConfiguratorMessageConfig`.

#### ConfiguratorAttributeDropDownComponent

The `onSelect` method has been removed and is no longer used. Use `onSelect` from the super class, which takes the value as an argument.

#### ConfiguratorAttributeNumericInputFieldComponent

The `createEventFromInput` method has been removed and is no longer used.

#### ConfiguratorAttributeRadioButtonComponent

The `onDeselect` method has been removed and is no longer used.

#### ConfiguratorGroupMenuComponent

The `preventScrollingOnSpace`, `navigateUpOnEnter` and `clickOnEnter` methods have been removed and are no longer used.

#### ConfiguratorProductTitleComponent

The `getProductImageURL`, `getProductImageAlt` and `clickOnEnter` methods have been removed and are no longer used.

#### ConfiguratorCartService

- The `checkoutService: CheckoutService` constructor parameter type is changed to `checkoutFacade: CheckoutFacade` to adapt to the new checkout library.

- The `cartStore: Store<StateWithMultiCart>` constructor parameter has been removed.

- The `ConfiguratorCartService` now requires the `ConfiguratorUtilsService`.

#### CommonConfiguratorUtilsService

The signature of the `getCartId` method has changed from `getCartId(cart: Cart): string` to `getCartId(cart?: Cart): string`.

#### ConfiguratorGroupsService

- The return parameter of the `getFirstConflictGroup` method has changed from `Configurator.Group` to `Configurator.Group | undefined`.
- The return parameter of the `getMenuParentGroup` method has changed from `Configurator.Group` to `Configurator.Group | undefined`.
- The return parameter of the `getParentGroup` method has changed from `Configurator.Group` to `Configurator.Group | undefined`.
- The return parameter of the `getNextGroupId` method has changed from `Observable<string>` to `Observable<string | undefined>`.
- The return parameter of the `getPreviousGroupId` method has changed from `Observable<string>` to `Observable<string | undefined>`.
- The return parameter of the `getNeighboringGroupId` method has changed from `Observable<string>` to `Observable<string | undefined>`.

#### ConfiguratorUtilsService

- The return parameter of the `getParentGroup` method has changed from `Configurator.Group` to `Configurator.Group | undefined`.

#### New and Renamed Dependencies

- `ConfiguratorCartEntryInfoComponent` now also requires `CommonConfiguratorUtilsService`.
- `ConfiguratorAttributeCheckboxListComponent` now also requires `ConfiguratorAttributeQuantityService`.
- `ConfiguratorAttributeDropDownComponent` now also requires `ConfiguratorAttributeQuantityService`.
- `ConfiguratorAttributeInputFieldComponent` now also requires `ConfiguratorUISettingsConfig`.
- `ConfiguratorAttributeNumericInputFieldComponent` now also requires `ConfiguratorUISettingsConfig`.
- `ConfiguratorAttributeRadiButtonComponent` now also requires `ConfiguratorAttributeQuantityService`.
- `ConfiguratorGroupMenuComponent` now also requires `ConfiguratorGroupMenuService` and `DirectionService`.
- `ConfiguratorStorefrontUtilsService` now also requires `WindowRef` and `KeyboardFocusService`.
- `ConfiguratorFormComponent` now also requires `ConfiguratorStorefrontUtilsService`.
- `ConfiguratorIssuesNotificationComponent` now also requires `CartItemContext`.
- `ConfiguratorOverviewAttributeComponent` now also requires `BreakpointService`.
- `ConfiguratorUpdateMessageComponent` now requires `ConfiguratorMessageConfig` instead of `MessageConfig`.

### LoginRegisterComponent

Library: `@spartacus/user`

Class: `LoginRegisterComponent`

Change: The `checkoutConfigService: CheckoutConfigService` constructor parameter is removed.

The display of the guest checkout button relies on the presence of the `forced` query parameter only.

### NgbTabsetModule

#### StoreFinderComponentsModule

- The deprecated `NgbTabsetModule` import from `@ng-bootstrap/ng-bootstrap` has been replaced with `NgbNavModule` to support version 8 of the library.

#### StoreFinderListComponent

- The mobile template has been updated to use nav instead of tabs. For more information, see this Spartacus GitHub [pull request](https://github.com/SAP/spartacus/pull/12398/files#diff-1db586698a503ea500917fe4d734f84d0729f585aa7c4b56705d9171a38e7f55L64-L120).
- Added styles for `ul.nav` to keep the same appearance.

### ASM Changes

- The `AsmModule` was removed from `@spartacus/storefrontlib`, and renamed to `AsmComponentsModule`. Use `@spartacus/asm/components` instead.
- `AsmModule` was removed from `@spartacus/core`, and renamed to `AsmCoreModule`. Use `@spartacus/asm/core` instead.
- `AsmOccModule` was removed from `@spartacus/core`. Use `@spartacus/asm/occ` instead.
- `OccAsmAdapter` was removed from `@spartacus/core`. Use `@spartacus/asm/occ` instead.
- `AsmConfig` was removed from `@spartacus/core`. Use `@spartacus/asm/core`.
- `AsmAdapter` was removed. Use `@spartacus/asm/core` instead.
- `AsmConnector` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH_PAGE_NORMALIZER` was removed. Use `@spartacus/asm/core` instead.
- `AsmService` was removed. Use `@spartacus/asm/core` instead.
- `CsAgentAuthService` was removed. Use `@spartacus/asm/root` instead.
- `CustomerSearchPage` was removed. Use `@spartacus/asm/core` instead.
- `CustomerSearchOptions` was removed. Use `@spartacus/asm/core` instead.
- `AsmUi` was removed. Use `@spartacus/asm/core` instead.
- `AsmAuthHttpHeaderService` was removed. Use `@spartacus/asm/root` instead.
- `TOKEN_TARGET` was removed. Use `@spartacus/asm/root` instead.
- `AsmAuthService` was removed. Use `@spartacus/asm/root` instead.
- `AsmAuthStorageService` was removed. Use `@spartacus/asm/root` instead.
- `SYNCED_ASM_STATE` was removed. Use `@spartacus/asm/core` instead.
- `AsmStatePersistenceService` was removed. Use `@spartacus/asm/core` instead.
- `ASM_UI_UPDATE` was removed. Use `@spartacus/asm/core` instead.
- `AsmUiUpdate` was removed. Use `@spartacus/asm/core` instead.
- `AsmUiAction` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH_FAIL` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH_SUCCESS` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH_RESET` was removed. Use `@spartacus/asm/core` instead.
- `CustomerSearch` was removed. Use `@spartacus/asm/core` instead.
- `CustomerSearchFail` was removed. Use `@spartacus/asm/core` instead.
- `CustomerSearchSuccess` was removed. Use `@spartacus/asm/core` instead.
- `CustomerSearchReset` was removed. Use `@spartacus/asm/core` instead.
- `CustomerAction` was removed. Use `@spartacus/asm/core` instead.
- `LOGOUT_CUSTOMER_SUPPORT_AGENT` was removed. Use `@spartacus/asm/core` instead.
- `LogoutCustomerSupportAgent` was removed. Use `@spartacus/asm/core` instead.
- `ASM_FEATURE` was removed. Use `@spartacus/asm/core` instead.
- `CUSTOMER_SEARCH_DATA` was removed. Use `@spartacus/asm/core` instead.
- `StateWithAsm` was removed. Use `@spartacus/asm/core` instead.
- `AsmState` was removed. Use `@spartacus/asm/core` instead.
- `getAsmUi` was removed. Use `@spartacus/asm/core` instead.
- `getCustomerSearchResultsLoaderState` was removed. Use `@spartacus/asm/core` instead.
- `getCustomerSearchResults` was removed. Use `@spartacus/asm/core` instead.
- `getCustomerSearchResultsLoading` was removed. Use `@spartacus/asm/core` instead.
- `getAsmState` was removed. Use `@spartacus/asm/core` instead.

### LaunchDialogService

#### SavedCartFormLaunchDialogService

- The `SavedCartFormLaunchDialogService` service has been removed. The `openDialog` method is part of the `LaunchDialogService` now.

#### AddToSavedCartComponent

- The `SavedCartFormLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### SavedCartDetailsActionComponent

- The `SavedCartFormLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### SavedCartDetailsOverviewComponent

- The `SavedCartFormLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### AnonymousConsentLaunchDialogService

- The `AnonymousConsentLaunchDialogService` service has been removed. The `openDialog` method is part of `LaunchDialogService` now.

#### AnonymousConsentManagementBannerComponent

- The `AnonymousConsentLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### AnonymousConsentOpenDialogComponent

- The `AnonymousConsentLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### ReplenishmentOrderCancellationLaunchDialogService

- The `ReplenishmentOrderCancellationLaunchDialogService` service has been removed. The `openDialog` method is part of `LaunchDialogService` now.

#### ReplenishmentOrderCancellationComponent

- The `ReplenishmentOrderCancellationLaunchDialogService` was removed from the constructor.
- The `LaunchDialogService` was added to the constructor.

#### OrderHistoryComponent

- The `div` that wrapped the `cx-sorting` component has been changed to `label` and `span` was added before field.

#### OrderReturnRequestListComponent

- The `div` that wrapped the `cx-sorting` component has been changed to `label` and `span` was added before field.

#### ReplenishmentOrderHistoryComponent

- The `ReplenishmentOrderCancellationLaunchDialogService` was removed from the constructor.
- the `LaunchDialogService` was added to the constructor.
- The `div` that wrapped the `cx-sorting` component has been changed to `label` and  `span` was added before field.

#### ProductListComponent

- Two `div` elements that wrapped the `cx-sorting` component have been merged to one `label` and `span` was added before field.

### SmartEdit

- `SmartEditModule` was removed. Use `@spartacus/smartedit` instead.
- `SmartEditService` was moved to `@spartacus/smartedit/core`.

### Personalization

- `PersonalizationModule` was removed. Use `@spartacus/tracking/personalization` instead.
- `PersonalizationConfig` was moved to `@spartacus/tracking/personalization/root`.
- `PersonalizationContextService` was moved to `@spartacus/tracking/personalization/core`.
- `PersonalizationAction` was moved to `@spartacus/tracking/personalization/core`.
- `PersonalizationContext` was moved to `@spartacus/tracking/personalization/core`.

### WindowRef

- `platformId` is now a required constructor dependency.

### ProductListComponentService

- `ProductListComponentService` now also requires `ViewConfig`.
- The `defaultPageSize` property was removed. To modify the default page size, use `provideConfig(<ViewConfig>{ view: { defaultPageSize: <your_default_page_size_value }})` in the module.

### Product reloading

- The `reload` method was removed from `ProductService`. Instead, use the [reloading triggers]({{ site.baseurl }}/loading-scopes/#reloading-triggers).
- The `EventService` from `@spartacus/core` was added as a parameter to the constructor for the `ProductLoadingService`.

### Product Variants Changes

#### Automated Migrations for Version 4.0

- `ProductVariantsModule` was removed from `@spartacus/storefront`. Use the `@spartacus/product/variants` feature library instead.
- `ProductVariantsComponent` was removed from `@spartacus/storefront`. Use `ProductVariantsContainerComponent` from `@spartacus/product/variants/components` instead.
- `VariantColorSelectorComponent` was removed from `@spartacus/storefront`. Use `ProductVariantColorSelectorComponent` from `@spartacus/product/variants/components` instead.
- `VariantColorSelectorModule` was removed from `@spartacus/storefront`. Use `ProductVariantColorSelectorModule` from `@spartacus/product/variants/components` instead.
- `VariantSizeSelectorComponent` was removed from `@spartacus/storefront`. Use `ProductVariantSizeSelectorComponent` from `@spartacus/product/variants/components` instead.
- `VariantSizeSelectorModule` was removed from `@spartacus/storefront`. Use `ProductVariantSizeSelectorModule` from `@spartacus/product/variants/components` instead.
- `VariantStyleSelectorComponent` was removed from `@spartacus/storefront`. Use `ProductVariantStyleSelectorComponent` from `@spartacus/product/variants/components` instead.
- `VariantStyleSelectorModule` was removed from `@spartacus/storefront`. Use `ProductVariantStyleSelectorModule` from `@spartacus/product/variants/components` instead.
- `VariantStyleIconsComponent` was removed from `@spartacus/storefront`. Use `ProductVariantStyleIconsComponent` from `@spartacus/product/variants/root` instead.
- `ProductVariantStyleIconsComponent` was moved from `@spartacus/product/variants/components`to `@spartacus/product/variants/root` instead.
- `VariantStyleIconsModule` was removed from `@spartacus/storefront`. Use `ProductVariantStyleIconsModule` from `@spartacus/product/variants/root` instead.
- `ProductVariantStyleIconsModule` was moved from `@spartacus/product/variants/components`to `@spartacus/product/variants/root` instead.
- `ProductVariantGuard` was removed from `@spartacus/storefront`. Use `ProductVariantsGuard` from `@spartacus/product/variants/components` instead. Additionally, the `findVariant` method was renamed to `findPurchasableProductCode`.
- `AuthHttpHeaderService` now requires `AuthRedirectService`.
- `AsmAuthHttpHeaderService` now requires `AuthRedirectService`.
- `AuthRedirectService` now requires `AuthFlowRoutesService`.
- `RoutingService` now requires `Location` from `@angular/common`.
- `ProtectedRoutesService` now requires `UrlParsingService`.
- `EventService` no longer uses `FeatureConfigService`.
- `PageEventModule` was removed. Instead, use `NavigationEventModule` from `@spartacus/storefront`.
- `PageEventBuilder` was removed. Instead, use `NavigationEventBuilder` from `@spartacus/storefront`.
- `CartPageEventBuilder` no longer uses `ActionsSubject` and `FeatureConfigService`
- `HomePageEventBuilder` no longer uses `FeatureConfigService`.
- `ProductPageEventBuilder` no longer uses `FeatureConfigService`.
- `PageEvent` no longer contains the `context`, `semanticRoute`, `url` and `params` properties. These are now contained in the `PageEvent.navigation` object.
- `EventsModule` was removed. Use individual imports instead (for example, `CartPageEventModule`, `ProductPageEventModule`, and so on).

#### Product Variants i18n

- The `variant` translation namespace was removed from `@spartacus/assets`. Use the `productVariants` namespace that can be imported with `productVariantsTranslations` and `productVariantsTranslationChunksConfig` from `@spartacus/product/variants/assets` instead. Translation keys from this namespace did not changed.

#### Product Variants Endpoint Scope

- The `variants` scope was removed from `defaultOccProductConfig`. It is now provided by `ProductVariantsOccModule` under `@spartacus/product/variants/occ` instead. Additionally, the endpoint now uses the `orgProducts` API instead of `products`.

#### ProductVariantStyleIconsComponent

- `ProductVariantStyleIconsComponent` changed its constructor dependency from `ProductListItemContextSource` to `ProductListItemContext`.

#### Product Variants Styles

- Styles for `cx-product-variants` were removed from `@spartacus/styles`. Use the `@spartacus/product/variants` import instead.

### Feature Keys for Product Configurators

The feature keys that are used to lazy load the product configurator libraries in `app.module.ts` were available as `rulebased` and `productConfiguratorRulebased` from 3.1 onwards (respective `textfield` and `productConfiguratorTextfield` for the textfield template configurator).

In 4.0, only the longer versions `productConfiguratorRulebased` and `productConfiguratorTextfield` are possible.

The following is an example of a configuration for Spartacus prior to 4.0:

```ts
      featureModules: {
        rulebased: {
          module: () => import('@spartacus/product-configurator/rulebased').then(
          (m) => m.RulebasedConfiguratorModule
        ),
        },
      }
```

With Spartacus 4.0, the configuration needs to appear as follows:

```ts
      featureModules: {
        productConfiguratorRulebased: {
          module: () => import('@spartacus/product-configurator/rulebased').then(
          (m) => m.RulebasedConfiguratorModule
        ),
        },
      }
```

### Translations (i18n) changed

- The `asm.standardSessionInProgress` key was removed.
- The `pageMetaResolver.checkout.title_plurar` key was removed.
- The value of `pageMetaResolver.checkout.title` has been changed to `Checkout`.

### Storage Sync Mechanism

In version 4.0, the storage sync mechanism that was deprecated in version 3.0 has now been removed. In the previous major release, Spartacus provided a more powerful mechanism based on `StatePersistenceService`, which can cover all use cases for synchronizing data to and from the browser storage (such as `localStorage` and `sessionStorage`), and it does this better than the removed storage sync.

The following was removed:

- The core of the mechanism (reducer)
- The configuration (`storageSync` from `StateConfig`)
- The default config and default keys (`defaultStateConfig`, `DEFAULT_LOCAL_STORAGE_KEY` and `DEFAULT_SESSION_STORAGE_KEY`)

### DefaultScrollConfig

- The `defaultScrollConfig` was renamed to `defaultViewConfig`

### BaseSiteService

- The `BaseSiteService.initialize` method was removed. Use `BaseSiteServiceInitializer.initialize` instead.
- A `BaseSiteService.isInitialized` method was added.

### LanguageService

- The `LanguageService.initialize` method was removed. Use `LanguageInitializer.initialize` instead.
- A `LanguageService.isInitialized` method was added.
- `LanguageService` no longer uses `WindowRef`. The language initialization from the state was moved to `LanguageInitializer`.
- `LanguageService` now validates the value passed to the `setActive()` method against the ISO codes listed in the Spartacus `context` config, before setting the actual value in the NgRx store.
- The initialization of the site context is scheduled a bit earlier than it was before (now it is run in an observable stream instead of a Promise's callback). It is a very slight change, but might have side effects in some custom implementations.
- The active language is now persisted in the Local Storage instead of the Session Storage.

### CurrencyService

- The `CurrencyService.initialize` method was removed. Use `CurrencyInitializer.initialize` instead.
- A `CurrencyService.isInitialized` method was added.
- `CurrencyService` no longer uses `WindowRef`. The currency initialization from the state was moved to `CurrencyInitializer`.
- `CurrencyService` now validates the value passed to the `setActive()` method against the ISO codes listed in the Spartacus `context` config, before setting the actual value in the RgRx store.
- The initialization of the site context is scheduled a bit earlier than it was before (now it is run in an observable stream instead of a Promise's callback). It is a very slight change, but might have side effects in some custom implementations.
- The active currency is now persisted in the LocalStorage instead of the Session Storage.

### Page Resolvers

In 3.1 and 3.2, Spartacus introduced a few changes on how page meta data is collected. The resolvers are now configurable, and you can also configure whether the resolvers render on the client (CSR) or server (SSR). By default, description, image, robots and canonical URL are resolved only in SSR. A few resolvers have been changed or added, since most data is now configurable in the back end (such as description and robots). The robot information that was previously hardcoded in some resolvers is now driven by back end data.

Resolving the canonical URL has been enabled by default in 4.0. If you want to opt-out, change the Spartacus configuration of `pageMeta.resolvers`.

A new feature has been added to the product and category resolvers for the canonical URL.

The `BasePageMetaResolver` is leveraged to compose most of the generic page meta data. Most page resolvers now use the page data to create the description and robot tags. The changes affect the following resolver classes:

- The `PageMetaService` has a dependency on `UnifiedInjector`, `PageMetaConfig` and the `platformId`.
- The `ContentPageMetaResolver` depends only on the `BasePageMetaResolver`.
- The `BasePageMetaResolver` requires the `Router` and `PageLinkService` to add canonical links to the page meta.
- The `ProductPageMetaResolver` requires the `BasePageMetaResolver` and `PageLinkService`.
- The `CategoryPageMetaResolver` requires the `BasePageMetaResolver`.
- The `SearchPageMetaResolver` requires the `BasePageMetaResolver`.
- The `CheckoutPageMetaResolver` uses the `BasePageMetaResolver`.
- The `OrganizationPageMetaResolver` no longer uses the `BasePageMetaResolver`.
- The `RoutingService` uses the `Router` to resolve the full URL (used to resolve the canonical URL in the page meta resolvers)

The `CmsPageTitleModule` is renamed to `PageMetaModule`.

The `CartPageMetaResolver` is removed because all content is resolved by the generic `ContentPageMetaResolver`.

The following properties where removed in 4.0:

- The `ContentPageMetaResolver` no longer supports the `homeBreadcrumb$`,`breadcrumb$`,`title$` and `cms$` because the content is resolved by the `BasePageMetaResolver`.
- The `resolverMethods` property on the `PageMetaService` has changed to `resolvers$` because the resolvers are read from the configuration stream.

### SelectiveCartService

- The `getLoaded` method was removed. Use the `isStable` method instead.

### DynamicAttributeService

- The `DynamicAttributeService` does not depend anymore on the `SmartEditService`, but only on the `UnifiedInjector`.
- The `addDynamicAttributes` method was removed. Use the `addAttributesToComponent` or `addAttributesToSlot` functions instead.

### SearchBoxComponentService

- The `SearchBoxComponentService` now also requires the `EventService`.

### CartListItemComponent

- The `FeatureConfigService` was removed from the constructor and the `UserIdService` and `MultiCartService` were added to the constructor.
- The `form: FormGroup` property is now initialized on component creation instead of in the `createForm()` method.
- The `ngOnInit()` method has been modified to fix an issue with rendering items.
- The `[class.is-changed]` template attribute on `<div>` tag now depends on the `control.get('quantity').disabled` method.

### Models

- The `Item` interface was removed. Use `OrderEntry` instead.
- `sortCode` was removed from the `TableHeader` interface.

### SearchBoxComponent

- The `RoutingService` is a new, required constructor dependency.
- `cx-icon[type.iconTypes.RESET]` has been changed to `button>cx-icon[type.iconTypes.Reset]`
- `cx-icon[type.iconstypes.SEARCH]` has been changed to `div>cx-icon[type.iconstypes.SEARCH]` with the rest of the attributes removed. The button is for presentation purpose only.
- `div.suggestions` has been changed to `ul>li>a` for better a11y support
- `div.products` has been changed to `ul>li>a` for better a11y support
- `winRef.document.querySelectorAll('.products > a, .suggestions > a')` has been changed to  `winRef.document.querySelectorAll('.products > li a, .suggestions > li a')`

### Organization Administration Breaking Changes

#### CardComponent (Administration)

- The `displayCloseButton` property in the `cxPopoverOptions` attribute of the `button.hint-popover` element has been set to `true`.

#### ListComponent

- The `displayCloseButton` property in the `cxPopoverOptions` attribute of the `button.hint-popover` element has been set to `true`.
- `ng-select` for sort has been wrapped by `label` and `span` has been added before.

#### UserGroupUserListComponent

- The `MessageService` was removed from the constructor.

#### ToggleStatusComponent

- The `FeatureConfigService` was removed from the constructor.
- The `DisableInfoService` was added to the constructor.

#### DeleteItemComponent

- The `FeatureConfigService` was removed from the constructor.

#### UnitChildrenComponent

- The `CurrentUnitService` is now a required parameter in the component constructor.

#### UnitCostCenterListComponent

- The `CurrentUnitService` is now a required parameter in the component constructor.

#### UnitUserListComponent

- The `CurrentUnitService` is now a required parameter in the component constructor.

#### UnitFormComponent

- The `formGroup` property was renamed to `form`.
- The `form$` property was removed.

#### OrganizationTableType

- The unused `UNIT_ASSIGNED_ROLES` property was removed from the enum.

#### HttpErrorModel

- The `error` property was removed from the interface.

#### Organization Related Translations (i18n) Changes

The contents of the following were changed:

- `orgBudget.messages.deactivate`
- `orgCostCenter.messages.deactivate`
- `orgPurchaseLimit.messages.deactivate`
- `orgUnit.messages.deactivate`
- `orgUnitAddress.messages.delete`
- `orgUserGroup.messages.delete`
- `orgUser.messages.deactivate`

The following unused keys were removed:

- `orgBudget.messages.deactivateBody`
- `orgBudget.byName`
- `orgBudget.byUnitName`
- `orgBudget.byCode`
- `orgBudget.byValue`
- `orgCostCenter.messages.deactivateBody`
- `orgCostCenter.byName`
- `orgCostCenter.byCode`
- `orgCostCenter.byUnitName`
- `orgPurchaseLimit.messages.deactivateBody`
- `orgPurchaseLimit.byName`
- `orgPurchaseLimit.byUnitName`
- `orgUnit.messages.deactivateBody`
- `orgUnitAddress.messages.deleteBody`
- `orgUserGroup.messages.deleteBody`
- `orgUserGroup.byName`
- `orgUserGroup.byUnitName`
- `orgUserGroup.byGroupID`
- `orgUser.messages.deactivateBody`
- `orgUser.byName`
- `orgUser.byUnitName`
  
### Dependencies Changes

- The `i18next-xhr-backend` peer dependency package was replaced with `i18next-http-backend`.
- The `i18next` peer dependency package was upgraded to version `20.2.2`

### CmsFeaturesService

- The `CmsComponentsService` constructor is now using `CmsFeaturesService` (replacing `FeatureModulesService`) and `ConfigInitializerService`.
- The `FeatureModulesService` was removed. It is replaced by the `CmsFeaturesService`.

### ConfigInitializerService

- The `getStableConfig` method was removed. Use the new equivalent `getStable` method instead.

### CartItemComponent

The `CartItemComponent` now also requires `CartItemContextSource`. Furthermore, a customized version of this component now also should provide `CartItemContextSource` and `CartItemContext` locally as follows:

```typescript
@Component({
  providers: [
    CartItemContextSource,
    { provide: CartItemContext, useExisting: CartItemContextSource },
  ],
  /* ... */
})
```

### ProductListItemComponent and ProductGridItemComponent

The `ProductListItemComponent` and `ProductGridItemComponent` now require `ProductListItemContextSource`. Furthermore, customized versions of those components now also should provide `ProductListItemContextSource` and `ProductListItemContext` locally as follows:

```typescript
@Component({
  providers: [
    ProductListItemContextSource,
    { provide: ProductListItemContext, useExisting: ProductListItemContextSource },
  ],
  /* ... */
})
```

### CartItemContext and CartItemContextSource

- The `promotionLocation$` property has been removed. Use `location$` instead.

### User Lib Changes

#### CMS Components

- The following modules were moved to `@spartacus/user/profile/components`:

  - `CloseAccountModule`
  - `ForgotPasswordModule`
  - `RegisterComponentModule`
  - `ResetPasswordModule`
  - `UpdateEmailModule`
  - `UpdatePasswordModule`
  - `UpdateProfileModule`

- The following modules were moved to `@spartacus/user/account/components`:

  - `LoginModule`
  - `LoginFormModule`
  - `LoginRegisterModule`

- The `ResetPasswordFormComponent` component was renamed to `ResetPasswordComponent` and can now be used from `@spartacus/user/profile/components`. The logic for this component was also changed. See below for more information.
- The `UpdateEmailFormComponent` component was removed. Use `UpdateEmailComponent` from `@spartacus/user/profile/components` instead.
- The `UpdatePasswordFormComponent` component was removed. Use `UpdatePasswordComponent` from `@spartacus/user/profile/components` instead.
- The `UpdateProfileFormComponent` component was removed. Use `UpdateProfileComponent` from `@spartacus/user/profile/components` instead.
- The `CloseAccountComponent`, `CloseAccountModalComponent`, `ForgotPasswordComponent`, `RegisterComponent`, `UpdateEmailComponent`, `UpdatePasswordComponent`, and `UpdateProfileComponent` components were moved to `@spartacus/user/profile/components`. The logic for these components was also changed. See below for more information.
- The `LoginComponent` and `LoginFormComponent` components were moved to `@spartacus/user/account/components`. The logic for these components was also changed. See below for more information.
- The `LoginRegisterComponent` component was moved to `@spartacus/user/account/components`.

#### CloseAccountModalComponent

- All services used in the constructor have been changed to `protected`.
- The component no longer uses the `UserService`.
- The `UserProfileFacade` was introduced.
- The component no longer uses the `Subscription` property.
- The `ngOnDestroy` method was removed.

#### ForgotPasswordComponent

- The `forgotPasswordForm` property was renamed to `form`.
- A new observable `isUpdating$` property was added.
- The `ngOnInit` and `requestForgotPasswordEmail` methods were removed. A new `onSubmit` method was added.
- The `FormBuilder`, `UserService`, `RoutingService`, and `AuthConfigService` services are no longer used directly in the component file. A new `ForgotPasswordComponentService` service was added and is used in the constructor.
- The change detection strategy for this component was set to `OnPush`.
- There were slight changes in the component template. A spinner component was added which relies on the `isUpdating$` property. Also, the form is now using the `onSubmit` method for form submit events.

#### RegisterComponent

- The component no longer uses `UserService`.
- The `UserRegisterFacade` was introduced.
- The `loading$` property was changed to `isLoading$` and the type was changed from `Observable<boolean>` to `BehaviorSubject<boolean>`.
- The `registerUserProcessInit` method was removed.

#### ResetPasswordComponent (Previously ResetPasswordFormComponent)

- The `subscription` property was removed.
- The type of the `token` property was changed from `string` to `Observable<string>`.
- The `resetPasswordForm` property was renamed to `form`.
- A new observable `isUpdating$` property was added.
- The `ngOnInit`, `resetPassword`, and `ngOnDestroy` methods were removed.
- A new `onSubmit` method was added.
- The `FormBuilder`, `UserService`, and `RoutingService` services are no longer used directly in the component file. A new `ResetPasswordComponentService` service was added and is used in the constructor.
- The change detection strategy for this component was set to `OnPush`.
- The component template was adapted to the new logic.
- A spinner component was added which relies on the `isUpdating$` property.

#### LoginComponent

- The component no longer uses `UserService`.
- The `UserAccountFacade` was introduced.
- The `user` property type was changed from `Observable<User>` to `Observable<User | undefined>`.

#### LoginFormComponent

- The `AuthService`, `GlobalMessageService`, `FormBuilder`, and `WindowRef` services are no longer used directly in the component file. A new `LoginFormComponentService` service was added and is used in the constructor.
- The `ngOnInit`, `submitForm`, and `loginUser` methods were removed from the component file.
- New `form` and `isUpdating$`properties were added.
- New `onSubmit` method was added.
- The change detection strategy for this component was set to `OnPush`.
- A spinner component was added to the template which relies on the `isUpdating$` property.

#### UpdateEmailComponent

- The `subscription`, `newUid`, and `isLoading$` properties were removed.
- The `ngOnInit`, `onCancel`, `onSuccess`, and `ngOnDestroy` methods were removed from the component file.
- The `GlobalMessageService`, `UserService`, `RoutingService`, and `AuthService` services are no longer used directly in the component file. A new `UpdateEmailComponentService` service was added and is used in the constructor.
- The logic for the `onSubmit` method was changed. Now this method has no parameters.
- New `form` and `isUpdating$` properties were added.
- There were important change in the component template. Because the `UpdateEmailFormComponent` was removed, the `UpdateEmailComponent` now contains the template for the update email form itself.
- The change detection strategy for this component was set to `OnPush`.
- A spinner component was added to the template which relies on the `isUpdating$` property.

#### UpdateEmailComponentService

- The `UpdateEmailComponentService` now also requires the `AuthRedirectService`.

#### UpdatePasswordComponent

- The `subscription` and `loading$` properties were removed.
- The `ngOnInit`, `onCancel`, `onSuccess`, and `ngOnDestroy` methods were removed from the component file.
- The `RoutingService`, `UserService`, and `GlobalMessageService` services are no longer used directly in the component file. A new `UpdatePasswordComponentService` service was added and is used in the constructor.
- The logic for the `onSubmit` method was changed. Now this method has no parameters.
- New `form` and `isUpdating$` properties were added.
- There were important change in the component template. Because the `UpdatePasswordFormComponent` was removed, the `UpdatePasswordComponent` now contains the template for the update password form itself.
- The change detection strategy for this component was set to `OnPush`.
- A spinner component was added to the template which relies on the `isUpdating$` property.

#### UpdateProfileComponent

- THe `user$` and `loading$` properties were removed.
- The `ngOnInit`, `onCancel`, `onSuccess`, and `ngOnDestroy` methods were removed from the component file.
- The `RoutingService`, `UserService`, and `GlobalMessageService` services are no longer used directly in the component file. A new `UpdateProfileComponentService` service was added and is used in the constructor.
- The logic for the `onSubmit` method was changed. Now this method has no parameters.
- New `form` and `isUpdating$` properties were added.
- There were important change in the component template. Because the `UpdateProfileFormComponent` was removed, the `UpdateProfileComponent` now contains the template for the update profile form itself.
- The change detection strategy for this component was set to `OnPush`.
- A spinner component was added to the template which relies on the `isUpdating$` property.

### MyCouponsComponent

- The `div` that wrapped the `cx-sorting` component has been changed to `label` with a `span` added before.

#### OccUserAdapter

- The `OccUserAdapter` was removed. Use the `OccUserAccountAdapter` from `@spartacus/user/account/occ` and the `OccUserProfileAdapter` from `@spartacus/user/profile/occ` instead.
- The `remove` method was removed. Use the `close` method instead.

#### UserAdapter

- The `UserAdapter` was removed. Use the `UserAccountAdapter` from `@spartacus/user/account/core` and the `UserProfileAdapter` from `@spartacus/user/profile/core` instead.
- The `remove` method was removed. Use the `close` method instead.

#### UserConnector

- The `UserConnector` was removed. Use the `UserAccountConnector` from `@spartacus/user/account/core` and the `UserProfileConnector` from `@spartacus/user/profile/core` instead.
- The `remove` method now returns the `close` method from the adapter (name change).

#### OccEndpoints

- The `user`endpoint was removed from the declaration in `@spartacus/core`. It is now provided through module augmentation from `@spartacus/user/account/occ`. The default value is also provided from this new entry point.
- The `titles`, `userRegister`, `userForgotPassword`, `userResetPassword`, `userUpdateLoginId`, `userUpdatePassword`, `userUpdateProfile`, and `userCloseAccount` endpoints were removed from the declaration in `@spartacus/core`. These endpoints are now provided through module augmentation from `@spartacus/user/profile`. Default values are also provided from this new entry point.

#### UserService

- The `get` method was changed, and now fully relies on `UserAccountFacade.get()` from `@spartacus/user`.
- The `load` method was removed. Use `UserAccountFacade.get()` from `@spartacus/user` instead.
- The `register` method was removed. Use `UserRegisterFacade.register()` from `@spartacus/user` instead.
- The `registerGuest` method was removed. Use `UserRegisterFacade.registerGuest()` from `@spartacus/user` instead.
- The `getRegisterUserResultLoading` method was removed. Instead, subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the loading state.
- The `getRegisterUserResultSuccess` method was removed. Instead, subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the success state.
- The `getRegisterUserResultError` method was removed. Instead, subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the error state.
- The `resetRegisterUserProcessState` method was removed and is no longer needed if `UserRegisterFacade.register()`from `@spartacus/user` was used.
- The `remove` method was removed. Use `UserProfileFacade.close()` from `@spartacus/user` instead.
- The `loadTitles` method was removed. Use `UserProfileFacade.getTitles()` from `@spartacus/user` instead.
- The `getRemoveUserResultLoading` method was removed. Instead, subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the loading state.
- The `getRemoveUserResultSuccess` method was removed. Instead, subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the success state.
- The `getRemoveUserResultError` method was removed. Instead, subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the error state.
- The `resetRemoveUserProcessState` method was removed and is no longer needed if `UserProfileFacade.close()`from `@spartacus/user` was used.
- The `isPasswordReset` method was removed. Instead, subscribe to `UserPasswordFacade.reset()` from `@spartacus/user` to get the success state.
- The `updatePersonalDetails` method was removed. Use `UserProfileFacade.update()` from `@spartacus/user` instead.
- The `getUpdatePersonalDetailsResultLoading` method was removed. Instead, subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the loading state.
- The `getUpdatePersonalDetailsResultError` method was removed. Instead, subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the error state.
- The `getUpdatePersonalDetailsResultSuccess` method was removed. Instead, subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the success state.
- The `resetUpdatePersonalDetailsProcessingState` method was removed and is no longer needed if `UserProfileFacade.update()` from `@spartacus/user` was used.
- The `resetPassword` method was removed. Use `UserPasswordFacade.reset()` from `@spartacus/user` instead.
- The `requestForgotPasswordEmail` method was removed. Use `UserPasswordFacade.requestForgotPasswordEmail()` from `@spartacus/user` instead.
- The `updateEmail` method was removed. Use `UserEmailFacade.update()` from `@spartacus/user` instead.
- The `getUpdateEmailResultLoading` method was removed. Instead, subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the loading state.
- The `getUpdateEmailResultSuccess` method was removed. Instead, subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the success state.
- The `getUpdateEmailResultError` method was removed. Instead, subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the error state.
- The `resetUpdateEmailResultState` method was removed and is no longer needed if `UserEmailFacade.update()` from `@spartacus/user` was used.
- The `updatePassword` method was removed. Use `UserPasswordFacade.update()` from `@spartacus/user` instead.
- The `getUpdatePasswordResultLoading` method was removed. Instead, subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the loading state.
- The `getUpdatePasswordResultError` method was removed. Instead, subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the error state.
- The `getUpdatePasswordResultSuccess` method was removed. Instead, subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the success state.
- The `resetUpdatePasswordProcessState` method was removed and is no longer needed if `UserPasswordFacade.update()` from `@spartacus/user` was used.

#### UserModule

- The `UserModule` was removed. The main modules currently are `UserAccountModule` in `@spartacus/user/account` and `UserProfileModule` in `@spartacus/user/profile`.

#### Occ Endpoint Models

- The `UserSignUp` model was moved to the `@spartacus/user/profile` library.

#### NgRx State of the User Feature

The `'account'`, `'titles'`, and `'resetPassword'` branches of the NgRx state for the User feature were removed. Please use the new approach with Queries and Commands that is defined in the new facades in `@spartacus/user` the library, as follows:

- `UserAccountFacade` from `'@spartacus/user/account/root'`
- `UserEmailFacade` from `'@spartacus/user/profile/root'`
- `UserPasswordFacade` from `'@spartacus/user/profile/root'`
- `UserProfileFacade` from `'@spartacus/user/profile/root'`
- `UserRegisterFacade` from `'@spartacus/user/profile/root'`

The following items related to the NgRx state were removed from `@spartacus/core`:

- Actions:
  - `ForgotPasswordEmailRequest`
  - `ForgotPasswordEmailRequestFail`
  - `ForgotPasswordEmailRequestSuccess`
  - `ResetPassword`
  - `ResetPasswordFail`
  - `ResetPasswordSuccess`
  - `LoadTitles`
  - `LoadTitlesFail`
  - `LoadTitlesSuccess`
  - `UpdateEmailAction`
  - `UpdateEmailSuccessAction`
  - `UpdateEmailErrorAction`
  - `ResetUpdateEmailAction`
  - `UpdatePassword`
  - `UpdatePasswordFail`
  - `UpdatePasswordSuccess`
  - `UpdatePasswordReset`
  - `LoadUserDetails`
  - `LoadUserDetailsFail`
  - `LoadUserDetailsSuccess`
  - `UpdateUserDetails`
  - `UpdateUserDetailsFail`
  - `UpdateUserDetailsSuccess`
  - `ResetUpdateUserDetails`
  - `RegisterUser`
  - `RegisterUserFail`
  - `RegisterUserSuccess`
  - `ResetRegisterUserProcess`
  - `RegisterGuest`
  - `RegisterGuestFail`
  - `RegisterGuestSuccess`
  - `RemoveUser`
  - `RemoveUserFail`
  - `RemoveUserSuccess`
  - `RemoveUserReset`
- Effects:
  - `ForgotPasswordEffects`
  - `ResetPasswordEffects`
  - `TitlesEffects`
  - `UpdateEmailEffects`
  - `UpdatePasswordEffects`
  - `UserDetailsEffects`
  - `UserRegisterEffects`
- Selectors:
  - `getResetPassword`
  - `getDetailsState`
  - `getDetails`
  - `getTitlesState`
  - `getTitlesEntites`
  - `getAllTitles`
  - `titleSelectorFactory`
- Reducers for the `account`, `titles`, and `resetPassword` states were removed.

#### Connectors

- `TITLE_NORMALIZER` was moved to `@spartacus/user/profile`.
- `USER_SIGN_UP_SERIALIZER` was moved to `@spartacus/user/profile`.
- `USER_SERIALIZER` was removed. Use `USER_ACCOUNT_SERIALIZER` from `@spartacus/user/account` and `USER_PROFILE_SERIALIZER` from `@spartacus/user/profile` instead.
- `USER_NORMALIZER` was removed. Use `USER_ACCOUNT_NORMALIZER` from `@spartacus/user/account` and `USER_PROFILE_NORMALIZER` from `@spartacus/user/profile` instead.

#### StoreFinderListItemComponent

- The `div[class.cx-store-name]` element was changed to `h2[class.cx-store-name]`.

#### StoreFinderStoresCountComponent

- The `div[class.cx-title]` element was changed to `h2[class.cx-title]`.

#### StoreFinderListItemComponent

- The `div[class.cx-total]` element was changed to `h4[class.cx-total]`.

#### CartItemComponent

- The `{{item.product.name}}` element was changed to `<h2>{{item.product.name}}</h2>`.

#### OrderSummaryComponent

- The `<h4>{{ 'orderCost.orderSummary' | cxTranslate }}</h4>` element was changed to `<h3>{{ 'orderCost.orderSummary' | cxTranslate }}</h3>`.

#### DeliveryModeComponent

- The `h3[class.cx-checkout-title]` element was changed to `h2[class.cx-checkout-title]`.

#### PaymentMethodComponent

- The `h3[class.cx-checkout-title]` element was changed to `h2[class.cx-checkout-title]`.

#### ReviewSubmitComponent

- The `h3[class.cx-review-title]` element was changed to `h2[class.cx-review-title]`.
- The `div[class.cx-review-cart-total]` element was changed to `h4[class.cx-review-cart-total]`.

#### ShippingAddressComponent

- The `h3[class.cx-checkout-title]` element was changed to `h2[class.cx-checkout-title]`.

#### CmsPageTitleComponent

- A new interface has been created.

#### CmsBreadcrumbsComponent

- The `CmsBreadcrumbsComponent` now extends the `CmsPageTitleComponent`.
- The `container` property has been moved to the `CmsPageTitleComponent`.

#### BreadcrumbComponent

- The `BreadcrumbComponent` now extends the `PageTitleComponent`.
- The `setTitle()` function has been moved to the `PageTitleComponent`.

#### PageTitleComponent

- The `PageTitleComponent` is a new component that sets the page title if there is not one set by default.

#### NavigationUiComponent

- The `<h5><cx-icon ...></h5>` element was changed to `<span><cx-icon ...></span>`.
- The `h5[attr.aria-label]="node.title"` element was changed to `span[attr.aria-label]="node.title"`.

#### ProductCarouselComponent

- The `<h4>{{item.name}}</h4>` element was changed to `<h3>{{item.name}}</h3>`.

#### WishListItemComponent

- The `<a>{{ cartEntry.product.name }}</a>` element was changed to `<a><h2>{{ cartEntry.product.name }}</h2></a>`.

#### CardComponent

- The `h4[class.cx-card-title]` element was changed to `h3[class.cx-card-title]`.

#### CarouselComponent

- The `<h3 *ngIf="title">{{ title }}</h3>` element was changed to `<h2 *ngIf="title">{{ title }}</h2>`.

#### AddedToCartDialogComponent

- The `[attr.aria-label]="'common.close' | cxTranslate"` element was changed to `attr.aria-label="{{ 'addToCart.closeModal' | cxTranslate }}"`.

#### Translations (i18n) changes

- The `miniLogin.userGreeting` key was moved to a separate library. It is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `miniLogin.signInRegister` key was moved to the separate `@spartacus/user` library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.signIn` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.register` key was moved to a separate library. It is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.dontHaveAccount` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.guestCheckout` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.emailAddress.label` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.emailAddress.placeholder` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.password.label` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.password.placeholder` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.wrongEmailFormat` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `loginForm.forgotPassword` key was moved to a separate library. Is is now a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- The `updateEmailForm.newEmailAddress.label` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.newEmailAddress.placeholder` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.confirmNewEmailAddress.label` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.confirmNewEmailAddress.placeholder` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.enterValidEmail` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.bothEmailMustMatch` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.password.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.password.placeholder` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.pleaseInputPassword` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `updateEmailForm.emailUpdateSuccess` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.resetPassword` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.enterEmailAddressAssociatedWithYourAccount` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.emailAddress.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.emailAddress.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.enterValidEmail` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.passwordResetEmailSent` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `forgottenPassword.passwordResetSuccess` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.confirmPassword.action` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.confirmPassword.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.confirmPassword.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.managementInMyAccount` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.termsAndConditions` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.signIn` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.register` key was moved to a separate library. Is is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.confirmNewPassword` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.resetPassword` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.createAccount` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.title` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.firstName.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.firstName.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.lastName.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.lastName.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.emailAddress.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.emailAddress.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.password.label` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.password.placeholder` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.newPassword` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.emailMarketing` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.confirmThatRead` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.selectTitle` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.passwordMinRequirements` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.bothPasswordMustMatch` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.titleRequired` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `register.postRegisterMessage` key was moved to a separate library. It is now a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- The `myCoupons.sortByMostRecent` key has been removed. Use `myCoupons.sortBy` instead.
- The `myInterests.sortByMostRecent` key has been removed. Use `myInterests.sortBy` instead.
- The `orderHistory.sortByMostRecent` key has been removed. Use `orderHistory.sortBy` instead.
- The `returnRequestList.sortByMostRecent` key has been removed. Use `returnRequestList.sortBy` instead.
- The `productList.sortByMostRecent` key has been removed. Use `productList.sortBy` instead.

### Default Routing Configuration for the My Company Feature

The default routing configuration for the **My Company** pages was moved from various modules in `@spartacus/organization/administration/components` to `OrganizationAdministrationRootModule` in `@spartacus/organization/administration/root`. As a result, the default configuration is now provided eagerly, so it is available early on app start (but not only after the feature is lazy loaded). Also, the following objects were renamed and moved to `@spartacus/organization/administration/root`:

- `budgetRoutingConfig` was renamed to `defaultBudgetRoutingConfig`
- `costCenterRoutingConfig` was renamed to `defaultCostCenterRoutingConfig`
- `permissionRoutingConfig` was renamed to `defaultPermissionRoutingConfig`
- `unitsRoutingConfig` was renamed to `defaultUnitsRoutingConfig`
- `userGroupRoutingConfig` was renamed to `defaultUserGroupRoutingConfig`
- `userRoutingConfig` was renamed to `defaultUserRoutingConfig`

#### Checkout-Related Translations (i18n) Changes

The checkout-related translation keys were moved to `@spartacus/checkout/assets`. If you use any checkout-related labels outside of checkout and the checkout library is not used, you will need to use alternate translation labels.

- The `checkoutAddress.verifyYourAddress` key is moved to `addressSuggestion.verifyYourAddress`.
- The `checkoutAddress.ensureAccuracySuggestChange` key is moved to `addressSuggestion.ensureAccuracySuggestChange`.
- The `checkoutAddress.chooseAddressToUse` key is moved to `addressSuggestion.chooseAddressToUse`.
- The `checkoutAddress.suggestedAddress` key is moved to `addressSuggestion.suggestedAddress`.
- The `checkoutAddress.enteredAddress` key is moved to `addressSuggestion.enteredAddress`.
- The `checkoutAddress.editAddress` key is moved to `addressSuggestion.editAddress`.
- The `checkoutAddress.saveAddress` key is moved to `addressSuggestion.saveAddress`.
- The `checkoutOrderConfirmation.replenishmentNumber` key is removed. You can use `` instead.
- The `checkoutOrderConfirmation.placedOn` key is removed. You can use `orderDetails.placedOn` instead.
- The `checkoutOrderConfirmation.status` key is removed. You can use `orderDetails.status` instead.
- The `checkoutOrderConfirmation.active` key is removed. You can use `orderDetails.active` instead.
- The `checkoutOrderConfirmation.cancelled` key is removed. You can use `orderDetails.cancelled` instead.
- The `checkoutOrderConfirmation.frequency` key is removed. You can use `orderDetails.frequency` instead.
- The `checkoutOrderConfirmation.nextOrderDate` key is removed. You can use `orderDetails.nextOrderDate` instead.
- The `checkoutOrderConfirmation.orderNumber` key is removed. You can use `orderDetails.orderNumber` instead.

#### Changes in Styles

- The styles for the following selectors were moved from `@spartacus/styles` to `@spartacus/user/profile/styles`:

  - `cx-close-account-modal`
  - `cx-close-account`
  - `cx-forgot-password`
  - `cx-register`
  - `cx-update-password-form`
  - `cx-user-form`

- The styles for the following selectors were moved from `@spartacus/styles` to `@spartacus/user/account/styles`:

  - `cx-login`
  - `cx-login-form`

### LogoutGuard

- `AuthRedirectService` is a new, required constructor dependency.

### RoutingService

- The `RoutingService.go` signature was changed. Prior to 4.0, an object with query params could be passed in the second argument. Now, the second argument is an Angular `NavigationExtras` object (with a `'queryParams'` property).
- The `RoutingService.navigate` signature was changed. Prior to 4.0, an object with query params could be passed in the second argument. Now, the second argument is an Angular `NavigationExtras` object (with a `'queryParams'` property).

### RoutingActions RgRx

The following NgRx actions have been removed:

- `RoutingActions.RouteGo` (and `RoutingActions.ROUTER_GO`). Use the `go()` method of the the `RoutingService` instead.
- `RoutingActions.RouteGoByUrlAction` (and `RoutingActions.ROUTER_GO_BY_URL`). Use the `goByUrl()` method of the the `RoutingService` instead.
- `RoutingActions.RouteBackAction` (and `RoutingActions.ROUTER_BACK`). Use the `back()` method of the the `RoutingService` instead.
- `RoutingActions.RouteForwardAction` (and `RoutingActions.ROUTER_FORWARD`). Use the `forward()` method of the the `RoutingService` instead.

### AuthRedirectService

- The `#reportNotAuthGuard` method is not needed anymore. Every visited URL is now remembered automatically as a redirect URL on a `NavigationEnd` event.
- The `#reportAuthGuard` method is deprecated. Use the new `#saveCurrentNavigationUrl` method instead. It remembers the anticipated page when being invoked during the navigation.

### OccEndpointsService

- The `getEndpoint` method was removed. Use `buildUrl` instead, with the `endpoint` string and the `propertiesToOmit` matching your desired URL.
- The `getOccEndpoint` method was removed. Use `buildUrl` instead, with the `endpoint` string and the `propertiesToOmit` matching your desired URL.
- The `getBaseEndpoint` method was removed. Use `buildUrl` method instead, with configurable endpoints or the `getBaseUrl` method.
- The `getUrl` method was removed. Use the `buildUrl` method instead. The `buildUrl` method has the same first parameter as `getUrl`. The second, third and fourth parameters of `getUrl` are merged into the second argument object of `buildUrl` with the `urlParams`, `queryParams` and `scope` properties.
- The `getRawEndpoint` method was removed. Use `buildUrl` with configurable endpoints or the `getRawEndpointValue` method instead.

### Modal Service

- The `FeatureConfigService` was removed from the constructor.
- `ApplicationRef` is a new, required constructor dependency.

### ExternalJsFileLoader

- The service was removed from `@spartacus/core`. Use `ScriptLoader` instead.

### CxApi

- The following public members of `CxApi` were removed:

  - `CheckoutService`
  - `CheckoutDeliveryService`
  - `CheckoutPaymentService`

### TabParagraphContainerComponent

- `WindowRef` and `BreakpointService` are now required parameters in the constructor.
- All services used in constructor have been changed to `protected`.

### b2cLayoutConfig

- `b2cLayoutConfig` was removed from `@spartacus/storefront`. Use the layout from the corresponding feature library instead.

### UnitAddressFormService

- The `UserService` param that was imported from `@spartacus/core` was removed from the constructor. Instead, a new `UserAddressService` param from `@spartacus/user/profile/root` was added.

### GuestRegisterFormComponent

- The `UserService` param that was imported from `@spartacus/core` was removed from the constructor. Instead, a new `UserRegisterFacade` param from `@spartacus/user/profile/root` was added.

### UserIdService

- The `invokeWithUserId` method was removed. Use `takeUserId` instead.

### PopoverDirective

- The `PopoverDirective` class now implements `ngOnInit`.
- The `PositioningService` was removed from the constructor.
- The `openPopover` and `closePopover` event emitters are no longer optional.
- A new `eventSubject: Subject<PopoverEvent>` property was added.
- The `handleOpen` and `toggle` methods were removed.
- The following new methods were added:
  - `handleEscape`
  - `handleClick`
  - `handlePress`
  - `handleTab`

### PopoverService

- The `event` argument of the `getFocusConfig` method changed type from `Event` to `PopoverEvent`.

### PopoverComponent

- The `insideClicked` property was removed.
- `button.close` has been moved into a `div.cx-close-row`

### OnNavigateFocusService

- The `document` injection param was removed from the constructor.
- The `WindowRef` param was added into the constructor.

### Facade Factories Are Now Inlined

- Facade factories are now inlined into an `@Injectable` decorator. The following symbols are not needed anymore and were removed:
  - `userAccountFacadeFactory`
  - `UserEmailFacadeFactory`
  - `UserPasswordFacadeFactory`
  - `UserProfileFacadeFactory`
  - `UserRegisterFacadeFactory`
  - `savedCartFacadeFactory`
  - `cdcAuthFacadeFactory`
