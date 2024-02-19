---
title: Changes to HTML in Spartacus 2211.19
---

The following HTML changes were made in Spartacus 2211..

## Changes in the Product Configurator Feature Library

### configurator-add-to-cart-button.html

A quantity control has been added for specifying the product quantity when adding to the cart.

### configurator-attribute-footer.component.html

The view now renders different error messages depending on the attribute type.

In the case of free input types, the resource key is `configurator.attribute.defaultRequiredMessage`. In the case of
drop-down attributes, the key is `configurator.attribute.singleSelectRequiredMessage`.

### configurator-attribute-drop-down.component.html

New styling `cx-required-error-msg` is active in case the attribute is required but not provided.

### configurator-attribute-input-field.component.html

New styling `cx-required-error-msg` is active in case the attribute is required but not provided.

### configurator-attribute-numeric-input-field.component.html

New styling `cx-required-error-msg` is active in case the attribute is required but not provided.

Issues with respect to the numeric format of the input are rendered with `ICON_TYPE.ERROR` instead of `ICON_TYPE.WARNING`.

### configurator-attribute-single-selection-bundle-dropdown.component.html

New styling `cx-required-error-msg` is active in case the attribute is required but not provided.

### configurator-price-summary.component.html

The label for total price uses the `configurator.priceSummary.totalPricePerItem` translation key instead of `configurator.priceSummary.totalPrice`.

## Changes in the ASM Feature Library

### asm-main-ui.component.html

Three new `cx-message` elements have been incorporated into the view to exhibit distinct confirmation messages based on specific events, as follows:

- Following the successful creation of a customer, the confirmation message is determined by the `showCreateCustomerSuccessfullyAlert` property being set to `true`.
- When initiating customer emulation, the confirmation message is contingent upon the `showCustomerEmulationInfoAlert` property being set to `true`.
- When managing either an inactive or active cart through a deep link, the confirmation message is dictated by the `showDeeplinkCartInfoAlert` property being set to `true`.

### customer-list.component.html

The close button has been relocated from the top-right corner to the bottom-left corner.

A new button for creating a customer has been introduced in the top-right corner.

Additionally, a new customer search text box has been incorporated.

### customer-selection.component.html

A new `<span>` element, adorned with the style class `linkStyleLabel`, has been introduced within the `searchResultItem` button. This particular `<span>` is designed to be visible in scenarios where the search result yields no matches. Importantly, this `<span>` serves as a clickable element facilitating the creation of a new customer.

## Changes in the Checkout Feature Library

### checkout-review-submit.component.html

Added a new `<ng-template>` to the delivery mode section for displaying the `CheckoutDeliveryModeComponent`.

### checkout-delivery-mode.component.html

Added a new `<ng-template>` to display `CheckoutDeliveryModeComponent`.

### order-overview.component.html

Added a new `<ng-template>` to display the `OrderOverviewComponent` in three different cases of orders.
