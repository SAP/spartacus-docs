---
title: Cybersource Integration
---

The following document describes how to integrate Spartacus with CyberSource payment subscription in a PCI compliant scenario (no card information sent through Hybris).

1. Provide a class that implements _CheckoutPaymentAdapter_, which will encapsulate the new checkout logic for Cybersource and will override the default mock implementation from Spartacus. You can refer to _OccCheckoutPaymentAdapter_ as a reference.

```ts
@Injectable()
export class CybersourceCheckoutPaymentAdapter
  implements CheckoutPaymentAdapter {
  public create(
    userId: string,
    cartId: string,
    paymentDetails: PaymentDetails
  ): Observable<PaymentDetails> {
    // Cybersource-based logic to create payment details
  }
}
```

_Note_: If you need to set and reuse existing payments the way Spartacus does it out of the box, extend this class instead and override the create() method.

1. Provide your custom payment adapter in a module and include your module in your main application.

```ts
import { NgModule } from "@angular/core";
import { CheckoutPaymentAdapter } from "@spartacus/core";
import { CybersourceCheckoutPaymentAdapter } from "./checkout.adapter";

@NgModule({
  providers: [
    {
      provide: CheckoutPaymentAdapter,
      useClass: CybersourceCheckoutPaymentAdapter
    }
  ]
})
export class CybersourceCheckoutModule {}
```
