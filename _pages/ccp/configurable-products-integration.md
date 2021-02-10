---
title: Configurable Products Integration
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Configurable Products integration with Spartacus lets you implement a Spartacus storefront in conjunction with SAP Variant Configuration and Pricing.

## Locales

All available locales must be replicated into Spartacus. Locales in the back end and front end must be in sync.

<!-- What exactly needs to be done on customer side? (This came up in relation to numeric formats) Could be that Spartacus core is going to document something on this. -->

## Conflict Solver

The conflict solver as developed with the minimal viable product (MVP) version is quite rudimentary with regards to user navigation.

In the MVP version, the following user navigation is currently implemented:

- If the user is in a conflict group and changes a value there, after the update the UI displays the original group of the attribute for which she changed the value, i.e. the user is taken out of the conflict resolving context.
- This happens every time she is changing a value in a conflict group, even if the value-change did not solve the conflict or if there are still other conflicts to be resolved.
- If the user clicks on "Resolve Issues" link in overview/cart the user is taken to the first conflict group. But after changing a value in the conflict group the above behavior applies, i.e. there is currently no guided "resolve issue" mode where the user is taken from issue to issue until the configuration has no issues anymore.

<!-- For v2, we have created a BI to enhance the conflict solver: https://cxjira.sap.com/browse/TIGER-6778 -->

## Save for Later / Selective Cart

This feature is not supported in MVP. To prevent the button from showing, customers should remove the relevant view (disable selective cart):

- Ensure that in the cart configuration, selective cart is disabled. The used configuration should contain the following:

    ```ts
    cart: {
      selectiveCart: {
        enabled: false,
      },
    },
    ```

- Deactivate the saveForLater component that is assigned to CMS component SaveForLaterComponent: Introduce a new module that clears the assigned SPA components for that CMS component. The following is an example:

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

## Cart Validation

Cart validation is currently not supported, although you can implement your own workaround.

### Spartacus

- Introduce their own version of `cart-totals.component.ts` and ensure that it is assigned to the `CartTotalsComponent` CMS component instead of the original one
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

### Commerce

The steps that can be done on the Spartacus side ensure that for a standard UI flow, configurations with issues cannot be ordered. Still it's needed to also block the creation of orders via OCC, otherwise an order containing such configurations can be created using e.g. the developer tools in the end-user's browser.

In your spring configuration, see that bean commerceWebServicesCartService refers to cartValidationStrategy instead of cartValidationWithoutCartAlteringStrategy. This can be achieved, for example, in the `spring.xml` of a custom extension, as follows:

```xml
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
    <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
    <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

Note that it will guarantee that the order is validated for product configuration issues before order submit, but it will not ensure that the error message that is returned reflects the actual issue. The error message will state that the issue is because of low stock. We plan to address this in SAP Commerce Cloud release 20.11.

## RTL Support

Right-to-left (RTL) is supported for product configuration in Spartacus.

## Group Status Handling

There are three group statuses, which are interpreted as follows:

|Group Status|Combination|Description|
|------------|-----------|-----------|
|COMPLETE|Visited + Complete + Consistent|The group is *complete* if it has been visited and there are no incomplete characteristics or conflicts.|
|ERROR|Visited + Incomplete|The group gets an *error* icon if it has been visited and there are incomplete characteristics.|
|WARNING|Inconsistent|The group is *inconsistent* if there are conflicting characteristics within the corresponding group. The default configuration can contain inconsistent groups. It means by entering such configuration a conflicting groups should be displayed accordingly.|

## Conflict Group Navigation

After the conflict group has been updated, you are taken to the non-conflict group where the updated characteristic is located, regardless of whether the conflict has been resolved.

In contrast, if you resolve a conflict in the Accelerator directly in the conflict group, you are taken to the first conflict group or the first non-conflict group within the configuration.  If the conflict has not been resolved, you remain in the corresponding conflict group until the conflict has been resolved or you explicitly leave the conflict group.

### Conflict Navigation

1. You click on **Resolve Conflict** for a specific, conflicting attribute.
1. You resolve the conflict.
1. You return to the group that contained the conflict.
1. You click on **Resolve Conflict** on the cart, overview page, or conflict group via the group menu.
1. You resolve the conflict.
1. You navigate to the next conflict group.
1. You resolve the last conflict.
1. You are taken to the first group.

### Icon Alignment

The following is an example of the **Configuration Menu** showing errors and conflicts:

<img src="{{ site.baseurl }}/assets/images/ccp/icon_alignment.png" alt="Configuration menu showing errors and conflicts" width="650" border="1px" />

For reference, the Accelerator behaves as follows.

Only a header of conflict groups gets a warning icon. In the Accelerator, the icons have the following meanings:

|Group Status|Combination|Description|
|------------|-----------|-----------|
|COMPLETE|Visited + Complete|The group is *complete* if it has been visited and there are no incomplete characteristics.|
|ERROR|Visited + Incomplete|The group gets an *error* icon with the total number of errors in the group if the group has been visited and there are incomplete characteristics. The conflicts within the corresponding group are not counted.|
|WARNING|Inconsistent|Only the headers of conflict groups get a *warning* icon with the total number of conflicts in the configuration.|

The following is an example of conflicts shown on the B2B Accelerator screen:

![Conflicts shown on the B2B Accelerator screen]({{site.baseurl}}/assets/images/ccp/b2b_accelerator.png)

## Browser Refresh

When users refresh the browser, the product configuration is reset to the default configuration (unlike in the Accelerator). Users will therefore have to reconfigure their products after reloading the page.
