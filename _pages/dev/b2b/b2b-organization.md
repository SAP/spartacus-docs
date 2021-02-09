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

## UI

### Override RoutingConfig


In organization module, we have defined the following routes:

Budgets:
`orgBudget, orgBudgetCreate, orgBudgetDetails, orgBudgetCostCenters, orgBudgetEdit`

Cost centers:
`orgCostCenter, orgCostCenterCreate, orgCostCenterDetails, orgCostCenterBudgets, orgCostCenterAssignBudgets, orgCostCenterEdit`

Purchase limits:
`orgPurchaseLimit, orgPurchaseLimitCreate, orgPurchaseLimitDetails, orgPurchaseLimitEdit`

Units:
`orgUnits, orgUnitCreate, orgUnitDetails, orgUnitEdit, orgUnitChildren, orgUnitCreateChild, orgUnitUserList, orgUnitCreateUser, orgUnitUserRoles, orgUnitApprovers, orgUnitAssignApprovers, orgUnitAddressList, orgUnitAddressCreate, orgUnitAddressDetails, orgUnitAddressEdit, orgUnitCostCenters, orgUnitCreateCostCenter`

Users:
`orgUser, orgUserCreate, orgUserDetails, orgUserEdit, orgUserChangePassword, orgUserApprovers, orgUserAssignApprovers,   orgUserPermissions, orgUserAssignPermissions, orgUserUserGroups, orgUserAssignUserGroups`

User groups:
`orgUserGroup, orgUserGroupCreate, orgUserGroupDetails, orgUserGroupEdit, orgUserGroupUsers, orgUserGroupAssignUsers, orgUserGroupPermissions, orgUserGroupAssignPermissions`


For more details how to override routes, please see section [Route Configuration](https://sap.github.io/spartacus-docs/route-configuration/#predefined-config)

Example:

```ts
imports: [
  // ...
  B2bStorefrontModule.withConfig({
    // ...
    routing: {
      routes: {
        orgBudgetCreate: {
          paths: ['organization/budgets/my-create'],
        },
      },
    },    
  )},
  // ...
]
```

### Override CmsConfig

Organization library provides clear split into features. They are reflected in feature list components. 

You can override next CMS components:
`ManageBudgetsListComponent, ManageCostCentersListComponent, ManagePermissionsListComponent, ManageUnitsListComponent, ManageUsersListComponent, ManageUserGroupsListComponent`


Presented feature list components uses [Split view](https://sap.github.io/spartacus-docs/split-view/), it means all components inside are ordered in nested hierarchy. A side effect of this solution is the need to overwrite the entire configuration, even if we want to make a small change.

For more details how to override cms configuration, please see section [CMS Configuration](https://sap.github.io/spartacus-docs/customizing-cms-components/)

Example:
```ts
imports: [
  // ...
  B2bStorefrontModule.withConfig({
    // ...
    cmsComponents: {
      ManageBudgetsListComponent: {
        // ...
        childRoutes: {
          children: [
            {
              path: 'my-create',
              component: MyFormComponent,
            },
            // ...
          ],
        },
        // ...
      },
    },    
  )},
]
```

### Override TableConfig

Following lists in organization module which can be overridden:
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

For more details how to override table configuration, please see section [Table Configuration](https://sap.github.io/spartacus-docs/table/)

Example: How to override `name` cell in `orgBudget` table with prepared previously `MyComponent`

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
  //...
  provideConfig(myTableConfig)
],
```

### Cell components

Several implementations of `CellComponent` have been defined in the organization that apply to tables and subtables.

- `ToggleLinkCellComponent` - allows toggling branches on units list and set styles for depth level
- `AssignCellComponent` - is used for allows assigning or unassigning items
- `ActiveLinkCellComponent` - displays name and make whole row as link
- `AmountCellComponent` - prepared for display budget combined with currency
- `DateRangeCellComponent` - displays combined start and end date for budget
- `LimitCellComponent` - depending on orderApprovalPermissionType shows purchase limit
- `RolesCellComponent` - displays user roles in specified way
- `StatusCellComponent` - is used for display colorable status of active flag
- `UnitCellComponent` - displays information about unit of current item
- `LinkCellComponent` - link for nested views (address)
- `UnitUserRolesCellComponent` - personalized link for open roles view

### Local message component
Newly added messages was used in the organization. They work similarly to global messages, but are displayed directly in the component of the subject they concern.

- In common cases we use `NotificationMessageComponent` to display information about success or error.

- `ConfirmationMessageComponent` has been designed to ask question for make sure that user is aware of consequences of his action. Used e.g. in `ToggleStatusComponent` and `DeleteItemComponent`.

## Core

### Guards:
We provided new [guard](https://sap.github.io/spartacus-docs/customizing-cms-components/#guarding-components) `AdminGuard` which verify that logged user has permissions to see organization pages. By default, it redirects into organization home page and displays warning message. 

### Models
- Models from core used in organization 
`Address, Currency, B2BApprovalProcess, B2BUserRole, OrderApprovalPermissionType`
- Core models used for structure:
`ListModel, SearchConfig, StateUtils`  
- Models augmented core:
`B2BUnit, B2BUser, CostCenter`
- Dedicated models for organization:
`B2BUnitNode, Budget, Permission, Period, UserGroup`
- Other models, used for processes:
`LoadStatus, OrganizationItemStatus`
- Models used for components:
`B2BUnitTreeNode`
  
### Occ
Config - Organization uses below endpoints for data access:
```ts
export const defaultOccOrganizationConfig: OccConfig = {
  backend: {
    occ: {
      endpoints: {
        budgets: '/users/${userId}/budgets',
        budget: '/users/${userId}/budgets/${budgetCode}',
        orgUnitsAvailable: '/users/${userId}/availableOrgUnitNodes',
        orgUnitsTree: '/users/${userId}/orgUnitsRootNodeTree',
        orgUnitsApprovalProcesses:
          '/users/${userId}/orgUnitsAvailableApprovalProcesses',
        orgUnits: '/users/${userId}/orgUnits',
        orgUnit: '/users/${userId}/orgUnits/${orgUnitId}',
        orgUnitUsers:
          '/users/${userId}/orgUnits/${orgUnitId}/availableUsers/${roleId}',
        orgUnitApprovers:
          '/users/${userId}/orgUnits/${orgUnitId}/orgCustomers/${orgCustomerId}/roles',
        orgUnitApprover:
          '/users/${userId}/orgUnits/${orgUnitId}/orgCustomers/${orgCustomerId}/roles/${roleId}',
        orgUnitUserRoles:
          '/users/${userId}/orgCustomers/${orgCustomerId}/roles',
        orgUnitUserRole:
          '/users/${userId}/orgCustomers/${orgCustomerId}/roles/${roleId}',
        orgUnitsAddresses: '/users/${userId}/orgUnits/${orgUnitId}/addresses',
        orgUnitsAddress:
          '/users/${userId}/orgUnits/${orgUnitId}/addresses/${addressId}',
        userGroups: '/users/${userId}/orgUnitUserGroups',
        userGroup: '/users/${userId}/orgUnitUserGroups/${userGroupId}',
        userGroupAvailableOrderApprovalPermissions:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/availableOrderApprovalPermissions',
        userGroupAvailableOrgCustomers:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/availableOrgCustomers',
        userGroupMembers:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/members',
        userGroupMember:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/members/${orgCustomerId}',
        userGroupOrderApprovalPermissions:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/orderApprovalPermissions',
        userGroupOrderApprovalPermission:
          '/users/${userId}/orgUnitUserGroups/${userGroupId}/orderApprovalPermissions/${orderApprovalPermissionCode}',
        costCenters: '/costcenters',
        costCenter: '/costcenters/${costCenterCode}',
        costCentersAll: '/costcentersall',
        costCenterBudgets: '/costcenters/${costCenterCode}/budgets',
        costCenterBudget:
          '/costcenters/${costCenterCode}/budgets/${budgetCode}',
        permissions: '/users/${userId}/orderApprovalPermissions',
        permission:
          '/users/${userId}/orderApprovalPermissions/${orderApprovalPermissionCode}',
        orderApprovalPermissionTypes: '/orderApprovalPermissionTypes',
        b2bUsers: '/users/${userId}/orgCustomers',
        b2bUser: '/users/${userId}/orgCustomers/${orgCustomerId}',
        b2bUserApprovers:
          '/users/${userId}/orgCustomers/${orgCustomerId}/approvers',
        b2bUserApprover:
          '/users/${userId}/orgCustomers/${orgCustomerId}/approvers/${approverId}',
        b2bUserUserGroups:
          '/users/${userId}/orgCustomers/${orgCustomerId}/orgUserGroups',
        b2bUserUserGroup:
          '/users/${userId}/orgCustomers/${orgCustomerId}/orgUserGroups/${userGroupId}',
        b2bUserPermissions:
          '/users/${userId}/orgCustomers/${orgCustomerId}/permissions',
        b2bUserPermission:
          '/users/${userId}/orgCustomers/${orgCustomerId}/permissions/${premissionId}',
      },
    },
  },
};
```

For more information on OCC endpoint configuration, see [Configuring Endpoints](https://sap.github.io/spartacus-docs/connecting-to-other-systems/#configuring-endpoints)

### Adapters:
List of adapters:
`BudgetAdapter, OrgUnitAdapter, UserGroupAdapter, PermissionAdapter, CostCenterAdapter, B2BUserAdapter`

More information about adapters is available [here.](https://sap.github.io/spartacus-docs/connecting-to-other-systems/#adapter)

### Convertors:
- List of serializers in a core:
`ADDRESS_SERIALIZER, COST_CENTER_SERIALIZER`

- List of serializers in the organization:
`BUDGET_SERIALIZER, B2B_USER_SERIALIZER, B2BUNIT_SERIALIZER, PERMISSION_SERIALIZER, USER_GROUP_SERIALIZER, `

- List of normalizers in a core:
`COST_CENTERS_NORMALIZER, COST_CENTER_NORMALIZER`

- List of normalizers in the organization:
`BUDGET_NORMALIZER, BUDGETS_NORMALIZER, B2BUNIT_NORMALIZER, B2BUNIT_NODE_NORMALIZER, B2BUNIT_NODE_LIST_NORMALIZER, B2BUNIT_APPROVAL_PROCESSES_NORMALIZER, USER_GROUP_NORMALIZER, USER_GROUPS_NORMALIZER, PERMISSION_NORMALIZER, PERMISSIONS_NORMALIZER, PERMISSION_TYPE_NORMALIZER, PERMISSION_TYPES_NORMALIZER, B2B_USER_NORMALIZER, B2B_USERS_NORMALIZER`

Please see section [convertor](https://sap.github.io/spartacus-docs/connecting-to-other-systems/#convertor) to see more details.

### Store
Main assumptions:
- Every PATCH/POST action clean whole organization state to make sure, that we have always up to date data.
- Components and their services have responsibility to routing redirects.
- In facades, we try load data only if they were not loaded before.

Exceptions:
- We avoid cleaning users list when we assign / unassign an approver for user (race condition in split view)
- We have missing id while creation of user, so there are some routing redirections applied directly in effects.


Organization model stored in redux contains all main features:
```ts
export interface OrganizationState {
  [BUDGET_FEATURE]: BudgetManagement;
  [ORG_UNIT_FEATURE]: OrgUnits;
  [USER_GROUP_FEATURE]: UserGroupManagement;
  [PERMISSION_FEATURE]: PermissionManagement;
  [COST_CENTER_FEATURE]: CostCenterManagement;
  [B2B_USER_FEATURE]: B2BUserManagement;
}
```
In simplify we store everything related to organization in entities and lists of IDs separately. Associated data for a subsection is stored in their own feature, but for specific views we use combination of ID and query params to store list of IDs and other information.

```ts
export interface Management<Type> extends StateUtils.EntityListState<Type> {}

export interface BudgetManagement extends Management<Budget> {}

export interface OrgUnits {
  availableOrgUnitNodes: StateUtils.EntityLoaderState<B2BUnitNode[]>;
  entities: StateUtils.EntityLoaderState<B2BUnit>;
  tree: StateUtils.EntityLoaderState<B2BUnitNode>;
  approvalProcesses: StateUtils.EntityLoaderState<B2BApprovalProcess[]>;
  users: StateUtils.EntityLoaderState<ListModel>;
  addressList: StateUtils.EntityLoaderState<ListModel>;
  addressEntities: StateUtils.EntityLoaderState<Address>;
}

export interface UserGroupManagement extends Management<UserGroup> {
  permissions: StateUtils.EntityLoaderState<ListModel>;
  customers: StateUtils.EntityLoaderState<ListModel>;
}

export interface PermissionManagement extends Management<Permission> {
  permissionTypes: StateUtils.EntityLoaderState<OrderApprovalPermissionType[]>;
}

export interface CostCenterManagement extends Management<CostCenter> {
  budgets: StateUtils.EntityLoaderState<ListModel>;
}

export interface B2BUserManagement extends Management<B2BUser> {
  approvers: StateUtils.EntityLoaderState<ListModel>;
  permissions: StateUtils.EntityLoaderState<ListModel>;
  userGroups: StateUtils.EntityLoaderState<ListModel>;
}
```
For more details about usage of EntityLoaderState, please see section [Loader Meta Reducer](https://sap.github.io/spartacus-docs/loader-meta-reducer/#defining-the-state-interface)


#### Example.
For `User group` structure can look like this:
```ts
userGroup:
    entities:
        entities: {edited-entity-a33xc5fnn: {…}, edited-entity-xi4yvmatz: {…}, edited-entity-f88ca37gt: {…}, edited-entity-cfew7374i: {…}, edited-entity-jjajzn4na: {…}, …}
    list:
        entities:
            ?pageSize=10&currentPage=&sort=:
                error: false
                loading: false
                success: true
                value: {ids: Array<String>(10), pagination: {…}, sorts: Array(3)}
    customers:
        entities:
            edited-entity-a33xc5fnn?pageSize=10&currentPage=&sort=: {loading: false, error: false, success: true, value: {…}}
            edited-entity-a33xc5fnn?pageSize=2147483647&currentPage=&sort=: {loading: false, error: false, success: true, value: {…}}
    permissions:
        entities:
            edited-entity-a33xc5fnn?pageSize=10&currentPage=&sort=: {loading: false, error: false, success: true, value: {…}}
            edited-entity-a33xc5fnn?pageSize=2147483647&currentPage=&sort=: {loading: false, error: false, success: true, value: {…}}

```
Where:
- `entities` stores user group real objects (key mapped to status flags and value)
- `list` stores list of user groups IDs for specified page (keys based on query params like pagination, sort)
- `customers`, `permisions` stores ID's for a subsection (keys based on ID of user group and query params)
* `pageSize=2147483647` means, we fetch all possible items - max Java safe integer

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

How to override organization styles:

Make sure that file is generated properly by schematics, or add it own. Your `angular.json` file should include his path in build styles.
```ts
"styles": [
  "src/styles.scss",
  "src/styles/spartacus/organization.scss"
],
```

In `organization.scss` should be imported organization styles, and you can add your own styles below.
```ts
@import "@spartacus/organization";

// your styles, e.g.:
%organizationList {
    cx-org-toggle-link-cell {
        button.tree-item-toggle {
            background-color: blue;
        }
    }
}
```
More about styles in spartacus you can see in section dedicated to [ styles.](https://sap.github.io/spartacus-docs/css-architecture/#component-styles)

## Assets

### Override translations

Translation resources for organization can be overridden on the same rules as other spartacus chunks e.g.:

```ts
provideConfig({
  i18n: {
    resources: {
      en: {
        organization: {
          organization: { // general chunks
            enabled: 'Enabled',
          },
          orgUserGroup: { // specified sub features chunks
            header: 'List of user groups ({{count}})',
          }
        },
      },
    },
  },
}),
```
More about translations please see section [extending translation](https://sap.github.io/spartacus-docs/i18n/#extending-translations)
