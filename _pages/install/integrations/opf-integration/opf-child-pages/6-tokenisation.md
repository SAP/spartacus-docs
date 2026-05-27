---
title: Tokenisation
---

Tokenisation is an OPF-based feature that enables customers to save payment cards, reuse them during checkout, and manage saved cards in My Account.

It supports two key flows:

1. Checkout saved cards flow: Customers can select a previously saved card, optionally update the default, and place the order.
2. My Account payment methods flow: Logged-in customers can view, set default, and delete saved cards.

## Enabling Tokenisation in Spartacus

Tokenisation functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](1-open-payment-framework-in-spartacus.md#enabling-open-payment-framework-in-spartacus). Note that tokenisation is disabled by default and must be explicitly enabled during the schematics installation.

After installation, tokenisation is available through OPF modules and configuration.

## How Tokenisation is rendered ?

### 1. Checkout Flow (Saved Cards + New Payment)

Checkout tokenisation is outlet-driven, not CMS-driven. OPF injects tokenisation UI around checkout payment options through checkout outlets.

#### Rendered Elements

**Saved cards payment option (radio button) and heading**  
 Displayed when saved cards exist.

**Saved cards list and actions**  
 Displays tokenised cards and allows actions such as selecting a card for payment and setting default.

**New payment heading**  
 Separates the saved-cards area from the new-payment area.

#### Key Behavior

- Rendering depends on whether saved cards are available.
- If a user switches from a saved card to another payment method, checkout payment details are cleared to avoid stale state.

### 2. My Account Flow (CMS-Driven)

- **CMS component**: `AccountPaymentDetailsComponent`
- **Mapped Spartacus component**: `OpfTokenisationAccountPaymentMethodsComponent`
- **Guard**: Authenticated users only

You can enable the Tokenisation CMS component manually through ImpEx.

#### Adding CMS Component Manually

To add all required CMS data for tokenisation, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;AccountPaymentDetailsComponent;Account Payment Details Component;AccountPaymentDetailsComponent;AccountPaymentDetailsComponent
```

#### Impact

- If `AccountPaymentDetailsComponent` is already present, OPF tokenisation overrides the default rendering.
- Customers can manage their saved cards, including viewing available cards, setting a default, deleting cards, and identifying expired cards through tokenisation-specific UI indicators.

## Runtime Behavior

1. Tokenisation loads saved payment methods for logged-in users and enables saved-card checkout flow when cards are available.
2. The default saved card is auto-selected (when present), and users can explicitly select another saved card for payment.
3. Users can set a saved card as default, and this default is reflected in My Account payment methods.
4. Expired card indicators are shown in both checkout and My Account so invalid cards are clearly identified.
5. Saved-card mode is tracked through a dedicated internal selection state to keep checkout behavior consistent.
6. If a shopper selects a saved card and then switches to another payment option, checkout payment details are cleared to prevent stale state.
