---
title: CPQ Configurable Products Integration
feature:
- name: CPQ Configurable Products Integration
  spa_version: 3.3
  cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The CPQ Configurable Products integration provides a user interface in Spartacus for configuring and selling configurable products that have been modeled using *SAP CPQ Integration for Configurable Products* and the associated configuration engine. Note that the Spartacus library does not include SAP CPQ itself.

The initial version of the Spartacus library for *SAP CPQ Integration for Configurable Products* includes the following features:

- Bundling and guided-selling scenarios, where the bundle in SAP Commerce contains simple (non-configurable) products. The dependencies within this bundle are controlled by the underlying CPQ configurable product.
- Single-level configurable products in your Spartacus storefront where the product model resides in SAP CPQ.
- A configuration page with the most commonly used attribute types, especially attributes that are linked to a (non-configurable) product. For more information, see [Supported Attribute Types and Display Types](#supported-attribute-types-and-display-types).
- A price summary at the bottom of the configuration page that includes the base price, the price of the selected options, and the overall total price of the configured product.
- An overview page with all user selections accessible at any time during configuration.
- CPQ messages that are displayed in the Spartacus storefront in case of conflicts.

With this integration, configurable bundles become a part of the storefront's standard processes, such as catalog browsing, viewing product details pages, adding items to the cart, checking out, and viewing order history pages.

For more information about the underlying functionality, and for information about features that are currently not supported, see [SAP CPQ Integration for Configurable Products](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/latest/en-US) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

The CPQ Configurable Products integration requires the `cpqproductconfigocc` extension. For more information, see [Configurator for Complex Products Module](https://help.sap.com/viewer/bad9b0b66bac476f8a4a5c4a08e4ab6b/latest/en-US/0be43a427ee74bce9222c9b42d56844c.html) on the SAP Help Portal.

The CPQ Configurable Products integration also requires the following releases of SAP Commerce Cloud:

- SAP Commerce Cloud 2005 (minimum) or 2011 (recommended)
- SAP Commerce Cloud, Integration Extension Pack 2005.2 (minimum) or 2102 (recommended)

If you want to use the minimum required releases, make sure that you have read [Cart and Checkout Validation](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/2005/en-US/69abc7f904b14d6a999ae00f274d3d2d.html) on the SAP Help Portal.

## Adding the CPQ Configurable Products Integration to Spartacus

To add the CPQ Configurable Products integration to Spartacus, you install the `@spartacus/product-configurator` library.

You can either [install the product configurator library during initial setup of your Spartacus project](#installing-the-product-configurator-library-during-the-initial-setup-of-spartacus), or you can [add the product configurator library to an existing Spartacus project](#adding-the-product-configurator-library-to-an-existing-spartacus-project).

### Installing the Product Configurator Library During the Initial Setup of Spartacus

1. Follow the steps for setting up your Spartacus project, as described in [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).
1. While setting up your project using schematics, when you are asked which Spartacus features you would like to set up, choose `Product Configurator - CPQ Configurator (b2b feature)`.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

### Adding the Product Configurator Library to an Existing Spartacus Project

If you already have a Spartacus project up and running, you can add the product configurator library to your project by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/product-configurator
```

This command uses schematics to modify your application and add the modules needed to launch the library.

After running this command, you are asked which product configurator features you would like to set up. Choose `Product Configurator - CPQ Configurator (b2b feature)`.

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

## Early Login

Early login is mandatory. For more information, see [{% assign linkedpage = site.pages | where: "name", "early-login.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/early-login.md %}).

## Supported Attribute Types and Display Types

The following CPQ attributes types are supported in the storefront:

- User input or computed (string)
- User input or computed (number)
- User selection
- User selection with quantity for each attribute value
- User selection with attribute quantity input

The following CPQ display types are supported in the storefront:

- Checkbox
- Dropdown
- Radio button
- Free input, no matching (string or number)

## Handling of Quantity on Attribute and Value Level

### Multiselect Attributes

For multiselect attributes (checkbox list) that are line items, quantities are supported both on attribute level and on value level. Multiselect attributes that are non-line items cannot have quantities on the value level. They can only have quantities on the attribute level.

### Single-Select Attributes

For single-select attributes (radio button group, DDLB), only quantities on the attribute level are supported. Any quantities that have been defined on the value level for the attribute in CPQ product administration are ignored in the UI.

## Price on Attribute Value Level

The display of prices for individual options or attribute values is supported for both bundle items (attributes linked to products) and for simple attribute values (non-bundle items).

If the attribute value allows a quantity to be entered, the resulting price is displayed in the form of a formula (for example, `3x70 EUR = 210 EUR`).

When a price-relevant attribute value is selected, the price of the attribute value is added to the total price of the product.

**Note:** Currently, you can display the price information for attribute values only as an absolute (non-dynamic) price, not as a delta price. This means that the same price is always displayed next to the attribute value, regardless of whether the attribute value is selected.

## Text Labels for Attributes

The attribute label on the configuration screen displays the content of the attribute's **Custom Label** in CPQ. You can find this field for the attribute in CPQ product administration, as follows:

1. Choose **Product Catalog** > **Products**.
1. On the **Attributes** tab, choose the attribute that you want to edit.

If the **Custom Label** field is blank, the standard label will be **Choose** or **Select**, followed by the attribute name.
If you want to display only the attribute name without the word "Choose" in front of it, enter the attribute name in the **Custom Label** field.

## Translations for Product Texts in the UI

Product texts coming from the CPQ product model are translated in the Spartacus storefront if the translations are maintained in CPQ. However, there are a few exceptions.

The following translations are currently not displayed in the Spartacus storefront, but are instead shown in English:

- Standard labels **Choose** and **Select**, as well as standard label **No option selected**
- Error and validation messages coming from CPQ
- Product names in the cart summary

## Product ID (Article Number) in SAP Commerce

In SAP Commerce, product IDs (article numbers) cannot contain slashes, backslashes, encoded slashes (`%2F`), or encoded backslashes (`%5C`). If necessary, adjust the product IDs in CPQ.

## Group Status Handling

Group status handling in the CPQ Spartacus UI is different from the Spartacus UI for SAP Variant Configuration and Pricing. The CPQ Spartacus group menu only shows whether orders are "complete" in the sense that no mandatory fields are missing. The group menu does not provide any information about conflicts at the group level. Currently, CPQ Spartacus does not know whether a group is consistent (no conflicts) for the *current* group. This information also is not known for the attribute itself.

**Note:** The group status is reset once the product has been added to the cart. If the user edits the configuration coming from the cart, the display for the group status is initially empty again, even if some of the mandatory attributes were not filled when the product was added to the cart.

## Resolving Issues

**Resolve Issues** only leads to the first incomplete group for which mandatory fields are missing.

In CPQ, conflicts are rendered as messages. Consequently, there is no conflict solving with generated conflict groups, nor navigation to conflicting attributes through **Resolve Issues**.

## Error and Warning Messages

CPQ can generate different kinds of messages, which cause the following responses in Spartacus.

| CPQ Message Type | Counted Towards Total Number of Issues | Message Shown in Global Message Area | UI Message Type |
|----------------- | --------------------------------------- | --------------------------------------------|-----------------|
| Incomplete attributes | Yes | No | N/A |
| Incomplete messages   | Yes | Yes | ERROR |
| Error messages | Yes | Yes | ERROR |
| Conflict messages | Yes | Yes | ERROR |
| Invalid messages | Yes | Yes | Error |
| Failed validations | Yes | Yes | WARNING |

## Bundle Item Product Not Available in Commerce

If a bundle item cannot be found in SAP Commerce, only the product ID is displayed. Information about the bundle item (such as a picture or description) is not shown. This may occur if there are issues with master data replication.

## Cart Summary

When added to the cart, the CPQ bundle product results in a single cart item entry. There are no subitems representing the products contained in the bundle. However, to give customers an overview of their selections and to confirm what exactly they are buying, the information in the cart has been extended to show the list of products that have been selected inside the bundle. The list contains the product description, the quantity, and the item price if these are maintained in CPQ.

The following prerequisites apply for a product to appear in the cart summary:

- In CPQ, the attribute value has been linked to a product
- In CPQ, the attribute has been marked as line item

**Note:** Currently in the cart summary, the product names for line items come from CPQ, not from SAP Commerce. In contrast, product names for bundle items on the configuration page come from SAP Commerce. To avoid differing product names for bundle items between the configuration and overview page on the one hand, and the cart summary on the other hand, it is recommended that you use identical product names in both CPQ and SAP Commerce.

## Cart Validation

Cart validation is currently not supported, although you can implement your own workaround by making the adjustments described in the following sections.

### Configuring Spartacus for Cart Validation

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

### Configuring SAP Commerce 2005 and 2011 for Cart Validation

The steps that can be done on the Spartacus side ensure that for a standard UI flow, a configuration cannot be ordered if it has issues. However, you still need to block the creation of orders that could be done through OCC. Otherwise, an order containing such configurations can be created using, for example, the developer tools in the end user's browser. It is therefore necessary to make the adjustments described in this section if you are using SAP Commerce 2011, and to make the adjustments described in this section and the following section if you are using SAP Commerce 2005.

Note that these adjustments will guarantee that orders are validated for product configuration issues before they are submitted, but it will not ensure that any error message that is returned reflects the actual issue. The error message will state that the issue is because of low stock.

#### Enhance B2BOrdersController

The `validateCart` method in `B2BOrdersController` needs to be enhanced or replaced with a custom version. Cart validation is rudimentary and does not call the standard cart validation that is used in regular B2C scenarios. The new method should look like the following example:

```ts
protected void validateCart(final CartData cartData) throws InvalidCartException
{
    final Errors errors = new BeanPropertyBindingResult(cartData, "sessionCart");
    placeOrderCartValidator.validate(cartData, errors);
    if (errors.hasErrors())
    {
        throw new WebserviceValidationException(errors);
    }
 
    try
    {
        final List<CartModificationData> modificationList = cartFacade.validateCurrentCartData();
        if(CollectionUtils.isNotEmpty(modificationList))
        {
            final CartModificationDataList cartModificationDataList = new CartModificationDataList();
            cartModificationDataList.setCartModificationList(modificationList);
            throw new WebserviceValidationException(cartModificationDataList);
        }
    }
    catch (final CommerceCartModificationException e)
    {
        throw new InvalidCartException(e);
    }
}
```

### Configuring SAP Commerce 2005 for Cart Validation

In your spring configuration, ensure that the `commerceWebServicesCartService` bean refers to `cartValidationStrategy` instead of `cartValidationWithoutCartAlteringStrategy`. This can be achieved, for example, in the `spring.xml` of a custom extension, as follows:

```xml
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
  <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
  <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

## Commerce Business Rules in Combination with CPQ Configurable Products

Commerce business rules that are specific to product configuration (for example, hiding a certain value if another value is selected) are not supported for CPQ configurable products.

Other Commerce business rules (such as those for promotions) still work and apply (such as, 2% off if the cart value exceeds $4,000 USD, for example).

## Browser Refresh

When you refresh the browser, the product configuration is reset to the default configuration. You therefore have to reconfigure your products after reloading the page.

## Cart Import and Export

Cart import and export is currently not supported with the CPQ Configurable Products integration.
