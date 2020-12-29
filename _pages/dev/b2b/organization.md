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
// move so other section

```ts
export abstract class TableConfig {
  table?: {
    [tableType: string]: ResponsiveTableConfiguration;
  };
  tableOptions?: {
    /**
     * Global component to render table header _content_ (`<th>...</th>`). A specific component
     * can be configured alternatively per table or table field.
     */
    headerComponent?: Type<any>;

    /**
     * Global component to render table cell _content_ (`<td>...</td>`). A specific component per
     * field can be configured alternatively.
     *
     * If no component is available, the table content will render as-is.
     */
    dataComponent?: Type<any>;
  };
}
```
Organization lists which can be overridden:
```ts
export enum OrganizationTableType {
  BUDGET = 'orgBudget',
  BUDGET_ASSIGNED_COST_CENTERS = 'orgBudgetAssignedCostCenters',
  COST_CENTER = 'orgCostCenter',
  COST_CENTER_BUDGETS = 'orgCostCenterBudgets',
  COST_CENTER_ASSIGNED_BUDGETS = 'orgCostCenterAssignedBudgets',
  UNIT = 'orgUnit',
  UNIT_USERS = 'orgUnitUsers',
  UNIT_CHILDREN = 'orgUnitChildren',
  UNIT_APPROVERS = 'orgUnitApprovers',
  UNIT_ASSIGNED_APPROVERS = 'orgUnitAssignedApprovers',
  UNIT_ADDRESS = 'orgUnitAddress',
  UNIT_COST_CENTERS = 'orgUnitCostCenters',
  USER_GROUP = 'orgUserGroup',
  USER_GROUP_USERS = 'orgUserGroupUsers',
  USER_GROUP_ASSIGNED_USERS = 'orgUserGroupAssignedUsers',
  USER_GROUP_PERMISSIONS = 'orgUserGroupPermissions',
  USER_GROUP_ASSIGNED_PERMISSIONS = 'orgUserGroupAssignedPermissions',
  USER = 'orgUser',
  USER_APPROVERS = 'orgUserApprovers',
  USER_ASSIGNED_APPROVERS = 'orgUserAssignedApprovers',
  USER_PERMISSIONS = 'orgUserPermissions',
  USER_ASSIGNED_PERMISSIONS = 'orgUserAssignedPermissions',
  USER_USER_GROUPS = 'orgUserUserGroups',
  USER_ASSIGNED_USER_GROUPS = 'orgUserAssignedUserGroups',
  PERMISSION = 'orgPurchaseLimit',
}
```
Here is an example how to override `name` cell in `orgBudget` table with prepared previously `MyComponent`

```ts
export const myTableConfig: TableConfig = {
  table: {
    [OrganizationTableType.BUDGET]: {
      options: {
        cells: {
          name: {
            dataComponent: MyComponent,
          },
        },
      },
    },
  },
};
```

Now it's enough to add configuration in your providers list.
```ts
 providers: [
   ...
    provideConfig(myTableConfig)
  ],
```
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
