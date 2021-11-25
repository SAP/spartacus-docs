---
title: Cost Centers
---

A cost center is an entity that is used for tracking purchases. A cost center can only be assigned to a single unit. Cost centers can be linked to multiple budgets, which are used for limiting spending in various ways.

A buyer must select a cost center during the B2B Store purchase flow, and this plays an important role for B2B Commerce Organization in the following way:

- The shipping addresses that are available to the buyer depend on the selected cost center.
- The budget (or budgets) that the order applies to is selected based on the choice of cost center.

## Creating a Cost Center

1. From the **My Company** home page, click **Cost Centers**.

2. Click **Add**, and then fill in the following required fields:

   - **Name**
   - **Code**
   - **Currency**
   - **Parent unit**

Two new cost centers were created, as shown in the following example:

<img src="{{ site.baseurl }}/assets/images/commerceorg/cc_1-2cccreated.png" alt="Creating a Cost Center 1" width="200" border="1px" />

If you display the cost center information for your units, you will see that the cost center(s) are now associated with the units you chose when creating them. The following is an example:

<img src="{{ site.baseurl }}/assets/images/commerceorg/cc_1-associatedwithunit-hha.png" alt="Creating a Cost Center 2" width="500" border="1px" />

Following the examples provided in previous steps of this tutorial, the buyer assigned to unit **hh-1a** is **John Doe**, and the cost center assigned to unit **hh-1a** is **Cost Center 1**, as shown in the following example:

<img src="{{ site.baseurl }}/assets/images/commerceorg/cc_3-johndoe.png" alt="Creating a Cost Center 3" width="500" border="1px" />

As a result, **Cost Center 1** (and not **Cost Center 2**) will be available to **John Doe** during checkout, and **John Doe** will only be able to select shipping addresses from unit **hh-1a**.
