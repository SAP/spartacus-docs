---
title: FSA Checkout
---

**Note**: This feature is introduced with version 1.0 of the FSA Spartacus libraries.

Checkout in FSA Spartacus enables financial customers to buy insurance or banking products. It is configurable for each product kind.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Configuration

You can configure checkout steps over default-checkout-config.ts. There you can find a list of all possible steps that you can include in the checkout process.
The `FSCheckoutStep` interface extends `CheckoutStep` with an additional attribute - `restrictedCategories`.

```ts
export interface FSCheckoutStep extends CheckoutStep {
  restrictedCategories?: string[];
}
```

This attribute is important for making the checkout process different for various groups of products.
The following example of payment checkout step definition restricts the payment step for all banking products:

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

`FSCheckoutModule` consists of multiple checkout components, guards and services, making the checkout process fully configurable.
The following example shows step components inside the `FSCheckoutModule`:

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

These components are fulfilled with logic from `FSCheckoutConfigService`, responsible for navigation by setting the next and the previous step.

If you want to extend your checkout with an additional step, you should add the step definition and route to *default-checkout-config.ts*, create a new component and place the logic for handling steps inside it.

The following example illustrates the implementation of the `nextCheckoutStep` in the `QuoteReviewComponent`:  

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

Beside specific components of checkout steps, there is one crucial component that connects them - the `FSCheckoutProgressComponent`. This component is responsible for filtering the checkout steps, setting the active index, and indicating the step status by styling. A checkout step can be disabled, active or visited.

![checkout progress bar]({{ site.baseurl }}/assets/images/fsa/checkout_progress_bar.png)

## Integration with SAP Digital Payments

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

FSA Spartacus supports integration with SAP Digital Payments, which enables customers to complete the checkout with credit card payments. 

In the integration scenario, the user registers a new credit card during checkout and at the same time, a polling process is triggered to fetch the registered card details from SAP digital payments add-on. When the card details are successfully retrieved, the details are added to the Customer and Cart. Financial Services Accelerator then uses the tokenized card information to make the payment during order placement. Lastly, when the user places an order, an authorization call is made to SAP digital payments add-on to authorize the card payment. 

For more information on how to enable integration with SAP Digital Payments, see [Digital Payments Integration](https://sap.github.io/spartacus-docs/digital-payments-integration/). 