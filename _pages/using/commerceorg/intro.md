---
title: Introduction
---

# Overview

This tutorial introduces the B2B Commerce Organization feature introduced in SAP Commerce Cloud, project "Spartacus", in release 3.0. 

B2B Commerce Organization for Spartacus allows companies to manage purchases made through a Spartacus commerce web site. 

A company's purchasing manager can be set up as an administrator for the commerce organization. The administrator can create units representing the organizations, regions, cities, departments, or any other organizational entity in their company. The units are then associated with buyers, shipping addresses, and cost centers, all for the purpose of allowing, controlling and tracking spending.

For in-depth information on this feature, see the SAP Commerce Cloud B2B Commerce Organization [feature documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html).

Spartacus for B2B Commerce Organization requires release 2005 or later of SAP Commerce Cloud.


# Role definitions
In the out-of-the-box B2B Commerce Organization sample data, each user in the organization is assigned a role.
| Role | Description |
|---|---|
| Customer (Buyer) role | Users with the Customer (Buyer) role are permitted to place orders. Buyers can create orders of any value. |
| Approver role | An approver reviews and approvers or rejects orders placed by buyers, when the order goes beyond the purchase limit set for the buyer. |
| Administrator role | A user who makes changes the units and user settings in the organization. The administrator is only permitted to administrate the organization structure equal-to or below the B2B Administrator's position in the hierarchy. |
| Manager role | The manager role is intended for assigning the managers of other users; however it is not used in the out-of-the-box sample data. |

# Others terms used in B2B Commerce Organization
| Term | Description |
|---|---|
| Unit | A unit is the basic building block of the organization. A unit represents a department, location, region, or other entity. |
| User | Users are assigned to units. Each user has at least one role. |
| Cost Center | Cost centers are assigned to units and are used to track spending. When making a purchase through Account and not with credit card, buyers must choose a cost center. Buyers have access to all cost centers that are linked to their unit and all child units. |
| Budget | Budget limits are used to limit overall spending. Orders that exceed the budget are sent to approvers. |
| Purchase Limit | Purchase limits can be defined per order and per timespan. Buyers are assigned purchase limits in order to limit purchases; approvers are assigned purchase limits to limit the size of orders they can approver. |
| User Group | A collection of users, for the purposes of assigning purchase limits in one place, for many users.
| Credit Limit | Credit limits are used by selers to limit their credit exposure. Credit limits can be assigned to any unit by the seller and are not controlled by the buying company's administrator. |

# Powertools sample store

SAP Commerce Cloud includes a sample storefront called Powertools. If you install the standard recipe (called "CX" since 2005), Powertools is installed along with the extensions and sample data needed for B2B Commerce Organization.

In order to purchase something or to make changes to a commerce organization, the out-of-the-box Powertools store is configured to require users to log in first.

For a list of these default users and units, see the [Powertools extension documentation](https://help.sap.com/viewer/7e47d40a176d48ba914b50957d003804/latest/en-US/8ae789ad86691014afcccba59ba613e9.html).

Note: Starting with release 2005, SAP Commerce Cloud ships with all users inactive and without passwords. To restore the users and passwords available in the sample store, see this [help topic](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/latest/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html).

# Sample user examples

The B2B Commerce Organization feature depends on users being assigned various roles. The following table lists users who belong to the Rustic Hardwdare sample organization included in the Powertools store:

| Login | Role |
|---|---|
| linda.wolf@rustic-hw.com | Administrator |
| mark.rivers@rustic-hw.com | Buyer |
| hanna.schmidt@rustic-hw.com | Approver |