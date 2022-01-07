---
title: Approvers
---

The term approver is used in the following different contexts in B2B Commerce Organization for SAP Commerce Cloud:

- The role of approver is a user who is designated as someone who can approve orders, and who cannot make purchases. A user with the role of approver is not necessarily the approver for the unit he or she is assigned to. That is a separate assignment, which is described in the next bullet point.
- The approver for a unit is a user who has been added to the Approvers list for a unit. This person is an official approver for anyone in that unit.

**Note:** Buyers can also be assigned their own approver on an individual basis.

As stated above, a user with the role of approver who belongs to a unit is not necessarily an approver for that unit. A user must be assigned to the Approver list for that unit as well.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Spending Permissions Required for Approvers

As with buyers, approvers must also be assigned spending permissions. This is not for the purpose of placing orders, but to indicate the amount the user is allowed to approve.

For example, a buyer may be assigned a spending limit of $500 per order, and $1500 per month, in total. If the buyer spends more money on an order, the order is placed, but then held until approval is granted. In contrast, an approver may be assigned a "spending" (approval) limit of $10,000 per order, and $30,000 per month, in total.

## How Approvers are Chosen

The choice of approval is a bubble-up method: when approval is required, SAP Commerce Cloud goes up through the unit hierarchy, looking for an approver with the right combination of permissions and spending limits. If no approver is found, an administrator is chosen, ultimately arriving at the administrator of the root unit.

## Creating an Approver

1. From the Commerce Organization Home page, click **Units**.

2. Select the unit that the new approver will be assigned to.

3. Click **Users**.

4. Click **Create**, then fill in the **Title**, **First name**, **Last name**, and **Email** fields, and also check **Approver** for the **Roles**.

   The following is an example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/unit_hh-1c1-createapprover.png" alt="Create Approver" width="200" border="1px" />

   **Note:** For this example, the unit is not selectable because a user is being created within a unit.

5. Select **Add the user to approvers for the unit** to automatically add the new approver as an approver for this unit.

   Remember that, even though a user has the role of approver, it does not necessarily mean the user is assigned the job of approving for a unit.

6. Click **Save**.

For the moment, this approver cannot approve anything. This is because no spending permissions have been created yet. We'll do that later, in the step for setting [{% assign linkedpage = site.pages | where: "name", "b2b-purchasing-limits.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/using/commerceorg/b2b-purchasing-limits.md %}).

Don't forget to assign the new user a password.

## The Assigned Approvers List

Remember that when you created the approver, you selected the check box **Add the user to approvers for the unit**. We have created two users so far, and only one is an approver, so we should expect to see only one user in this unit's list of approvers.

If you go back and click **Approvers** for the unit, you will see that, indeed, this is the case. The following is an example:

<img src="{{ site.baseurl }}/assets/images/commerceorg/unit_hh-1c2-approverlist.png" alt="Approver List" width="500" border="1px" />
