---
title: Payment Integration with CyberSource Example
---

You can integrate Spartacus with a CyberSource payment subscription in a PCI-compliant scenario, where no card information is sent through SAP Commerce Cloud.

On a default installation of Spartacus, the checkout process uses the Accelerator mocked configuration mechanism for payments. The structure and behavior of the mocked payment is very similar to CyberSource in terms of functionality, in that it uses Silent Post Order, it does the field mappings for payment details, and so on.

For more information, see [Mocked Configuration](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae2fd11866910148aebc156c3e1a877.html).

Once CyberSource is up and running as a payment gateway in your Commerce Cloud backend, refer to the information in the following sections to integrate CyberSource with Spartacus.

## Providing a Custom Implementation for the CheckoutPaymentAdapter

Payment information functionality is encapsulated in a "Payment Adapter". For CyberSource integration, create a custom implementation for the `CheckoutPaymentAdapter` interface. This instance encapsulates the new checkout logic for CyberSource and overrides the default mock implementation from Spartacus. The following is an example:

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

  // Add other methods to get endpoints, map payment fields, and so on, as needed.
}
```

**Note:** You can refer to the `OccCheckoutPaymentAdapter` class as a reference, since all of the payment logic for the mocked payment mechanism is there, including payment provider HTTP endpoints, field names and mappings, and so on.

**Note:** If you need to set and reuse existing payments the way Spartacus does by default, extend the class above instead, and override the `create()` method.

## Setting up a Custom Payment Module

Export your custom payment adapter in a module, and include the module in your main application. With this, Spartacus uses your custom payment adapter instead of the default one that is provided for OCC. The following is an example:

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

**Note:** If your checkout process has been heavily customized, you might also have to override other members of Spartacus, including the checkout process steps and orchestration.

For more information, see [Extending Checkout]({{ site.baseurl }}{% link _pages/dev/extending-checkout.md %}).
