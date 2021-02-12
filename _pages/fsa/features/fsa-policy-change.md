---
title: FSA Policy Change
---

## Contents

- [Overview](#overview)
- [Adding additional drivers](#adding-additional-drivers)
- [Components](#components)

## Overview

The Policy Change Process framework enables insurance carriers to provide their customers with the possibility to change their policy online.
In addition to sample processes for changing mileage and adding coverages, customers can now add additional drivers and remove coverages. All sample processes are provided based on the Auto Insurance product.

![Policy details page]({{ site.baseurl }}/assets/images/fsa/policy_details.png)

### Adding Additional Drivers

By clicking  the **Add** button in the Drivers section of the 'Who or What is Insured' accordion, the user initiate the Policy Change process for adding an additional driver to the policy. User is presented with the form requesting information about the additional driver. Note that 'Effective date' field is disabled and cannot be changed by the policyholder.

![Policy details page]({{ site.baseurl }}/assets/images/fsa/additional_driver_form.png)

Once all the required fields are filled in, the user can proceed to the final step of the Policy Change process for adding a driver.
On this step, the user is presented with an overview of the change applied to the current Policy.

![Policy details page]({{ site.baseurl }}/assets/images/fsa/change_preview.png)

When the user clicks **Submit**, a Confirmation page is displayed, indicating that the request has been submitted.

![Policy details page]({{ site.baseurl }}/assets/images/fsa/cr_confirmation.png)

The user can see the policy change by visiting the Policy Details page again. In the 'Who or What is Insured' accordion there should be an additional section containing information about the additional driver, with the headline 'Driver 2'.

![Policy details page]({{ site.baseurl }}/assets/images/fsa/driver_added.png)

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

These components are fulfilled with logic from _FSCheckoutConfigService_, responsible for navigation by setting next and previous steps.
If you want to extend your checkout with an additional step, you should add the step definition and route to _default-checkout-config.ts_, create a new component and place the logic for handling steps inside it.

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
<ng-container *ngIf="nextCheckoutStep$ | async as nextCheckoutStep"
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
