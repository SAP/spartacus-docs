---
title: Changes to Styles in Spartacus 6.0
---

The following styling changes were in made in Spartacus 6.0.

## Changes to Styles in the ASM Feature Library

### AsmMainUiComponent

- Added `background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill='black' d='M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z'/%3E%3C/svg%3E");` property to `.close`.
- Added `background-image: url("[...IMAGE_URI...]");` property to `.logout`.
- Added `color: inherit; background-color: #ffffff; box-shadow: 2px 2px rgba(85, 107, 130, 0.1), inset 0px -1px 0px rgba(85, 107, 130, 0.2);` property to `.asm-bar`.
- `.spinner` styling removed from `%cx-asm-main-ui`.

### CustomerSelectionComponent

- `.spinner` styling removed from `%cx-customer-selection`.
- `cx-dot-spinner` styling added in `.asm-results`.
- Added `.input-contaier { display: flex; .icon-wrapper { display: flex; outline: 0; border: 1px solid #89919a; color: #ffffff; background-color: #1672b7; padding: 0 12px; height: 36px; border-top-left-radius: 4px; border-bottom-left-radius: 4px; border-right-width: 0px; cursor: pointer; } input { border: none; border-radius: 4px; background-color: #eff1f2; box-shadow: 0px 4px 4px rgb(0 0 0 / 25%); } } .searchTermLabel { display: flex; align-items: center; color: #556b82; min-width: auto; margin: 0 15px 0 0; }` property to `label`.
- Changed `@media (min-width: 575px)` property from `{ margin-inline-end: 15px; min-width: 20rem; }` to `{ margin-inline-end: 15px; min-width: 20rem; margin-bottom: 0; min-width: 25rem; }` in `label`
- Added `button[type='submit']` selector.
- Added `background-color: #ebf5cb; opacity: 0.4; border: 1px solid #ebf5cb; border-radius: 8px; color: #256f3a; font-weight: 700; transition: opacity 0.3s; &.active { opacity: 1; }` to `button[type='submit]'` property.

### CSAgentLoginFormComponent

`cx-dot-spinner` styling added in `%cx-csagent-login-form`.

### AsmSessionTimerComponent

Added `background: url("[...IMAGE_URI...]") no-repeat center center;` property to `.reset`.

### AsmToggleUiComponent

- Added `color: #d50101;` property to `.label`.
- Added `background: url("[...IMAGE_URI...]") center center no-repeat;` property to `.collapseIcon`.
- Added `background: url("[...IMAGE_URI...]") center center no-repeat;` property to `.expandIcon`.

### CustomerEmulationComponent

- Added `justify-content: flex-start; align-items: baseline; @media (max-width: 940px) { flex-direction: column; > * { margin-bottom: 12px; } }` property to `%cx-customer-emulation`.
- Added `button` selector.
- Added `color: #aa0808; font-weight: 700; background-color: #ffd6ea; border: 1px solid #ffd6ea; border-radius: 8px; padding: 6px 10px; @media (max-width: 940px) { width: 100%; }` property to `button`.
- Added `label` selector.
- Added `margin-inline-end: 10px; margin-inline-start: 0; margin-top: 0; margin-bottom: 0; color: #556b82;` property to `label`.
- Added `.cx-asm-customerInfo` selector.
- Added `display: flex; flex-direction: column; margin-inline-end: 15px;  .cx-asm-name { color: #1d2d3e; } .cx-asm-uid { color: #556b82; }` property to `.cx-asm-customerInfo`.

## Changes to Styles in the Product Configurator Feature Library

### ConfiguratorAddToCartButtonComponent

Added `z-index: 10;` to `%cx-configurator-add-to-cart-button`.

### ConfiguratorAttributeHeaderComponent

- Set `margin-block-end` to `0px` instead of `17px`.
- Added `.cx-action-link { font-size: 14px; min-height: 0px;} `to `.cx-conflict-msg `.
- Added `padding-block-end: 5px; padding-block-start: 5px; display: block;` to `img`.

### ConfiguratorAttributeReadOnlyComponent

`%cx-configurator-attribute-read-only` now only contains `@include cx-configurator-attribute-type();`. This mixin already has all the required styling settings.

### ConfigureCartEntryComponent

The styling file was obsolete and has been removed because `link cx-action-link` classes are used.

### ConfiguratorConflictSolverDialogComponent

`z-index: 2000` has been added to `%cx-configurator-conflict-solver-dialog` to control which dialog is rendered on top if multiple dialogs are open. The new `ConfiguratorRestartDialogComponent` uses `z-index: 3000`.

### ConfiguratorConflictSuggestionComponent

- `margin-inline-start` changed to `-15px` instead of `-20px`.
- `margin-inline-end` changed to `-15px` instead of `-20px`.
- Added `padding-inline-start: 0px;` to `.cx-title`.

### ConfiguratorExitButtonComponent

- Styling file was obsolete and has been removed.
- Added `btn btn-tertiary` classes to `button`.

### ConfiguratorGroupTitleComponent

- `margin-block-end` changed to `-15px` instead of `-20px`.
- `cx-hamburger-menu` styling added to `.cx-group-title`.

### ConfiguratorGroupMenuComponent

- Added `@include media-breakpoint-down(md) {background-color: var(--cx-color-background)}` to `.cx-group-menu`.
- Added `@include media-breakpoint-down(md) {font-weight: var(--cx-font-weight-semi); border-bottom: 1px solid var(--cx-color-light); background-color: var(--cx-color-medium);}` to `.cx-menu-back`.
- Added `@include media-breakpoint-down(md) {text-transform: uppercase; font-weight: var(--cx-font-weight-semi);}` to `.cx-menu-item`.
- Added `@include media-breakpoint-down(md) {border-bottom: 1px solid var(--cx-color-medium);}` to `button:not(.cx-menu-conflict)`.

### ConfiguratorIssuesNotificationComponent

Added `font-weight: var(--cx-font-weight-semi)` property.

### ConfiguratorOverviewAttributeComponent

- `line-break` changed to `normal` instead of `anywhere`.
- `z-index: -6;` added to `.cx-attribute-value`, `.cx-attribute-label` and `.cx-attribute-price`.

### ConfiguratorOverviewFilterDialogComponent

`z-index: 1000` added to `%cx-configurator-overview-filter-dialog` to control which dialog is rendered on top if multiple dialogs are open.

### ConfiguratorOverviewFilterButtonComponent

`btn btn-secondary` classes are added to `button`.

### ConfiguratorOverviewFormComponent

- `padding-inline-start: 0px;` removed from `%cx-configurator-overview-form`.
- `padding-inline-end: 0px;` removed from `%cx-configurator-overview-form`.
- `padding-inline-start: 0px;` removed from `.cx-group`.
- `padding-inline-end: 0px;` removed from `.cx-group`.
- `$subgroupLevel2Top: 60px; $subgroupLevel3Top: 112px; $subgroupLevel4Top: 164px; $subgroupLevel5Top: 216px;` added to `%cx-configurator-overview-form`.
- `padding-inline-start: 32px;padding-inline-end: 32px;padding-block-start: 16px;padding-block-end: 16px;`added to `&.topLevel { h2`.
- `background-color: var(--cx-color-inverse);`added to `&.topLevel { h2`.
- `margin-bottom` changed to `-20px` instead of `-60px` in `&.subgroupTopLevel`.
- `&.subgroup` styling added in `.cx-group`.
- Styling added for subgroups on `sm` resolutions.

### ConfiguratorOverviewMenuComponent

`ul` wraps the content of `cx-configurator-overview-menu`.

### ConfiguratorOverviewNotificationBannerComponent

Removed obsolete styling for `button.link` except `font-size: inherit`.

### ConfiguratorPreviousNextButtonsComponent

- Removed `.btn-action` from line 21 and 30.
- Removed `.cx-btn` from line 4 and 12
- Added `.btn-block` to line 4 and 12
- Removed styling for disabled `.btn-secondary`

### ConfiguratorProductTitleComponent

Added `box-shadow: inset 0px 10px 7px -12px var(--cx-color-dark)` property to the `.cx-general-product-info` class.

### ConfiguratorVariantOverviewPage

Handles a new `VariantConfigOverviewNavigation` slot. Previously it only had one slot, so no specific styling was required besides the page template `cx-configurator-template`.

Now, however, it needs to define the relative and absolute sizes of the two slots involved. The new `VariantConfigOverviewNavigation` slot gets `30%`, and the `VariantConfigOverviewContent` slot gets `70%` of the available space.

## Font Awesome Icons

The Font Awesome CSS library, which is used for icons, is not downloaded at runtime anymore.  The default icon configuration is still based on the same Font Awesome icons. However, the Font Awesome CSS is now bundled with the Spartacus styles. This change is done to comply with security best practices.

## Fonts Library

CSS fonts were downloaded at runtime from third-party servers using Google Fonts. It is now replaced by the Fontsource library, a self-hosted solution. The CSS fonts asset is now bundled with the Spartacus styles. This change is done to comply with security best practices.

## Changes to Styles in Miscellaneous Components

### ActiveFacetsComponent

- Replaced `h4` style class with `h2` style class.
- Removed styling for `h4` tag.

### AddToCartComponent

- Changed line 25 to `color: var(--cx-color-primary);`.
- Changed line 26 to `text-decoration-color: var(--cx-color-primary);`.
- Changed line 30 to `color: var(--cx-color-primary);`.

### AddedToCartDialogComponent

- Added `.cx-modal-content {height: 100%;}` on line 4.
- Added `.cx-dialog-pickup-store {padding-inline-start: 4.063rem;}`.
- Added `.cx-dialog-pickup-store-name {font-weight: var(--cx-font-weight-semi);}`.

### AddToSavedCartComponent

Added `a.disabled {color: gray; cursor: not-allowed; text-decoration: underline;}` on line 28.

### AnonymousConsentManagementBannerComponent

Added `button {margin-bottom: 10px;}` on line 29.

### BreadcrumbComponent

Added `box-shadow: inset 0px 10px 7px -12px var(--cx-color-dark); @include media-breakpoint-up(lg) {box-shadow: none;}`.

### CartItemListRowComponent

Replaced `text-align: end; width: 100%;` on line 21 and 22 to `margin-inline-start: auto;`.

### CustomerTicketingCreateComponent

Added line 23-26 `width: 100%; .cx-customer-ticketing-create { width: 100%;}`.

### CustomerTicketingListComponent

- Added line 134 `@include media-breakpoint-down(sm) {flex-wrap: wrap;}`.
- Added line 152 `@include media-breakpoint-down(sm) {width: 100% ; margin-bottom: 17px;}`.

### FooterNavigationComponent

Added `background-color: var(--cx-color-background-dark);` on line 2.

### MiniCartComponent

- Replaced line 12 `min-width: 70px;` with `min-width: 90px;`.
- Removed line 21 `color: currentColor;`.

### NavigationUIComponent

- Line 27 replaced hex color with color variable `color: var(--cx-color-text);`.
- Line 37 replaced hex color with color variable `color: var(--cx-color-inverse);`.
- Line 258 - 261 added `@include media-breakpoint-up(lg) {background-color: var(--cx-color-text);}`.
- Added `&.accNavComponent { background-color: transparent;}` on line 383.
- Removed line 54 `border-bottom: 1px solid var(--cx-color-light);`.
- Changed `border-bottom: 1px solid var(--cx-color-light);` on line 131 to `border-bottom: 1px solid var(--cx-color-medium);`.

### OrderDetailActionsComponent

Changed class `.btn-action` to `.btn-secondary` and `@include media-breakpoint-down(sm)` to `@include media-breakpoint-down(md)`.

### OrderDetailsItemsComponent

Removed `margin-top: 30px` from `%cx-order-details-items`.

### OrderDetailsShippingComponent

Renamed `%cx-order-details-shipping` to `%cx-order-overview`.

### OrderHistoryComponent

- `.cx-order-history-code` added `color: var(--cx-color-primary);`.
- Added `color: var(--cx-color-primary);` on line 82.

### OrderOverviewComponent

Modified and added elements to follow the redesign of order overview.

### PaymentMethodsComponent

- Removed styling for class `.cx-checkout-title`.
- Changed class `.btn-action` to `.btn-secondary` and `@include media-breakpoint-down(sm)` to `@include media-breakpoint-down(md)`.

### PickupOptionDialogComponent

- Added line 5 `align-items: normal;`.
- Added line 9-10 `@include media-breakpoint-down(md) {height: 100%;}`.
- Added line 14-17 `@include media-breakpoint-down(md) {height: 100%;}`.

### QuickOrderComponent

Added `input {height: 47px;}` to fix the input height on focus.

### QuickOrderFormComponent

- Added `input { height: 47px;}` to line 16.
- Changed line 20 from `color: var(--cx-color-light);` to `color: var(--cx-color-medium);`.

### ReplenishmentOrderCancellationDialogComponent

Changed line 6 `.btn-action` to `.btn-secondary`.

### ReplenishmentOrderHistoryComponent

- removed `text-decoration: underline; text-transform: uppercase; color: var(--cx-color-primary);padding-inline-start: 0;  color: var(--cx-color-text);` from `.cx-order-cancel`.
- removed `tfm 5.1 wrapper ` on line 87. It was giving the wrong color.
- removed `tfm 5.1 wrapper ` on `.cx-order-cancel`.
- Removed from line 88 `@include forVersion(5.1) {color: var(--cx-color-text);}`.

### ReturnRequestOverviewComponent

Changed `.btn-action` to `.btn-secondary` on line 10.

### SavedCartListComponent

Removed line 129 to 135 `.cx-saved-cart-list-make-cart-active {.cx-saved-cart-make-active {text-decoration: underline;text-transform: capitalize;}}`.

### ScrollToTopComponent

Changed line 21 to `background-color: var(--cx-color-primary);` and added `border-radius: 12px`.

### StoreComponent

Removed line 61 `width: 92%;` and 62 `margin: auto;`.

### TabParagraphContainerComponent

- Changed line 24 to `color: var(--cx-color-secondary);`.
- Changed line 89 `color: var(--cx-color-primary-accent);`.
- Changed line 109 to `height: 3px;` from `height: 5px;`.
- Changed line 110 to `color: var(--cx-color-primary-accent);`.

### UnitLevelOrderHistoryComponent

- Added  `(--cx-color-primary)` to `.cx-unit-level-order-history-code .cx-unit-level-order-history-value`.
- Added line 146 `color: var(--cx-color-primary);`.

## Changes in SCSS Files

### buttons.scss

- Added `.btn-tertiary` styling for new button class on line 158.
- Added `color: var(--cx-color-border-focus);` to line 188.
- Changed line 66 disabled button colors on `btn-primary`.
- Changed line 69 `border-color: var(--cx-color-primary);` to `{border-color: var(--cx-color-border-focus);}`.
- Changed line 78 `background-color: var(--cx-color-primary);border-color: var(--cx-color-primary);` to `background-color: var(--cx-color-primary-accent);border-color: var(--cx-color-primary-accent);`.
- Changed `background-color` to `var(--cx-color-border-focus)`.
- Changed `border-color: var(--cx-color-border-focus);` to `border: var(--cx-color-border-focus)`.
- Removed line 70 `@include cx-darken(100);`.
- Changed line 113 disabled button colors on `btn-secondary` as follows:
  - `background-color` to `var(--cx-color-inverse)`
  - `border-color: var(--cx-color-primary-accent);` to `border-color: var(--cx-color-border-focus);`
  - `color: var(--cx-color-primary-accent);` to `color: var(--cx-color-border-focus);`
  - And added `&:hover {border-color: var(--cx-color-border-focus);}`.
- Changed line 161 `.btn-tertiary &hover` from `background-color: var(--cx-color-inverse);` to `background-color: var(--cx-color-transparent);`.
- Changed lined 173 to `background-color: var(--cx-color-transparent);` from `background-color: var(--cx-color-inverse);`.
- Changed line 180 to `background-color: var(--cx-color-transparent);` from `background-color: var(--cx-color-inverse);`.

### checkout-media-style.scss

Changed `.btn-action` class to `.btn-secondary` and `@include media-breakpoint-down(sm)` to `@include media-breakpoint-down(md)`.

### company-page-template.scss

Changed line 18 from `--cx-img-filter: invert(71%) sepia(50%) saturate(7474%) hue-rotate(329deg)brightness(110%) contrast(99%);` to `--cx-img-filter: invert(34%) sepia(61%) saturate(1353%) hue-rotate(178deg)brightness(90%) contrast(90%);`.

### Header.scss

- Changed line 4 to `background-color: var(--cx-color-light);`.
- Added `@include media-breakpoint-up(lg) {background: linear-gradient(to top,var(--cx-color-background-dark) $header-height,va(--cx-color-light) 0);` to line 7.
- Added  line 31 `.SiteLinks {font-weight: var(--cx-font-weight-semi);`.
- Changed `background-color: var(--cx-color-dark);` to `background-color: var(--cx-background-dark);` on line 56.
- Changed line 71 to `color: var(--cx-color-medium);`.
- Added line 162 `background-color: var(--cx-color-primary);`.
- Added `color: var(--cx-color-primary);` to line 188.
- Added `.cx-hamburger` and `.hamburger-inner` styling.
- Added `height: 100vh; background-color: var(--cx-color-background);` to line 43.

### _link.scss

Added `text-decoration: underline;` to link 8.

### _login.scss

- Added `color: var(--cx-color-text);` to line 2.
- Changed `color: var(--cx-color-inverse);` to `color: var(--cx-color-text);`.

### _theme.scss

Added `@import 'theme/santorini/variables';` and commented out `@import 'theme/sparta/variables';`. This makes Santorini theme the main theme.

## Other Changes in Styles

### AgnosticTable

Replaced `border-bottom: 1px solid var(--cx-color-light)` with `border-top: 1px solid var(--cx-color-light)` in the `tr` style class.

### Forms styling

`border-color: var(--cx-color-medium);` changed to `border-color: var(--cx-color-medium);`.

### OrderConfirmationThankYouMessage

Replaced `font-weight: $font-weight-normal` with `font-weight: var(--cx-font-weight-bold)` and `font-size: var(--cx-font-size, 1.5rem);` in the `h2` style class.

### ReplenishmentOrderHistoryService

Replaced .cx-order-cancel `{text-decoration: underline;text-transform: uppercase;color: var(--cx-color-primary);padding-inline-start: 0;@include forVersion(5.1) {@include type('7');text-transform: var(--cx-button-text-transform);color: var(--cx-color-text); }` with `font-size: var(--cx-font-size, 0.875rem);`
