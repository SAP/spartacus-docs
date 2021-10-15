---
title: Purchase and Approval Flow Example
---

In this purchase and approval flow example, we make use of the new buyer and approver that were set up with your new organization.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Purchase Flow Example

In these steps, we are working with John Doe, the new buyer that we created in previous steps of this tutorial.

In this example, we'll purposely order something over the purchase limit so that we can see the approval process in action.

1. In a separate browser, or using a private browser window, log in to the Powertools site as your buyer (for example, John Doe).

   **Note:** If you try to log in using the same browser, you will lose the administrator browser session.

2. Add products to the cart until the total is over $500, and then start the checkout process.

   **Note:** The approval process will only be triggered if the purchase amount surpasses the purchase limits you have created. In this tutorial, we created a per-order limit of $500 for the buyer.

3. For the payment method, select **Account**, and then click **Continue**.

4. Select a cost center and shipping address, and then click **Continue**.

5. Select a delivery mode, and then click **Continue**.

   The **Review Order** page is displayed.

6. Select the terms and conditions check box, and then click **Place Order**.

The order is now held.

Because the order is over $500, the order is placed, but it is held for approval by the buyer's organization.

To see that an order is being held, display your order history. Wait a few moments for the back end to start the order flow. The order status starts out as **Created** but eventually you will see **Pending** and an approval table at the bottom of the order. The following is an example:

<img src="{{ site.baseurl }}/assets/images/commerceorg/johndoe_2-orderdetailsapprovaltable-waiting.png" alt="Order Details Approval Table - Waiting" width="600" border="1px" />

You can see the reason why an order is held under the **Permission** heading. In this case, the order was held because the total cost of the order exceeded the per-order limit. You can also see who the approver is.

## Approving the Order

To review the order, the approver that was created earlier in this tutorial must log in. You might want to do this in yet another browser so that you can see the status of the order before and after approval.

In these steps, we are working with Tommy Durang, the new approver that we created in previous steps of this tutorial.

1. Log in to the Powertools site as your approver (for example, Tommy Durang).

2. Click the **My Account** menu, and then click **Approval Dashboard**.

   The list of orders requiring approval is displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/tommy_1-approvaldashboard.png" alt="Approval Dashboard" width="600" border="1px" />

3. Click the order number for the order that requires approval.

   The entire order is displayed in the same way that the buyer would see it, but with the addition of an approval section at the top. The following is an example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/tommy_2-orderapprovalacceptreject.png" alt="Order Approval Accept Reject" width="600" border="1px" />

4. Click **Approve Order**.

   The **Order Approval** screen is displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/tommy_3-orderapprove.png" alt="Order Approval Screen" width="600" border="1px" />

   You can enter a comment if you wish.

5. To submit the approval, click **Approve**.

   The order can now proceed.

   If John Doe checks the order after approval, he can see that the approval table has been updated with the confirmation that the order was approved, along with the comment. The same would appear if the order were rejected. The following is an example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/johndoe_2-orderdetailsapprovaltable-approved.png" alt="Order Details Approval Table - Approved" width="600" border="1px" />