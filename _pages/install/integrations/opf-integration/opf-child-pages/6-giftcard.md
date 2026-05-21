---
title: Gift Card
---

The open payment framework (OPF) gift card feature enables customers to use one or more gift cards as a payment method during checkout. Within OPF, gift cards are categorized as a “stored value payment” type.

Customers can apply a gift card by entering the card number and PIN, allowing the gift card balance to be used toward the cart total. If the available balance fully covers the order amount, the order can be completed without adding any other payment method.

**Note:** Gift card payments are currently supported only for B2C stores when OPF is used as the payment provider. In this case, the functionality is available out of the box.

The feature supports the following checkout flows:

1. **Checkout with Gift Card Only**  
   Customers can apply one or more gift cards to reduce the cart total. If the total amount is fully covered by the gift card balance, the order can be completed without selecting any additional payment method.

2. **Checkout with Gift Card and Other Payment Methods**  
   If the applied gift card balance does not fully cover the cart total, an additional payment method is required to complete the purchase.

## Enabling Gift Card in Spartacus

The gift card functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](1-open-payment-framework-in-spartacus.md#enabling-open-payment-framework-in-spartacus).

**Important:** Gift card is **not enabled by default**. During the schematics installation process, you must explicitly select or verify that the feature is enabled in your storefront configuration.

After installation, the gift card feature is available through OPF modules and configuration.

### Gift Card Configuration

`OpfGiftCardRootModule` registers all required providers automatically, including cart and order normalizers and the HTTP interceptor. You do not need to register these providers manually.

**Note:** The OCC endpoint overrides (`defaultOccOpfGiftCardCartEndpointsConfig`, `defaultOccOpfGiftCardOrderEndpointsConfig`) and cart config (`defaultOpfGiftCardCartConfig`) are intentionally **not** provided by `OpfGiftCardRootModule`. They must be registered conditionally in your app module because they are scoped to B2C + OPF storefronts only and should not be applied globally.

## CMS Components

The gift card feature overrides three existing CMS components via `defaultOpfGiftCardComponentsConfig` (no ImpEx needed):

| CMS Component | Spartacus Component | Purpose |
| --- | --- | --- |
| `CheckoutOrderSummary` | `OpfGiftCardCheckoutOrderSummaryComponent` | Displays applied gift cards in checkout |
| `OrderConfirmationTotalsComponent` | `OpfGiftCardOrderConfirmationTotalsComponent` | Displays gift card totals in confirmation |
| `AccountOrderDetailsTotalsComponent` | `OpfGiftCardOrderDetailTotalsComponent` | Displays gift card totals in order details |

### Gift Card Apply Component

The `OpfGiftCardApplyComponent` (`cx-opf-gift-card-apply` selector) is rendered as an outlet in the OPF payment and review step. Use the selector directly if custom placement is required.

## Checkout Flow

Gift card checkout behavior depends on the remaining cart amount:

- **Partial Coverage**: If the gift card balance does not fully cover the cart total, the customer must select an additional payment method for the remaining amount.

- **Full Coverage** (`giftCardsCoverFullAmount === true`): If the cart is fully covered, the external payment provider step is skipped and the order can be placed directly.

### Order Placement

For fully covered orders, the checkout:
- Validates Terms & Conditions acceptance
- Places the order using `placePaymentAuthorizedOrder`
- Redirects to the order confirmation page on success
- Returns to the payment step if an error occurs

### Payment Failure Handling

If payment authorization fails, the cart is automatically reloaded. Any applied gift cards removed by the backend are immediately reflected in the updated cart.

### OpfPaymentEventsService Integration

The gift card feature communicates coverage state to the OPF checkout via `OpfPaymentEventsService` from `@spartacus/opf/payment/root`:

| Method | Description |
| --- | --- |
| `emitIsGiftCardCoveredTotalAmountEvent(isCovered: boolean)` | Notifies the OPF checkout whether gift cards fully cover the cart total. When `true`, other payment options are hidden. |
| `isGiftCardCoveredTotalAmountEvent$` | Observable the OPF checkout subscribes to for toggling the payment UI. |

The gift card feature emits this event reactively whenever `opfGiftCardSummary.giftCardsCoverFullAmount` changes on the cart.

## Runtime Behavior

1. **Gift Card Operations**: Apply and remove actions trigger cart reload on success
2. **Add Gift Card Button**: Displayed based on `applyGiftCard` availability in `cart.availableOperations`
3. **Form Auto-Close**: The gift card entry form closes when `selectedPaymentOptionId >= -1` (any payment option, including saved payment details with ID `-1`)  
4. **Full Coverage Flow**: When `giftCardsCoverFullAmount` is `true`, the payment step is skipped and the Place Order button is displayed
5. **Payment Failure Recovery**: HTTP interceptor reloads the cart when `placePaymentAuthorizedOrder` fails (backend removes gift cards on error)

## OCC Endpoints

### Gift Card Operations

The following endpoints are used for gift card operations:

```ts
applyGiftCard: 'users/${userId}/carts/${cartId}/giftCards'    // POST
removeGiftCard: 'users/${userId}/carts/${cartId}/giftCards/${giftCardId}'  // DELETE
```

**Apply Request Body:** `{ number: string, securityCode: string }`

### Extended Cart Fields

The `carts` and `cart` endpoints request additional fields:
- `sapGiftCards` — list of applied gift cards with balance details
- `sapGiftCardSummary` — aggregate totals (total applied, remaining, balance)
- `_availableOperations` — operation availability flags (used for "Add Gift Card" button visibility)

### Extended Order Fields

The `orderDetail` and `placePaymentAuthorizedOrder` endpoints include:
- `sapGiftCardSummary` — gift card totals for placed orders

## Data Normalization

`OpfGiftCardRootModule` registers normalizers that map backend fields to Spartacus models:

| Normalizer | Mapping |
| --- | --- |
| `OpfGiftCardCartOccNormalizer` | `sapGiftCards` → `opfGiftCards`<br/>`sapGiftCardSummary` → `opfGiftCardSummary`<br/>`_availableOperations` → `availableOperations` |
| `OpfGiftCardOrderOccNormalizer` | `sapGiftCardSummary` → `opfGiftCardSummary` |

The models are augmented via TypeScript declaration merging, making fields available throughout the storefront:
- `cart.opfGiftCards`, `cart.opfGiftCardSummary`, `cart.availableOperations`
- `order.opfGiftCardSummary`

## Applying and Removing Gift Cards

### Applying Gift Card

The `OpfGiftCardApplyComponent` provides a form with the following fields:

| Field | Validation |
| --- | --- |
| Card Number | Required, 8-64 characters |
| PIN | Required, 3-28 characters |

Enter the card number and PIN, then click **Apply**. If the gift card is valid, it is applied to the cart, a success message is displayed, and the cart total is updated to reflect the applied gift card balance.

### Removing Gift Cards

The `OpfGiftCardAppliedComponent` lists applied cards with remove buttons. Removing a card calls `OpfGiftCardFacade.removeGiftCard(giftCardId)` and reloads the cart.

## Component Reference

| Component | Selector | Description |
| --- | --- | --- |
| `OpfGiftCardApplyComponent` | `cx-opf-gift-card-apply` | Main entry point. Renders the gift card form toggle, the apply form, the list of applied gift cards, and the Place Order button when the cart is fully covered |
| `OpfGiftCardAppliedComponent` | `cx-opf-gift-card-applied` | Displays a list of applied gift cards with masked numbers, applied amounts, remaining balances, and a Remove button |
| `OpfGiftCardCheckoutPlaceOrderComponent` | `cx-opf-gift-card-checkout-place-order` | Renders the Place Order button only when gift cards fully cover the cart total |
| `OpfGiftCardCheckoutOrderSummaryComponent` | *(nested)* | Displays the order summary with gift card adjustments in checkout |
| `OpfGiftCardOrderSummaryComponent` | `cx-opf-gift-card-order-summary` | Used across checkout, order confirmation, and order details to display the gift card total breakdown |
| `OpfGiftCardOrderConfirmationTotalsComponent` | *(CMS-mapped)* | Replaces `OrderConfirmationTotalsComponent` on the order confirmation page to include gift card summary |
| `OpfGiftCardOrderDetailTotalsComponent` | *(CMS-mapped)* | Replaces `AccountOrderDetailsTotalsComponent` in My Account order details to include gift card totals |
| `OpfGiftCardOrderDetailBillingComponent` | *(nested)* | Renders billing details section with gift card payment method information |
| `OpfGiftCardPaymentMethodDetailComponent` | *(nested)* | Renders the payment method detail section showing gift card as the payment type |
