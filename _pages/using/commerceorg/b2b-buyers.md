---
title: Buyers
---

Users with the Customer (Buyer) role are permitted to place orders. Buyers can create orders of any value.

## Creating a Buyer

1. From the Commerce Organization Home page, click **Units**.

2. Select the unit that the new buyer will be assigned to.

3. Click **Users**.

   No users exist yet, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/unit_hh-1a.png" alt="Creating a Buyer 1" width="500" border="1px" />

4. Click **Create**, then fill in the **Title**, **First name**, **Last name**, and **Email** fields, and also check **Customer** for the **Roles**.

   The following is an example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/unit_hh-1b-createuser.png" alt="Creating a Buyer 2" width="200" border="1px" />

   **Note:** For this example, the unit is not selectable because a user is being created within a unit.

5. Click **Save**.

For the moment, this user's purchases are all subject to order approvals. This is because no spending permissions have been created yet. We'll do that later, in the step for setting [{% assign linkedpage = site.pages | where: "name", "b2b-purchasing-limits.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/using/commerceorg/b2b-purchasing-limits.md %}).

## Assigning a Password to the New User

New users are not given passwords by default. These users can choose to reset their password at first login, or you can assign a password.

The following steps describe how to assign a password:

1. From the Commerce Organization Home page, click **Users**.

2. Select the user whose password you want to change.

3. Click **Change password**.

4. Type the new password in the two fields, and click **Save**.
