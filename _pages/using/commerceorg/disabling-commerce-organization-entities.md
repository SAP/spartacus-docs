---
title: Disabling and Deleting Commerce Organization Entities
---

You can disable Commerce Organization entities, such as units, users, cost centers, and most other entities, but you cannot delete them. This is due to the interconnected nature of Commerce Organization entities.

Disabling an entity, such as a user, means that the user cannot make purchases and cannot be edited. The user must be re-enabled first.

Another way of thinking about disabling and deleting entities is this:

- Shipping addresses and user groups can be deleted
- Everything else can only be disabled

## Warning When Disabling Units

Many Commerce Organization entities are connected through (or "owned by") units. For this reason, if you disable a unit, all children of the unit and related entities are disabled, including users, cost centers, and budgets.

Take the following example:

- Unit A contains/owns User A, Budget B, and Cost Center C
- Budget B is assigned to Cost Center C

If you disable Unit A, then User A, Budget B, and Cost Center C are all disabled.

However, the budget would not be disabled in the following situation:

- Budget B is "owned" by Unit Z instead of Unit A
- Budget B is still assigned to Cost Center C

In this case, if you were to disable Unit A, Budget B would remain active because it is owned by Unit Z. The assignment to Cost Center C has no effect here.

A warning message is displayed when disabling entities.
