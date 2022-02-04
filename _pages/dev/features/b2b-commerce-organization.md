---
title: B2B Commerce Organization
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

The following sections describe how to customize and configure the Spartacus Organization feature library. For information about using B2B Commerce Organization in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "b2b-commerce-organization-tutorial.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/using/commerceorg/landing-page/b2b-commerce-organization-tutorial.md%}).

For in-depth information on this feature, see [Commerce Organization](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

B2B Commerce Organization requires the Organization feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

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

For more information on overriding routes, see [{% assign linkedpage = site.pages | where: "name", "route-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md%}).

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

All of the list components in the Organization library use split view, which means all the components inside the split view component are ordered in a nested hierarchy. As a result, even small changes require overwriting the entire configuration. For more information, see [{% assign linkedpage = site.pages | where: "name", "split-view.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/shared-components/split-view.md%}).

For more information on overriding CMS configurations, see [{% assign linkedpage = site.pages | where: "name", "customizing-cms-components.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/customizing-cms-components.md%}).

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

For more information, see [{% assign linkedpage = site.pages | where: "name", "table-component.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/shared-components/table-component.md %}).

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

## Guards

Spartacus provides an `AdminGuard` that verifies that a logged-in user has permissions to see the commerce organization pages. By default, the guard redirects to the organization home page and displays a warning message.

For more information on guards, see [Guarding Components]({{ site.baseurl }}/customizing-cms-components/#guarding-components).

## Models

The following core models are used in the Organization library:

- `Address`
- `Currency`
- `B2BApprovalProcess`
- `B2BUserRole`
- `OrderApprovalPermissionType`

The following core models are used for structure:

- `ListModel`
- `SearchConfig`
- `StateUtils`  

The models are augmented from core models:

- `B2BUnit`
- `B2BUser`
- `CostCenter`

The following are dedicated models for the Organization library:

- `B2BUnitNode`
- `Budget`
- `Permission`
- `Period`
- `UserGroup`

The following models are use for processes:

- `LoadStatus`
- `OrganizationItemStatus`

The following model is used for components:

- `B2BUnitTreeNode`

## OCC

You can see all the endpoints that the Organization library makes use of in `feature-libs/organization/administration/occ/config/default-occ-organization-config.ts`.

For more information, see [Configuring Endpoints]({{ site.baseurl }}/connecting-to-other-systems/#configuring-endpoints).

## Adapters

The following adapters are used in the Organization library:

- `BudgetAdapter`
- `OrgUnitAdapter`
- `UserGroupAdapter`
- `PermissionAdapter`
- `CostCenterAdapter`
- `B2BUserAdapter`

For more information, see [Adapter]({{ site.baseurl }}/connecting-to-other-systems/#adapter)

## Converters

The Organization library uses the following core serializers:

- `ADDRESS_SERIALIZER`
- `COST_CENTER_SERIALIZER`

The following are serializers in the Organization library:

- `BUDGET_SERIALIZER`
- `B2B_USER_SERIALIZER`
- `B2BUNIT_SERIALIZER`
- `PERMISSION_SERIALIZER`
- `USER_GROUP_SERIALIZER`

The Organization library uses the following core normalizers:

- `COST_CENTERS_NORMALIZER`
- `COST_CENTER_NORMALIZER`

The following are normalizers in the Organization library:

- `BUDGET_NORMALIZER`
- `BUDGETS_NORMALIZER`
- `B2BUNIT_NORMALIZER`
- `B2BUNIT_NODE_NORMALIZER`
- `B2BUNIT_NODE_LIST_NORMALIZER`
- `B2BUNIT_APPROVAL_PROCESSES_NORMALIZER`
- `USER_GROUP_NORMALIZER`
- `USER_GROUPS_NORMALIZER`
- `PERMISSION_NORMALIZER`
- `PERMISSIONS_NORMALIZER`
- `PERMISSION_TYPE_NORMALIZER`
- `PERMISSION_TYPES_NORMALIZER`
- `B2B_USER_NORMALIZER`
- `B2B_USERS_NORMALIZER`

For more information, see [Converter]({{ site.baseurl }}/connecting-to-other-systems/#converter).

## Store

The following are standard behaviors in the Organization library:

- Every `PATCH` and `POST` action cleans the entire state of the Organization library to ensure that Spartacus always has data that is up-to-date.
- Components and their services have the responsibility of routing redirects.
- In facades, Spartacus tries to load data only if the data were not already loaded.

The following are exceptions:

- Spartacus avoids cleaning users list when an approver is assigned or unassigned for a user. This is to avoid a race condition in split view.
- The ID is missing when a user is being created, and as a result, some routing redirects are applied directly in effects.

Spartacus stores everything related to Organization in entities and lists of IDs separately. Associated data for a subsection is stored with its own feature, but for specific views, Spartacus uses a combination of ID and query parameters to store a list of IDs and other information.

You can see how this is implemented in Spartacus in `feature-libs/organization/administration/core/store/organization-state.ts`.

The following is an example of the user group structure:

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

The various elements in the structure are described as follows:

- `entities` stores real user group objects, which are key mapped to status flags and values
- `list` stores a list of user groups IDs for specified pages, with keys based on query parameters, such as `pagination` and `sorts`
- `customers` stores IDs for a subsection, with keys based on the ID of the user group and query parameters
- `permisions` stores IDs for a subsection, with keys based on the ID of the user group and query parameters
- `pageSize=2147483647` indicates that Spartacus fetches all possible items, up to the maximum safe Java integer

For more information, see [{% assign linkedpage = site.pages | where: "name", "loader-meta-reducer.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/loader-meta-reducer.md %}).

## Homepage

The Organization homepage contains a set of links that allow users to access all of the My Company functionality.

All of the links on the Organization homepage correspond to standard banner components that are created in the back end.

### Adding a New Banner

The easiest way to add new links to the Organization homepage is to create a new **Banner Component** in Backoffice, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS**, and then **Component**.

    A list of components is displayed.

1. Above the list of components, click on the down-arrow next to the plus (`+`) icon, select **Abstract Banner Component**, and then **Banner Component**.

    The **Create New Banner Component** dialog is displayed.

1. Select the **Catalog Version**, provide an ID in the **ID** field, and then click **Done**.

1. Select the new component.

    It should appear at the top of the **Components** list, but you may have to refresh the view before it appears (for example, you could click on any other entry in the Backoffice navigation sidebar, and then return to **Components**).

1. Once you have selected your new component, click on the **Administration** tab.

1. In the **Unbound** section of the **Administration** tab, fill in the following fields:

   - **Headline** is title of the link.
   - **Content** is the text displayed below link title.
   - **Media** is a reference to a specific media object that has been added to the media library. In this case, it is used to define a banner icon. For more information, see [Adding a Custom Icon]({{ site.baseurl }}#adding-a-custom-icon), below.
   - **URL link** is the target URL address.

1. Click the **Content Slots** tab and select **My Company Slot**.

    This allows you display the new banner by assigning it to an appropriate content slot.

### Hiding a Banner

The easiest way to hide a banner is to set the component visibility to **False** in Backoffice, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS**, and then **Component**.

    A list of components is displayed.

1. Select the banner component assigned to **My Company Slot** that you want to hide.

1. Click the **Properties** tab and set the **Visible** radio button to **False**.

### Adding a Custom Icon

You can upload any image file and use it as an icon in the banner link, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **Multimedia**, and then **Media**.

1. Click the plus (`+`) icon.

    The **Create New Media** dialog appears.

1. Fill in the **Identifier** field, specify a **Catalog version**, and then click **Next**.

    You now see the **Content: Upload media content** step.

1. Upload the image you want to use, click **Next** if you want to define additional properties, then click **Done**.

    When you are creating a new banner, you can now select this image in the **Media** field to use as an icon in the banner link, as described in [Adding a New Banner]({{ site.baseurl }}#adding-a-new-banner), above.

## Styles

If you want to override the default Organization styles, first ensure that the `organization.scss` file is generated properly by schematics, or else you can add your own. Your `angular.json` file should include the following path in the build styles:

```ts
"styles": [
  "src/styles.scss",
  "src/styles/spartacus/organization.scss"
],
```

In `src/styles/spartacus/organization.scss`, you should import the Organization styles, and then you can add your own styles below. The following is an example:

```ts
@import "@spartacus/organization";

// Your custom styles
%organizationList {
    cx-org-toggle-link-cell {
        button.tree-item-toggle {
            background-color: blue;
        }
    }
}
```

For more information, see [Component Styles]({{ site.baseurl }}/css-architecture/#component-styles).

## Translations

Organization translation resources can be overridden following the same rules as for other Spartacus chunks. The following is an example:

{% raw %}

```ts
provideConfig({
  i18n: {
    resources: organizationTranslations,
    chunks: organizationTranslationChunksConfig,
  },
}),
provideConfig({
  i18n: {
    resources: {
      en: {
        organization: {
          organization: { // general chunks
            enabled: 'Enabled',
          },
          orgUserGroup: { // specified sub-feature chunks
            header: 'List of user groups ({{count}})',
          }
        },
      },
    },
  },
}),
```

{% endraw %}

For more information, see [Extending Translations]({{ site.baseurl }}/i18n/#extending-translations).
