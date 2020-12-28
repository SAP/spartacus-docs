---
title: B2B Organization
feature:
- name: B2B Organization
  spa_version: 3.0
  cx_version: 2005
---

## Overview

Commerce Org allows companies to create and manage their buying company as represented on the seller's site:

- **Units** (companies, divisions, etc.) in a hierarchy i.e. parents and children units
- **Shipping addresses** assigned to units
- **Users** (assigned to units) (assigned roles such as admin, manager, approver, or customer/buyer, and you can add more)
  - Only admins can see and manage units, employees and cost centers
  - Only approvers can see items requiring approval
- **Cost centers** (assigned to units)
- **Budgets** (assigned to cost centers)
- **Purchase thresholds** (labelled as "Permissions" in Powertools), which trigger approvals if over the threshold (assigned to users)
- **User groups**

## Configuration

Config details

## Override RoutingConfig

https://sap.github.io/spartacus-docs/route-configuration/#predefined-config
RouterConfig details or link

## Override CmsConfig

CmsConfig details or link

## Override TableConfig

TableConfig details or link

## Homepage

Organization homepage is a place containing set of links which user can use to navigate through all specific my company functionalities.

All links introduced on organization homepage are corresponding to standard banner components created on the backend.

### Adding new banner

There is possibility to add new links to organization homepage. Easiest way to do that is to create new **Banner Component** in Backoffice as described in the following procedure:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS ––> Component**.

1. When components list shows up, click on arrow down icon next to plus from top left and select following type **Abstract Banner Component ––> Banner Component**.

1. Next specify **ID** and **Catalog Version** fields, then click **Done**.

1. Select recent created component from components list and go to **Administration** tab.

1. <span id="fields-list">Following fields needs to be filled in:</span>
   - **Headline** - is title of the link.
   - **Content** - is a text displayed below link title.
   - **URL link** - is target url address.
   - **Media** - is reference to specified media object added into *Media Library*. In this case used to define banner icon.

1. Finally to display newly created banner it should be assigned to proper content slot. Go to **Content slots** tab and select **My Company Slot**.

### Hiding specific banner

Number of visible banners on organization homepage can be reduced. Easiest way to hide specific banner is to set component visibility to `false` in the Backoffice:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS ––> Component**.

1. Select banner component assigned to **My Company Slot** you want to hide.

1. Go to **Properties** tab and set **Visibility** value to `false`.

### Adding custom icon

There is also possibility to upload any image file and use it as an icon in banner link. To do it again Backoffice can be used:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **Multimedia ––> Media**.

1. Click add icon and specify **Identifier** and **Catalog Version**.

1. On the next step upload image you want to use.

1. When media object is created it can be used as media  reference of any **Banner Component** belongs to **My Company Slot** ([please see](###fields-list)).

## Styles

How to override styles
