---
title: Gift Card
---

The OPF Gift Card feature enables customers to use one or more gift cards as a payment method during checkout. Within the Open Payment Framework (OPF), gift cards are categorized as a “stored value payment” type.

Customers can apply a gift card by entering the card number and PIN, allowing the gift card balance to be used toward the cart total. If the available balance fully covers the order amount, the order can be completed without adding any other payment method.

**Note:** Currently, gift card support is available only for B2C stores using OPF.

The feature supports the following checkout flows:

1. **Checkout with Gift Card Only**  
   Customers can apply one or more gift cards to reduce the cart total. If the total amount is fully covered by the gift card balance, the order can be completed without selecting any additional payment provider.

2. **Checkout with Gift Card and Other Payment Options**  
   If the applied gift card balance does not fully cover the cart total, customers can choose an additional payment method to pay the remaining amount.

## Enabling Gift Card in Spartacus

Gift Card functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

**Important:** Gift Card is **not enabled by default** during Spartacus installation. During the schematics installation process, you must explicitly select or verify that the Gift Card feature is enabled in your storefront configuration.

After installation, Gift Card is available through OPF modules and configuration.

### Gift Card Configuration

`OpfGiftCardRootModule` registers all required providers automatically, including cart and order normalizers and the HTTP interceptor. You do not need to register these providers manually.

**Note:** The OCC endpoint overrides (`defaultOccOpfGiftCardCartEndpointsConfig`, `defaultOccOpfGiftCardOrderEndpointsConfig`) and cart config (`defaultOpfGiftCardCartConfig`) are intentionally **not** provided by `OpfGiftCardRootModule`. They must be registered conditionally in your app module because they are scoped to B2C + OPF storefronts only and should not be applied globally.

```ts
if (!environment.b2b && environment.opf) {
  extensionProviders.push(
    provideConfig(defaultOccOpfGiftCardCartEndpointsConfig),
    provideConfig(defaultOccOpfGiftCardOrderEndpointsConfig),
    provideConfig(defaultOpfGiftCardCartConfig)
  );
}
```

### Adding Translations

Add translations to your storefront via `I18nConfig`:

```ts
import {
  opfGiftCardTranslationChunksConfig,
  opfGiftCardTranslationsEn,
} from '@spartacus/opf/gift-card/assets';

provideConfig(<I18nConfig>{
  i18n: {
    resources: { en: opfGiftCardTranslationsEn },
    chunks: opfGiftCardTranslationChunksConfig,
    fallbackLang: 'en',
  },
}),
```

## CMS Components

Gift card feature overrides three existing CMS components via `defaultOpfGiftCardComponentsConfig` (no ImpEx needed):

| CMS Component | Spartacus Component | Purpose |
| --- | --- | --- |
| `CheckoutOrderSummary` | `OpfGiftCardCheckoutOrderSummaryComponent` | Shows applied gift cards in checkout |
| `OrderConfirmationTotalsComponent` | `OpfGiftCardOrderConfirmationTotalsComponent` | Shows gift card totals in confirmation |
| `AccountOrderDetailsTotalsComponent` | `OpfGiftCardOrderDetailTotalsComponent` | Shows gift card totals in order details |

### Gift Card Apply Component

The `OpfGiftCardApplyComponent` (`cx-opf-gift-card-apply` selector) is rendered as an outlet in the OPF payment and review step. Use the selector directly if you need custom placement.

## Checkout Flow

Gift card checkout supports two flows based on the remaining cart amount:

- **Partial Coverage**: If the gift card balance does not fully cover the cart total, the customer must select an additional payment method for the remaining amount.

- **Full Coverage** (`giftCardsCoverFullAmount === true`): If the gift cards fully cover the cart total, the checkout skips the external payment provider step and allows the customer to place the order directly.

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
| `emitIsGiftCardCoveredTotalAmountEvent(isCovered: boolean)` | Notifies the OPF checkout whether gift cards fully cover the cart total. When `true`, the checkout hides the other payment options. |
| `isGiftCardCoveredTotalAmountEvent$` | Observable the OPF checkout subscribes to for toggling the payment UI. |

The gift card feature emits this event reactively whenever `opfGiftCardSummary.giftCardsCoverFullAmount` changes on the cart.

## Runtime Behavior

1. **Gift Card Operations**: Apply/remove calls reload the active cart on success
2. **Add Gift Card Button**: Shown conditionally based on `applyGiftCard` availability in `cart.availableOperations`
3. **Form Auto-Close**: The gift card entry form closes when `selectedPaymentOptionId >= -1` (any payment option, including saved payment details with ID `-1`)  
4. **Full Coverage Flow**: When `giftCardsCoverFullAmount` is `true`, payment step is skipped and Place Order button is shown
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

| Normalizer | Maps |
| --- | --- |
| `OpfGiftCardCartOccNormalizer` | `sapGiftCards` → `opfGiftCards`<br/>`sapGiftCardSummary` → `opfGiftCardSummary`<br/>`_availableOperations` → `availableOperations` |
| `OpfGiftCardOrderOccNormalizer` | `sapGiftCardSummary` → `opfGiftCardSummary` |

The models are augmented via TypeScript declaration merging, making fields available throughout the storefront:
- `cart.opfGiftCards`, `cart.opfGiftCardSummary`, `cart.availableOperations`
- `order.opfGiftCardSummary`

## Data Models

The gift card feature introduces the following models, exported from `@spartacus/opf/gift-card/root`:

### OpfGiftCards

Represents a single applied gift card on the cart:

```ts
interface OpfGiftCards {
  id: string;
  maskedNumber: string;
  balance: Price;
  appliedAmount: Price;
  remainingBalance: Price;
}
```

### OpfGiftCardSummary

Represents the aggregate gift card totals for a cart or order:

```ts
interface OpfGiftCardSummary {
  totalBalance: Price;
  totalAppliedAmount: Price;
  totalRemainingBalance: Price;
  giftCardsCoverFullAmount: boolean;
}
```

The `giftCardsCoverFullAmount` flag is the key signal that drives the full-coverage checkout flow. When `true`, the standard OPF payment step is bypassed.

### OpfGiftCardBalanceRequest

The request body for applying a gift card:

```ts
interface OpfGiftCardBalanceRequest {
  number: string;
  securityCode: string;
}
```

### CartAvailableOperation

Represents a cart-level operation availability entry used to control UI actions such as the **Add Gift Card** button:

```ts
interface CartAvailableOperation {
  key: string;
  value: {
    available?: boolean;
    name?: string;
  };
}
```

## Applying and Removing Gift Cards

### Apply Gift Card

The `OpfGiftCardApplyComponent` provides a form with the following fields:

| Field | Validation |
| --- | --- |
| Card Number | Required, 8-64 characters |
| PIN | Required, 3-28 characters |

Enter the card number and PIN, then click **Apply**. If the gift card is valid, it is applied to the cart, a success message is displayed, and the cart total is updated to reflect the applied gift card balance.

### Removing Gift Cards

The `OpfGiftCardAppliedComponent` lists applied cards with remove buttons. Clicking remove calls `OpfGiftCardFacade.removeGiftCard(giftCardId)` and reloads the cart.

## Component Reference

| Component | Selector | Description |
| --- | --- | --- |
| `OpfGiftCardApplyComponent` | `cx-opf-gift-card-apply` | Main entry point. Renders the gift card form toggle, the apply form, the list of applied gift cards, and the Place Order button when the cart is fully covered |
| `OpfGiftCardAppliedComponent` | `cx-opf-gift-card-applied` | Displays a list of applied gift cards with masked numbers, applied amounts, remaining balances, and a Remove button |
| `OpfGiftCardCheckoutPlaceOrderComponent` | `cx-opf-gift-card-checkout-place-order` | Place Order button rendered only when gift cards fully cover the cart total |
| `OpfGiftCardCheckoutOrderSummaryComponent` | *(nested)* | Renders the order summary with gift card adjustment inside the checkout |
| `OpfGiftCardOrderSummaryComponent` | `cx-opf-gift-card-order-summary` | Shared component used in checkout, order confirmation, and order details to display the gift card total breakdown |
| `OpfGiftCardOrderConfirmationTotalsComponent` | *(CMS-mapped)* | Replaces `OrderConfirmationTotalsComponent` on the order confirmation page to include gift card summary |
| `OpfGiftCardOrderDetailTotalsComponent` | *(CMS-mapped)* | Replaces `AccountOrderDetailsTotalsComponent` in My Account order details to include gift card totals |
| `OpfGiftCardOrderDetailBillingComponent` | *(nested)* | Renders billing details section with gift card payment method information |
| `OpfGiftCardPaymentMethodDetailComponent` | *(nested)* | Renders the payment method detail section showing gift card as the payment type |
