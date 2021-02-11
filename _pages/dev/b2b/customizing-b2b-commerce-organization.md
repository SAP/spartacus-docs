---
title: Customizing B2B Commerce Organization
feature:
- name: B2B Commerce Organization
  spa_version: 3.0
  cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

B2B Commerce Organization for Spartacus allows companies to manage purchases made through a Spartacus commerce web site.

The following sections describe how to customize and configure B2B Commerce Organization for Spartacus. For information about using B2B Commerce Organization, see [B2B Commerce Organization Tutorial]({{ site.baseurl }}{% link _pages/using/commerceorg/landing-page/b2b-commerce-organization-tutorial.md%}).

For in-depth information on this feature, see [Commerce Organization](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html) on the SAP Help Portal.

## Customizing Routes

A number of default routes are defined for B2B Commerce Organization. You can see the routes in the `config.ts` files of the following components:

- budget
- cost-center
- permission (also known as purchase limits)
- unit
- user
- user-group

For example, the routes for budgets are defined in `feature-libs/organization/administration/components/budget/budget.config.ts`.

You can override these routes, as shown in the following example:

```ts
imports: [
  // ...
  B2bStorefrontModule.withConfig({
    // ...
    routing: {
      routes: {
        orgBudgetCreate: {
          paths: ['organization/budgets/custom-create'],
        },
      },
    },    
  )},
  // ...
]
```

For more information on overriding routes, see [Route Configuration]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md%}).

## Customizing CMS Components

In the Organization library, you can override the following CMS components:

- `ManageBudgetsListComponent`
- `ManageCostCentersListComponent`
- `ManagePermissionsListComponent`
- `ManageUnitsListComponent`
- `ManageUsersListComponent`
- `ManageUserGroupsListComponent`

The following is an example:

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
              path: 'custom-create',
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

All of the list components in the Organization library use split view, which means all the components inside the split view component are ordered in a nested hierarchy. As a result, even small changes require overwriting the entire configuration. For more information, see [Split View]({{ site.baseurl }}{% link _pages/dev/components/shared-components/split-view.md%}).

For more information on overriding CMS configurations, see [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/components/customizing-cms-components.md%}).

## Customizing Table Configurations

All of the table configurations in the Organization library are listed in the `OrganizationTableType` enum in `feature-libs/organization/administration/components/shared/organization.model.ts`.

You can override any of these table configurations, as shown in the following example, which overrides the `name` cell in the `orgBudget` table with a previously prepared `MyComponent` data component:

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

Now you can add the configuration to your `providers` list. The following is an example:

```ts
providers: [
  //...
  provideConfig(myTableConfig)
],
```

For more information, see [Table Component]({{ site.baseurl }}{% link _pages/dev/components/shared-components/split-view.md%}).

**MAKE SURE THE ABOVE LINK IS CORRECT!**

### Cell Components

Several implementations of `CellComponent` have been defined in the Organization library that apply to tables and subtables, as follows:

- `ToggleLinkCellComponent` allows toggling of branches on the units list and sets styles for the depth level
- `AssignCellComponent` is used to allow assigning or unassigning of items
- `ActiveLinkCellComponent` displays the name and makes the whole row into a link
- `AmountCellComponent` displays the budget combined with the currency
- `DateRangeCellComponent` displays the combined start and end date for budget
- `LimitCellComponent` shows the purchase limit, depending on `orderApprovalPermissionType`
- `RolesCellComponent` displays user roles in a specified way
- `StatusCellComponent` is used for displaying the colorable status of an active flag
- `UnitCellComponent` displays information about the unit of the current item
- `LinkCellComponent` provides a link for nested views (such as address)
- `UnitUserRolesCellComponent` is a personalized link for the open roles view

## Local Message Component

Messages in the Organization library similarly to global messages, but are displayed directly in the component of the subject they are related to. For normal cases, Spartacus uses `NotificationMessageComponent` to display information about the success or failure of an action. The `ConfirmationMessageComponent` is designed to ask a question that ensures users are aware of any consequences that may result from their actions. The `ConfirmationMessageComponent` is used in the `ToggleStatusComponent` and `DeleteItemComponent`, for example.

## Core

### Guards

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

### Adapters

List of adapters:
`BudgetAdapter, OrgUnitAdapter, UserGroupAdapter, PermissionAdapter, CostCenterAdapter, B2BUserAdapter`

More information about adapters is available [here.](https://sap.github.io/spartacus-docs/connecting-to-other-systems/#adapter)

### Convertors

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

#### Example

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
