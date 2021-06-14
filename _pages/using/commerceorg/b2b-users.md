---
title: Users
---

When creating B2B users, every user must have a role. The following "out-of-the-box" user roles are available with SAP Commerce Cloud:

- Customer (Buyer): Places orders.
- Approver: Reviews and approves or rejects orders placed by buyers, when the order goes beyond the purchase limit set for the buyer. Cannot make purchases.
- Administrator: Makes changes to the units and user settings in the organization. Cannot make purchases.
- Manager: Not used in the out-of-the-box sample data.

You can create a user for a unit within the unit view, or separately, by displaying all users.

See the following pages for examples of creating users from within the units view:

- [{% assign linkedpage = site.pages | where: "name", "b2b-buyers.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/using/commerceorg/b2b-buyers.md %})
- [{% assign linkedpage = site.pages | where: "name", "b2b-approvers.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/using/commerceorg/b2b-approvers.md %})
