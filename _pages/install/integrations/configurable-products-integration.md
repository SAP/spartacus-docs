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

The Configurable Products integration requires SAP Commerce Cloud release **2105** or newer.

The integration also requires the `sapproductconfigocc` extension.

For more information, see [Configurator for Complex Products Module](https://help.sap.com/viewer/bad9b0b66bac476f8a4a5c4a08e4ab6b/latest/en-US/0be43a427ee74bce9222c9b42d56844c.html) on the SAP Help Portal.

## Adding the Configurable Products Integration to Spartacus

To add the Configurable Products integration to Spartacus, you install the `@spartacus/product-configurator` library.

You can either [install the product configurator library during initial setup of your Spartacus project](#installing-the-product-configurator-library-during-the-initial-setup-of-spartacus), or you can [add the product configurator library to an existing Spartacus project](#adding-the-product-configurator-library-to-an-existing-spartacus-project).

### Installing the Product Configurator Library During the Initial Setup of Spartacus

1. Follow the steps for setting up your Spartacus project, as described in [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).
1. While setting up your project using schematics, when you are asked which Spartacus features you would like to set up, choose `Product Configurator - Variant Configurator`.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

### Adding the Product Configurator Library to an Existing Spartacus Project

If you already have a Spartacus project up and running, you can add the product configurator library to your project by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/product-configurator
```

This command uses schematics to modify your application and add the modules needed to launch the library.

After running this command, you are asked which product configurator features you would like to set up. Choose `Product Configurator - Variant Configurator`.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

## Early Login

You must have early login enabled to be able to use the configurable products integration with Spartacus. For more information, see [{% assign linkedpage = site.pages | where: "name", "early-login.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/early-login.md %}).

## Supported Attribute Types

The following attributes types are supported in Spartacus:

|Attribute Type|Technical Representation in de.hybris.platform.sap.productconfig.facades.UiType|
|------------|-----------|
|User input (string)|STRING|
|User input (numeric)|NUMERIC|
|Boolean value|CHECKBOX|
|Single selection, rendered as radio button group|RADIO_BUTTON|
|Single selection, rendered as radio button group, with additional input|RADIO_BUTTON_ADDITIONAL_INPUT|
|Single selection, rendered as drop down listbox|DROPDOWN|
|Single selection, rendered as drop down listbox, with additional input |DROPDOWN_ADDITIONAL_INPUT|
|Single selection, rendered as image list|SINGLE_SELECTION_IMAGE|
|Read-only |READ_ONLY|
|Multi selection, rendered as checkbox list|CHECKBOX_LIST|
|Multi selection, rendered as image list|MULTI_SELECTION_IMAGE|

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

## Product Variants

{% capture version_note %}
{{ site.version_note_part1 }} 4.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

With Commerce Cloud 2205, the Spartacus UI supports the display and configuration of product variants, both fully and partially specified.

From a business point of view, product variants represent the configurations that sell best; vendors might want to have them in stock to make them readily available to customers at a favorable price. Web shop customers might prefer a matching product variant over an individually configured product, with a view to benefiting from shorter delivery times and more favorable prices.

For more information about product variants and how to set them up in the SAP Commerce Cloud, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/docs/SAP_COMMERCE_INTEGRATIONS/80c3212d1d4646c5b91db43b84e9db47/ecdb7e2f02124e6c816f029af1f6762e.html?version=2205)

## Saved Cart

{% capture version_note %}
{{ site.version_note_part1a }} 3.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The saved cart feature is generally supported with the Configurable Products integration. A saved cart can contain a configurable product and can be activated. After the cart is activated, the configuration can be accessed and edited. Note, however, that as long as the saved cart is not activated, the configuration of the configurable product cannot be displayed.

## Cart Validation

When cart validation is enabled, it ensures that users cannot check out a cart that has configurations which are conflicting, nor can users check out a cart that contains mandatory attributes if values have not been selected.

If you are using SAP Commerce Cloud 2005 or older, you should consider disabling the checkout button in `cart-proceed-to-checkout.component.html` if `ConfiguratorCartService#activeCartHasIssues` emits `true`.

To enable cart validation, see [{% assign linkedpage = site.pages | where: "name", "cart-validation.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-validation.md %}).

**Note:** Cart validation requires SAP Commerce Cloud 2011 or newer.

## Locales

All available locales must be replicated in Spartacus. Locales in the back end and front end must be in sync.

## Conflict Solver

The user navigation for solving conflicts is nearly the same as in Accelerator, except that in Spartacus, users are not yet guided from issue to issue. If a user is in a conflict group and the user changes a value, after the update, the UI displays the original group of the attribute that was changed. In other words, the user exits the conflict resolving context. This happens every time a value is changed in a conflict group, whether or not the conflict is resolved, and even if there are other conflicts that still need to be resolved.

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

## Retract Option for Single-Select Characteristics

By default, when making a selection for single-select characteristics in drop-down lists and radio button lists, users can change their selection, but they cannot simply undo it. This means that, depending on the product modeling, users could run into a deadlock situation that does not allow them to complete the configuration. To avoid this scenario, you can enable the "retract" feature in your Spartacus configuration that allows users to undo their selection, which they can do by selecting the special **No option selected** entry.

This feature is valuable if your product modeling relies on VC/AVC automatically generating a **No option selected** value. By enabling the retract feature, you can also have Commerce generate the additional **No option selected** value, if needed. In this case, the system interprets the characteristic as not having been selected.

You can activate the retract feature as follows:

```ts
productConfigurator: { 
    addRetractOption: true,
  } 
```

**Note:** You can customize the `No option selected` label of this entry, just as you can with any UI text in Spartacus.

Depending on the product modeling and the configuration engine, after the customer has retracted their selection, the default setting may be withdrawn with the attribute unselected, or the configuration engine may set a default selection.

If you do not activate the retract feature, a read-only value might get involved in a conflict, where users cannot change or undo their selection. In this case, you can allow customers to undo the selection under the following conditions:

- You have set the attribute in your model in the back end system as follows: `retractBlocked = false`
- The attribute setting has not been set by the system.

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

When you refresh the browser, if you are logged in, the product configuration is persisted. If you are not logged in, the product configuration is reset to the default configuration, and you therefore have to reconfigure your products after reloading the page.

## Performance and Session Affinity

To communicate with the configurator in a performant way, the Commerce Cloud back end caches session cookies that are sent to the configurator for every interaction. This allows the configurator to read a runtime configuration from its cache instead of from the database.

To ensure session affinity, Spartacus should always contact the same Commerce node when doing configuration reads and updates. You can ensure session affinity by setting the following configuration parameters:

- In SAP Commerce Cloud: `corsfilter.commercewebservices.allowCredentials=true`
- In Spartacus: `backend.occ.useWithCredentials=true`

## Unsupported Features

The following features are currently not supported (or in some cases, not fully supported) in the Configurable Products integration with Spartacus:

- [Save for Later and Selective Cart](#save-for-later-and-selective-cart)
- [Commerce Business Rules in Combination with Configurable Products](#commerce-business-rules-in-combination-with-configurable-products)
- [Assisted Service Mode](#assisted-service-mode)
- [Cart Import and Export](#cart-import-and-export)

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

### Cart Import and Export

Cart import and export is currently not supported with the Configurable Products integration.
