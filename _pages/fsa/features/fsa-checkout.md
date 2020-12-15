---
title: Checkout
---

## Contents

- [Overview](#overview)
- [Configuration](#configuration)
- [Components](#components)

## Overview

Checkout in FSA Spartacus enables financial customers to buy insurance or banking products. It's configurable for each kind of product.

## Configuration

You can configure checkout steps over default-checkout-config.ts. There is a list of all possible steps during checkout process.
Interface FSCheckoutStep extends Checkout Step with one additional attribute *restrictedCategories*. 
```
export interface FSCheckoutStep extends CheckoutStep {
  restrictedCategories?: string[];
}
```
This attribute is important for making checkout process different for various group of products.
Following example of payment checkout step definition restricts payment step for all banking products:
```
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

FSCheckoutModule consists of multiple checkout components, guards and services which are making checkout process fully configurable.
Example of the step components inside FSCheckoutModule:  
```
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

These components are fulfilled with logic from *FSCheckoutConfigService*, responsible for navigation by setting next and previous steps. If you want to extend checkout with additional step you should add step definition and route to *default-checkout-config.ts*, create new component and place logic for handling steps inside it. 

QuoteReviewComponent example of implementing nextCheckoutStep:  
```
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

There are many implemented guards which are preventing access of restricted checkout steps and uncompleted steps: 

- CategoryStepGuard
- BindQuoteGuard
- LegalInformationSetGuard
- OrderConfirmationGuard
- PersonalDetailsSetGuard
- QuoteNotBoundGuard
- ReferredQuoteGuard

Besides concrete components of checkout  steps there is one important component which connects them all and that is FSCheckoutProgressComponent.
 It's responsible for filtering steps, setting active index and indicating step status by styling. Step could be disabled, active or visited.

![checkout progress bar]({{ site.baseurl }}/assets/images/fsa/checkout_progress_bar.png)
