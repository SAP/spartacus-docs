---
title: Configurable Products Integration
feature:
- name: Configurable Products Integration
  spa_version: 3.1
  cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Configurable Products integration provides a user interface for configuring and selling configurable products in Spartacus. The integration makes use of the *Product Configuration with SAP Variant Configuration and Pricing* AddOn, which is part of SAP Commerce Cloud. This AddOn is not included in the Spartacus libraries.

The Spartacus product configuration library includes the following features:

- Single-level and multilevel configurable products in the Spartacus storefront, with the product model residing in SAP ERP or SAP S/4HANA
- A configuration page, with the most commonly used characteristic types for characteristic values, such as radio buttons, checkboxes, dropdown listboxes, and images
- A price summary at the bottom of the configuration page that includes the base price, the price of the selected options, and the overall total price of the configured product
- An overview page with all user selections accessible at any time during configuration
- Basic conflict handling

With this integration, configurable products become a part of the storefront's standard processes, such as catalog browsing, viewing product details pages, adding items to the cart, checking out, and viewing order history pages.

For more information, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/latest/en-US/528b7395bc314999a01e3560f2bdc069.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

The Configurable Products integration requires SAP Commerce Cloud release **2005.6** or **2011.1** or newer.

The integration also requires the `sapproductconfigocc` extension.

For more information, see [Configurator for Complex Products Module](https://help.sap.com/viewer/bad9b0b66bac476f8a4a5c4a08e4ab6b/latest/en-US/0be43a427ee74bce9222c9b42d56844c.html) on the SAP Help Portal.

## Adding the Configurable Products Integration to Spartacus

To add the Configurable Products integration to Spartacus, you install the `@spartacus/product-configurator` library.

You can either [install the product configurator library during initial setup of your Spartacus project](#installing-the-product-configurator-library-during-the-initial-setup-of-spartacus), or you can [add the product configurator library to an existing Spartacus project](#adding-the-product-configurator-library-to-an-existing-spartacus-project).

### Installing the Product Configurator Library During the Initial Setup of Spartacus

1. Follow the steps for setting up your Spartacus project, as described in [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries-3-2.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries-3-2.md %}).
1. While setting up your project using schematics, when you are asked which Spartacus features you would like to set up, choose `Product Configurator`.
1. Later in the setup, you are asked which product configurator features you would like to set up, other than the variant configurator, which is installed by default.

   Select `CPQ configurator` only if you have set up the CPQ integration for configurable products. For more information, see [SAP CPQ Integration for Configurable Products](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/latest/en-US) on the SAP Help Portal.

   Select `Textfield configurator` if you have products that can be configured using text-field-based configuration forms. For more information, see [{% assign linkedpage = site.pages | where: "name", "text-field-configurator-template.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/text-field-configurator-template.md %}) in the Spartacus documentation, and [Text Field Configurator Template Module](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/d558fab75a454ae4928a2c63e22abe2b.html) on the SAP Help Portal.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

### Adding the Product Configurator Library to an Existing Spartacus Project

If you already have a Spartacus project up and running, you can add the product configurator library to your project by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/product-configurator
```

This command uses schematics to modify your application and add the modules needed to launch the library.

After running this command, you are asked which product configurator features you would like to set up, other than the variant configurator, which is installed by default.

Select `CPQ configurator` only if you have set up the CPQ integration for configurable products. For more information, see [SAP CPQ Integration for Configurable Products](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/latest/en-US) on the SAP Help Portal.

Select `Textfield configurator` if you have products that can be configured using text-field-based configuration forms. For more information, see [{% assign linkedpage = site.pages | where: "name", "text-field-configurator-template.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/text-field-configurator-template.md %}) in the Spartacus documentation, and [Text Field Configurator Template Module](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/d558fab75a454ae4928a2c63e22abe2b.html) on the SAP Help Portal.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

## Configuring the Input Time for User Entries

For complicated user entries, it is possible that the system starts validating the entry before the user has finished typing. To avoid this, you can adjust the default input time of 500 ms in the customer app, as shown in the following example:

```ts
provideConfig(<Config>{
    productConfigurator: {
      updateDebounceTime: {        
        input: 2500         
      }
    },
  }),
```

## Saved Cart

{% capture version_note %}
{{ site.version_note_part1a }} 3.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The saved cart feature is generally supported with the Configurable Products integration. A saved cart can contain a configurable product and can be activated. After the cart is activated, the configuration can be accessed and edited. Note, however, that as long as the saved cart is not activated, the configuration of the configurable product cannot be displayed.

## Locales

All available locales must be replicated in Spartacus. Locales in the back end and front end must be in sync.

## Conflict Solver

For this initial (MVP) version of the Configurable Products integration, the user navigation for the conflict solver is still quite simple. For example, if a user is in a conflict group and the user changes a value, after the update, the UI displays the original group of the attribute that was changed. In other words, the user exits the conflict resolving context. This happens every time a value is changed in a conflict group, whether or not the conflict is resolved, and even if there are other conflicts that still need to be resolved.

For now, there is no navigation mode that guides the user from issue to issue until the configuration has no remaining issues. Instead, users have two options for navigating through conflicts, as described in the following procedures.

### Conflict Navigation Option 1

1. Click on **Resolve Conflict** for a specific, conflicting attribute.
1. Resolve the conflict.
1. Return to the group that contained the conflict.

### Conflict Navigation Option 2

1. Click on **Resolve Conflict** on the cart, the overview page, or the conflict group by using the group menu.
1. Resolve the conflict.
1. Navigate to the next conflict group.
1. Resolve the last conflict, after which, you are taken to the first group.

## RTL Support

Right-to-left (RTL) orientation is supported for product configuration in Spartacus. For more information on RTL support in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "directionality.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/directionality.md %}).

## Group Status Handling

Group statuses are interpreted as follows:

|Group Status|Combination|Description|
|------------|-----------|-----------|
|COMPLETE|Visited + Complete + Consistent|The group is considered complete if it has been visited and there are no incomplete characteristics or conflicts.|
|ERROR|Visited + Incomplete|The group gets an error icon if it has been visited and there are incomplete characteristics.|
|WARNING|Inconsistent|The group is considered inconsistent if there are conflicting characteristics within the corresponding group.|

The following is an example of the configuration menu showing visited sections, missing mandatory selections, and conflicts:

![Spartacus group status icon alignment]({{ site.baseurl }}/assets/images/ccp/spartacus-group-status-icon-alignment.png)

## Browser Refresh

When you refresh the browser, the product configuration is reset to the default configuration. You therefore have to reconfigure your products after reloading the page.

## Unsupported Features

The following features are currently not supported (or in some cases, not fully supported) in the Configurable Products integration with Spartacus:

- [Save for Later and Selective Cart](#save-for-later-and-selective-cart)
- [Cart Validation](#cart-validation)
- [Commerce Business Rules in Combination with Configurable Products](#commerce-business-rules-in-combination-with-configurable-products)
- [Assisted Service Mode](#assisted-service-mode)

### Save for Later and Selective Cart

This feature is currently not supported. To prevent the button from showing, you should remove the relevant view (disable selective cart), as follows:

1. Ensure that selective cart is disabled in the cart configuration.

    Your configuration should contain the following:

    ```ts
    cart: {
      selectiveCart: {
        enabled: false,
      },
    },
    ```

2. Deactivate the `saveForLater` component that is assigned to the `SaveForLaterComponent` CMS component, and introduce a new module that clears the assigned Spartacus components for that CMS component.

    The following is an example:

    ```ts
    @NgModule({
      imports: [CommonModule, I18nModule, CartSharedModule],
      providers: [
        provideDefaultConfig(<CmsConfig | FeaturesConfig>{
          cmsComponents: {
            SaveForLaterComponent: {},
          },
        }),
      ],
      declarations: [SaveForLaterComponent],
      exports: [SaveForLaterComponent],
      entryComponents: [SaveForLaterComponent],
    })
    ```

### Cart Validation

Cart validation is currently not supported, although you can implement your own workaround by making the adjustments described in the following sections.

#### Configuring Spartacus for Cart Validation

1. Introduce your own version of `cart-totals.component.ts` and ensure that it is assigned to the `CartTotalsComponent` CMS component instead of the original one.

1. Inject `ConfiguratorCartService` from `@spartacus/product-configurator/common` into the custom version of `cart-totals.component`.

1. Introduce a component member.

    The following is an example:

    ```ts
    hasNoConfigurationIssues$: Observable<
        boolean
      > = this.configuratorCartService
        .activeCartHasIssues()
        .pipe(map((hasIssues) => !hasIssues));
    ```

1. Make use of this member in the component template.

    The following is an example:

    {% raw %}

    ```ts
    <ng-container *ngIf="cart$ | async as cart">
      <ng-container *ngIf="entries$ | async as entries">
        <cx-order-summary [cart]="cart"></cx-order-summary>
        <ng-container
          *ngIf="hasNoConfigurationIssues$ | async as   hasNoConfigurationIssues"
        >
          <button
            [routerLink]="{ cxRoute: 'checkout' } | cxUrl"
            *ngIf="entries.length"
            class="btn btn-primary btn-block"
            type="button"
          >
            {{ 'cartDetails.proceedToCheckout' | cxTranslate }}
          </button>
        </ng-container>
      </ng-container>
    </ng-container>
    ```

    {% endraw %}

#### Configuring SAP Commerce 2005 for Cart Validation

**Note:** If you use SAP Commerce 2011, the following steps are not necessary.

The steps that can be done on the Spartacus side ensure that for a standard UI flow, a configuration cannot be ordered if it has issues. However, you still need to block the creation of orders that could be done through OCC. Otherwise, an order containing such configurations can be created using, for example, the developer tools in the end user's browser.

In your spring configuration, ensure that the `commerceWebServicesCartService` bean refers to `cartValidationStrategy` instead of `cartValidationWithoutCartAlteringStrategy`. This can be achieved, for example, in the `spring.xml` of a custom extension, as follows:

```xml
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
    <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
    <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

Note that this adjustment will guarantee that order are validated for product configuration issues before they are submitted, but it will not ensure that any error message that is returned reflects the actual issue. The error message will state that the issue is because of low stock. This should be addressed in SAP Commerce Cloud release 2011.

### Commerce Business Rules in Combination with Configurable Products

The following conditions and actions are supported in the Spartacus storefront:

- Conditions:
  - Product you are currently configuring
  - Customers
  - Customer groups
- Actions:
  - Set characteristic value for configurable product
  - Hide assignable value for configurable product
  - Hide characteristic for configurable product
  - Display characteristic for configurable product as read-only

The following conditions and actions are currently **not supported** in the Spartacus storefront:

- Conditions:
  - Product with specified configuration in the cart
  - Customer support (ASM mode currently not supported for configurable products)
- Actions:
  - Display message at the product level
  - Display message at the attribute level
  - Display message at the value level
  - Display promo message (promo applies)
  - Display promo opportunity message (promo does not yet apply)
  - Display discount message

### Assisted Service Mode

Assisted service mode (ASM) is currently not supported with the Configurable Products integration.
