---
title: Cybersource Integration
---

The following document describes how to integrate Spartacus with CyberSource payment subscription in a PCI compliant scenario (no card information sent through Hybris).

On a Vanilla installation of Spartacus, the checkout process uses the accelerator's [Mocked configuration](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ae2fd11866910148aebc156c3e1a877.html) mechanism for payments. The structure and behavior of the accelerator's mocked payment is very similar to Cybersource in terms of functionality (Silent Post Order, field mappings for payment details, etcetera).

Once Cybersource is up and running as a payment gateway in your CX backend, you can follow these steps for Cybersource integration on the Spartacus side:

### Provide a custom implementation for CheckoutPaymentAdapter

Payment information functionality is encapsulated in a _Payment Adapter_. For Cybersource integration, create a custom implementation for the _CheckoutPaymentAdapter_ interface. This instance will encapsulate the new checkout logic for Cybersource and will override the default mock implementation from Spartacus.

```ts
import {
  PaymentDetails,
  CheckoutPaymentAdapter,
  CardType
} from "@spartacus/core";
import { Injectable } from "@angular/core";
import { Observable, of } from "rxjs";

@Injectable()
export class CybersourceCheckoutPaymentAdapter
  implements CheckoutPaymentAdapter {
  constructor() {}

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

_Notes:_

- You can refer to _OccCheckoutPaymentAdapter_ class as a reference, since all of the payment logic for the mocked payment mechanism (including payment provider HTTP endpoints, field names and mappings, etc.) is there.

- If you need to set and reuse existing payments the way Spartacus does it out of the box, extend the class above instead and override the create() method.

### CustomPaymentModule

Provide (export) your custom payment adapter in a module and include your module in your main application. With this, Spartacus will use your custom payment adapter instead of the default one (provided for OCC).

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

_Note:_

If your checkout process has been heavily customized, you might also have to override other members of Spartacus, including the checkout process steps and orchestration.

More information about extending the checkotu process [here](#extending-checkout).
