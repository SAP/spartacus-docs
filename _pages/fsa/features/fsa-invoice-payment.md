---
title: FSA Invoice Payment
---

**Note**: This feature is introduced with version 2.0 of the FSA Spartacus libraries.

Two payment options are available in the FSA Checkout Process: credit card and invoice.

![payment details]({{ site.baseurl }}/assets/images/fsa/payment_details.png)

If the customer selects credit card as a payment method, they first need to register a new credit card. In that case, a standard form for card information will be displayed:

![credit card]({{ site.baseurl }}/assets/images/fsa/credit_card.png)

On the other hand, if the customer selects invoice as a payment method, there is no need for further input, so they can proceed right away to the Final Review page:
![final review]({{ site.baseurl }}/assets/images/fsa/final_review_invoice.png)

Once the policy is created, the information about the chosen payment method is available on the Policy Details page:

![policy details]({{ site.baseurl }}/assets/images/fsa/policy_details_payment.png)

## Components

The payment feature logic sits in `FSPaymentMethodComponent` which extends the Spartacus' `PaymentMethodComponent`.
Payment types are loaded via the payment type service and shown to the customer in the form of radio buttons.

```html
   <form>
          <div class="form-check" *ngFor="let type of paymentTypes$ | async">
            <input
              id="paymentType-{{ type.code }}"
              class="form-check-input"
              type="radio"
              name="paymentMethod"
              [attr.aria-checked]="type.code === (paymentType$ | async)"
              (click)="changeType(type.code)"
              [value]="type.code"
              [checked]="type.code === (paymentType$ | async)"
            />
            <label class="pl-3 pt-1">
                 { 'fscommon.payment.' + type.code | cxTranslate }
            </label>
          </div>
        </form>
```
