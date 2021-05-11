---
title: CPQ Configurable Products Integration
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.1x {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The CPQ Configurable Products integration provides the user interface (UI) for configuring and selling configurable products that have been modeled using *SAP CPQ Integration for Configurable Products* and the associated configuration engine. Note that the Spartacus library does not include SAP CPQ itself.

The initial version of the Spartacus library for *SAP CPQ Integration for Configurable Products* includes the following features:

- Bundling and guided-selling scenarios, where the bundle in SAP Commerce contains simple (non-configurable) products. The dependencies within this bundle are controlled by the underlying CPQ configurable product 
- Single-level configurable products in your Spartacus storefront where the product model resides in SAP CPQ
- Configuration page with the most commonly used attribute types (see [Supported Attribute Types and Display Types](#supported-attribute-types-and-display-types)), especially attributes that are linked to a (non-configurable) product
- Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the overall total price of the configured product
- Overview page with all user selections accessible at any time during configuration
- CPQ messages displayed in the SAP Commerce storefront in case of conflicts
- Configurable bundles are part of storefront processes such as catalog browsing, product detail page, add to cart, checkout, and order history

For more information about the underlying functionality and for features that are currently not supported, see [SAP CPQ Integration for Configurable Products](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/latest/en-US) on SAP Help Portal.

## Requirements

The CPQ Configurable Products integration requires the following releases of SAP Commerce Cloud:

- SAP Commerce Cloud 2005 (minimum) or 2011 (recommended)
- SAP Commerce Cloud, Integration Extension Pack 2005.2 (minimum) or 2102 (recommended)

If you want to use the minimum required releases, make sure that you have read the information at [Cart and Checkout Validation](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/2005/en-US/69abc7f904b14d6a999ae00f274d3d2d.html) on SAP Help Portal.

The CPQ Configurable Products integration also requires the following extension to work:

- `cpqproductconfigocc`

For more information, see [Configurator for Complex Products Module](https://help.sap.com/viewer/bad9b0b66bac476f8a4a5c4a08e4ab6b/latest/en-US/0be43a427ee74bce9222c9b42d56844c.html) on SAP Help Portal.

## Installation

1. Follow the instructions at [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).
After running `ng add @spartacus/schematics`, you'll be asked to select a number of optional features.
1. Select **Product Configurator**.
The system will ask which product configurator features you want to set up besides variant configurator.
1. Select **CPQ configurator** only if you have integrated [SAP CPQ Integration for Configurable Products](https://help.sap.com/viewer/347450bd6a3d49a9a266964b6c618ca5/latest/en-US).
1. Select **Textfield configurator** if you have products that are configurable in the sense of the textfield template configurator. For more information, see [Text Field Configurator Template Module](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/d558fab75a454ae4928a2c63e22abe2b.html).

**Note:** At runtime, most of the configurator library is lazy loaded when the configurator is first loaded. This is done for performance reasons.



## Early Login

Early login is mandatory. For more information, see [Early Login]({{ site.baseurl }}{% link _pages/dev/routes/early-login.md %}).

## Supported Attribute Types and Display Types

The following CPQ attributes types are supported on the UI:

- User input or computed - string
- User input or computed - number
- User selection
- User selection with quantity for each attribute value
- User selection with attribute quantity input

The following CPQ display types are supported on the UI:

- Checkbox
- Dropdown
- Radio button
- Free input, no matching (string or number)

## Handing of Quantity on Attribute and Value Level

### Multiselect Attributes

For multiselect attributes (checkbox list) that are line items, quantities are supported both on attribute and on value level. Multiselect attributes that are non-line items cannot have quantities on value level, only on attribute level.

### Single-Select Attributes

For single-select attributes (radio button group, DDLB), only quantities on attribute level are supported. Any quantities have been defined on value level for the attribute in CPQ product administration, they will be ignored on the UI.

## Price on Attribute Value Level

The display of prices for individual options or attribute values is initially only supported for bundle items (attributes linked to products).

Note that a simple attribute value (non-bundle item) can still have a price attached to it that is considered correctly in the price calculation on the bottom of the page. However, the price will initially not be displayed together with the attribute.

## Text Labels for Attributes 

The attribute label on the configuration screen displays the content of the attribute's **Custom Label** in CPQ. You can find this field in CPQ product administration for the attribute:

1. Choose **Product Catalog** > **Products**.
1. On the **Attributes** tab, choose the attribute that you want to edit.

If the **Custom Label** field is blank, the standard label will be **Choose** or **Select** followed by the attribute name.
If you want to display only the attribute name without the word "Choose" in front of it, enter the attribute name in the **Custom Label** field.

## Translations for Product Texts on the UI

Product texts coming from the CPQ product model are translated on the Commerce UI if the translations are maintained in CPQ. However, there are a few exceptions.

The following translations are currently not displayed on the Commerce UI but are instead shown in English:
- Standard labels **Choose** and **Select**, as well as standard label **No option selected**
- Error and validation messages coming from CPQ
- Product names in the cart summary

## Product ID (Article Number) in SAP Commerce

Note that in SAP Commerce, product IDs (article numbers) cannot contain slashes, backslashes, encoded slashes (`%2F`), or encoded backslashes (`%5C`). If necessary, adjust the product IDs in CPQ accordingly. 

## Group Status Handling

Group status handling on the CPQ Spartacus UI is different from the Spartacus UI for SAP Variant Configuration and Pricing. The CPQ Spartacus group menu only shows whether are "complete" in the sense that no mandatory fields are missing. The group menu doesn't provide any information about conflicts at group level. At this point, CPQ Spartacus doesn't even know whether a group is consistent (no conflicts) for the *current* group. This information isn't even known for the attribute itself.

Note that the group status is reset once the product has been added to the cart. If the user edits the configuration coming from the cart, the display for the group status is initially empty again, even if some of the mandatory attributes were not filled when the product was added to the cart.

## Resolving Issues

**Resolve Issues** only leads to the first incomplete group for which mandatory fields are missing.

In CPQ, conflicts are rendered as messages. Consequently, there is no conflict solving with generated conflict groups or navigation to conflicting attributes through **Resolve Issues**.

## Error and Warning Messages

CPQ can generate different kinds of messages, which cause the following responses on the SAP UI.

| CPQ Message Type | Counted Towards Total Number of Issues? | Message Shown on UI in Global Message Area? | UI Message Type |
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

- In CPQ, the attribute value has been linked to a product. 
- In CPQ, the attribute has been marked as line item.

Note that currently in the cart summary, the product names for line items come from CPQ, not from SAP Commerce. In contrast, product names for bundle items on the configuration page come from SAP Commerce. To avoid differing product names for bundle items between the configuration and overview page on the one hand and the cart summary on the other hand, we recommend that you use the identical product name both in CPQ and in SAP Commerce.

## Cart Validation

Cart validation is currently not supported, although you can implement your own workaround as follows:

### Necessary Adjustments in Spartacus

- Introduce your own version of `cart-totals.component.ts` and ensure that it is assigned to the `CartTotalsComponent` CMS component instead of the original one
- Inject `ConfiguratorCartService` from `@spartacus/product/configurators/common` into the custom version of `cart-totals.component`
- Introduce a component member. The following is an example:

    ```ts
    hasNoConfigurationIssues$: Observable<
        boolean
      > = this.configuratorCartService
        .activeCartHasIssues()
        .pipe(map((hasIssues) => !hasIssues));
    ```

- Make use of this member in the component template. The following is an example:

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

### Necessary Adjustments in SAP Commerce 2005 and 2011

The steps that can be done on Spartacus side ensure that for a standard UI flow, configurations with issues cannot be ordered. However, it's still necessary to block the creation of orders via OCC. Otherwise, an order containing such configurations can be created using e.g. the developer tools in the end-user's browser. Therefore, two further changes are necessary for SAP Commerce.

Note that although the order will be checked for product configuration issues before it is submitted, any error message that is returned may not reflect the actual error. The error message will state that the issue is because of low stock.

#### Enhance B2BOrdersController

The `validateCart` method in `B2BOrdersController` needs to be enhanced or replaced with a custom version. Cart validation is rudimentary and does not call the standard cart validation like the B2C case. The new method should look as follows.

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

### Necessary Adjustments in SAP Commerce 2005

#### Adjust CartValidation Strategy
    
In your spring configuration, see that bean commerceWebServicesCartService refers to cartValidationStrategy instead of cartValidationWithoutCartAlteringStrategy. This can be achieved, for example, in the `spring.xml` of a custom extension, as follows:

```xml
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
  <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
  <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

## Commerce Business Rules in Combination with CPQ Configurable Products

Commerce business rules that are specific to product configuration (for example, hiding a certain value if another value is selected) do not work for CPQ configurable products.

Other Commerce business rules (such as those for promotions) still work and apply (for example, 2% off if the cart value exceeds 4000 USD).

