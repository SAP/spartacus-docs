---
title: Technical Changes in Spartacus 4.0
---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

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

- The first parameter of the `provideConfig` function changed type from `any` to `Config`
- The first parameter of the `provideDefaultConfig` function changed type from `any` to `Config`

### ConfigModule

- The parameter of the `withConfig` method changed type from `object` to `Config`
- The parameter of the `forRoot` method changed type from `any` to `Config`

### Config injection tokens

- The `Config` injection token was replaced with an injectable `Config` abstract class.
- The `ConfigChunk` injection token is now of type `Config[]` (from `object[]`)
- The `DefaultConfigChunk` injection token is now of type `Config[]` (from `object[]`)

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

- type `ConfigValidator` changed from `(config: any) => string | void` to `(config: Config) => string | void`
- first parameter of function `validateConfig` changed from `any` to `Config`

### ConfigInitializer

- `ConfigInitializer.configFactory` signature changed from `() => Promise<any>` to `() => Promise<Config>`.

### ConfigurationService

- `unifiedConfig$` type changed from `Observable<any>` to `Observable<Config>`
- `config` type changed from `any` to `Config`
- constructor changed from

    ```ts
    constructor(
      @Inject(RootConfig) protected rootConfig: any,
      @Inject(DefaultConfig) protected defaultConfig: any,
      protected unifiedInjector: UnifiedInjector,
      @Inject(Config) config: any
    )
    ```

    to

    ```ts
    constructor(
      @Inject(RootConfig) protected rootConfig: Config,
      @Inject(DefaultConfig) protected defaultConfig: Config,
      protected unifiedInjector: UnifiedInjector,
      config: Config
    )
    ```

### Feature config utils

- `isFeatureLevel` first parameter type changed from `unknown` to `Config`
- `isFeatureEnabled` first parameter type changed from `unknown` to `Config`

### MediaService

- constructor changed from

    ```ts
    constructor(
      @Inject(Config) protected config: StorefrontConfig,
      protected breakpointService: BreakpointService
    ) {}
    ```

    to

    ```ts
    constructor(
      protected config: Config
    ) {}
    ```
- `getMedia` now supports `role` attribute

### ModalService

- `ModalService` no longer depends on `FeatureConfigService`. But `ApplicationRef` is now a new required dependency.

#### Product configurator configuration

- `productConfigurator` configuration option is now optional (properties `updateDebounceTime` and `cpq` from this options are now also optional)
- `backend.cpq` configuration option is now optional

#### SmartEditConfig

- `smartEdit` property is optional
- `smartEdit.storefrontPreviewRoute` property is optional
- `smartEdit.allowOrigin` property is optional

#### PersonalizationConfig

- `personalization` property is optional

#### CmsStructureConfig

- `cmsStructure` property is optional

#### PageComponentModule

- Exposes `forRoot()` method, to minimize side-effects of frequent import in dependant modules. `PageComponentModule.forRoot()` is now imported in `BaseStorefrontModule`.

## New Checkout Library

Spartacus 4.0 introduces the checkout library.  The checkout related code is moved out of `@spartacus/core` and `@spartacus/storefrontlib` into one of the checkout lib's entry points.  The checkout library is split into the following entry points:

```text
@spartacus/checkout/assets 
The checkout related i18n keys are moved here.

@spartacus/checkout/components
Checkout related UI code is moved here. This includes components, guards and ui services.

@spartacus/checkout/core
The checkout facade API implementation are moved here, as well as connectors, event builder, event listener, models, other services, and state management.

@spartacus/checkout/occ
The checkout related OCC code is moved here. This includes the checkout related adapters and converters.

@spartacus/checkout/root
The root entry point is, by convention, meant to always be eager loaded.  It contains the config, events, facades, http interceptors and models.

@spartacus/checkout/styles
The checkout related scss styles are moved here.
```

Most of the code is moved unchanged, but some classes required changes after they were moved.  See the section below for the list:

### Use Facades Instead of Services

Some services are now available through facades. Facades should be used instead. The main advantage to use facades instead of their service implementation is that the facades support lazy loading. Facades are imported from `@spartacus/checkout/root`.

- `CheckoutCostCenterFacade` should be used instead of `CheckoutCostCenterService`

- `CheckoutDeliveryFacade` should be used instead of `CheckoutDeliveryService`

- `CheckoutPaymentFacade` should be used instead of `CheckoutPaymentService`

- `CheckoutFacade` should be used instead of `CheckoutService`

- `PaymentTypeFacade` should be used instead of `PaymentTypeService`

- `ClearCheckoutFacade` should be used instead of `ClearCheckoutService`

#### ExpressCheckoutService

- Service moved from `@spartacus/storefront` entry point to `@spartacus/checkout/components`.
- `CheckoutDeliveryService` constructor parameter replaced with `CheckoutDeliveryFacade` from `@spartacus/checkout/root`.
- `CheckoutPaymentService` constructor parameter replaced with `CheckoutPaymentFacade` from `@spartacus/checkout/root`.
- `CheckoutDetailsService` constructor parameter is now imported from `@spartacus/checkout/components`.
- `CheckoutConfigService` constructor parameter is now imported from `@spartacus/checkout/components`.
- `ClearCheckoutService` constructor parameter replaced with required `ClearCheckoutFacade` from `@spartacus/checkout/root`.
- Method `resetCheckoutProcesses` was removed, use method `resetCheckoutProcesses` from `ClearCheckoutFacade` instead.

### CostCenterComponent

constructor parameter of type `CheckoutCostCenterService` is now of type `CheckoutCostCenterFacade`
constructor parameter of type `PaymentTypeService` is now of type `PaymentTypeFacade`

### DeliveryModeComponent

constructor parameter of type `CheckoutDeliveryService` is now of type `CheckoutDeliveryFacade`

### PaymentMethodComponent

constructor parameter of type `CheckoutService` is now of type `CheckoutFacade`
constructor parameter of type `CheckoutDeliveryService` is now of type `CheckoutDeliveryFacade`
constructor parameter of type `CheckoutPaymentService` is now of type `CheckoutPaymentFacade`

### PaymentFormComponent

constructor parameter of type `CheckoutPaymentService` is now of type `CheckoutPaymentFacade`
constructor parameter of type `CheckoutDeliveryService` is now of type `CheckoutDeliveryFacade`
PaymentFormComponent does not implement `OnDestroy` anymore
method `ngOnDestroy()` removed.
Address verification uses new `UserAddressService.verifyAddress` function instead of `CheckoutDeliveryService.verifyAddress`.
expiration date has been wrapped to `fieldset` instead of `label`. `span` has been replaced with `legend` and there are new `label` instead of `div` per every form control (expiration month, expiration year).

### PaymentTypeComponent

constructor parameter of type `PaymentTypeService` is now of type `PaymentTypeFacade`

### PlaceOrderComponent

constructor parameter of type `CheckoutService` is now of type `CheckoutFacade`

### ReviewSubmitComponent

constructor parameter of type `CheckoutDeliveryService` is now of type `CheckoutDeliveryFacade`
constructor parameter of type `CheckoutPaymentService` is now of type `CheckoutPaymentFacade`
constructor parameter of type `PaymentTypeService` is now of type `PaymentTypeFacade`
constructor parameter of type `CheckoutCostCenterService` is now of type `CheckoutCostCenterFacade`
Removed constructor parameter `PromotionService`

Removed the attribute orderPromotions$
The component gets promotions directly from the cart in the html template.

### ScheduleReplenishmentOrderComponent

constructor parameter of type `CheckoutService` is now of type `CheckoutFacade`

### ShippingAddressComponent

constructor parameter of type `CheckoutDeliveryService` is now of type `CheckoutDeliveryFacade`
constructor parameter of type `PaymentTypeService` is now of type `PaymentTypeFacade`
constructor parameter of type `CheckoutCostCenterService` is now of type `CheckoutCostCenterFacade`

### CheckoutEventModule

Change: One new required constructor parameters `_checkoutEventListener: CheckoutEventListener`

To split out the checkout code in the checkout lib, the address verification functionality
was moved in `UserAddressService` in @spartacus/core.  The address verification related functions in `CheckoutDeliveryService` and ngrx supporting classes are not present in the checkout lib.

### CheckoutDeliveryService

New property `processStateStore: Store<StateWithCheckout>` is added into the constructor.

These functions are not present in the checkout lib:

- `getAddressVerificationResults(): Observable<AddressValidation | string>`
- `verifyAddress(address: Address): void`
- `clearAddressVerificationResults(): void`

These functions are also not present in the corresponding facade `CheckoutDeliveryFacade`

### CheckoutState

Property `addressVerification: AddressVerificationState` is removed from the `CheckoutState` class in the checkout lib.

### AddressVerificationState

The `AddressVerificationState` class is not carried over to the checkout lib.

### CheckoutPaymentService

New property `processStateStore: Store<StateWithCheckout>` is added into the constructor.

### CheckoutService

New property `processStateStore: Store<StateWithCheckout>` is added into the constructor.

### PaymentTypeService

New property `processStateStore: Store<StateWithCheckout>` is added into the constructor.

### OrderConfirmationItemsComponent

Removed constructor parameter `PromotionService`
Removed the attribute orderPromotions$
The component gets promotions directly from the order in the html template.

### OccCheckoutAdapter

Protected method `getEndpoint` has been removed. There are new methods: `getPlaceOrderEndpoint`, `getRemoveDeliveryAddressEndpoint`, `getClearDeliveryModeEndpoint`, `getLoadCheckoutDetailsEndpoint`.

### OccCheckoutPaymentAdapter

Protected method`getCartEndpoint` has been removed. There are new methods: `getCardTypesEndpoint`, `getCreatePaymentDetailsEndpoint`, `getPaymentProviderSubInfoEndpoint`, `getSetPaymentDetailsEndpoint`.

### OccCheckoutCostCenterAdapter

Protected method`getCartEndpoint` has been removed. There is a new method: `getSetCartCostCenterEndpoint`.

### OccCheckoutDeliveryAdapter

Protected method`getCartEndpoint` has been removed. There are new methods: `getCreateDeliveryAddressEndpoint`, `getDeliveryModeEndpoint`, `getDeliveryModesEndpoint`, `getSetDeliveryAddressEndpoint`, `getSetDeliveryModeEndpoint`.

### OccCheckoutPaymentTypeAdapter

Protected method`getCartEndpoint` has been removed. There are new methods: `getPaymentTypesEndpoint`, `getSetCartPaymentTypeEndpoint`.

### OccCheckoutReplenishmentOrderAdapter

There is a new method: `getScheduleReplenishmentOrderEndpoint`.

### CheckoutComponentModule

`CheckoutComponentModule` was and renamed to `CheckoutComponentsModule`. It was moved to `@spartacus/checkout/components`.  The new module is, not exactly the same as the previous one, but the new one should essentially be a superset of the previous one.

### CheckoutModule

The `CheckoutModule` from `@spartacus/core` became `CheckoutCoreModule` in `@spartacus/checkout/core`.  `CheckoutCoreModule` from `@spartacus/checkout/core` fills a similar role as the previous `CheckoutModule` from `@spartacus/core`.  One exception is providing the `CheckoutCartInterceptor`, which is now done in `CheckoutRootModule` from `@spartacus/checkout/root` instead.
(Note: The new `CheckoutCoreModule` doesn't have the method `forRoot()` - please just import `CheckoutCoreModule` instead.)

There is still a `CheckoutModule` in `@spartacus/checkout`.  While its name is the same as the previous module from `@spartacus/core`,  his role is different.  It imports other new checkout lib modules: `CheckoutComponentsModule`, `CheckoutCoreModule`, `CheckoutOccModule`.  The new module naming changes might seem confusing at first sight, but the choice of the new names were made to align with the feature libs module naming convention in Spartacus.

## Complete List of Symbols (class, interface, const) Moved to the Checkout Library

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

- Added `platformId` injection to constructor.
- Methods `getStoreLatitude()` and `getStoreLongitude()` have been moved to this service from removed `StoreDataService`.

### StoreDataService

- Service has been removed and functions moved to `StoreFinderService`.

### AbstractStoreItemComponent

- `StoreDataService` has been replaced with `StoreFinderService`.

### StoreFinderListItemComponent

- `StoreDataService` has been replaced with `StoreFinderService`.

### StoreFinderListComponent

- `StoreDataService` has been replaced with `StoreFinderService`.

### StoreFinderStoreDescriptionComponent

- `StoreDataService` has been replaced with `StoreFinderService`.

### GoogleMapRendererService

- `StoreDataService` has been replaced with `StoreFinderService`.
- `ExternalJsFileLoader` has been replaced with `ScriptLoader`.

### ScheduleComponent

- `ngOnChanges()` has been changed to `ngOnInit()` along with corresponding class implementations (ie. implements `OnChanges` to `OnInit`).
- `displayDays` variable has been removed. Use `weekDays` instead.
- `StoreDataService` has been removed`.
- Methods `getStoreOpeningTime()`, `getStoreClosingTime()`, `getInitialDate()` have been removed. Use `weekDayOpeningList` from `location` instead.

### PromotionService

PromotionService is deleted.  The promotions can directly be found on the order or cart.  Use other existing services to retrieve the Order or cart.

The order promotions are in the order/cart attributes `appliedOrderPromotions` and `potentialOrderPromotions`

The product promotions for order/cart entries are now available via the attribute `entries[].promotions`

### SavedCartDetailsActionComponent

- Removed `ClearCheckoutService` from constructor.

### SavedCartListComponent
- Removed `ClearCheckoutService` from constructor.

### SavedCartFormDialogComponent
- Removed `ClearCheckoutService` from constructor.

### AddressBookComponentService
Lib: @spartacus/core
Class: AddressBookComponentService
Change: constructor parameter `checkoutDeliveryService: CheckoutDeliveryService` is removed.
Instead, the `CheckoutEventListener` from the checkout lib listens for the new address change events and resets the checkout delivery accordingly.

### AddressBookComponent
Lib: @spartacus/core
Class: AddressBookComponent
Change: Two constructor parameters are removed.  First the constructor parameter `checkoutDeliveryService: CheckoutDeliveryService` is removed.
AddressBookComponent does not call `CheckoutDeliveryService.clearCheckoutDeliveryDetails()` anymore when an address is changed.  Instead, `AddressBookComponentService` fires events.  See `AddressBookComponentService` migration doc.

The second constructor parameters removed is `userAddressService: UserAddressService`. `UserAddressService` interactions are now encapsulated in `AddressBookComponentService`.

### AddressFormComponent
Lib: @spartacus/core
Change: constructor parameter `checkoutDeliveryService: CheckoutDeliveryService` is removed.
AddressFormComponent now uses the new address verification function from  `UserAddressService` called `verifyAddress` instead of the `verifyAddress` function from `CheckoutDeliveryService`.  `UserAddressService.verifyAddress` does not use the ngrx store under the hood.

Change: `TranslationService` is a new, required constructor dependency.
AddressFormComponent now uses translations to show a configurable default title option instead of a hard coded title.

### UserAddressService
Lib: @spartacus/core
Change: Two new required constructor parameters `userAddressConnector: UserAddressConnector` and `command: CommandService`

### CheckoutDetailsLoadedGuard
Lib: @spartacus/storefront
CheckoutDetailsLoadedGuard was not used and is now removed.

### PaymentDetailsSetGuard
Lib: @spartacus/storefront
PaymentDetailsSetGuard was not used and is now removed.

### ShippingAddressSetGuard
Lib: @spartacus/storefront
ShippingAddressSetGuard was not used and is now removed.

### DeliveryModeSetGuard
Lib: @spartacus/storefront
DeliveryModeSetGuard was not used and is now removed.

### AddedToCartDialogComponent
- Removed constructor parameter `PromotionService`
- Removed the attribute orderPromotions$
- The component gets promotions directly from the cart in the html template.
- The `increment` property was removed. Use property `numberOfEntriesBeforeAdd` instead.


### CartDetailsComponent
- Removed constructor parameter `PromotionService`
- Removed the attributes `orderPromotions$` and `promotions$`.
- The component gets promotions directly from the cart in the html template.



### CartItemComponent
- Removed constructor parameter `PromotionService`
- The component gets product promotions directly from the cart entry data.
- Removed the `ngOnInit()` method
- Removed the attribute `appliedProductPromotions$`


### CartItemListComponent
- removed constructor dependency `FeatureConfigService`
- added new required constructor dependencies `UserIdService` and `MultiCartService`

### OrderDetailItemsComponent
Removed constructor parameter `PromotionService`
Removed the attribute orderPromotions$
The component gets promotions directly from the order in the html template.

### SuggestedAddressDialogComponent

SuggestedAddressDialogComponent uses different translation label keys:

- Key `checkoutAddress.verifyYourAddress` is replaced by `addressSuggestion.verifyYourAddress`.
- Key `checkoutAddress.ensureAccuracySuggestChange` is replaced by `addressSuggestion.ensureAccuracySuggestChange`.
- Key `checkoutAddress.chooseAddressToUse` is replaced by `addressSuggestion.chooseAddressToUse`.
- Key `checkoutAddress.suggestedAddress` is replaced by `addressSuggestion.suggestedAddress`.
- Key `checkoutAddress.enteredAddress` is replaced by `addressSuggestion.enteredAddress`.
- Key `checkoutAddress.editAddress` is replaced by `addressSuggestion.editAddress`.
- Key `checkoutAddress.saveAddress` is replaced by `addressSuggestion.saveAddress`.

### OrderOverviewComponent

OrderOverviewComponent uses different translation label keys:

- Key `checkoutOrderConfirmation.replenishmentNumber` is replaced by `orderDetails.replenishmentId`.
- Key `checkoutOrderConfirmation.status` is replaced by `orderDetails.status`.
- Key `checkoutOrderConfirmation.active` is replaced by `orderDetails.active`.
- Key `checkoutOrderConfirmation.cancelled` is replaced by `orderDetails.cancelled`.
- Key `checkoutReview.startOn` is replaced by `orderDetails.startOn`.
- Key `checkoutOrderConfirmation.frequency` is replaced by `orderDetails.frequency`.
- Key `checkoutOrderConfirmation.nextOrderDate` is replaced by `orderDetails.nextOrderDate`.
- Key `checkoutOrderConfirmation.orderNumber` is replaced by `orderDetails.orderNumber`.
- Key `checkoutOrderConfirmation.placedOn` is replaced by `orderDetails.placedOn`.
- Key `checkoutReview.poNumber` is replaced by `orderDetails.purchaseOrderNumber`.
- Key `checkoutPO.noPoNumber` is replaced by `orderDetails.emptyPurchaseOrderId`.
- Key `checkoutProgress.methodOfPayment` is replaced by `orderDetails.methodOfPayment`.
- Key `checkoutPO.costCenter` is replaced by `orderDetails.costCenter`.
- Key `checkoutShipping.shippingMethod` is replaced by `orderDetails.shippingMethod`.
- The `getOrderCurrentDateCardContent` method requires `isoDate` parameter. It is no longer optional.

### Qualtrics changes

- `QualtricsConfig` was removed from storefrontlib. Use @spartacus/qualtrics/components instead.
- `QUALTRICS_EVENT_NAME` was removed from storefrontlib. Use @spartacus/qualtrics/components instead.
- `QualtricsLoaderService` was removed from storefrontlib. Use @spartacus/qualtrics/components instead.
- `QualtricsLoaderService` from the feature-lib no longer requires `RendererFactory2`. It has been replaced with `ScriptLoader`.
- `QualtricsComponent` was removed from storefrontlib. Use @spartacus/qualtrics/components instead.
- `QualtricsModule` was removed from storefrontlib, and renamed QualtricsComponentsModule. Use @spartacus/qualtrics/components instead.

### OccConfigLoaderModule
- `OccConfigLoaderModule` was removed. Please use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccConfigLoaderService
- `OccConfigLoaderService` was removed. Please use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccLoadedConfigConverter
- `OccLoadedConfigConverter` was removed. Please use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccLoadedConfig 
- `OccLoadedConfig` was removed. Please use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccSitesConfigLoader 
- `OccSitesConfigLoader`was removed. Please use `SiteContextConfigInitializer` and `I18nConfigInitializer` instead.

### OccEndpoints
The config property `backend.occ.endpoints.baseSitesForConfig` has been removed. Please use `backend.occ.endpoints.baseSites` instead.

#### NavigationUIComponent

- Added `HamburgerMenuService` to constructor.

### Removal of grouping modules

In 4.0 release we removed few modules that were grouping feature modules and provided some default configuration.

To migrate them check this section: `Before migrating to Spartacus 4.0`

- removed `B2cStorefrontModule` from `@spartacus/storefront`
- removed `B2bStorefrontModule` from `@spartacus/setup`
- removed `StorefrontModule` from `@spartacus/storefront`
- removed `CmsLibModule` from `@spartacus/storefront`
- removed `MainModule` from `@spartacus/storefront`
- removed `StorefrontFoundationModule` from `@spartacus/storefront`
- removed `OccModule` from `@spartacus/core`
- removed `EventsModule` from `@spartacus/storefront`

### ViewConfigModule removed

This module only provided empty default configuration that is not needed. This module was pretty much useless.

### EventService

- `EventService` will now register event's parent as an event. For more, see [this docs page](https://sap.github.io/spartacus-docs/event-service/#event-type-inheritance).

### Changes in product configurator feature library

#### MessageConfig

Has been renamed to `ConfiguratorMessageConfig`

#### ConfiguratorAttributeDropDownComponent

Method `onSelect` has been removed, it is no longer used. Use `onSelect` from super class which takes the value as argument

#### ConfiguratorAttributeNumericInputFieldComponent

Method `createEventFromInput` has been removed, it is no longer used

#### ConfiguratorAttributeRadioButtonComponent

Method `onDeselect` has been removed, it is no longer used

#### ConfiguratorGroupMenuComponent

Method `preventScrollingOnSpace`, `navigateUpOnEnter` and `clickOnEnter` have been removed, they are no longer used

#### ConfiguratorProductTitleComponent

Methods `getProductImageURL`, `getProductImageAlt` and `clickOnEnter` have been removed, they are no longer used

#### ConfiguratorCartService
 
Change: The type of constructor parameter `checkoutService: CheckoutService` is changed to `checkoutFacade: CheckoutFacade` to adapt to the new checkout lib. 
The constructor parameter `cartStore: Store<StateWithMultiCart>` has been removed.

In addition, `ConfiguratorCartService` now also requires `ConfiguratorUtilsService`.

#### CommonConfiguratorUtilsService

Method `getCartId` changes its signature from `getCartId(cart: Cart): string` to `getCartId(cart?: Cart): string`

#### ConfiguratorGroupsService

Method `getFirstConflictGroup` changes return parameter from `Configurator.Group` to `Configurator.Group | undefined`
Method `getMenuParentGroup` changes return parameter from `Configurator.Group` to `Configurator.Group | undefined`
Method `getParentGroup` changes return parameter from `Configurator.Group` to `Configurator.Group | undefined`
Method `getNextGroupId` changes return parameter from `Observable<string>` to `Observable<string | undefined>`
Method `getPreviousGroupId` changes return parameter from `Observable<string>` to `Observable<string | undefined>`
Method `getNeighboringGroupId` changes return parameter from `Observable<string>` to `Observable<string | undefined>`

#### ConfiguratorUtilsService

Method `getParentGroup` changes return parameter from `Configurator.Group` to `Configurator.Group | undefined`

#### New and renamed dependencies

`ConfiguratorCartEntryInfoComponent` now also requires `CommonConfiguratorUtilsService`.
`ConfiguratorAttributeCheckboxListComponent` now also requires `ConfiguratorAttributeQuantityService`.
`ConfiguratorAttributeDropDownComponent` now also requires `ConfiguratorAttributeQuantityService`.
`ConfiguratorAttributeInputFieldComponent` now also requires `ConfiguratorUISettingsConfig`.
`ConfiguratorAttributeNumericInputFieldComponent` now also requires `ConfiguratorUISettingsConfig`.
`ConfiguratorAttributeRadiButtonComponent` now also requires `ConfiguratorAttributeQuantityService`.
`ConfiguratorGroupMenuComponent` now also requires `ConfiguratorGroupMenuService` and `DirectionService`.
`ConfiguratorStorefrontUtilsService` now also requires `WindowRef` and `KeyboardFocusService`.
`ConfiguratorFormComponent` now also requires `ConfiguratorStorefrontUtilsService`. 
`ConfiguratorIssuesNotificationComponent` now also requires `CartItemContext`.
`ConfiguratorOverviewAttributeComponent` now also requires `BreakpointService`.
`ConfiguratorUpdateMessageComponent` now requires `ConfiguratorMessageConfig` instead of `MessageConfig`.

### LoginRegisterComponent

Lib: @spartacus/user
Class: LoginRegisterComponent

Change: constructor parameter `checkoutConfigService: CheckoutConfigService` is removed.
The display of the guest checkout button relies on the presence of the `forced` query param only.

### NgbTabsetModule

#### StoreFinderComponentsModule

- Deprecated import `NgbTabsetModule` from `@ng-bootstrap/ng-bootstrap` has been replaced with `NgbNavModule` to support version 8 of the library.

#### StoreFinderListComponent

- Mobile template has been updated to use nav instead of tabs. [See changes.](https://github.com/SAP/spartacus/pull/12398/files#diff-1db586698a503ea500917fe4d734f84d0729f585aa7c4b56705d9171a38e7f55L64-L120)
- Added styles for `ul.nav` to keep the same appearance.

### ASM changes

- `AsmModule` was removed from storefrontlib, and renamed AsmComponentsModule. Use @spartacus/asm/components instead.
- `AsmModule` was removed from core, and renamed AsmCoreModule. Use @spartacus/asm/core. instead.
- `AsmOccModule` was removed from core. Use @spartacus/asm/occ instead.
- `OccAsmAdapter` was removed from core. Use @spartacus/asm/occ instead.
- `AsmConfig` was removed from core. Use @spartacus/asm/core.
- `AsmAdapter` was removed. Use @spartacus/asm/core instead.
- `AsmConnector` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH_PAGE_NORMALIZER` was removed. Use @spartacus/asm/core instead.
- `AsmService` was removed. Use @spartacus/asm/core instead.
- `CsAgentAuthService` was removed. Use @spartacus/asm/root instead.
- `CustomerSearchPage` was removed. Use @spartacus/asm/core instead.
- `CustomerSearchOptions` was removed. Use @spartacus/asm/core instead.
- `AsmUi` was removed. Use @spartacus/asm/core instead.
- `AsmAuthHttpHeaderService` was removed. Use @spartacus/asm/root instead.
- `TOKEN_TARGET` was removed. Use @spartacus/asm/root instead.
- `AsmAuthService` was removed. Use @spartacus/asm/root instead.
- `AsmAuthStorageService` was removed. Use @spartacus/asm/root instead.
- `SYNCED_ASM_STATE` was removed. Use @spartacus/asm/core instead.
- `AsmStatePersistenceService` was removed. Use @spartacus/asm/core instead.
- `ASM_UI_UPDATE` was removed. Use @spartacus/asm/core instead.
- `AsmUiUpdate` was removed. Use @spartacus/asm/core instead.
- `AsmUiAction` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH_FAIL` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH_SUCCESS` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH_RESET` was removed. Use @spartacus/asm/core instead.
- `CustomerSearch` was removed. Use @spartacus/asm/core instead.
- `CustomerSearchFail` was removed. Use @spartacus/asm/core instead.
- `CustomerSearchSuccess` was removed. Use @spartacus/asm/core instead.
- `CustomerSearchReset` was removed. Use @spartacus/asm/core instead.
- `CustomerAction` was removed. Use @spartacus/asm/core instead.
- `LOGOUT_CUSTOMER_SUPPORT_AGENT` was removed. Use @spartacus/asm/core instead.
- `LogoutCustomerSupportAgent` was removed. Use @spartacus/asm/core instead.
- `ASM_FEATURE` was removed. Use @spartacus/asm/core instead.
- `CUSTOMER_SEARCH_DATA` was removed. Use @spartacus/asm/core instead.
- `StateWithAsm` was removed. Use @spartacus/asm/core instead.
- `AsmState` was removed. Use @spartacus/asm/core instead.
- `getAsmUi` was removed. Use @spartacus/asm/core instead.
- `getCustomerSearchResultsLoaderState` was removed. Use @spartacus/asm/core instead.
- `getCustomerSearchResults` was removed. Use @spartacus/asm/core instead.
- `getCustomerSearchResultsLoading` was removed. Use @spartacus/asm/core instead.
- `getAsmState` was removed. Use @spartacus/asm/core instead.

### LaunchDialogService

#### SavedCartFormLaunchDialogService

- Service has been removed. `openDialog` method is part of LaunchDialogService now.

#### AddToSavedCartComponent

- Removed `SavedCartFormLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### SavedCartDetailsActionComponent

- Removed `SavedCartFormLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### SavedCartDetailsOverviewComponent

- Removed `SavedCartFormLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### AnonymousConsentLaunchDialogService

- Service has been removed. `openDialog` method is part of `LaunchDialogService` now.

#### AnonymousConsentManagementBannerComponent

- Removed `AnonymousConsentLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### AnonymousConsentOpenDialogComponent

- Removed `AnonymousConsentLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### ReplenishmentOrderCancellationLaunchDialogService

- Service has been removed. `openDialog` method is part of LaunchDialogService now.

#### ReplenishmentOrderCancellationComponent

- Removed `ReplenishmentOrderCancellationLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.

#### OrderHistoryComponent

- `div` which wrapped `cx-sorting` component has been changed to `label` and added `span` before field.

#### OrderReturnRequestListComponent

- `div` which wrapped `cx-sorting` component has been changed to `label` and added `span` before field.

#### ReplenishmentOrderHistoryComponent

- Removed `ReplenishmentOrderCancellationLaunchDialogService` from constructor.
- Added `LaunchDialogService` to constructor.
- `div` which wrapped `cx-sorting` component has been changed to `label` and added `span` before field.

#### ProductListComponent

- Two elements `div` which wrapped `cx-sorting` component has been merged to one `label` and added `span` before field.

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

- `platformId` is now required constructor dependency.

### ProductListComponentService

- `ProductListComponentService` now also requires `ViewConfig`.
- The `defaultPageSize` property was removed. To modify default page size use `provideConfig(<ViewConfig>{ view: { defaultPageSize: <your_default_page_size_value }})` in module.

### Product reloading

- `reload` method was removed from `ProductService`. Instead, use the [reloading triggers](https://sap.github.io/spartacus-docs/loading-scopes/#reloading-triggers).
- `ProductLoadingService`'s constructor has changed - `EventService` from `@spartacus/core` was added as a parameter.

### Product variants changes

#### Automated Migrations for Version 4.0

- `ProductVariantsModule` was removed from @spartacus/storefront. Use `@spartacus/product/variants` feature-library instead.
- `ProductVariantsComponent` was removed from @spartacus/storefront. Use `ProductVariantsContainerComponent` from `@spartacus/product/variants/components` as a replacement.
- `VariantColorSelectorComponent` was removed from @spartacus/storefront. Use `ProductVariantColorSelectorComponent` from `@spartacus/product/variants/components` as a replacement.
- `VariantColorSelectorModule` was removed from @spartacus/storefront. Use `ProductVariantColorSelectorModule` from `@spartacus/product/variants/components` as a replacement.
- `VariantSizeSelectorComponent` was removed from @spartacus/storefront. Use `ProductVariantSizeSelectorComponent` from `@spartacus/product/variants/components` as a replacement.
- `VariantSizeSelectorModule` was removed from @spartacus/storefront. Use `ProductVariantSizeSelectorModule` from `@spartacus/product/variants/components` as a replacement.
- `VariantStyleSelectorComponent` was removed from @spartacus/storefront. Use `ProductVariantStyleSelectorComponent` from `@spartacus/product/variants/components` as a replacement.
- `VariantStyleSelectorModule` was removed from @spartacus/storefront. Use `ProductVariantStyleSelectorModule` from `@spartacus/product/variants/components` as a replacement.
- `VariantStyleIconsComponent` was removed from @spartacus/storefront. Use `ProductVariantStyleIconsComponent` from `@spartacus/product/variants/root` as a replacement.
- `ProductVariantStyleIconsComponent` was moved from `@spartacus/product/variants/components`to `@spartacus/product/variants/root` instead.
- `VariantStyleIconsModule` was removed from @spartacus/storefront. Use `ProductVariantStyleIconsModule` from `@spartacus/product/variants/root` as a replacement.
- `ProductVariantStyleIconsModule` was moved from `@spartacus/product/variants/components`to `@spartacus/product/variants/root` instead.
- `ProductVariantGuard` was removed from @spartacus/storefront. Use `ProductVariantsGuard` from `@spartacus/product/variants/components` instead. Additionally method: `findVariant` was renamed to `findPurchasableProductCode`.
- `AuthHttpHeaderService` now requires `AuthRedirectService`.
- `AsmAuthHttpHeaderService` now requires `AuthRedirectService`.
- `AuthRedirectService` now requires `AuthFlowRoutesService`.
- `RoutingService` now requires `Location` from `@angular/common`.
- `ProtectedRoutesService` now requires `UrlParsingService`.
- `EventService` no longer uses `FeatureConfigService`.
- `PageEventModule` was removed. Instead, use `NavigationEventModule` from `@spartacus/storefront`
- `PageEventBuilder` was removed. Instead, use `NavigationEventBuilder` from `@spartacus/storefront`
- `CartPageEventBuilder` no longer uses `ActionsSubject` and `FeatureConfigService`
- `HomePageEventBuilder` no longer uses `FeatureConfigService`
- `ProductPageEventBuilder` no longer uses `FeatureConfigService`
- `PageEvent` no longer contains `context`, `semanticRoute`, `url` and `params` properties. These are now contained in the `PageEvent.navigation` object
- `EventsModule` was removed. Use individual imports instead. (e.g. CartPageEventModule, ProductPageEventModule, etc.)

#### Product variants i18n

- translation namespace `variant` was removed from `@spartacus/assets`. Use namespace `productVariants` that can be imported with `productVariantsTranslations` and `productVariantsTranslationChunksConfig` from `@spartacus/product/variants/assets` instead. Translation keys from this namespace did not changed.

#### Product variants endpoint scope

- scope `variants` was removed from `defaultOccProductConfig`. It's now provided by `ProductVariantsOccModule` under `@spartacus/product/variants/occ` instead. Additionally the endpoint now uses `orgProducts` API instead of `products`.

#### ProductVariantStyleIconsComponent
`ProductVariantStyleIconsComponent` changed its constructor dependency from `ProductListItemContextSource` to `ProductListItemContext`.

#### Product variants styles

- styles for `cx-product-variants` were removed from `@spartacus/styles`. Use `@spartacus/product/variants` import instead.

### Feature keys for product configurators

The feature keys that are used to lazily load the product configurator libraries in app.module.ts were available as `rulebased` and `productConfiguratorRulebased` from 3.1 onwards (respective `textfield` and `productConfiguratorTextfield` for the textfield template configurator).

In 4.0, only the longer versions `productConfiguratorRulebased` and `productConfiguratorTextfield` are possible.

Example: A configuration

```
      featureModules: {
        rulebased: {
          module: () => import('@spartacus/product-configurator/rulebased').then(
          (m) => m.RulebasedConfiguratorModule
        ),
        },
      }
```

needs to look like that in 4.0

```
      featureModules: {
        productConfiguratorRulebased: {
          module: () => import('@spartacus/product-configurator/rulebased').then(
          (m) => m.RulebasedConfiguratorModule
        ),
        },
      }
```

### Translations (i18n) changed

- Key `asm.standardSessionInProgress` was removed.
- Key `pageMetaResolver.checkout.title_plurar` has been removed.
- Value of `pageMetaResolver.checkout.title` has been changed to `Checkout`.

### Storage Sync mechanism

I version 4.0 we removed deprecated in version 3.0 storage sync mechanism. In previous major release we provided more powerful mechanism based on `StatePersistenceService` which can cover all use cases for synchronizing data to and from browser storage (eg. `localStorage`, `sessionStorage`) better than the removed storage sync.

What was removed:

- core of the mechanism (reducer)
- configuration (`storageSync` from `StateConfig`)
- default config and default keys (`defaultStateConfig`, `DEFAULT_LOCAL_STORAGE_KEY` and `DEFAULT_SESSION_STORAGE_KEY`)

### DefaultScrollConfig

- `defaultScrollConfig` was renamed to `defaultViewConfig`

### BaseSiteService

- The method `BaseSiteService.initialize` was removed, please use `BaseSiteServiceInitializer.initialize` instead. A method `BaseSiteService.isInitialized` was added.

### LanguageService

- The method `LanguageService.initialize` was removed, please use `LanguageInitializer.initialize` instead. A method `LanguageService.isInitialized` was added.
- `LanguageService` no longer uses `WindowRef`. The language initialization from the state was moved to `LanguageInitializer`.
- `LanguageService` now validate the value passed to the method `setActive()` against the iso codes listed in the Spartacus `context` config, before setting the actual value in the ngrx store.
- The initialization of the site context is scheduled a bit earlier than in before (now it's run in an observable stream instead of a Promise's callback). It's a very slight change, but might have side-effects in some custom implementations.
- The active language is now persisted in the Local Storage instead of the Session Storage

### CurrencyService

- The method `CurrencyService.initialize` was removed, please use `CurrencyInitializer.initialize` instead. A method `CurrencyService.isInitialized` was added.
- `CurrencyService` no longer uses `WindowRef`. The currency initialization from the state was moved to `CurrencyInitializer`.
- `CurrencyService` now validate the value passed to the method `setActive()` against the iso codes listed in the Spartacus `context` config, before setting the actual value in the ngrx store.
- The initialization of the site context is scheduled a bit earlier than in before (now it's run in an observable stream instead of a Promise's callback). It's a very slight change, but might have side-effects in some custom implementations.
- The active currency is now persisted in the LocalStorage instead of the Session Storage.

### Page resolvers

In 3.1 and 3.2 we've introduced a few changes on how the page meta data is collected. The resolvers are now configurable and whether they render on the client or server (SSR) is also configurable (by default description, image, robots and canonical url are resolved only in SSR). A few resolvers are changed or added, since most data is now configurable in the backend (description, robots). The robot information that was previously hardcoded in some resolvers, are now driven by backend data.

The feature of resolving the canonical URL has been enabled by default in 4.0. In case you want to opt-out, please change the Spartacus configuration of `pageMeta.resolvers`.

A new feature has landed in the product and category resolvers for the canonical URL.

The `BasePageMetaResolver` is leveraged to compose most of the generic page meta data. Most page resolvers now use the page data to create the description and robot tags. The changes have affected the following resolver classes:

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
The `CartPageMetaResolver` is removed since all content is resolved by the generic `ContentPageMetaResolver`.

The following properties where removed in 4.0:

- The `ContentPageMetaResolver` no longer supports the `homeBreadcrumb$`,`breadcrumb$`,`title$` and `cms$` as the content is resolved by the `BasePageMetaResolver`.
- The `resolverMethods` property on the `PageMetaService` has changed to `resolvers$` since the resolvers are read from the configuration stream.

### SelectiveCartService

- The `getLoaded` method was removed. Use `isStable` method instead.

### DynamicAttributeService

- `DynamicAttributeService` doesn't depend anymore on the `SmartEditService`, but only on the `UnifiedInjector`.
-  The method `addDynamicAttributes` was removed. Please use functions `addAttributesToComponent` or `addAttributesToSlot` instead.

### SearchBoxComponentService

- `SearchBoxComponentService` now also requires `EventService`.

### CartListItemComponent

- Removed `FeatureConfigService` from constructor and added `UserIdService` and `MultiCartService` to constructor.
- Property `form: FormGroup` is now initialized on component creation instead of in the `createForm()` method.
- `ngOnInit()` method has been modified to fix an issue with rendering items.
- `[class.is-changed]` template attribute on `<div>` tag now depends on method `control.get('quantity').disabled`.

### Models

- The `Item` interface was removed. Use `OrderEntry` instead.
- `sortCode` was removed from interface `TableHeader`.

### SearchBoxComponent

- `RoutingService` is a new, required constructor dependency.
- `cx-icon[type.iconTypes.RESET]` has been changed to `button>cx-icon[type.iconTypes.Reset]`
- `cx-icon[type.iconstypes.SEARCH]` has been changed to `div>cx-icon[type.iconstypes.SEARCH]` with rest of the attributes removed. The button is for presentation purpose only. 
- `div.suggestions` has been changed to `ul>li>a` for better a11y support
- `div.products` has been changed to `ul>li>a` for better a11y support
- `winRef.document.querySelectorAll('.products > a, .suggestions > a')` has been changed to  `winRef.document.querySelectorAll('.products > li a, .suggestions > li a')`

### Organization Administration breaking changes

#### CardComponent (Administration)

- In attribute `cxPopoverOptions` of element `button.hint-popover` property `displayCloseButton` has been set to `true`.

#### ListComponent 

- In attribute `cxPopoverOptions` of element `button.hint-popover` property `displayCloseButton` has been set to `true`.
- `ng-select` for sort has been wrapped by `label` and added `span` before.

#### UserGroupUserListComponent

- Removed `MessageService` from constructor.

#### ToggleStatusComponent

- Removed `FeatureConfigService` from constructor.
- Added `DisableInfoService` to constructor.

#### DeleteItemComponent

- Removed `FeatureConfigService` from constructor.

#### UnitChildrenComponent

- `CurrentUnitService` is now required parameter in component constructor.

#### UnitCostCenterListComponent

- `CurrentUnitService` is now required parameter in component constructor.

#### UnitUserListComponent

- `CurrentUnitService` is now required parameter in component constructor.

#### UnitFormComponent

- Renamed property `formGroup` to `form`.
- Removed property `form$`.

#### OrganizationTableType

- Removed unused `UNIT_ASSIGNED_ROLES` property from enum.

#### HttpErrorModel

- Removed `error` property from interface.

#### Organization related Translations (i18n) changes

- Change contents of:
  `orgBudget.messages.deactivate`,
  `orgCostCenter.messages.deactivate`,
  `orgPurchaseLimit.messages.deactivate`,
  `orgUnit.messages.deactivate`,
  `orgUnitAddress.messages.delete`,
  `orgUserGroup.messages.delete`,
  `orgUser.messages.deactivate`
- Removed unused keys:
  `orgBudget.messages.deactivateBody`,
  `orgBudget.byName`,
  `orgBudget.byUnitName`,
  `orgBudget.byCode`,
  `orgBudget.byValue`,
  `orgCostCenter.messages.deactivateBody`,
  `orgCostCenter.byName`,
  `orgCostCenter.byCode`,
  `orgCostCenter.byUnitName`,
  `orgPurchaseLimit.messages.deactivateBody`,
  `orgPurchaseLimit.byName`,
  `orgPurchaseLimit.byUnitName`,
  `orgUnit.messages.deactivateBody`,
  `orgUnitAddress.messages.deleteBody`,
  `orgUserGroup.messages.deleteBody`,
  `orgUserGroup.byName`,
  `orgUserGroup.byUnitName`,
  `orgUserGroup.byGroupID`,
  `orgUser.messages.deactivateBody`,
  `orgUser.byName`,
  `orgUser.byUnitName`,
  
### Dependencies changes

- The peer dependency package `i18next-xhr-backend` was replaced with `i18next-http-backend`.
- The peer dependency package `i18next` was upgraded to the version `20.2.2`

### CmsFeaturesService

- `CmsComponentsService` constructor is now using `CmsFeaturesService` (replacing `FeatureModulesService`) and `ConfigInitializerService`.
- `FeatureModulesService` was removed. Was replaced by `CmsFeaturesService`.

### ConfigInitializerService

- `getStableConfig` method was removed. Use the new equivalent method instead: `getStable`.

### CartItemComponent

`CartItemComponent` now also requires `CartItemContextSource`. Moreover, a customized version of this component now also should provide locally `CartItemContextSource` and `CartItemContext` in the following way:
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
`ProductListItemComponent` and `ProductGridItemComponent` now require `ProductListItemContextSource`. Moreover, customized versions of those components now also should provide locally `ProductListItemContextSource` and `ProductListItemContext` in the following way:
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
- the property `promotionLocation$` has been removed, please use `location$` instead  


### User lib changes

#### CMS Components

- Following modules `CloseAccountModule`, `ForgotPasswordModule`, `RegisterComponentModule`, `ResetPasswordModule`, `UpdateEmailModule`, `UpdatePasswordModule`, `UpdateProfileModule` were moved to `@spartacus/user/profile/components`.
- Following modules `LoginModule`, `LoginFormModule`, `LoginRegisterModule` were moved to `@spartacus/user/account/components`.
- Component `ResetPasswordFormComponent` was renamed to `ResetPasswordComponent` and now can be used from `@spartacus/user/profile/components`. Also logic for this component was changed. For details look on sections below.
- Component `UpdateEmailFormComponent` was removed. For replacement `UpdateEmailComponent` from `@spartacus/user/profile/components` can be used.
- Component `UpdatePasswordFormComponent` was removed. For replacement `UpdatePasswordComponent` from `@spartacus/user/profile/components` can be used.
- Component `UpdateProfileFormComponent` was removed. For replacement `UpdateProfileComponent` from `@spartacus/user/profile/components` can be used.
- Components `CloseAccountComponent`, `CloseAccountModalComponent`, `ForgotPasswordComponent`, `RegisterComponent`, `UpdateEmailComponent`, `UpdatePasswordComponent`, `UpdateProfileComponent` were moved to `@spartacus/user/profile/components`. Logic for those components was changed. For details look on sections below.
- Components `LoginComponent`, `LoginFormComponent` were moved to `@spartacus/user/account/components`. Logic for those components was changed. For details look on sections below.
- Component `LoginRegisterComponent` were moved to `@spartacus/user/account/components`.

#### CloseAccountModalComponent

- All services used in constructor have been changed to be `protected`.
- Component is not using `UserService` anymore, `UserProfileFacade` was introduced.
- Component is no longer using `Subscription` property, also `ngOnDestroy` method was removed.

#### ForgotPasswordComponent

- Property `forgotPasswordForm` was renamed to `form`.
- New observable property `isUpdating$` was added.
- Methods `ngOnInit`, `requestForgotPasswordEmail` were removed. New method `onSubmit` was added.
- Services `FormBuilder`, `UserService`, `RoutingService`, `AuthConfigService` are no longer used directly in component file. New service `ForgotPasswordComponentService` was introduced and used in constructor.
- Change detection strategy for this component was set to `OnPush`.
- There were slight changes in component template. Spinner component was added which relys on `isUpdating$` property, also form now is using `onSubmit` method on form submit event.

#### RegisterComponent

- Component is not using `UserService` anymore, `UserRegisterFacade` was introduced.
- Property `loading$` was changed to `isLoading$` and type was change to `BehaviorSubject<boolean>` instead of `Observable<boolean>`.
- Method `registerUserProcessInit` was removed.

#### ResetPasswordComponent (previously ResetPasswordFormComponent)

- Property `subscription` was removed.
- Type of `token` property was changed from `string` to `Observable<string>`.
- Property `resetPasswordForm` was renamed to `form`.
- New observable property `isUpdating$` was added.
- Methods `ngOnInit`, `resetPassword`, `ngOnDestroy` were removed. New method `onSubmit` was added.
- Services `FormBuilder`, `UserService`, `RoutingService`, are no longer used directly in component file. New service `ResetPasswordComponentService` was introduced and used in constructor.
- Change detection strategy for this component was set to `OnPush`.
- Component template was adapted to the new logic.
- Spinner component was added which relys on `isUpdating$` property.

#### LoginComponent

- Component is not using `UserService` anymore, `UserAccountFacade` was introduced.
- Type of `user` property was changed to `Observable<User | undefined>` instead of `Observable<User>`.

#### LoginFormComponent

- Services `AuthService`, `GlobalMessageService`, `FormBuilder`, `WindowRef` are no longer used directly in component file. New service `LoginFormComponentService` was introduced and used in constructor.
- Methods `ngOnInit`, `submitForm`, `loginUser` were removed from component file.
- New properties `form`, `isUpdating$` were added.
- New method `onSubmit` was added.
- Change detection strategy for this component was set to `OnPush`.
- Spinner component was added to the template which relys on `isUpdating$` property.

#### UpdateEmailComponent

- Properties `subscription`, `newUid`, `isLoading$` were removed.
- Methods `ngOnInit`, `onCancel`, `onSuccess`, `ngOnDestroy` were removed from component file.
- Services `GlobalMessageService`, `UserService`, `RoutingService`, `AuthService` are no longer used directly in component file. New service `UpdateEmailComponentService` was introduced and used in constructor.
- Logic for `onSubmit` method was changed. Now this method has no parameters.
- New properties `form`, `isUpdating$` were added.
- There were important change in component template. Since `UpdateEmailFormComponent` was removed `UpdateEmailComponent` contains now the template for update email form itself.
- Change detection strategy for this component was set to `OnPush`.
- Spinner component was added to the template which relays on `isUpdating$` property.

#### UpdateEmailComponentService

- `UpdateEmailComponentService` now also requires `AuthRedirectService`

#### UpdatePasswordComponent

- Properties `subscription`, `loading$` were removed.
- Methods `ngOnInit`, `onCancel`, `onSuccess`, `ngOnDestroy` were removed from component file.
- Services `RoutingService`, `UserService`, `GlobalMessageService`, are no longer used directly in component file. New service `UpdatePasswordComponentService` was introduced and used in constructor.
- Logic for `onSubmit` method was changed. Now this method has no parameters.
- New properties `form`, `isUpdating$` were added.
- There were important change in component template. Since `UpdatePasswordFormComponent` was removed `UpdatePasswordComponent` contains now the template for update password form itself.
- Change detection strategy for this component was set to `OnPush`.
- Spinner component was added to the template which relys on `isUpdating$` property.

#### UpdateProfileComponent

- Properties `user$`, `loading$` were removed.
- Methods `ngOnInit`, `onCancel`, `onSuccess`, `ngOnDestroy` were removed from component file.
- Services `RoutingService`, `UserService`, `GlobalMessageService`, are no longer used directly in component file. New service `UpdateProfileComponentService` was introduced and used in constructor.
- Logic for `onSubmit` method was changed. Now this method has no parameters.
- New properties `form`, `isUpdating$` were added.
- There were important change in component template. Since `UpdateProfileFormComponent` was removed `UpdateProfileComponent` contains now the template for update profile form itself.
- Change detection strategy for this component was set to `OnPush`.
- Spinner component was added to the template which relys on `isUpdating$` property.

### MyCouponsComponent

- `div` which wrapped `cx-sorting` component has been changed to `label` and added `span` before.
#### OccUserAdapter

- `OccUserAdapter` was removed. Instead please use `OccUserAccountAdapter` from `@spartacus/user/account/occ` and `OccUserProfileAdapter` from `@spartacus/user/profile/occ`.
- The `remove` method was removed. Use `close` method instead.

#### UserAdapter

- `UserAdapter` was removed. Instead please use `UserAccountAdapter` from `@spartacus/user/account/core` and `UserProfileAdapter` from `@spartacus/user/profile/core`.
- The `remove` method was removed. Use `close` method instead.

#### UserConnector

- `UserConnector` was removed. Instead please use equivalents: `UserAccountConnector` from `@spartacus/user/account/core` and `UserProfileConnector` from `@spartacus/user/profile/core` .
- The `remove` method now returns `close` method from adapter (name change).

#### OccEndpoints

- Endpoint `user` was removed from the declaration in `@spartacus/core`. It's now provided with module augmentation from `@spartacus/user/account/occ`. Default value is also provided from this new entry point.
- Endpoints `titles`, `userRegister`, `userForgotPassword`, `userResetPassword`, `userUpdateLoginId`, `userUpdatePassword`, `userUpdateProfile`, `userCloseAccount` were removed from the declaration in `@spartacus/core`. Those endpoints are now provided with module augmentation from `@spartacus/user/profile`. Default values are also provided from this new entry point.

#### UserService

- `get` method was changed, now fully relys on `UserAccountFacade.get()` from `@spartacus/user`.
- `load` method was removed, instead please use `UserAccountFacade.get()` from `@spartacus/user`.
- `register` method was removed, instead please use `UserRegisterFacade.register()` from `@spartacus/user`.
- `registerGuest` method was removed, instead please use `UserRegisterFacade.registerGuest()` from `@spartacus/user`.
- `getRegisterUserResultLoading` method was removed, instead please subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the loading state.
- `getRegisterUserResultSuccess` method was removed, instead please subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the success state.
- `getRegisterUserResultError` method was removed, instead please subscribe to `UserRegisterFacade.register()` from `@spartacus/user` to get the error state.
- `resetRegisterUserProcessState` method was removed and no longer needed if `UserRegisterFacade.register()`from `@spartacus/user` was used.
- `remove` method was removed, instead please use `UserProfileFacade.close()` from `@spartacus/user`.
- `loadTitles` method was removed, instead please use `UserProfileFacade.getTitles()` from `@spartacus/user`.
- `getRemoveUserResultLoading` method was removed, instead please subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the loading state.
- `getRemoveUserResultSuccess` method was removed, instead please subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the success state.
- `getRemoveUserResultError` method was removed, instead please subscribe to `UserProfileFacade.close()` from `@spartacus/user` to get the error state.
- `resetRemoveUserProcessState` method was removed and no longer needed if `UserProfileFacade.close()`from `@spartacus/user` was used.
- `isPasswordReset` method was removed, instead please subscribe to `UserPasswordFacade.reset()` from `@spartacus/user` to get the success state.
- `updatePersonalDetails` method was removed, instead please use `UserProfileFacade.update()` from `@spartacus/user`.
- `getUpdatePersonalDetailsResultLoading` method was removed, instead please subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the loading state.
- `getUpdatePersonalDetailsResultError` method was removed, instead please subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the error state.
- `getUpdatePersonalDetailsResultSuccess` method was removed, instead please subscribe to `UserProfileFacade.update()` from `@spartacus/user`to get the success state.
- `resetUpdatePersonalDetailsProcessingState` method was removed and no longer needed if `UserProfileFacade.update()` from `@spartacus/user` was used.
- `resetPassword` method was removed, instead please use `UserPasswordFacade.reset()` from `@spartacus/user`.
- `requestForgotPasswordEmail` method was removed, instead please use `UserPasswordFacade.requestForgotPasswordEmail()` from `@spartacus/user`.
- `updateEmail` method was removed, instead please use `UserEmailFacade.update()` from `@spartacus/user`.
- `getUpdateEmailResultLoading` method was removed, instead please subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the loading state.
- `getUpdateEmailResultSuccess` method was removed, instead please subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the success state.
- `getUpdateEmailResultError` method was removed, instead please subscribe to `UserEmailFacade.update()` from `@spartacus/user`to get the error state.
- `resetUpdateEmailResultState` method was removed and no longer needed if `UserEmailFacade.update()` from `@spartacus/user` was used.
- `updatePassword` method was removed, instead please use `UserPasswordFacade.update()` from `@spartacus/user`.
- `getUpdatePasswordResultLoading` method was removed, instead please subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the loading state.
- `getUpdatePasswordResultError` method was removed, instead please subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the error state.
- `getUpdatePasswordResultSuccess` method was removed, instead please subscribe to `UserPasswordFacade.update()` from `@spartacus/user`to get the success state.
- `resetUpdatePasswordProcessState` method was removed and no longer needed if `UserPasswordFacade.update()` from `@spartacus/user` was used.

#### UserModule

- `UserModule` was removed. Main modules currently are `UserAccountModule` in `@spartacus/user/account` and `UserProfileModule` in `@spartacus/user/profile`.

#### Occ Endpoint Models

- `UserSignUp` model was moved to `@spartacus/user/profile` lib.

#### Ngrx state of the User feature

Some branches of the ngrx state for the User feature were removed: `'account'`, `'titles'`, and `'resetPassword'`. Please use the new approach with Queries and Commands defined in the new facades in  the library `@spartacus/user`:
`UserAccountFacade` from '@spartacus/user/account/root'
`UserEmailFacade` from '@spartacus/user/profile/root'
`UserPasswordFacade` from '@spartacus/user/profile/root'
`UserProfileFacade` from '@spartacus/user/profile/root'
`UserRegisterFacade` from '@spartacus/user/profile/root' 

The following items related to the ngrx state were removed from `@spartacus/core`:
- Following actions `ForgotPasswordEmailRequest`, `ForgotPasswordEmailRequestFail`, `ForgotPasswordEmailRequestSuccess`, `ResetPassword`, `ResetPasswordFail`, `ResetPasswordSuccess`, `LoadTitles`, `LoadTitlesFail`, `LoadTitlesSuccess`, `UpdateEmailAction`, `UpdateEmailSuccessAction`, `UpdateEmailErrorAction`, `ResetUpdateEmailAction`, `UpdatePassword`, `UpdatePasswordFail`, `UpdatePasswordSuccess`, `UpdatePasswordReset`, `LoadUserDetails`, `LoadUserDetailsFail`, `LoadUserDetailsSuccess`, `UpdateUserDetails`, `UpdateUserDetailsFail`, `UpdateUserDetailsSuccess`, `ResetUpdateUserDetails`, `RegisterUser`, `RegisterUserFail`, `RegisterUserSuccess`, `ResetRegisterUserProcess`, `RegisterGuest`, `RegisterGuestFail`, `RegisterGuestSuccess`, `RemoveUser`, `RemoveUserFail`, `RemoveUserSuccess`, `RemoveUserReset` were removed.
- Following effects `ForgotPasswordEffects`, `ResetPasswordEffects`, `TitlesEffects`, `UpdateEmailEffects`, `UpdatePasswordEffects`, `UserDetailsEffects`, `UserRegisterEffects` were removed.
- Following selectors `getResetPassword`, `getDetailsState`, `getDetails`, `getTitlesState`, `getTitlesEntites`, `getAllTitles`, `titleSelectorFactory` were removed.
- Reducers for following states `account`, `titles`, `resetPassword` were removed.

#### Connectors

- `TITLE_NORMALIZER` was moved to `@spartacus/user/profile`.
- `USER_SIGN_UP_SERIALIZER` was moved to `@spartacus/user/profile`.
- `USER_SERIALIZER` was removed. For replacement please use `USER_ACCOUNT_SERIALIZER` from `@spartacus/user/account` and `USER_PROFILE_SERIALIZER` from `@spartacus/user/profile`.
- `USER_NORMALIZER` was removed. For replacement please use `USER_ACCOUNT_NORMALIZER` from `@spartacus/user/account` and `USER_PROFILE_NORMALIZER` from `@spartacus/user/profile`.

#### StoreFinderListItemComponent

- `div[class.cx-store-name]` element has been changed to `h2[class.cx-store-name]`.

#### StoreFinderStoresCountComponent

- `div[class.cx-title]` element has been changed to `h2[class.cx-title]`

#### StoreFinderListItemComponent

- `div[class.cx-total]` element has been changed to `h4[class.cx-total]`

#### CartItemComponent

- `{{item.product.name}}` element has been changed to `<h2>{{item.product.name}}</h2>`

#### OrderSummaryComponent

- `<h4>{{ 'orderCost.orderSummary' | cxTranslate }}</h4>` element has changed to `<h3>{{ 'orderCost.orderSummary' | cxTranslate }}</h3>`

#### DeliveryModeComponent

- `h3[class.cx-checkout-title]` element has changed to `h2[class.cx-checkout-title]`

#### PaymentMethodComponent

- `h3[class.cx-checkout-title]` element has changed to `h2[class.cx-checkout-title]`

#### ReviewSubmitComponent

- `h3[class.cx-review-title]` element changed to `h2[class.cx-review-title]`
- `div[class.cx-review-cart-total]` element changed to `h4[class.cx-review-cart-total]`

#### ShippingAddressComponent

- `h3[class.cx-checkout-title]` element changed to `h2[class.cx-checkout-title]`

#### CmsPageTitleComponent

- New interface has been created 

#### CmsBreadcrumbsComponent
- `CmsBreadcrumbsComponent` extends `CmsPageTitleComponent` now
- `container` property has been moved to `CmsPageTitleComponent`

#### BreadcrumbComponent

- `BreadcrumbComponent` extends `PageTitleComponent` now
- `setTitle()` function has been moved to `PageTitleComponent`

#### PageTitleComponent

- New component that sets page title if there is not one set by default 

#### NavigationUiComponent

- `<h5><cx-icon ...></h5>` element was changed to `<span><cx-icon ...></span>`
- `h5[attr.aria-label]="node.title"` element was was changed to `span[attr.aria-label]="node.title"`

#### ProductCarouselComponent

- `<h4>{{item.name}}</h4>` element changed to `<h3>{{item.name}}</h3>`

#### WishListItemComponent

- `<a>{{ cartEntry.product.name }}</a>` element changed to `<a><h2>{{ cartEntry.product.name }}</h2></a>`

#### CardComponent

- `h4[class.cx-card-title]` element changed to `h3[class.cx-card-title]`

#### CarouselComponent

- `<h3 *ngIf="title">{{ title }}</h3>` element changed to `<h2 *ngIf="title">{{ title }}</h2>`

#### AddedToCartDialogComponent

- `[attr.aria-label]="'common.close' | cxTranslate"` element changed to `attr.aria-label="{{ 'addToCart.closeModal' | cxTranslate }}"`

#### Translations (i18n) changes

- Key `miniLogin.userGreeting` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `miniLogin.signInRegister` was moved to separated `@spartacus/user` lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.signIn` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.register` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.dontHaveAccount` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.guestCheckout` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.emailAddress.label` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.emailAddress.placeholder` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.password.label` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.password.placeholder` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.wrongEmailFormat` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `loginForm.forgotPassword` was moved to separated lib. Now is a part of `userAccountTranslations`, `userAccountTranslationChunksConfig` from `@spartacus/user/account/assets`.
- Key `updateEmailForm.newEmailAddress.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.newEmailAddress.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.confirmNewEmailAddress.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.confirmNewEmailAddress.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.enterValidEmail` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.bothEmailMustMatch` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.password.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.password.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.pleaseInputPassword` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `updateEmailForm.emailUpdateSuccess` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.resetPassword` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.enterEmailAddressAssociatedWithYourAccount` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.emailAddress.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.emailAddress.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.enterValidEmail` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.passwordResetEmailSent` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `forgottenPassword.passwordResetSuccess` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.confirmPassword.action` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.confirmPassword.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.confirmPassword.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.managementInMyAccount` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.termsAndConditions` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.signIn` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.register` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.confirmNewPassword` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.resetPassword` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.createAccount` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.title` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.firstName.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.firstName.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.lastName.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.lastName.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.emailAddress.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.emailAddress.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.password.label` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.password.placeholder` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.newPassword` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.emailMarketing` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.confirmThatRead` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.selectTitle` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.passwordMinRequirements` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.bothPasswordMustMatch` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.titleRequired` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `register.postRegisterMessage` was moved to separated lib. Now is a part of `userProfileTranslations`, `userProfileTranslationChunksConfig` from `@spartacus/user/profile/assets`.
- Key `myCoupons.sortByMostRecent` has been removed. We use `myCoupons.sortBy` now.
- Key `myInterests.sortByMostRecent` has been removed. We use `myInterests.sortBy` now.
- Key `orderHistory.sortByMostRecent` has been removed. We use `orderHistory.sortBy` now.
- Key `returnRequestList.sortByMostRecent` has been removed. We use `returnRequestList.sortBy` now.
- Key `productList.sortByMostRecent` has been removed. We use `productList.sortBy` now.

### Default routing config for the My Company feature
The default routing config for the My Company pages was moved from various modules in `@spartacus/organization/administration/components` to `OrganizationAdministrationRootModule` in `@spartacus/organization/administration/root`. Therefore the default config is now provided eagerly, so it's available early on app start (but not only after the feature is lazy loaded). Also, the following objects were renamed and moved to `@spartacus/organization/administration/root`:
- `budgetRoutingConfig` -> `defaultBudgetRoutingConfig`
- `costCenterRoutingConfig` -> `defaultCostCenterRoutingConfig`
- `permissionRoutingConfig` -> `defaultPermissionRoutingConfig`
- `unitsRoutingConfig` -> `defaultUnitsRoutingConfig`
- `userGroupRoutingConfig` -> `defaultUserGroupRoutingConfig`
- `userRoutingConfig` -> `defaultUserRoutingConfig`

#### Checkout Related Translations (i18n) changes

The checkout related translation keys were moved to the `@spartacus/checkout/assets`.  If you use some checkout 
related labels outside of checkout and the checkout lib is not used, you will need to use alternate translation labels.

- Key `checkoutAddress.verifyYourAddress` is moved to `addressSuggestion.verifyYourAddress`.
- Key `checkoutAddress.ensureAccuracySuggestChange` is moved to `addressSuggestion.ensureAccuracySuggestChange`.
- Key `checkoutAddress.chooseAddressToUse` is moved to `addressSuggestion.chooseAddressToUse`.
- Key `checkoutAddress.suggestedAddress` is moved to `addressSuggestion.suggestedAddress`.
- Key `checkoutAddress.enteredAddress` is moved to `addressSuggestion.enteredAddress`.
- Key `checkoutAddress.editAddress` is moved to `addressSuggestion.editAddress`.
- Key `checkoutAddress.saveAddress` is moved to `addressSuggestion.saveAddress`.

- Key `checkoutOrderConfirmation.replenishmentNumber` is removed. You can use instead ``.
- Key `checkoutOrderConfirmation.placedOn` is removed. You can use instead `orderDetails.placedOn`.
- Key `checkoutOrderConfirmation.status` is removed. You can use instead `orderDetails.status`.
- Key `checkoutOrderConfirmation.active` is removed. You can use instead `orderDetails.active`.
- Key `checkoutOrderConfirmation.cancelled` is removed. You can use instead `orderDetails.cancelled`.
- Key `checkoutOrderConfirmation.frequency` is removed. You can use instead `orderDetails.frequency`.
- Key `checkoutOrderConfirmation.nextOrderDate` is removed. You can use instead `orderDetails.nextOrderDate`.
- Key `checkoutOrderConfirmation.orderNumber` is removed. You can use instead `orderDetails.orderNumber`.

#### Changes in styles

- Styles for following selectors `cx-close-account-modal`, `cx-close-account`, `cx-forgot-password`, `cx-register`, `cx-update-password-form`, `cx-user-form` were moved from `@spartacus/styles` to `@spartacus/user/profile/styles`.
- Styles for following selectors `cx-login`, `cx-login-form` were moved from `@spartacus/styles` to `@spartacus/user/account/styles`.

### LogoutGuard

`AuthRedirectService` is a new, required constructor dependency.

### RoutingService
- `RoutingService.go` - changed signature. Before 4.0, the object with query params could be passed in the 2nd argument. Now the 2nd argument is Angular `NavigationExtras` object (with `'queryParams'` property).
- `RoutingService.navigate` - changed signature. Before 4.0, the object with query params could be passed in the 2nd argument. Now the 2nd argument is Angular `NavigationExtras` object (with `'queryParams'` property).

### RoutingActions ngrx
The following ngrx actions have been removed:
- `RoutingActions.RouteGo` (and `RoutingActions.ROUTER_GO`)
- `RoutingActions.RouteGoByUrlAction` (and `RoutingActions.ROUTER_GO_BY_URL`)
- `RoutingActions.RouteBackAction` (and `RoutingActions.ROUTER_BACK`)
- `RoutingActions.RouteForwardAction` (and `RoutingActions.ROUTER_FORWARD`).

Please use instead the methods of the `RoutingService`, respectively: `go()`, `goByUrl()`, `back()`, `forward()`.

### AuthRedirectService

- `#reportNotAuthGuard` - method not needed anymore. Every visited URL is now remembered automatically as redirect URL on `NavigationEnd` event.
- `#reportAuthGuard` - method deprecated; use the new equivalent method instead: `#saveCurrentNavigationUrl`. It remembers the anticipated page, when being invoked during the navigation.

### OccEndpointsService

- The `getEndpoint` method was removed. Use `buildUrl` instead with the `endpoint` string and the `propertiesToOmit` matching your desired URL.
- The `getOccEndpoint` method was removed. Use `buildUrl` instead with the `endpoint` string and the `propertiesToOmit` matching your desired URL.
- The `getBaseEndpoint` method was removed. Use `buildUrl` method instead with configurable endpoint or the `getBaseUrl` method.
- The `getUrl` method was removed. Use `buildUrl` method instead. The `buildUrl` method has the same first parameter as `getUrl`. The 2nd, 3rd and 4th parameters of `getUrl`, are merged into the second argument object of `buildUrl` with properties: `urlParams`, `queryParams` and `scope`.
- The `getRawEndpoint` method was removed. Use `buildUrl` with configurable endpoints or `getRawEndpointValue` method instead.

### Modal Service

- Removed `FeatureConfigService` from constructor.
- `ApplicationRef` is a new, required constructor dependency.

### ExternalJsFileLoader

- The service was removed from core. Please use `ScriptLoader` instead.

### CxApi
Removed public members of `CxApi`: `CheckoutService`, `CheckoutDeliveryService`, `CheckoutPaymentService`.

### TabParagraphContainerComponent

- `WindowRef` and `BreakpointService` are now required parameters in the constructor.
- All services used in constructor have been changed to be `protected`.

### b2cLayoutConfig

- `b2cLayoutConfig` was removed from @spartacus/storefront, please use corresponding feature-lib specific layout.

### UnitAddressFormService

- Param `UserService` imported from `@spartacus/core` was removed from constructor. Instead new param `UserAddressService` from `@spartacus/user/profile/root` was added.

### GuestRegisterFormComponent

- Param `UserService` imported from `@spartacus/core` was removed from constructor. Instead new param `UserRegisterFacade` from `@spartacus/user/profile/root` was added.

### UserIdService

- `invokeWithUserId` method was removed. Use `takeUserId` instead.

### PopoverDirective

- `PopoverDirective` class now implements `ngOnInit`.
- Removed `PositioningService` from constructor.
- Event emitters `openPopover` and `closePopover` are no longer optional.
- New property: `eventSubject: Subject<PopoverEvent>`.
- Removed methods: `handleOpen`, `toggle`.
- Added new methods: `handleEscape`, `handleClick`, `handlePress`, `handleTab`.

### PopoverService

- Argument `event` of `getFocusConfig` method is now type `PopoverEvent` instead of `Event`

### PopoverComponent

- Removed property`insideClicked`.
- `button.close` has been moved into a `div.cx-close-row`

### OnNavigateFocusService

- Removed `document` injection param from constructor.
- Added `WindowRef` param into constructor.

### Facade factories are now inlined

Facade factories are now inlined into `@Injectable` decorator, the following symbols are not needed anymore and were removed: `userAccountFacadeFactory`, `UserEmailFacadeFactory`, `UserPasswordFacadeFactory`, `UserProfileFacadeFactory`, `UserRegisterFacadeFactory`, `savedCartFacadeFactory`, `cdcAuthFacadeFactory`.
