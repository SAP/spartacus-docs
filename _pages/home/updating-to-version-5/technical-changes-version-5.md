---
title: Technical Changes in Spartacus 5.0
---

The Spartacus migration schematics scan your codebase and inject code comments whenever you use a reference to a Spartacus class or function that has changed its behavior in version 5.0, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed). After the migration schematics have finished running, inspect your code for comments that begin with `// TODO:Spartacus` to see the areas of your code that have been identified as possibly needing further work to complete your migration.

**Note:** If you happen to have in your codebase a custom function or class that has the same name as a function or class that has changed or been removed in the Spartacus public API, there is a chance that the migration script could identify your custom function or class as needing to be updated. In this case, you can ignore and remove the comment.

## Augmented Types

If you augmented any of the Spartacus types, you will have code similar to the following:

```ts
declare module '@spartacus/core' {
  interface OrderEntry {
    ...
  }
}
```

The interface for the `OrderEntry` type might have been moved from `@spartacus/core` to another location. This change will not be automatically migrated, so you will need to check all the module names for all of your augmented types by looking up the augmented type and checking if it was moved to a new location.

## Changes of Generic Types

### ItemActiveDirective (in @spartacus/organization)

The generic type `T` in `class ItemActiveDirective<T = BaseItem> ` has been changed to `T extends BaseItem`.

### AssignCellComponent (in @spartacus/organization)

The generic type `T` in `class AssignCellComponent<T>` has been changed to `T extends BaseItem`.

## Removed Incubator Library

The incubator library is no longer published.

## Breaking Changes in the user-profile Library

- A `RegisterComponentService` was added that accepts `UserRegisterFacade` through constructor injection. The `RegisterComponentService` only has the methods from `UserRegisterFacade` that are needed for `RegisterComponent`.
- The constructor of `RegisterComponent` was updated and `UserRegisterFacade` was replaced with `RegisterComponentService`.

## Breaking Changes in the CDC Integration Library

- When `CX_CDC` is enabled, the native Login / Register and Forgot Password screens use the CDC JS SDK to perform user account creation and authentication.
- The `CDCRegisterComponentService` was added, which extends `RegisterComponentService`. It invokes the CDC JS SDK to register the user and overrides the `postRegisterMessage()` to suppress the success message on successful registration.
- The `CdcLoginFormComponentService` was added, which extends `LoginFormComponentService` and invokes the CDC JS SDK to log in the user.
- The `CDCForgotPasswordComponentService` was added, which extends `ForgotPasswordComponentService` and invokes the CDC JS SDK to send the account reset email.

## Breaking Changes in the product-configurator Library

### Reduced Number of Page Header Slots and Introduction of Exit Button

In case the rule-based product configurator is launched from the Product Details page, the Product Catalog page, or the cart, the number of slots displayed in the page header has been reduced, as compared to Spartacus version 4.0. Now we only show the `SiteLogo`,`VariantConfigOverviewExitButton` and `MiniCart` slots. For details, see `CpqConfiguratorLayoutModule`, `VariantConfiguratorInteractiveLayoutModule` and `VariantConfiguratorOverviewLayoutModule`. These modules are new in 5.0. The layout configuration was removed from `CpqConfiguratorInteractiveModule`, `VariantConfiguratorInteractiveModule`
and `VariantConfiguratorOverviewModule`.

Note that the `VariantConfigOverviewExitButton` is new, and allows users to leave the configuration. Clicking it directs the user to the product detail page, and configuration changes are not taken over to the cart.

### Specific Page Header Slots in Case the Configurator is Launched in displayOnly Mode

In case the rule-based product configurator is launched from the Review Order checkout page, from the Order Confirmation page, or from the Order History page, the page header shows the standard Spartacus header slots (not the reduced set of header slots listed in the previous section).

Specifically, `VariantConfigOverviewExitButton` is not offered then. For details, see `CpqConfiguratorPageLayoutHandler` and `VariantConfiguratorPageLayoutHandler`.

The page header slots used in case of the displayOnly mode can be configured in `CpqConfiguratorLayoutModule` and `VariantConfiguratorOverviewLayoutModule`, under the `headerDisplayOnly` section.

### ConfiguratorAddToCartButtonComponent

- `#displayOnly` template was added
- `<button class="cx-btn btn btn-block btn-primary cx-display-only-btn"></button>` was added to the `#displayOnly` template
- Now also uses `configurator.addToCart.buttonDisplayOnly` translation label key

### ConfiguratorGroupMenuComponent

- `configurator.addToCart.buttonDisplayOnly` was added to `configurator-common.ts`

### ConfiguratorAttributeSingleSelectionBaseComponent

- Two new input fields were added: `language` and `ownerType`, both of type `string`

### ConfiguratorAttributeProductCardComponentOptions

- New `attributeLabel`, `attributeName`, `itemCount` and `itemIndex` attributes were added to the interface.

### ConfiguratorExitButton

- `container$ | async as container` was added to the button to determine what the current owner type is. The button will be named accordingly.

### ConfiguratorAttributeProductCardComponent

- `span` was added (visually hidden) for screen readers to read explanation for hidden buttons (in case option .hideRemoveButton is `true`).

### ConfiguratorAttributeDropDownComponent

- Added conditional includes of `<cx-configurator-attribute-numeric-input-field>` and `<cx-configurator-attribute-input-field>` because of the support for attributes with additional values.
- Added styling  `.cx-configurator-attribute-additional-value { margin-inline-start: 0px; }` in order to render an additional attribute value properly.
- Added `label` (visually hidden) for screen readers to read explanations of drop-down listboxes (number of entries).

### ConfiguratorAttributeRadioButtonComponent

- Added conditional includes of `<cx-configurator-attribute-numeric-input-field>` and `<cx-configurator-attribute-input-field>` because of the support for attributes with additional values.
- Added styling  `.cx-configurator-attribute-additional-value { margin-inline-start: 0px; }` in order to render an additional attribute value properly.

### ConfiguratorAttributeReadOnlyComponent

For the `staticDomain` part:

- `span` was added (visually hidden) for screen readers to read `value x of attribute y` (in order to better distinguish between the text of a value and the text of an attribute for screen reader users).
- `span` was added with `aria-hidden=true` around visible read-only values to avoid double reading by screen readers.

For the `#noStaticDomain` template:

- `span` was added (visually hidden) for screen readers to read `value x of attribute y` (in order to better distinguish between the text of a value and the text of an attribute for screen reader users).
- `span` was added with `aria-hidden=true` around visible read-only values to avoid double reading by screen readers.

For the `userInput` part:

- `span` was added (visually hidden) for screen readers to read `value x of attribute y` (in order to better distinguish between the text of a value and the text of an attribute for screen reader users).
- `span` was added with `aria-hidden=true` around visible read-only values to avoid double reading by screen readers.

### ConfiguratorAttributeSingleSelectionBundleDropdownComponent

- `label` was added (visually hidden) for screen readers to read explanations of drop-down listboxes (number of entries).

### ConfiguratorAttributeSingleSelectionImageComponent

- enclosing `div` added with attribute `role=listbox` to make clear for screen readers that the enclosed divs belong to a list selection

### ConfiguratorConflictSuggestionComponent

- `span`-tags added around suggestion title and texts with attribute `aria-hidden=true` as the text for screen readers is taken over by new attribute aria-label at `div`-tag to provide consistent screen readers text for different browsers

### ConfiguratorAttributeSingleSelectionImageComponent

- `span`-tags added (visually hidden) to provide extra information for screen reader users

### ConfiguratorOverviewAttributeComponent

- `span` added (visually hidden) for screen readers to read `value x of attribute y` or `value x of attribute y surcharge z` if a price is present (in order to better distinguish between text of a value and text of an attribute for screen reader users)

### ConfiguratorOverviewBundleAttributeComponent

- `span` added (visually hidden) for screen readers to read `item x of attribute y`, `item x of attribute y, surcharge z`, `item x of attribute y, quantity 123` or `item x of attribute y, quantity 123, surcharge z` depending on availability of price and quantity

### ConfiguratorOverviewFormComponent

- `span`-tags added (visually hidden) to provide extra information for screen reader users

### ConfiguratorProductTitleComponent

- `span` with attribute `aria-hidden=true` around visible link text to avoid double reading by screen readers (text is covered by new `aria-label` attribute of surrounding `div`)

### ConfiguratorUpdateMessageComponent

- `div` with attributes `aria-live=polite` and `aria-atomic=false` added around update message div in order to monitor changes in this area. As soon as update message becomes visible it will be read by the screen readers (in polite mode).

### ConfiguratorIssuesNotificationComponent

- Default config of outlet has been changed from `{id: CartOutlets.ITEM, position: OutletPosition.BEFORE}` to `{id: CartOutlets.ITEM_CONFIGURATOR_ISSUES, position: OutletPosition.REPLACE,}`.

### Translation (i18n) changes related to accessibility in variant configuration

The following keys have been added to `configurator-common.ts`:

- `configurator.a11y.xx`
- `configurator.a11y.configureProduct`
- `configurator.a11y.cartEntryBundleInfo`
- `configurator.a11y.cartEntryBundleInfo_other`
- `configurator.a11y.cartEntryBundleName`
- `configurator.a11y.cartEntryBundleNameWithQuantity`
- `configurator.a11y.cartEntryBundleNameWithPrice`
- `configurator.a11y.cartEntryBundle`
- `configurator.a11y.cartEntryInfoIntro`
- `configurator.a11y.cartEntryInfo`
- `configurator.a11y.nameOfAttribute`
- `configurator.a11y.valueOfAttribute`
- `configurator.a11y.forAttribute`
- `configurator.a11y.valueOfAttributeFull`
- `configurator.a11y.valueOfAttributeFullWithPrice`
- `configurator.a11y.selectedValueOfAttributeFull`
- `configurator.a11y.selectedValueOfAttributeFullWithPrice`
- `configurator.a11y.readOnlyValueOfAttributeFull`
- `configurator.a11y.valueOfAttributeBlank`
- `configurator.a11y.value`
- `configurator.a11y.attribute`
- `configurator.a11y.requiredAttribute`
- `configurator.a11y.listOfAttributesAndValues`
- `configurator.a11y.editAttributesAndValues`
- `configurator.a11y.group`
- `configurator.a11y.itemOfAttributeSelected`
- `configurator.a11y.itemOfAttributeSelectedWithPrice`
- `configurator.a11y.itemOfAttributeSelectedPressToUnselect`
- `configurator.a11y.itemOfAttributeSelectedPressToUnselectWithPrice`
- `configurator.a11y.itemOfAttributeUnselected`
- `configurator.a11y.itemOfAttributeUnselectedWithPrice`
- `configurator.a11y.selectNoItemOfAttribute`
- `configurator.a11y.itemOfAttribute`
- `configurator.a11y.itemOfAttributeFull`
- `configurator.a11y.itemOfAttributeFullWithPrice`
- `configurator.a11y.itemOfAttributeFullWithQuantity`
- `configurator.a11y.itemOfAttributeFullWithPriceAndQuantity`
- `configurator.a11y.itemDescription`
- `configurator.a11y.listbox`
- `configurator.a11y.valueSurcharge`
- `configurator.a11y.conflictDetected`
- `configurator.a11y.conflictsInConfiguration`
- `configurator.a11y.listOfGroups`
- `configurator.a11y.inListOfGroups`
- `configurator.a11y.groupName`
- `configurator.a11y.groupBack`
- `configurator.a11y.conflictBack`
- `configurator.a11y.iconConflict`
- `configurator.a11y.iconIncomplete`
- `configurator.a11y.iconComplete`
- `configurator.a11y.iconSubGroup`
- `configurator.a11y.next`
- `configurator.a11y.previous`
- `configurator.a11y.showMoreProductInfo`
- `configurator.a11y.showLessProductInfo`
- `configurator.a11y.productName`
- `configurator.a11y.productCode`
- `configurator.a11y.productDescription`
- `configurator.a11y.configurationPage`
- `configurator.a11y.configurationPageLink`
- `configurator.a11y.overviewPage`
- `configurator.a11y.overviewPageLink`
- `configurator.attribute.singleSelectAdditionalRequiredMessage`

## UI Breaking Changes Introduced in Composable Storefront 5.0

### Translation (i18n) changes

- `configurator.conflict.viewConfigurationDetails` was added to `configurator-common.ts`
- `quickOrderCartForm.entriesWasAdded` changed to `quickOrderCartForm.entriesWereAdded`
- `quickOrder.addToCart` changed to `quickOrder.add`
- `payment.paymentForm.setAsDefault` changed from `Set as default` to `Set as default payment method` for screen reader improvements.
- `storeFinder.storeFinder.searchBox` changed from `Enter postal code, town or address` to `Postal code, town or address`
- `common.searchBox.placeholder` changed from `Search here...` to `Enter product name or SKU`
- Translation for key `address.addressForm.setAsDefault` changed from `Set as default` to `Set as default shipping address`
- `quickOrderForm.searchBoxLabel` changed from `Enter Product name or SKU for quick order` to `Enter Product name or SKU for quick order. You can add up to {{ limit }} products per order.` for screen reader improvements.
- `AccountOrderHistoryTabContainer.tabs.tabPanelContainerRegion` was added to `order.i18n.ts`

### TabParagraphContainerComponent

- `ariaLabel` has been added to fill the container aria-label based on displayed components.

#### Template changes

- Second ng-container, `<ng-container *ngFor="let component of components; let i = index">` has been wrapped in a `div` for screen reader improvements.
- `span` with class `accordion-icon` added as icon placeholder for screen reader improvements.

### ProductImageZoomProductImagesComponent

- Exposes field `product$: Observable<Product>` from parent component `ProductImagesComponent`

#### Template changes

- Element `<cx-carousel *ngIf="thumbs.length" class="thumbs"....>` has been wrapped in a new container `<ng-container *ngIf="product$ | async as product">` for screen reader improvements.

### CartTotalsComponent

#### Template changes

- Removed progress button component in favor for decoupling the cart-totals business logic and the button to proceed to checkout. The new button component which is CMS-driven is tied to a cms component called `CartProceedToCheckoutComponent` that is mapped to the Spartacus component `CartProceedToCheckoutComponent`.

### FacetListComponent

#### Template changes

- Top element `<div>` has been changed to `<sector>` to make accesibility navigation consistent.

### OrderHistoryComponent

- Changed `<h3 *ngIf="!type.replenishmentOrder"></h3>` to `<h2 *ngIf="!type.replenishmentOrder"></h2>`

### OrderConfirmationThankYouMessageComponent

#### Template Changes

- Component template was modified to display `span` instead of `h1` for page title.

### PromotionsComponent

- Component template was modified to display single promotions using the `p` tag and multiple promotions using `ul` list elements

### CartDetailsComponent

- Component template was modified to display `h2` instead of `h4` for cart name.
- Button in `#saveForLaterBtn` is no longer wrapped by div element.

### SaveForLaterComponent

- Button in `#moveToCartBtn` is no longer wrapped by div element.

### CartOutlets

- New enum values available: `LIST_ITEM` and `ITEM_CONFIGURATOR_ISSUES`;

### CartItemComponent

- Component template was modified to display `h3` instead of `h2` for product name.
- Component template was modified, `tabindex` for `a` element inside `<div class="col-2 cx-image-container">` has been changed from `-1` to `0`
- Added separated `[cxOutlet]="CartOutlets.ITEM_CONFIGURATOR_ISSUES"` inside `ITEM` outlet.

### CartItemListComponent

- Component template was modified to display native table instead of nested divs. The structure has been simplified and bootstrap classes has been removed.
- It doesn't use `cx-cart-item` anymore. Instead, it uses new `cx-cart-item-list-row` component.

### OrderSummaryComponent

- Component template was modified to display `h2` instead of `h3` for order summary.
- Markup template changed in `order-summary.component.html`. `h2` tag has been converted to `div.cx-summary-heading` and `h4.cx-review-cart-heading` has been converted to `div.cx-review-cart-heading` in two places for screen reader improvements.

### ProductAttributesComponent

- Component template was modified to display `h2` instead of `h3` for classification name.

### CartCouponComponent

- Component template was modified to display coupon as a `label` inside a form. Previously it was in a `div` before `form` tag.

### CheckoutProgressComponent

- `section` element changed to `nav`.

### CardComponent

- Component template was modified to display `span` instead of `h3` for card title.
- `<a>{{action.name}}</a>` changed to `<button>{{ action.name }}</button>`
- `cx-card-link card-link btn-link` classes have been replaced with a single class `link`

### StoreFinderSearchComponent

- Component template modified, `input[attr.aria-label]="'common.search' | cxTranslate"` has been changed to `input[attr.aria-label]="'storeFinder.searchBoxLabel' | cxTranslate"`
- Component template modified, `cx-icon[attr.aria-label]="'common.search' | cxTranslate"` has been changed to `cx-icon[attr.aria-label]="'storeFinder.searchNearestStores' | cxTranslate"`

### StoreFinderListComponent

- Component template modified, part under `<div class="cx-columns-mobile">` has been refactored to not depend on `NgbNav` anymore.
- All related directives have been removed, like: `ngbNav`, `ngbNavItem`, `ngbNavLink`, `ngbNavContent`, `ngbNavOutlet`.
- Attributes `role="tablist"` and `class="nav cx-nav"` were added to `ul`.
- Attribute `class="nav-item cx-nav-item"` has been added to `li` elements.
- Clickable tabs were replaced from `a` tag to `button`.
- Variable `displayModes` was added to iterate tabs through available display modes.
- Element `<div class="cx-address-col">` was wrapped by `<div id="tab-listView-panel" role="tabpanel" aria-labelledby="tab-listView">` to improve a11y performance.
- Element `<div class="cx-map-col">` was wrapped by `<div id="tab-mapView-panel" role="tabpanel" aria-labelledby="tab-mapView">` to improve a11y performance.
- To display appropriate content `[ngSwitch]` and `[ngSwitchCase]` directives were added.

### SearchBoxComponent

- Component template modified, `<label class="searchbox" [class.dirty]="!!searchInput.value">` has been wrapped in a `div`
- Attribute `role="listbox"` has been added to `ul` tags and `role="option"` to descendant `a` elements for accessibility improvements.

### QuickOrderFormComponent

- Component template modified, `input[attr.aria-label]="'common.search' | cxTranslate"` has been changed to `input[attr.aria-label]="'quickOrderForm.searchBoxLabel' | cxTranslate"`
- Styling for `cx-quick-order-form` dom element: deprecated class `search` was removed. Use `quick-order-form-search-icon` class instead.

### QuickOrderTableComponent

- Component template was modified to display native table instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### QuickOrderItemComponent

- The selector should not be used independently - it should be applied for `tr` elements.
- Component template was modified to display content of native table's cells (`td`) instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### WishListComponent

- Component template was modified to display native table instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### WishListItemComponent

- The selector should not be used independently - it should be applied for `tr` elements.
- Component template was modified to display content of native table's cells (`td`) instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### AmendOrderItemsComponent

- Component template was modified to display native table instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### ReturnRequestItemsComponent

- Component template was modified to display native table instead of nested divs. The structure has been simplified and bootstrap classes has been removed.

### DeliveryModeComponent

- the condition to show a spinner was changed to: `supportedDeliveryModes$ | async)?.length && !(isSetDeliveryModeBusy$ | async)`.
- the `ng-container` wrapper which holds `div.row.cx-checkout-btns` is removed.

### StoreFinderListItemComponent

- `store-finder-list-item.component.html` markup structure changed. `h2.cx-store-name > button` changed to `a.cx-store-name` for screen reader improvements.

### BreadcrumbComponent

#### Template changes

- `breadcrumb.component.html` markup structure change from `nav > span > a` to `nav > ol > li > a` for Screen reader improvements and corresponding styles has also been updated.

#### Translation (i18n) changes

- `common.breadcrumbs` was added to `common.ts`

### ParagraphComponent

- `p` has been replaced by `div` tag.

### AddressFormComponent

#### Template changes

- Separated the bootstrap class `"row"` from the parent `<div class="cx-address-form-btns">` to keep the html semantic and keep the cx class from overwriting the bootstrap styles
- Moved element `<div class="cx-address-form-btns">` inside the top level `<div class="row">`
- Changed classes of `<div class="col-md-12 col-lg-6">` to `<div class="col-md-13 col-lg-6">` inside `<div class="cx-address-form-btns">`
- Changed classes of `<div class="col-md-12 col-lg-9">` to `<div class="col-md-12 col-xl-10">` inside `<form (ngSubmit)="verifyAddress()" [formGroup]="addressForm">` from the first row .column

### CancelOrderComponent

#### Template changes

- Added `<cx-message>` element inside the wrapper `<ng-container *ngIf="form$ | async as form">` to indicate form error

### ReviewSubmitComponent

- Markup template changed in `review-submit.component.html`. `h4.cx-review-cart-total` tag has been converted to `div.cx-review-cart-total` for screen reader improvements.

#### Template changes - structure of navigation has been changed:

- whole content has been wrapped in `nav > ul`
- `div > span.back` has been replaced by `li > button.back`
- every smaller `nav` has been changed to `li`
- `span` which was a header in `ng-template #heading` has been changed to `cx-generic-link` + `button` in most of the cases (except e.g. footer-nav structure)
- `div.wrapper > cx-generic-link` with "shop all ..." link has been removed. Now the `cx-generic-link` will be displayed in `#heading` (see point above).

#### Translations (i18n) changes

- key `common.navigation.shopAll` has been removed.
- added new keys: `common.navigation.categoryNavLabel`, `common.navigation.footerNavLabel`

### CheckoutPageMetaResolver

- Class now implements `PageHeadingResolver`

### StoreFinderComponent

#### Template changes

- `div` container of class `cx-store-finder-wrapper` has been wrapped by another `div` for better a11y performance.

#### Translation (i18n) changes

- `resultsFound` key has been removed.
- Following keys `storesFound`, `ariaLabelCountriesCount` have been added for screen reader improvements.

### FacetComponent

- Attribute `role="checkbox"` has been added to checkable `a` elements for accesibility improvements.

#### Translations (i18n) changes

- Added new key `product.productFacetNavigation.ariaLabelItemsAvailable` to improve Screen Readers vocalization.

### SpinnerComponent

- Attribute `role="status"` has been added to `div` of class `loader-container` for accesibility improvements.

### CheckoutPlaceOrderComponent

#### Translation (i18n) changes

- Added new key `checkoutReview.placeOrder` to improve Screen Reader vocalization.

### FormErrorsComponent

- Class now implements 'DoCheck'.
- Added host attribute `role="alert"`.
- Added new property `hidden` which is host for class `cx-visually-hidden`.
- content rendering depends on `hidden` flag.
- `errorsDetails$` field type has been changed from `Observable<Array<[string, string]>>` to `Observable<Array<[string, string | boolean]>>`

### ComponentWrapperDirective

- `cmfRef` has been made `protected` due to being unsafe.

### StockNotificationDialogComponent

All modal content is wrapped inside  `<div class="cx-stock-notification-dialog">` and `<div class="cx-modal-container">` tags.

Translation (i18n) changes:

- `subscriptionDialog.notifiedSuffix` changed from `as soons as this product is back in stock.` to `as soon as this product is back in stock.`.
- `subscriptionDialog.manageChannelsPrefix` changed from `Manage your prefered notification channels at the ` to `Manage your preferred notification channels on the `.
- `subscriptionDialog.manageSubscriptionsPrefix` changed from `You can manage your subscriptions at ` to `You can manage your subscriptions on `.

### AddToCartComponent

#### Template changes

- Wrapped elements `cx-item-counter` and `span.info` in a `div` to prevent styling bug on Firefox.

### i18next breaking changes
Due to i18next migration, certain set of keys have been migrated (from `_plural` to `_other`) to include proper plural form suffixes:
- `common.pageMetaResolver.category.title_other`
- `common.pageMetaResolver.search.title_other`
- `common.pageMetaResolver.search.findProductTitle_other`
- `common.searchBox.suggestionsResult_other`
- `common.miniCart.item_other`
- `product.productFacetNavigation.ariaLabelItemsAvailable_other`
- `product.productReview.addRate_other`
- `quickOrderList.errors.outOfStockErrorFound_other`
- `quickOrderList.warnings.reduceWarningFound_other`
- `quickOrderList.successes.addedToCartFound_other`
- `cart.cartItems.cartTotal_other`
- `cart.voucher.coupon_other`
- `cart.saveForLaterItems.itemTotal_other`
- `importEntriesDialog.warning_other`
- `importEntriesDialog.error_other`
- `storeFinder.storesFound_other`
- `storeFinder.fromStoresFound_other`

### UpdateProfileComponent

#### Translation (i18n) changes

- `updateProfileForm.title` changed from `''` to `'Title'`

### CheckoutPaymentTypeComponent

#### Template Changes

- Changed `<ng-container *ngIf="(typeSelected$ | async) && !(isUpdating$ | async); else loading">` to `<ng-container *ngIf="!!paymentTypes.length && (typeSelected$ | async) && !(isUpdating$ | async); else loading">`

### ProductCarouselComponent

- Template code for carousel item has been moved to a reusable component - `ProductCarouselItemComponent` Its selector is `<cx-product-carousel-item>`.


### OccEndpoints

- Endpoints `b2bUsers`, `b2bUser`, `b2bUserApprovers`, `b2bUserApprover`, `b2bUserUserGroups`, `b2bUserUserGroup`, `b2bUserPermissions`, `b2bUserPermission`, `budget`, `budgets`, `costCentersAll`, `costCenter`, `costCenters`, `costCenterBudgets`, `costCenterBudget`, `orgUnits`, `orgUnitsAvailable`, `orgUnitsTree`, `orgUnitsApprovalProcesses`, `orgUnit`, `orgUnitUsers`, `orgUnitUserRoles`, `orgUnitUserRole`, `orgUnitApprovers`, `orgUnitApprover`, `orgUnitsAddresses`, `orgUnitsAddress`, `permissions`, `permission`, `orderApprovalPermissionTypes`, `userGroups`, `userGroup`, `userGroupAvailableOrderApprovalPermissions`, `userGroupAvailableOrgCustomers`, `userGroupMembers`, `userGroupMember`, `userGroupOrderApprovalPermissions`, `userGroupOrderApprovalPermission` were removed from the declaration in `@spartacus/core`. Those endpoints are now provided with module augmentation from `@spartacus/organization/administration/occ`. Default values are also provided from this new entry point.
- Endpoints `orderApprovals`, `orderApproval`, `orderApprovalDecision`, were removed from the declaration in `@spartacus/core`. Those endpoints are now provided with module augmentation from `@spartacus/organization/order-approval/occ`. Default values are also provided from this new entry point.
- Endpoints `store`, `stores`, `storescounts`, were removed from the declaration in `@spartacus/core`. Those endpoints are now provided with module augmentation from `@spartacus/storefinder/occ`. Default values are also provided from this new entry point.

### IconLoaderService

- Text type icon symbols are now converted into text, meaning DOM does not render HTML symbols anymore.

### JsonLdScriptFactory

- Removed `DomSanitizer` from constructor.
- `sanitize` method was removed, replaced by `escapeHTML` for security improvement.

### JsonLdDirective
- Added `Renderer2` and `ElementRef` to constructor
- Removed `DomSanitizer` from constructor.

## Schematics

`Account` and `Profile` CLI names have been changed to `User-Account` and `User-Profile`, respectively, to better reflect their purpose.


## Merchandising Module Changes

### Not used converters removed

- Removed converter class `MerchandisingFacetNormalizer`
- Removed converter class `MerchandisingFacetToQueryparamNormalizer`
- Removed const `MERCHANDISING_FACET_NORMALIZER` pointing to MerchandisingFacetNormalizer converter
- Removed const `MERCHANDISING_FACET_TO_QUERYPARAM_NORMALIZER` pointing to MerchandisingFacetToQueryparamNormalizer converter
- Removed `forRoot` method from `MerchandisigModule`

### CdsMerchandisingProductService

- Removed `CdsMerchandisingSearchContextService` from constructor
- Changed return type for method `loadProductsForStrategy`  (`Observable<StrategyProducts>` -> `Observable<StrategyResponse>`)

### CdsMerchandisingUserContextService

- Removed `ConverterService` from constructor
- Added `FacetService` to constructor


### OrderHistoryComponent

- Added `PONumber` and `costCenter` columns to the `table`
- Attribute `role="table"` has been added to `table` for accesibility improvements.
- Added hidden `caption` in the `table` for accesibility improvements.
- Attribute `role="row"` has been added to `tr` for accesibility improvements.
- Attribute `role="cell"` has been added to `td` for accesibility improvements.

### TrackingEventsComponent

- All classes related to component templating have been prefixes with `cx-`
- Changed `<div class="events modal-body">` to `<div class="cx-tracking-events modal-body">`
- Changed `<div class="event-body">` to `<div class="cx-tracking-event-body">`
- Changed `<div class="event-content">` to `<div class="cx-tracking-event-content">`
- Changed `<div class="event-title">` to `<div class="cx-tracking-event-title">`
- Changed `<div class="event-city">` to `<div class="cx-tracking-event-city">`
- Changed `<div class="tracking-loading">` to `<div class="cx-tracking-loading">`

### AddedToCartDialogComponent

- Wrapper for entire dialog `<div #dialog>` has been removed. Instead all modal content was wrapped inside  `<div class="cx-modal-container">` and `<div class="cx-modal-content">` tags
- Directives `cxModal` and `cxModalReason` were removed from action buttons 
- Close modal action is now performed by `(click)="dismissModal('Reason')"` method 

### SuggestedAddressesDialogComponent

- template has been wrapped with `<div *ngIf="data$ | async as data" class="cx-suggested-addresses-dialog">` > `<div class="cx-suggested-addresses-container">`
- Changed `<div class="cx-dialog-header modal-header">` to `<div class="cx-suggested-addresses-header">`
- Changed `<div class="cx-dialog-title modal-title">` to `<div class="cx-suggested-addresses-header">`
- Changed `<div class="cx-dialog-body modal-body" ngForm>` to `<div class="cx-suggested-addresses-body" ngForm>`
- Removed `<div class="container">`
- Removed all `<div class="row">`
- Footer part has been wrapped with `<div class="cx-suggested-addresses-footer">`
- Class `btn-block` has been removed from `<button class="btn btn-secondary btn-block cx-dialog-buttons" (click)="closeModal()">`
- Class `btn-block` has been removed from `<button cxAutoFocus class="btn btn-primary btn-block cx-dialog-buttons" (click)="closeModal(selectedAddress)">`

### CloseAccountModalComponent

- template inside `<ng-container>` has been wrapped with `<div class="cx-close-account-modal" [cxFocus]="focusConfig" (esc)="dismissModal('Escape click')">` and `<div class="cx-close-account-modal-container">`
- Changed `<div class="modal-header cx-dialog-header">` to `<div class="cx-close-account-modal-header">`
- Changed `<h3 class="modal-title">` to `<h3 class="cx-close-account-modal-title">`
- Changed `<div class="modal-body">` to `<div class="cx-close-account-modal-body">`
- Changed `<div class="cx-btn-group">` to `<div class="cx-close-account-modal-footer">`
- All `<div class="cx-row">` have been removed
- Added class `.cx-close-account-modal` extending `.modal-dialog` and `.modal-dialog-centered`
- Added class `.cx-close-account-modal-container { padding: 1rem }` extending `.modal-content` 
- Added class `.cx-close-account-modal-header {display: flex; justify-content: space-between}` including `type('3')`
- Added class `.cx-close-account-modal-title` including `type('3')`
- Added class `.cx-close-account-modal-body { padding: 1rem 0 }` extending `.modal-body`
- Added class `cx-close-account-modal-footer { display: flex }`

### CouponDialogComponent

- Added two levels of wrappers in template to align structure with other dialogs in project: `.cx-coupon-dialog` and `.cx-coupon-container`
- Changed close button click event method from `dismissModal` to `close` 
