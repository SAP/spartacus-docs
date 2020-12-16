---
title: Spartacus
---
- Introduce their own version of cart-totals.component.ts and ensure that it is assigned to CMS component CartTotalsComponent instead of the original one
- Inject ConfiguratorCartService from '@spartacus/product/configurators/common' into the custom version of cart-totals.component
- Introduce a component member

```
hasNoConfigurationIssues$: Observable<
    boolean
  > = this.configuratorCartService
    .activeCartHasIssues()
    .pipe(map((hasIssues) => !hasIssues));
```

- Make use of this member in the component template

```
<ng-container *ngIf="cart$ | async as cart">
  <ng-container *ngIf="entries$ | async as entries">
    <cx-order-summary [cart]="cart"></cx-order-summary>
    <ng-container
      *ngIf="hasNoConfigurationIssues$ | async as hasNoConfigurationIssues"
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