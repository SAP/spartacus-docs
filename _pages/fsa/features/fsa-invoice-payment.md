---
title: FSA Invoice Payment
---

## Overview

Through the FSA checkout process two payment options are available: credit card and invoice. 

![payment details]({{ site.baseurl }}/assets/images/fsa/payment_details.png)

If customer selects credit card, standard form for card information will be displayed:

![credit card]({{ site.baseurl }}/assets/images/fsa/credit_card.png)

On the other hand for invoice type of payment there is no further input needed, customer can just select option and proceed to the final review page:
![final review]({{ site.baseurl }}/assets/images/fsa/final_review_invoice.png)

After policy is created, on policy details page information about chosen payment is available:

![policy details]({{ site.baseurl }}/assets/images/fsa/policy_details_payment.png)


## SPA Components

Payment feature logic sits in FSPaymentMethodComponent which extends Spartacus's PaymentMethodComponent.
Payment types are loaded over payment type service and shown to the customer in the form of radio buttons.

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
