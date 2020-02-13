---
title: Cybersource Integration
---

The following document describes how to integrate Spartacus with CyberSource payment subscription in a PCI compliant scenario (no card information sent through Hybris).

On a Vanilla installation of Spartacus, the checkout process uses the accelerator's [Mocked configuration](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ae2fd11866910148aebc156c3e1a877.html) mechanism for payments. The structure and behavior of the accelerator's mocked payment is very similar to Cybersource.

Once Cybersource is properly configured in your CX backend, you will have to do the following on the Spartacus side:

### CheckoutPaymentAdapter

Create a custom implementation of _CheckoutPaymentAdapter_, which will encapsulate the new checkout logic for Cybersource and will override the default mock implementation from Spartacus.

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

  // Other methods to get endpoints, map payment fields, etc.
}
```

You can refer to _OccCheckoutPaymentAdapter_ class as a reference, since all of the payment logic for the mocked payment mechanism (including payment provider HTTP endpoints, field names and mappings, etc.) is there.

_Note_: If you need to set and reuse existing payments the way Spartacus does it out of the box, extend this class instead and override the create() method.

### CustomPaymentModule

Provide (export) your custom payment adapter in a module and include your module in your main application.

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

_Note_ If your checkout process has been heavily customized, you might also have to override other members of Spartacus, including the checkout process steps and orchestration. More information about this [here](#extending-checkout).
