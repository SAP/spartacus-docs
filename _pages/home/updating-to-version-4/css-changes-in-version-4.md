---
title: Changes to Styles in 4.0
---

## Changes in the storefrontstyles Components

- The `$page-template-blacklist` SCSS variable name has been renamed to `$page-template-blocklist` in `_page-template.scss`.
- The `$cart-components-whitelist` SCSS variable name has been renamed to `$cart-components-allowlist` in `cart/_index.scss`.
- The `$cds-components-whitelist` SCSS variable name has been renamed to `$cds-components-allowlist` in `cds/index.scss`.
- The `$store-finder-components-whitelist` SCSS variable name has been renamed to `$store-finder-components-allowlist` in `store-finder/index.scss`.
- The `$checkout-components-whitelist` SCSS variable name has been renamed to `$checkout-components-allowlist` in `checkout/_index.scss`.
- The `$content-components-whitelist` SCSS variable name has been renamed to `$content-components-allowlist` in `content/_index.scss`.
- The `$layout-components-whitelist` SCSS variable name has been renamed to `$layout-components-allowlist` in `layout/_index.scss`.
- The `$misc-components-whitelist` SCSS variable name has been renamed to `$misc-components-allowlist` in `misc/_index.scss `.
- The `$myaccount-components-whitelist` SCSS variable name has been renamed to `$myaccount-components-allowlist` in `myaccount/_index.scss`.
- The `$product-components-whitelist` SCSS variable name has been renamed to `$product-components-allowlist` in `product/index.scss`.
- The `$product-list-whitelist` SCSS variable name has been renamed to `$product-list-allowlist` in `product/list/_index.scss`.
- The `$pwa-components-whitelist` SCSS variable name has been renamed to `$pwa-components-allowlist` in `pwa/add-to-home-screen-banner/_index.scss`.
- The `$user-components-whitelist` SCSS variable name has been renamed to `$user-components-allowlist` in `user/_index.scss`.
- The `$wish-list-components-whitelist` SCSS variable name has been renamed to `$wish-list-components-allowlist` in `wish-list/index.scss`.

## Changes in the Organization Feature Library

- The `$page-template-blacklist-organization` SCSS variable name has been renamed to `$page-template-blocklist-organization`.
- The `$page-template-whitelist-organization` SCSS variable name has been renamed to `$page-template-allowlist-organization`.

## Changes in the Storefinder Feature Library

- The `$page-template-blacklist-store-finder` SCSS variable name has been renamed to `$page-template-blocklist-store-finder`.
- The `$page-template-whitelist-store-finder` SCSS variable name has been renamed to `$page-template-allowlist-store-finder`.

## Changes in the Checkout Components

- The `cx-product-variants` selector has been moved to the corresponding `@spartacus/product` feature library.

## Change in the Configurator Attribute Type Components

- The `cx-quantity` selector has been added to achieve a consistent styling.

## Changes in the Configurator Product Title Component

- The `width` is set to `80%` in the `%cx-configurator-product-title` to use only 80% of the configuration product title width.
- There is now a `button` instead of an anchor link in the `%cx-configurator-product-title`.
- The `padding` is set to `16px/ 32px` in the `%cx-configurator-product-title` for the `cx-details` selector to align spacing depending on the screen size.
- The `cx-configurator-image` mixin has been defined in the `%cx-configurator-product-title` for the `cx-details-image` selector to achieve a consistent styling.
- The `cx-configurator-truncate-content` mixin has been added to the `%cx-configurator-product-title` for the `cx-detail-title`, `cx-code` and `cx-description` selectors to enable the truncation for the small widgets.

## Changes in the Configurator Group Menu Component

- The `cx-group-menu` class replaces the `ul` element in the `%cx-configurator-group-menu`.
- The `cx-configurator-truncate-content` mixin has been added to the `%cx-configurator-group-menu` for the `span` selector to enable the configuration group title truncation for the small widgets.

## Changes in the Configurator Form Component

- The `width` is set to `100%` in the `%cx-configurator-form` to use the whole width of the configuration form.
- The `padding` is set to `16px` in the `%cx-configurator-form` for the `cx-group-attribute` to align the spacing between the configuration group attributes.

## Changes in the Configurator Attribute Header Component

- The `margin` is set to `17px` in the `%cx-configurator-attribute-header` to align the spacing to the attribute header to the attribute type.
- The `padding` is set to `0px` and the `margin` to `17px` in the `%cx-configurator-attribute-type` to align the spacing between the configuration attribute types.

## Changes in the Configurator Attribute Drop-Down Component

- The `flex-direction` is set to `column` in the `%cx-configurator-attribute-drop-down`.
- The `cx-configurator-attribute-level-quantity-price` mixin has been defined in the `%cx-configurator-attribute-drop-down` for the `.cx-attribute-level-quantity-price` class to achieve a consistent styling.
- The `margin-block-start` is set to `32px` in the `%cx-configurator-attribute-drop-down` for the `.cx-value-price` class to align the spacing for mobile widget.
- The `margin-block-start` is set to `32px` in the `%cx-configurator-attribute-drop-down` for the `.cx-attribute-level-quantity-price` class to align the spacing.

## Changes in the Configurator Attribute Checkbox List Component

- The `padding` is set to `1rem` in the `%cx-configurator-attribute-checkbox-list` to define the spacing between the checkbox-list attribute type and the quantity counter.
- The `cx-configurator-attribute-level-quantity-price` mixin has been defined in the `%cx-configurator-attribute-checkbox-list` for the `cx-attribute-level-quantity-price` selector to achieve a consistent styling.
- The `cx-configurator-attribute-visible-focus` mixin has been defined in the `%cx-configurator-attribute-checkbox-list` to enable visual focus.

## Changes in the Configurator Attribute Radio Button Component

- The `padding` is set to `1rem` in the `%cx-configurator-attribute-radio-button` to define the spacing between the radio-button attribute type and the quantity counter.
- The `cx-configurator-attribute-level-quantity-price` mixin has been defined in the `%cx-configurator-attribute-radio-button` for the `.cx-attribute-level-quantity-price` class to achieve a consistent styling.
- The `cx-configurator-attribute-visible-focus` mixin has been defined in the `%cx-configurator-attribute-radio-button` to enable visual focus.

## Change in the Configurator Previous Next Button Component

- The `padding` is set to `16px` in the `%cx-configurator-previous-next-buttons` to align the spacing between the configuration form and the bottom of the configuration.

## Change in the Configurator Price Summary Component

- The `padding` is set to `16px` in the `%cx-configurator-price-summary` for the `cx-total-summary` selector to align the spacing.

## Change in the Configurator Footer Container Mixin

- The `padding` is set to `16px` in the `%cx-configurator-footer-container` mixin to align the spacing between the price summary and add-to-cart button.

## Change in the Configurator Required Error Message Mixin

- The `padding` is set to `5px` in the `%cx-configurator-required-error-msg` mixin to add spacing at the end of the `cx-icon` selector.

## Change in the Configurator Attribute Single-Selection Bundle Component

- The `cx-configurator-attribute-level-quantity-price` mixin has been replaced in the `%cx-configurator-attribute-single-selection-bundle` to `cx-configurator-bundle-attribute-level-quantity-price`.

## Change in the Configurator Attribute Multi-Selection Bundle Component

- The `cx-configurator-attribute-level-quantity-price` mixin has been replaced in the `%cx-configurator-attribute-multi-selection-bundle` to `cx-configurator-bundle-attribute-level-quantity-price`.

## Changes in the Configurator Attribute Type Mixin

- The `width` is set to `100%` in the `%cx-configurator-attribute-type` for the `fieldset` selector to use 100% of the width.
- The `display` is set to `flex` in the `%cx-configurator-attribute-type` for the `form-check` selector.
- The `flex-direction` is set to `row` in the `%cx-configurator-attribute-type` for the `form-check` selector.
- The `justify-content` is set to `space-between` in the `%cx-configurator-attribute-type` for the `form-check` selector.
- The `width` is set to `80%` in the `%cx-configurator-attribute-type` for the `cx-value-label-pair` selector to use only 80% of the width.
- The `padding-inline-end` is set to `10px` in the `%cx-configurator-attribute-type` for the `cx-value-label-pair` selector.
- The `line-break` has been set to `anywhere` in the `%cx-configurator-attribute-type` for the `cx-value-label-pair` selector to enable a line break if the value pair label gets longer.
- The `width` is set to `20%` in the `%cx-configurator-attribute-type` for the `cx-value-price` selector to use only 20% of the width.

## Changes in Configurator Form Group Mixin

- The `width` is set to `100%` in the `%cx-configurator-form-group` for the `form-group` selector to use 100% of the width.
- The `display` is set to `flex` in the `%cx-configurator-form-group` for the `form-group` selector.
- The `flex-direction` is set to `row` in the `%cx-configurator-form-group` for the `form-group` selector.
- The `align-items` is set to `center` in the `%cx-configurator-form-group` for the `form-group` selector.
- The `justify-content` is set to `space-between` in the `%cx-configurator-form-group` for the `form-group` selector.
- The `width` is set to `80%` in the `%cx-configurator-form-group` for the `select` selector to use only 80% of the width.
- The `width` is set to `20%` in the `%cx-configurator-form-group` for the `cx-value-price` selector to use only 20% of the width.

## Changes in the Configurator Attribute Level Quantity Price Mixin

- The `margin-block-start` has been removed from `%cx-configurator-attribute-level-quantity-price`.
- The `margin-block-end` has been removed from `%cx-configurator-attribute-level-quantity-price`.
- The `margin-inline-start` has been removed from `%cx-configurator-attribute-level-quantity-price`.
- The `margin-inline-end` has been removed from `%cx-configurator-attribute-level-quantity-price`.

## Changes in the Configurator Overview Form Component

- The `padding` is set to `0px` in the `%cx-configurator-overview-form` to fix inconsistent spacings in the configuration overview form.
- The `padding` is set to `20px` and the `margin` to `0px` in the `%cx-configurator-overview-form` for the `cx-group` selector to align spacing between the configuration overview groups.
- The `padding` is set to `32px/16px` in the `%cx-configurator-overview-form` for the `h2` selector to align spacing around the configuration overview group titles.
- The `cx-configurator-truncate-content` mixin has been added to the `%cx-configurator-overview-form` for the `span` selector to enable the overview group title truncation for the small widgets.
- The `padding` is set to `32px` in the `%cx-configurator-overview-form` for the `cx-attribute-value-pair` selector to align spacing between the configuration overview attribute value pairs.
- The `display` is set to `none / inline` and `visibility` to `hidden` in the `%cx-configurator-overview-form` for the `cx-attribute-value-pair` selector to define the visibility for the configuration overview attribute value label.
- The `padding` is set to `20px` in the `%cx-configurator-overview-form` for the `cx-no-attribute-value-pairs` selector to align spacing between the configuration overview form and the container which is shown when there are no results, including a link for removing filter(s).
- The `font-size` is set to `1.25rem` in the `%cx-configurator-overview-form` for the `topLevel` selector to adjust the attribute header according to the new styling requirement.
- The `font-weight` is set to `700` in the `%cx-configurator-overview-form` for the `topLevel` selector to adjust the attribute header according to the new styling requirement.
- The `border-bottom` is set to `solid 1px var(--cx-color-light)` in the `%cx-configurator-overview-form` for the `topLevel` selector to create the bottom border of the attribute header.
- The `border-top` is set to `solid 1px var(--cx-color-light)` in the `%cx-configurator-overview-form` for the `topLevel` selector to create the top border of the attribute header.
- The `border-left-style` is set to `none` in the `%cx-configurator-overview-form` for the `topLevel` selector to achieve a top-bottom border.
- The `border-right-style` is set to `none` in the `%cx-configurator-overview-form` for the `topLevel` selector to achieve a top-bottom border.
- The `background` set to `none` in the `%cx-configurator-overview-form` for the `topLevel` to make the header background transparent.
- The `text-transform` is set to `none` in the `%cx-configurator-overview-form` for the `topLevel` to prevent the header form transforming to uppercase.
- The `margin-bottom` is set to `-60px` in the `%cx-configurator-overview-form` for the `subgroupTopLevel` to eliminate the space between the top-level attribute header and its subgroups.
- The `background-color` is set to `var(--cx-color-background)` in the `%cx-configurator-overview-form` for the `cx-group h2` to set the background color of the subgroup headers.
- The `font-size` is set to `1rem` in the `%cx-configurator-overview-form` for the `cx-group h2` to specify the font size of the subgroup headers.
- The `text-transform` is set to `uppercase` in the `%cx-configurator-overview-form` for the `cx-group h2` to transform the subgroup header into uppercase.

## Changes in the Configurator Overview Attribute Component

- The `justify-content` is set to `space-between` in the `%cx-configurator-overview-attribute`.
- The `width` is set to `50%` in the `%cx-configurator-overview-attribute` for the `cx-attribute-value` selector to use only `50%` of the width for the small widgets.
- The `font-weight` is set to `600` in the `%cx-configurator-overview-attribute` for the `cx-attribute-value` selector to make the attribute values bold.
- The `line-break` has been set to `anywhere` in the `%cx-configurator-overview-attribute` for the `cx-attribute-value` selector to enable line break if the attribute value label gets longer.
- The `padding-inline-end` is set to `10px` in the `%cx-configurator-overview-attribute` for the `cx-attribute-value` selector to align spacing between the `cx-attribute-value` selector and the next element.
- The `width` is set to `100%` in the `%cx-configurator-overview-attribute` for the `cx-attribute-label` selector to use 100% of the width for the small widgets.
- The `padding-inline-end` is set to `10px` in the `%cx-configurator-overview-attribute` for the `cx-attribute-label` selector to align spacing between the `cx-attribute-label` selector and the next element.
- The `line-break` has been set to `anywhere` in the `%cx-configurator-overview-attribute` for the `cx-attribute-label` selector to enable a line break if the attribute value label gets longer.
- The `width` is set to `50%` in the `%cx-configurator-overview-attribute` for the `cx-attribute-price` selector to use only 50% of the width for the small widgets.

## Changes in the Product Configurator Card Component

- The `.cx-card-title` class was added (a11y).
- The `.deselection-error-message` class was added.
- The `display` is set to `inline-block` in the `%cx-configurator-attribute-product-card` for the `&.deselection-error-message` to prevent a line break in the deselection error message.
- The `width` is set to `80%` in the `%cx-configurator-attribute-product-card` for the `&.deselection-error-message` to set the element's box size and prevent a line break.
- The `flex-wrap` is set to `wrap` in the `%cx-configurator-attribute-product-card` for the `.cx-product-card-selected` to align the deselection error to the desired position.
- The `padding-top` is set to `5px` in the `%cx-configurator-attribute-product-card` for the `.deselection-error-message` to create space between the value description and the error message.
- The `color` is set to `var(--cx-color-danger)` in the `%cx-configurator-attribute-product-card` for the `.deselection-error-message` to signal the message as an error message.
- The `padding-right` is set to `5px` in the `%cx-configurator-attribute-product-card` for the `.deselection-error-message-symbol` to create space between the message and the 'error' icon.

## Change in the Cart Item Component

- An `h2` was added under `.cx-name` to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Order Summary Component

- The `h4` was changed to `h3` to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Review Submit Component

- A `type(3)` was added to the `.cx-review-title` class to retain the previous style after changes in the markup template.

## Change in index.scss

- A new `cx-page-header` component was added to the allow list (a11y).
- `_screen-reader.scss` was added, which will contain screen reader specific styles (a11y).

## Changes in the Category Navigation Component

- The `h5` was changed to `span` to account for the change in the markup template for improved screen reader support (a11y).
- The `nav.is-open > h5` was changed to `li.is-open > span` to remove headings from the category navigation for improved categorization in the screen reader elements dialog (a11y).

## Change in the Footer Navigation Component

- The `h5` was changed to `span` under `.flyout`, `@include media-breakpoint-down(md)`, `nav` and `nav >` to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Carousel Component

- The `h3` was changed to an `h2` to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Product Carousel Component

- The `h4` was changed to an `h3` to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Product List Item Component

- An `h2` was added to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Wish List Item Component

- An `h2` added to account for the change in the markup template for improved screen reader support (a11y).

## Change in the Checkout Media Style Component

- `type(3)` and `font-weight` were added to retain the existing styling after a change in the markup template for improved screen reader support (a11y).

## Change in _screen-reader.scss

- The `.cx-visually-hidden` class was added. This class can be used to hide elements specific to screen reader announcement and narration (a11y).

## Change in _list.scss

- `.cx-table td .text` and `.cx-table td a` padding-inline-start removed to align the `cx-org` table items with head labels.

## Change in buttons.scss`

- `text-transform: var(--cx-button-text-transform)` is changed to `text-transform: var(--cx-text-transform)` to accommodate for theme changes.

## Changes in _searchbox.scss

- `cx-icon.reset` was changed to `button.reset`
- `.dirty cx-icon.search` was changed to `.dirty div.search`
- `:not(.dirty) cx-icon.reset` was changed to `:not(.dirty) button.reset`
- `cx-icon` was changed to `button, div.search`
- `cursor: pointer` was removed.
- `.reset` was changed to `.reset cx-icon`
- `h4.name` was changed to `div.name`

## Change in _payment-form.scss

- `legend` was added with `font-size: 1rem` in `.cx-payment-form-exp-date`

## Change in _list.scss

- `.sort` has been wrapped in a `label` in `.header.actions`. A `min-width: 170px;` was added for `.sort` and a few other stylings for `label`.

## Change in _my-coupons.scss

- Styling was added for `.cx-my-coupons-form-group`: `align-items: center;  display: flex;` and a few other stylings for `span` and `cx-sorting`.

## Change in _my-interests.scss

- Styling was added for `.cx-product-interests-form-group`: `align-items: center;  display: flex;` and a few other stylings for `span` and `cx-sorting`.

## Change in _order-history.scss and _order-return-request-list.scss

- Styling added for `cx-order-history-form-group`: `align-items: center;  display: flex;` and a few other stylings for `span` and `cx-sorting`.

## Change in _replenishment-order-history.scss

- Styling added for `.cx-replenishment-order-history-form-group`: `align-items: center;  display: flex;` and a few other stylings for `span` and `cx-sorting`.

## Change in _product-list.scss

- Styling added for `.cx-sort-dropdown`: `align-items: center;  display: flex;` and a few other stylings for `span` and `cx-sorting`.
- `text-transform: var(--cx-button-text-transform)` was changed to `text-transform: var(--cx-text-transform)` to accommodate for theme changes.

## Change in _popover.scss

- `popover-body > .close` has been moved to `popover-body > .cx-close-row > .close`.

## Changes in _navigation-ui_.scss

- `popover-body > .close` has been moved to `popover-body > .cx-close-row > .close`.
- `padding-bottom: 25px` was changed to `padding-bottom: 22px` to accommodate for the header navigation links line-heights.

## Change in _versioning.scss

- For the 4.0 release, themes for versioning of minor releases was changed from `$_fullVersion: 3.3;` and `$_majorVersion: 3;` to `$_fullVersion: 4;` and `$_majorVersion: 4;`, respectively.
