---
title: FSA Checkout
---

## Contents

- [Overview](#overview)
- [Configuration](#configuration)
- [Components](#components)

Checkout in FSA Spartacus enables financial customers to buy insurance or banking products. It’s configurable for each product kind.

## Configuration

You can configure checkout steps over default-checkout-config.ts. There you can find a list of all possible steps that you can include in the checkout process.
Interface FSCheckoutStep extends Checkout Step with one additional attribute - *restrictedCategories*.

```ts
export interface FSCheckoutStep extends CheckoutStep {
  restrictedCategories?: string[];
}
```

This attribute is important for making the checkout process different for various groups of products.
The following example of payment checkout step definition restricts payment step for all banking products:

```ts
     {
        id: 'checkoutPaymentDetailsStep',
        name: 'fscommon.paymentDetails',
        routeName: 'checkoutPaymentDetails',
        type: [CheckoutStepType.PAYMENT_DETAILS],
        restrictedCategories: [
          'banking_credit_card',
          'banking_current_account',
          'banking_loans',
          'banking_fixed_term_deposit',
        ],
      },
```

## Components

FSCheckoutModule consists of multiple checkout components, guards and services, making the checkout process fully configurable.
The following example shows step components inside the FSCheckoutModule:

```plaintext
    AddOptionsComponent,
    QuoteReviewComponent,
    BindQuoteDialogComponent,
    ReferredQuoteDialogComponent,
    FinalReviewComponent,
    ChooseCoverNavigationComponent,
    PersonalDetailsNavigationComponent,
    OrderConfirmationComponent,
    OrderConfirmationMessageComponent,
    MiniCartComponent,
```

These components are fulfilled with logic from *FSCheckoutConfigService*, responsible for navigation by setting next and previous steps.
If you want to extend your checkout with an additional step, you should add the step definition and route to *default-checkout-config.ts*, create a new component and place the logic for handling steps inside it.

QuoteReviewComponent example of implementing nextCheckoutStep:  

```ts
@Component({
    selector: 'cx-fs-quote-review',
    templateUrl: './quote-review.component.html',
  })
 export class QuoteReviewComponent implements OnInit, OnDestroy {`
 constructor(
    protected cartService: FSCartService,
    protected config: OccConfig,
    protected routingService: RoutingService,
    protected checkoutConfigService: FSCheckoutConfigService,
    protected categoryService: CategoryService,
    protected activatedRoute: ActivatedRoute,
    protected modalService: ModalService,
    protected translationService: FSTranslationService
  ) {}

  ngOnInit() {
    this.cart$ = this.cartService.getActive();
    this.isCartStable$ = this.cartService.isStable();
    this.previousCheckoutStep$ = this.checkoutConfigService.previousStep;
    this.nextCheckoutStep$ = this.checkoutConfigService.nextStep;
    this.activeCategory$ = this.categoryService.getActiveCategory();
  }
```

quote-review.component.html

```html
  <ng-container
                *ngIf="nextCheckoutStep$ | async as nextCheckoutStep"
                ><button
                  class="primary-button btn-block"
                  type="button"
                  data-checkout-url=""
                  (click)="navigateNext(nextCheckoutStep, cart)"
                >
                  {{ 'common.continue' | cxTranslate }}
                </button></ng-container
              >
```

The following guards have been implemented to prevent access to restricted or uncompleted checkout steps:

- CategoryStepGuard
- BindQuoteGuard
- LegalInformationSetGuard
- OrderConfirmationGuard
- PersonalDetailsSetGuard
- QuoteNotBoundGuard
- ReferredQuoteGuard

Besides specific components of checkout steps, there is one crucial component that connects them - the FSCheckoutProgressComponent. This component is responsible for filtering the checkout steps, setting the active index, and indicating the step status by styling. A checkout step can be disabled, active or visited.

![checkout progress bar]({{ site.baseurl }}/assets/images/fsa/checkout_progress_bar.png)
