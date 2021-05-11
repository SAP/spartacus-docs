---
title: Purchase Flow Example
---

The following example highlights the differences between a B2C and a B2B checkout. The purchase flow is done with Mark Rivers (who is a "buyer"), and demonstrates how the checkout flow is influenced by B2B Commerce Organization settings.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## B2B Purchase Flow

1. Mark has products in his cart, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_0-cart.png" alt="Cart with one item" width="600" border="1px" />

2. Mark clicks **Proceed to Checkout**.

   In the B2B Powertools storefront, the buyer can enter a purchase order number (PO number), as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_1a-methodofpayment-cc.png" alt="Method of Payment step, Credit Card selected" width="400" border="1px" />
  
   The default payment method is credit card, in which case the payment process is the same as with a standard B2C storefront (such as the Electronics storefront).

3. Mark selects the **Account** payment method, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_1b-methodofpayment-account.png" alt="Method of Payment step, Account selected" width="400" border="1px" />

    With the **Account** payment method selected, the checkout steps change and the **Payment Details** step is removed. This is because there is no need to supply a credit card when paying by account. Invoicing is done separately, through an arrangement between the seller and buyer companies.

4. Mark clicks **Continue**.

   The **Shipping Address** screen is displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_2a-shippingaddress.png" alt="Shipping Address step" width="400" border="1px" />

   In order to continue, Mark must select a cost center. Mark can access all cost centers in the unit he is assigned to, and any cost centers belonging to child units of his unit.

   The shipping addresses available to Mark depend on the cost center he selects. Units are assigned cost centers and shipping addresses, and the shipping addresses are taken from the unit associated with the chosen cost center.

   **Note:** In the following example, a second cost center was added to the sample data to show that there are multiple cost centers available:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_2b-costcentermenu.png" alt="Cost Center menu, 2 cost centers shown" width="400" border="1px" />

5. After selecting a cost center and shipping address, Mark clicks **Continue**.

   The **Delivery Mode** screen is displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_3-deliverymode.png" alt="Delivery mode step" width="400" border="1px" />

   This screen is the same as with the standard B2C storefront, with the delivery cost depending on the shipping address.

6. Mark clicks **Continue**.

   The **Review Order** screen is displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/mark1_4-review.png" alt="Review step" width="600" border="1px" />

   A summary of the order is displayed for Mark. There is also an option to schedule an automatic replenishment of the order (on the right side, below the **Order Summary**).

7. Mark clicks **Place Order**.

   The **Confirmation** page appears, and depending on Mark's purchase limits, the following occurs:

   - If the order is within Mark's purchase limits, the order proceeds through the seller's purchase workflow automatically.
   - If the order is beyond Mark's purchase limits, the order is placed, but is held until an approver from Mark's company approves the purchase.

## Minimum Requirements for Setting Up a Commerce Organization

From Mark's purchase example, the minimum setup for a commerce organization is the following:

- One unit
- One shipping address assigned to the unit
- One cost center assigned to the unit
- Two users: an administrator and a buyer

The following features are optional, but can help for controlling and tracking spending:

- Approvers: if there are no approvers defined, the administrator is the approver
- Spending limits: for triggering approvals, but also to allow small purchases to be approved automatically
- Budgets: to apply spending limits collectively to a group of buyers
