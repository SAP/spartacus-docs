---
title: Units
---

A unit is the basic building block of the organization. A unit represents a department, location, region, or any other entity that makes sense to you.

Units are the parents of, or are associated with, the following Commerce Organization entities:

- Child units
- Users
- Approvers
- Shipping addresses
- Cost centers

Each entity is important in its own way, as follows:

- Units are inherited. A user assigned to a unit also has permissions for the child units.
- An approver who is assigned to a unit can potentially approve any of the purchases made by buyers in that unit or in the related child units.
- The locations a buyer can ship to depend on the shipping addresses that have been created for a unit.
- The cost centers available to a buyer depend on the unit or child units the buyer has access to. The shipping addresses available to a buyer depend on the cost centers he or she can select.

## Creating a Child Unit

The following example starts off with a new unit and a new administrator. No other units, shipping addresses, cost centers, or any other entity are defined.

There must be one root unit, and accordingly, all new units are child units of another unit.

1. From the **My Company** home page, click **Units**.

   All units are displayed, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/allunits-rootonly.png" alt="All Units" width="500" border="1px" />

2. Click **Add**, and then fill in the following required fields:

   - **Name**
   - **ID**
   - **Approval Process**, which defines the approval process used by the seller (not defined by your organization)
   - **Parent unit**

   In the following example, two new child units were created:

   <img src="{{ site.baseurl }}/assets/images/commerceorg/allunits-2unitscreated.png" alt="New Child Units" width="500" border="1px" />
