---
title: Changes to HTML in Spartacus 6.0
---

The following HTML changes were made in Spartacus 6.0.

## CheckoutTranslations

- Changed default English translation for `checkoutProgress.paymentDetails` key from `Payment Details` to `Payment`.
- Changed default English translation for `checkoutProgress.reviewOrder` key from `Review Order` to `Review`.
- Changed default English translation for `checkoutProgress.deliveryAddress` key from `Delivery Address` to `Shipping Address`.
- Removed English translation key for `checkoutAddress.deliveryAddress`. In default templates, this key is replaced by `checkoutAddress.shippingAddress`.

## Miscellaneous Configs

### defaultAnonymousConsentLayoutConfig

Changed `inline: true` to `inlineRoot: true` for keyboard tabbing and VO to work correctly.

### defaultCouponLayoutConfig

Changed `inline: true` to `inlineRoot: true` for keyboard tabbing and VO to work correctly.

## Miscellaneous Components

### ActiveFacetsComponent

Replaced `h4` tag with `h2` tag `header` for accessibility improvements.

### AddressBookComponent

- Replaced `p` tag with `h2` tag `header` for accessibility improvements.
- Changed `btn btn-block btn-action` to `btn btn-block btn-secondary`.

### AddressBookFormComponent

- Added `cellphone` field to the `addressForm`.
- Added `Cellphone` field to address card with corresponding form group element.

### AddToCartComponent

- Changed line 33 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.
- Changed line 37 to have `button` content wrapped in a `span` tag on line 46. The `AddToCart` string can be interchanged with `BuyItAgain`.
- Added Icon wrapped in a `span` tag which appears when `AddToCart` string is changed to `BuyItAgain`.
- Changed line 31 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.
- Added class `cx-dialog-pickup-store` to line 39.
- Added `span class="cx-dialog-pickup-store-name"` to line 41.

### AddToSavedCartComponent

- Changed line 3 `<button>` to `<a>`.
- Changed line 14 `<button>` to `<a>`.

### AmendOrderActionsComponent

Changed line 9 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### AnonymousConsentManagementBannerComponent

- Changed bootstrap class on buttons from `col-lg-8` to `col-lg-7` and `col-lg-4` to `col-lg-5`. 
- Changed bootstrap class `col-lg-4 col-xs-12 cx-banner-buttons` to `col-lg-5 col-xs-12 cx-banner-buttons`.
- Changed `btn btn-action` to `btn btn-secondary`.

### AppliedCouponsComponent

- Removed invalid attribute (`role="filter"`) from div tags for accessibility improvements.
- `<div class="coupon-summary">` element has been removed.

### AsmMainUiComponent

Custom customer list has been added as first child of `<div class="asm-bar-actions">` tag.

### B2BCheckoutDeliveryAddressComponent

- Changed line 24 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 54 classes from `'cx-btn btn btn-block btn-action'` to `'cx-btn btn btn-block btn-secondary'`.

### CardComponent

Replaced `a` tag with `button` for accessibility improvements.

### CartCouponComponent

Changed line 18 class `btn-action` to `btn-secondary` to update to UX specifications.

### CartItemListRowComponent

Changed class on line 155 `link cx-action-link` to `btn btn-tertiary`.

### CartQuickOrderFormComponent

Changed line 44 classes from `'btn btn-block btn-action apply-quick-order-button'` to `'btn btn-block btn-secondary apply-quick-order-button'`.

### CheckoutDeliveryAddressComponent

- Replaced translation text from `checkoutAddress.deliveryAddress` to `checkoutAddress.shippingAddress` in the element `<h2 class="cx-checkout-title d-none d-lg-block d-xl-block">`.
- Changed line 24 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 54 classes from `'cx-btn btn btn-block btn-action'` to `'cx-btn btn btn-block btn-secondary'`.

### CheckoutDeliveryModeComponent

Changed design and structure of how delivery modes are displayed.

### CheckoutPaymentFormComponent

- Changed line 410 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 417 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### CheckoutPaymentMethodComponent

- Changed line 23 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 51 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### CheckoutPaymentTypeComponent

Changed line 66 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### CheckoutReviewSubmitComponent

Removed `col-md-12` from `div` tag used to display entries.

### ClearCartComponent

Changed line 161 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.

### ClearCartDialogComponent

Changed line 42 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ConfiguratorAttributeDropDownComponent

Drop-down options can now contain the technical attribute value key (if expert mode is active) and the value price if present.

### ConfiguratorAttributeProductCardComponent

- Changed line 72 classes from `'btn btn-action'` to `'btn btn-secondary'`.
- Changed line 133 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ConfiguratorAttributeReadOnlyComponent

- Component content now wrapped in `<fieldset>`.
- Label can now contain the technical attribute value key (if expert mode is active).
- New `cx-read-only-attribute-label` class attached to the label has been introduced.
- Label is wrapped in `<div class="cx-value-label-pair">` for accessibility improvements.
- Value price is displayed in addition to label, wrapped in `<div class="cx-value-price">`.

### ConfiguratorGroupTitleComponent

Contains `<cx-hamburger-menu>` for mobile resolutions.

### ConfiguratorOverviewFormComponent

Overview group style class is now compiled by the `<div [ngClass]="getGroupLevelStyleClasses(level, group.subGroups)">` component.

### ConfiguratorOverviewMenuComponent

Overview menu is wrapped in an unordered list`<ul>` for accessibility improvements.

### ConfiguratorPreviousNextButtonsComponent

- Changed line 4 classes from `'cx-btn btn btn-action'` to `'cx-btn btn btn-secondary cx-previous'`.
- Changed line 12 classes from `'cx-btn btn btn-secondary'` to `'cx-btn btn btn-secondary cx-next'`.

### ConfiguratorProductTitleComponent

Now also contains information about the knowledge base that was used to run the configuration. This information is only visible when expert mode is active. The knowledge base-related information is enclosed with `<div class="cx-kb-key-details">`.

### ConsignmentTrackingComponent

Changed line 5 classes from `'btn btn-action btn-track'` to `'btn btn-secondary btn-track'`.

### CouponCardComponent

- Replaced anchor tag with button tag for `read more` link for accessibility tabbing improvements.
- Changed line 60 `btn btn-block btn-action` to `btn btn-block btn-secondary`.

### CSAgentLoginFormComponent

- Replaced `div.spinner` tag with `cx-dot-spinner`.
- Changed assertions to `expect(el.query(By.css('cx-dot-spinner'))).toBeTruthy();` in unit tests.

### CustomerEmulationComponent

Removed the disabled `<input>` element and replaced it with the corresponding information in the `<div class="cx-asm-customerInfo">` element.

### CustomerSelectionComponent

- Replaced `div.spinner` tag with `cx-dot-spinner`.
- Changed assertions to `expect(el.query(By.css('cx-dot-spinner'))).toBeTruthy();` in unit tests.

### CustomerTicketingCloseComponent

Customer ticketing cancel button class has been changed from `class="btn btn-action"` to `class="btn btn-secondary"`.

### CustomerTicketingCloseDialogComponent

Close ticket dialog cancel button class has been changed from `class="btn btn-action"` to `class="btn btn-secondary"`.

### CustomerTicketingCreateDialogComponent

Create ticket dialog cancel button class has been changed from `class="btn btn-action"` to `class="btn btn-secondary"`.

#### CustomerTicketingReopenComponent

Changed `btn-action` to `btn-secondary` to fix the styling.

### CustomerTicketingReopenDialogComponent

Reopen ticket dialog cancel button class has been changed from `class="btn btn-action"` to `class="btn btn-secondary"`.

### DpPaymentMethodComponent

- Changed line 24 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 50 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### ExportOrderEntriesComponent

- Changed translation key from `exportEntries.exportToCsv` to `exportEntries.exportProductToCsv`.
- Changed line 5 classes from `'link cx-action-link'` to `'btn btn-tertiary cx-export-btn'`.
- Changed line 14 classes from `'link cx-action-link'` to `'btn btn-tertiary cx-export-btn'`.

### FacetListComponent

Separated button tag from header tag for accessibility improvements.

### FileUploadComponent

Changed line 12 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ImportEntriesFormComponent

Changed line 20 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ImportEntriesSummaryComponent

- Changed line 33 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.
- Changed line 61 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.
- Changed line 83 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ImportOrderEntriesComponent

Changed line 3 classes from `'link cx-action-link'` to `'btn btn-tertiary cx-import-btn'`.

### ImportToNewSavedCartFormComponent

Changed line 64 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### ListComponent

Wrapped `a` tag in line 60 with a conditional `if` clause. The corresponding `else` clause has a new `button` tag with `(click)` event. Also, the labels are returned from the `getCreateButtonLabel()` method.

### MyCouponsComponent

Replaced `h3` tag with `h2` tag `header` for accessibility improvements.

### MyInterestsComponent

Replaced `h3` tag with `h2` tag `header` for accessibility improvements.

### OrderApprovalListComponent

- Wrapped `cx-sorting` with `label` and added hidden `span` for accessibility improvements.
- The `role="table"` attribute has been added to `table` for accessibility improvements.
- Added hidden `caption` in the `table` for accessibility improvements.
- The `role="row"` attribute has been added to `tr` for accessibility improvements.
- The `role="cell"` attribute has been added to `td` for accessibility improvements.

### OrderDetailActionsComponent

- Changed line 6 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 21 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 34 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### OrderHistoryComponent

- Added `PONumber` and `costCenter` columns to the `table`.
- The `role="table"` attribute has been added to `table` for accessibility improvements.
- Added hidden `caption` in the `table` for accessibility improvements.
- The `role="row"` attribute has been added to `tr` for accessibility improvements.
- The `role="cell"` attribute has been added to `td` for accessibility improvements.
- Wrapped `th` tags with `tr` for accessibility improvements.

### PaymentMethodsComponent

Replaced `h3` tag with `h2` tag `header` for accessibility improvements.

### PickupOptionDialogComponent

Added class `cx-modal-container` to line 2.

### ProductFacetNavigationComponent

Changed line 3 `btn btn-action btn-block dialog-trigger` to `btn btn-secondary btn-block dialog-trigger`.

### ProductScrollComponent

- Changed line 29 `btn btn-block btn-action` to `btn btn-block btn-secondary`
- Changed line 36 `btn btn-block btn-action align-btn` to `btn btn-block btn-secondary align-btn`
- Changed line 73 `btn btn-block btn-action` to `btn btn-block btn-secondary`
- Changed line 80 `btn btn-block btn-action align-btn` to `btn btn-block btn-secondary align-btn`

### QuickOrderComponent

- Replaced h3 tag with h2 tag `header` for accessibility improvements.
- Changed line 195 classes from `col-xs-12 col-md-5 col-lg-4` to `col-xs-12 col-md-5 col-lg-3` 
- Changed line 201 classes from `btn btn-block btn-action clear-button` to `btn btn-block btn-secondary clear-button` 
- Changed line 208 classes from `col-xs-12 col-md-5 col-lg-4` to `col-xs-12 col-md-5 col-lg-3` 

### QuickOrderFormComponent

Renamed `div` tag `id` value and `input` tag `aria-controls` value to remove duplicate IDs that occurred on the screen.

### QuickOrderItemComponent

Changed line 61 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.

### ReplenishmentOrderCancellationComponent

- Changed line 4 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.
- Changed line 18 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### ReplenishmentOrderCancellationDialogComponent

- Icon button has been added with closing dialog functionality inside `<div class="cx-cancel-replenishment-dialog-header">`.
- Changed line 32 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### ReplenishmentOrderHistoryComponent

- Added column header text for actions column.
- Added hidden `caption` in the `table` for accessibility improvements.
- Replenish order history cancel button class has changed from `class="cx-order-cancel btn btn-link"` to `class="cx-order-cancel btn btn-secondary"`.

### ReturnRequestOverviewComponent

Changed line 4 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### SavedCartDetailsActionComponent

Changed line 6 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### SavedCartFormDialogOptions

- Changed line 146 classes from `'mr-2 btn btn-action'` to `'mr-2 btn btn-secondary'`.
- Changed line 244 classes from `'btn btn-action'` to `'btn btn-secondary'`.

### SavedCartListComponent

- Replaced `h3` tag with `h2` tag `header` for accessibility improvements.
- Changed line 123 classes from `'link cx-action-link cx-saved-cart-make-active'` to `'btn btn-tertiary cx-saved-cart-make-active'`.

### SaveForLaterComponent

Changed line 34 classes from `'link cx-action-link'` to `'btn btn-tertiary'`.

### SiteContextSelectorComponent

Added `:`

### StoreComponent

Changed line 63 btn class to `btn-secondary`.

### StoreFinderListItemComponent

Changed line 45 classes from `'btn btn-sm btn-action btn-block cx-button'` to `'btn btn-sm btn-secondary btn-block cx-button'`.

### StoreFinderSearchComponent

Added `tabindex"` to control tab stop for accessibility improvements.

### StoreFinderStoreComponent

Changed line 14 classes from `'btn btn-block btn-action'` to `'btn btn-block btn-secondary'`.

### StoreListComponent

Removed `container` class on line 20.

### UnitLevelOrderOverviewComponent

Removed a condition to hide 2nd order summary column.

### UnitUserListComponent

Added `*ngIf` to line 3 to hide/show the template based on condition.

### UpdateProfileComponent

Removed empty option (`ng-option`) from the title code selector(`ng-select`).

### UserDetailsComponent

- Added `*ngIf` in lines 8 and 18 to hide/show the template based on condition.
- Added `*ngIf` in line 71 with corresponding `else` clause to show/hide hyperlink for navigation.
- Updated condition in `*ngIf` clause in line 88 to hide/show the template based on condition.

### UserRegistrationFormComponent

- Added `id` attribute to `ng-select` to generate `aria-controls` for accessibility improvements.
- New input field for company name has been added. The markup for this field looks identical to the other text fields in the form.
