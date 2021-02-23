---
title: Configurable Products Integration
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Configurable Products integration provides a user interface for configuring and selling configurable products in Spartacus. The integration makes use of the *Product Configuration with SAP Variant Configuration and Pricing* AddOn, which is part of SAP Commerce Cloud. This AddOn is not included in the Spartacus libraries.

The Spartacus product configuration library includes the following features:

- Single-level and multilevel configurable products in the Spartacus storefront, with the product model residing in SAP ERP or SAP S/4HANA
- A configuration page, with the most commonly used characteristic types, such as radio buttons, checkboxes, dropdown listboxes, and images, for characteristic values
- A price summary at the bottom of the configuration page, with the base price, the price of the selected options, and the overall total price of the configured product
- An overview page with all user selections accessible at any time during configuration
- Basic conflict handling
- An experience where configurable products become a part of the storefront's processes, such as catalog browsing, viewing product detail pages, adding to cart, checking out, and viewing order history pages.

For more information, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/latest/en-US/528b7395bc314999a01e3560f2bdc069.html) on the SAP Help Portal.

## Requirements

The Configurable Products integration requires release 2005 of SAP Commerce Cloud and the following extension to work:

- `sapproductconfigocc`

For more information, see [Configurator for Complex Products Module](https://help.sap.com/viewer/bad9b0b66bac476f8a4a5c4a08e4ab6b/latest/en-US/0be43a427ee74bce9222c9b42d56844c.html) on the SAP Help Portal.

## Adding the Configurable Products Integration to Spartacus

You must set up your Spartacus storefront before you can add the Configurable Products integration. For more information, see [Building the Spartacus Storefront Using 3.x Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

After you have set up your Spartacus storefront, install the product configuration library by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/product-configurator
```

This command uses schematics to modify your application and add the modules needed to launch the library.

**Note:** At runtime, most of the library is lazy loaded when the configurator is first loaded. This is done for performance reasons.

## Locales

All available locales must be replicated in Spartacus. Locales in the back end and front end must be in sync.

## Conflict Solver

If a user is in a conflict group and changes a value, after the update, the UI displays the original group of the attribute that was changed. In other words, the user exits the conflict resolving context. This happens every time a value is changed in a conflict group, whether or not changing the value resolves the conflict, and even if there are other conflicts that still need to be resolved. There is currently no "resolve issue" mode that guides the user from issue to issue until the configuration has no remaining issues.

## RTL Support

Right-to-left (RTL) orientation is supported for product configuration in Spartacus. For more information on RTL support in Spartacus, see [Directionality]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/directionality.md %})

## Group Status Handling

Group statuses are interpreted as follows:

|Group Status|Combination|Description|
|------------|-----------|-----------|
|COMPLETE|Visited + Complete + Consistent|The group is considered complete if it has been visited and there are no incomplete characteristics or conflicts.|
|ERROR|Visited + Incomplete|The group gets an error icon if it has been visited and there are incomplete characteristics.|
|WARNING|Inconsistent|The group is considered inconsistent if there are conflicting characteristics within the corresponding group. The default configuration can contain inconsistent groups. It means by entering such a configuration, a conflicting groups status should be displayed accordingly.|

### Navigation

When you are resolving a conflict in Spartacus, after the conflict group has been updated, you are taken to the non-conflict group where the updated characteristic is located, regardless of whether the conflict has been resolved.

This is different to how the conflict resolution navigation behaves in Accelerator. If you resolve a conflict directly in the conflict group in Accelerator, you are taken to the first conflict group or the first non-conflict group within the configuration. If the conflict has not been resolved, you remain in the corresponding conflict group until the conflict has been resolved, or you explicitly leave the conflict group.

In Spartacus, you have two options for navigating through conflicts, as described in the following procedures.

#### Conflict Navigation Option 1

1. Click on **Resolve Conflict** for a specific, conflicting attribute.
1. Resolve the conflict.
1. Return to the group that contained the conflict.

#### Conflict Navigation Option 2

1. Click on **Resolve Conflict** on the cart, the overview page, or the conflict group by using the group menu.
1. Resolve the conflict.
1. Navigate to the next conflict group.
1. Resolve the last conflict, after which, you are taken to the first group.

### Icon Alignment

The following is an example of the **Configuration Menu**, which is displaying errors and conflicts:

![Configuration menu showing errors and conflicts]({{ site.baseurl }}/assets/images/ccp/icon_alignment.png)

For reference, in the Accelerator, only a header of conflict groups gets a warning icon.

## Browser Refresh

When you refresh the browser, the product configuration is reset to the default configuration (unlike in the Accelerator). You therefore have to reconfigure your products after reloading the page.

## Features Not Supported in the Configurable Products Spartacus Integration

The following features are currently not supported in the Configurable Products integration with Spartacus:

- [Save for Later and Selective Cart](#save-for-later-and-selective-cart)
- [Cart Validation](#cart-validation)
- [Assisted Service Mode](#assisted-service-mode)

### Save for Later and Selective Cart

This feature is currently not supported. To prevent the button from showing, you should remove the relevant view (disable selective cart), as follows:

1. Ensure that in the cart configuration, selective cart is disabled. Your configuration should contain the following:

    ```ts
    cart: {
      selectiveCart: {
        enabled: false,
      },
    },
    ```

2. Deactivate the `saveForLater` component that is assigned to the `SaveForLaterComponent` CMS component, and introduce a new module that clears the assigned Spartacus components for that CMS component. The following is an example:

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

1. Inject `ConfiguratorCartService` from `@spartacus/product-configurator/common` into the custom version of `cart-totals.component`

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

#### Configuring SAP Commerce 2005 for Cart Validation

**Note:** If you use SAP Commerce 2011, the following steps are not necessary.

The steps that can be done on the Spartacus side ensure that for a standard UI flow, configurations with issues cannot be ordered. However, you still need to block the creation of orders via OCC. Otherwise, an order containing such configurations can be created using, for example, the developer tools in the end user's browser.

In your spring configuration, see that bean `commerceWebServicesCartService` refers to `cartValidationStrategy` instead of `cartValidationWithoutCartAlteringStrategy`. This can be achieved, for example, in the `spring.xml` of a custom extension, as follows:

```xml
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
    <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
    <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

Note that it will guarantee that the order is validated for product configuration issues before an order is submitted, but it will not ensure that the error message that is returned reflects the actual issue. The error message will state that the issue is because of low stock. This should be addressed in SAP Commerce Cloud release 2011.

### Assisted Service Mode

Assisted service mode (ASM) is currently not supported with the configurable products integration.
