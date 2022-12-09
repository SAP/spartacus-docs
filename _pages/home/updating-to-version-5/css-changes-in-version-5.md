---
title: Changes to Styles in 5.0
---

## Changes in the Configurator Tab Bar Component

- Styling is now applied only if the content is not empty. Therefore, the styling is wrapped with an `&:not(:empty) {` expression.
- `justify-content` is set to `flex-end` instead of `flex-start`.

## Changes in the Configurator Add To Cart Button Component

- `.cx-display-only-btn-container` and `button.cx-display-only-btn` were added to `_configurator-add-to-cart-button.scss`. Both classes use the same styling as the `add-to-cart-button`.
- `position` was added and set to `fixed` in `%cx-configurator-add-to-cart-button` to make the button float. The `position` will be set to `sticky` once the intersection of `.cx-price-summary-container` occurs.
- `bottom` was added and set to `0` in `%cx-configurator-add-to-cart-button`.
- `width` was added and set to `100%` in `%cx-configurator-add-to-cart-button`.
- `background-color` was added and set to `var(--cx-color-background)` in `%cx-configurator-add-to-cart-button`.
- `border-top` was added and set to `solid 1px var(--cx-color-light)` in `%cx-configurator-add-to-cart-button`.
- `box-shadow` was added and set to `0 0 5px var(--cx-color-light)` in `%cx-configurator-add-to-cart-button`.
- `margin-top` was added and set to `0px` in `@include cx-configurator-footer-container()`.

## Changes in the Configurator Overview Notification Banner Component

- The error banner was converted to a div so that the `cx-error-notification-banner` style could be added.
- A new conflict banner div with the `cx-conflict-notification-banner` style was added.

## Changes in the Configurator Attribute Numeric Input Field Component

- `flex-direction` is set to `column` in `%cx-configurator-attribute-numeric-input-field`.
- `configurator-validation-msg` mixin has been defined in `%cx-configurator-attribute-numeric-input-field` to achieve a consistent styling for rendering a validation message underneath the numeric input field.

## Change in the Configurator Required Error Message Mixin

The `cx-configurator-error-msg` mixin has been defined in the `%cx-configurator-required-error-msg` mixin to achieve a consistent styling for rendering error and validation messages.

## Changes in Styles

### Changes in \_configurator-attribute-header.scss

- `padding-inline-start: 5px;` was removed from the `cx-icon`section.
- A new `a.cx-conflict-msg` section has been introduced to style the link that allows for navigating from conflicting attributes to their original group. Its content is `cursor: pointer;`.

### Changes in \_configurator-overview-notification-banner.scss

- The flex box at the root level was changed to column direction to support multiple banners placed underneath.
- `.cx-error-notification-banner` and `.cx-conflict-notification-banner` were added with a flex direction row for styling the individual banners.
- `.cx-error-notification-banner` replicates the error banner style implemented before at the root level.
- `.cx-conflict-notification-banner` implements the new conflict banner styling.

### Changes in \_tab-paragraph-container.scss

- Wrapped everything in `%pdpTabs` inside a `> div {...}` to restore styling after template changes.
- Wrapped everything in `%pdpFlat` inside a `> div {...}` to restore styling after template changes.
- `span.accordion-icon` has been added for screen reader improvements.
- A `$useAccordionOnly` variable has been added, allowing to switch between the tabs and accordion views.
- The `div.cx-tab-paragraph-content` class has been added to change the background color of the active open tab.

### Change in \_order-summary.scss

An `h2` has been changed to `.cx-summary-heading` to restore styling for the corresponding markup changes.

### Change in tables.scss

`text-align: center` has been removed from `.table > thead > th`.

### Change in store-finder-list-item.scss

Obsolete style rules were removed for the `.cx-store-name` class because the markup structure changed from `h2.cx-store-name > button` to `a.cx-store-name` for screen reader improvements.

### Mixins

`padding-block-end` was deleted in `@mixin cx-configurator-template` to enable floating add to cart button styling.

### BreadcrumbComponent (_breadcrumb.scss)

- The style structure changed from `span > a` to `ol > li > a` to account for the changes in template markup.
- Added `text-transform` and set to `capitalize` for `h1`.

### AddressFormComponent

Changed `justify-content` to `center` for `.cx-address-form-btns` in `%cx-address-form`.

### NavigationUIComponent, NavigationComponent, FooterNavigationComponent, CategoryNavigationComponent

The styles has been aligned to the new structure of navigation. For more information, see the template changes of the [NavigationUIComponent](./5_0.md#NavigationUIComponent).

### CartItemComponent

- The width for `cx-label` in `cx-price` is set to `100px` in mobile view.
- The width for `cx-label` in `cx-total` is set to `100px` in mobile view.
- The width for `cx-label` in `cx-quantity` is set to `100px` in mobile view.
- Set `display` to `block` for `cx-actions > link` in mobile view.

### FormErrorsComponent

- `display: none` has been removed from `cx-form-errors`.
- Style structure `&.control-invalid > &.control-dirty, &.control-touched` has been removed from `cx-form-errors`.

### AddToCartComponent (_add-to-cart.scss)

- Added `position` and set to `absolute` of `quantity.info`.
- Added `transform` and set to `translate(0, -50%)` of `quantity.info`.
- Added `top` and set to `50%` of `quantity.info`.

### CartDetails (_cart-details.scss)

Removed styling for classes `cx-total`, `cx-remove-btn`, `cx-sfl-btn`.

### CartItemList (_cart-item-list.scss)

- Now it extends styles of `.cx-agnostic-table`.
- Most of the styles responsible for table structure have been moved to `.cx-agnostic-table`.
- Previous styles have been removed and custom styling has been added for cells and used classes. Please see the source code for more details.

### CartItemValidationWarning (_cart-item-validation-warning.scss)

Changed `text-align` to `var(--cx-text-align, start)` for `.alert` in `%cx-cart-item-validation-warning`.

### SaveForLater (_save-for-later.scss)

Removed styling for classes `cx-total`, `cx-remove-btn`, and `cx-sfl-btn`.

### QuickOrderForm (_quick-order-form.scss)

The `cx-quick-order-form` selector has been replaced by the `%cx-quick-order-form` placeholder selector.

### CartQuickOrderForm (_cart-quick-order-form.scss)

The `cx-cart-quick-order-form` selector has been replaced by the `%cx-cart-quick-order-form` placeholder selector.

### QuickOrder (_quick-order.scss)

The `cx-quick-order` selector has been replaced by the `%cx-quick-order` placeholder selector.

### QuickOrderTable (_quick-order-table.scss)

- The `cx-quick-order-table` selector has been replaced by the `%cx-quick-order-table` placeholder selector.
- Now it extends styles of `%cx-cart-item-list`.
- All other styles have been removed.

### WishList (_wish-list.scss)

- Added styling for `td.cx-actions > cx-add-to-cart`.
- Removed styling for `.cx-item-list-price`.
- Removed `--cx-max-width: 75%` and `margin: auto` from `%cx-wish-list`.
- Changed the order of `@include media-breakpoint-down(sm)` and `@include media-breakpoint-down(md)`.
- Styling for `.cx-item-list-row:last-of-type` has been moved from `@include media-breakpoint-down(sm)` to `@include media-breakpoint-down(md)`.
- `--cx-max-width` from `@include media-breakpoint-down(md)` has been changed to `75%`.

### WishListItem (_wish-list-item.scss)

File has been removed.

### AmendOrderItems (_amend-order-items.scss)

- Now it extends styles of `%cx-cart-item-list`.
- All other styles have been removed.

### ReturnRequestItems (_return-request-items.scsss)

- Now it extends styles of `%_return-request-items.scss`.
- All other styles have been removed.

### LoginComponent (_login.scss)

- Added `padding-top` and set to `4px` for the `nav > ul > li > button` part of the `cx-page-slot`.
- Added `padding-bottom` and set to `0` for the `nav > ul > li > button` part of the `cx-page-slot`.

### ConfigureCartEntry (_configure-cart-entry.scss)

- Changed `font-size` to `var(--cx-font-size, 1.188rem)` for `label.disabled-link` in `%cx-configure-cart-entry`.
- Changed `font-weight` to `var(--cx-font-weight-bold)` for `label.disabled-link` in `%cx-configure-cart-entry`.

### Change in _variables.scss

`$primary-accent: #ff8b8b !default;` has been added to Sparta theme colors.

### Change in santorini.scss

`--cx-color-primary-accent: #50b0f4;` and `--cx-color-secondary-accent: #c3cbde;` were added to the Santorini theme.
