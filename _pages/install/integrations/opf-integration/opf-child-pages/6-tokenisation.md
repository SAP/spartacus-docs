---
title: Tokenisation
---

Tokenisation is an OPF-based feature that enables customers to use saved payment cards during checkout and manage saved cards in My Account.

It supports two key flows:
1. Checkout saved cards flow: customers can select a previously saved card and place the order.
2. My Account payment methods flow: logged-in customers can view, set default, and delete saved cards.

## Enabling Tokenisation in Spartacus

Tokenisation functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

After installation, tokenisation is available through OPF modules and configuration.

## How Tokenisation is rendered ?

1. Checkout flow (saved cards + new payment) : 
Checkout tokenisation is outlet-driven, not CMS-driven. OPF injects tokenisation UI around checkout payment options through checkout outlets.

Rendered elements:
a. Saved cards payment option(radio button) and heading :
    Displayed as a radio option when saved cards exist.
b. Saved cards list and card actions :  
    Shows tokenised cards and allows actions such as selecting a card for payment and setting default.
c. New payment heading:
    Separates the saved-cards area from the new-payment area when both are available.   

Key behavior:
a. Rendering is reactive to whether saved cards are available.
b. If a user selected a saved card and then moves to another payment option, checkout payment details are cleared to avoid stale state.

2. My Account flow (CMS-driven) :
a. CMS component: AccountPaymentDetailsComponent
b. Mapped Spartacus component: OpfTokenisationAccountPaymentMethodsComponent
c. Guard: authenticated users only

Impact :
a. If AccountPaymentDetailsComponent is already on the account payment page, OPF tokenisation takes over rendering.
b. Customers get tokenised card management (view/set default/delete) with tokenisation-specific UI behavior.
