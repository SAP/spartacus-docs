---
title: Extending Checkout
---

## Overview

The checkout feature in Spartacus is CMS-driven, which means every page in the checkout flow is based on CMS pages, slots and components. As a result, you can change the content of each page, add new components, convert the checkout into a single-step checkout, or create very sophisticated multi-step checkout flows with only a minimal amount of configuration in the storefront application.

## Routing and Configuration

In the checkout, you often have links from one step to another, which is the reason for registering each checkout page as a semantic page in the storefront configuration.

The following is the default route configuration for checkout:

```typescript
B2cStorefrontModule.withConfig({
  routing: {
    routes: {
      checkout: {
        paths: ['checkout'],
      },
      checkoutShippingAddress: {
        paths: ['checkout/shipping-address']
      },
      checkoutDeliveryMode: {
        paths: ['checkout/delivery-mode']
      },
      checkoutPaymentDetails: {
        paths: ['checkout/payment-details']
      },
      checkoutReviewOrder: {
        paths: ['checkout/review-order']
      }
    },
  },
}),
```

Although the default checkout has four steps, the default configuration defines five semantic pages. This additional page has a general `checkout` route that is linked to from every component that should redirect to the checkout. From this general checkout page, Spartacus redirects to the correct checkout step.

If you want to link to the checkout, always point to this general checkout page, regardless of how your checkout is set up. For example, with a multi-step checkout, you can use your `CheckoutGuard` to take care of redirecting to the correct checkout step. With a single-step checkout, you can set all components on this `checkout` route and remove the `CheckoutGuard` from the component configuration.

For more information about the `CheckoutGuard`, see the [CheckoutGuard](#checkoutguard) section below.

Aside from the route configuration, you can also configure the checkout by defining the responsibility of each step, the route to the page, and the order of the steps. The following is the default configuration:

```typescript
B2cStorefrontModule.withConfig({
  checkout: {
    steps: [
      {
        id: 'shippingAddress',
        name: 'checkoutProgress.shippingAddress',
        routeName: 'checkoutShippingAddress',
        type: [CheckoutStepType.SHIPPING_ADDRESS],
      },
      {
        id: 'deliveryMode',
        name: 'checkoutProgress.deliveryMode',
        routeName: 'checkoutDeliveryMode',
        type: [CheckoutStepType.DELIVERY_MODE],
      },
      {
        id: 'paymentDetails',
        name: 'checkoutProgress.paymentDetails',
        routeName: 'checkoutPaymentDetails',
        type: [CheckoutStepType.PAYMENT_DETAILS],
      },
      {
        id: 'reviewOrder',
        name: 'checkoutProgress.reviewOrder',
        routeName: 'checkoutReviewOrder',
        type: [CheckoutStepType.REVIEW_ORDER],
      },
    ],
  },
})
```

The attributes in the `steps` array work as follows:

- The `id` attribute should have a unique value. You can use `id` when you need to identify a specific step in the configuration.
- The `name` attribute is used in the `CheckoutProgress` component to indicate which checkout steps have been completed. The `name` is also used as a translation key.
- The `routeName` attribute specifies the semantic page for each step.
- The `type` attribute is used by the checkout guards. For more information, see [Protecting Routes](#protecting-routes).

Also, the order of the steps in the `steps` array determines which steps are "previous" and "next" for the navigation buttons in the checkout flow. For example, based on the default configuration, the **Back** button for the delivery mode component points to the previous `shippingAddress` step, while the **Next** button points to the `paymentDetails` step. If you change the order of the steps in the configuration, the navigation buttons automatically update to link to the correct pages.

## Components

Every checkout component is a CMS component. Furthermore, in the default checkout, all components are [CMSFlexComponents](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#placeholder-components). Compared to other CMS components, these components have more guards defined in the configuration, but are otherwise identical to regular CMS components.

## Protecting Routes

The checkout uses component guards instead of page guards. You protect routes by applying guards in the CMS component mapping.

Component guards have the same API as page guards. Spartacus exposes the following guards as part of the checkout:

- `ShippingAddressSetGuard`
- `DeliveryModeSetGuard`
- `PaymentDetailsSetGuard`
- `CheckoutGuard`

As an example, if you wanted to restrict access to the Review Order page, so that it displays only when the shipping address, delivery mode and payment details were correctly set, you would set guards for the review order component to `guards: [ShippingAddressSetGuard, DeliveryModeSetGuard, PaymentDetailsSetGuard]`. Then, when you try to access the Review Order page, Spartacus first checks the guards for every component on that page, and only displays the page if every guard returns `true`. If one of the guard returns `false`, or returns a redirect URL, Spartacus redirects to the provided URL.

The following is an example scenario:

1. A user sets the shipping address.
2. The user comes back to shop after a few days, and the browser auto-suggests the Review Order page from a previous order.
3. The user follows the suggestion.
4. The `ShippingAddressSetGuard` returns `true`.
5. The `DeliveryModeSetGuard` returns `checkout/delivery-mode` redirect.
6. The `PaymentDetailsSetGuard` returns `checkout/payment-details` redirect.
7. The user is redirected to the Delivery Mode selection page.

The order of the guards is important because the first redirect is used. In general, you should define guards in the same order as the checkout flow.

### CheckoutGuard

A special `CheckoutGuard` is responsible for redirecting to the correct step. The default implementation redirects every checkout request to the first step. You can replace this with your own guard (for example, you could redirect users to the first step that is not set). A custom example is provided in the [Express Checkout](#express-checkout) section, below.

### Configuring Where Guards Redirect To

In the checkout configuration, for each step, you specify a `type` attribute and the type of data that should be set. A guard looks for the first step that contains the specific `type` and then redirects to this step.

For example, `ShippingAddressSetGuard` searches the checkout configuration for the first step with a `type` containing `CheckoutStepType.shippingAddress`, then reads the step route and redirects to that page.

Note that, on each checkout step, you can have multiple components. As a result, the `type` property is an array.

## CMS Catalog Content and Default Template

In the default checkout, Spartacus uses a modified `MultiStepCheckoutOrderSummaryPageTemplate`. In addition to `BodyContent` and `SideContent`, Spartacus includes `TopContent` and `BottomContent` for 100% of the sections above and below the `BodyContent` and `SideContent` page slots.

For the default checkout flow, Spartacus includes an impex file with all pages, slots, components and relations configured. This impex is available as part of the `spartacussampledataaddon` AddOn. For more information, see [Spartacussampledataaddon AddOn]({{ site.baseurl }}{% link _pages/install/spartacussampledataaddon.md %})

## Extensibility

The following sections describe some common ways to modify the checkout. Of course, you can also extend checkout services and components like any other services and components that are shipped with the Spartacus libraries.

### Changing the Order of the Checkout Flow

The following scenario describes how to change the order of two steps. In the default configuration, the checkout flow starts with setting a shipping address, followed by setting the delivery mode, and finally by filling in the payment details. In this scenario, the configuration is modified so that the payment details step occurs before the delivery mode step.

To achieve this, you change the checkout configuration in the storefront configuration, and change the guards in the CMS components that are used on the checkout pages. The following is an example:

```ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      ...restOfConfig,
      checkout: {
        // You must specify all of the steps (this configuration is not merged with the default one)
        steps: [
          {
            id: 'shippingAddress',
            name: 'checkoutProgress.shippingAddress',
            routeName: 'checkoutShippingAddress',
            type: [CheckoutStepType.SHIPPING_ADDRESS],
          },
          // Change the payment details step to be before the delivery mode
          {
            id: 'paymentDetails',
            name: 'checkoutProgress.paymentDetails',
            routeName: 'checkoutPaymentDetails',
            type: [CheckoutStepType.PAYMENT_DETAILS],
          },
          {
            id: 'deliveryMode',
            name: 'checkoutProgress.deliveryMode',
            routeName: 'checkoutDeliveryMode',
            type: [CheckoutStepType.DELIVERY_MODE],
          },
          {
            id: 'reviewOrder',
            name: 'checkoutProgress.reviewOrder',
            routeName: 'checkoutReviewOrder',
            type: [CheckoutStepType.REVIEW_ORDER],
          },
        ],
      },
      cmsComponents: {
        CheckoutPaymentDetails: {
          component: PaymentMethodsComponent,
          // The default CheckoutPaymentDetails uses the DeliveryModeSetGuard, but in this case, the delivery mode details will not be set yet.
          // Instead, override the component guards with a new set that does not include the DeliveryModeSetGuard
          guards: [AuthGuard, CartNotEmptyGuard, ShippingAddressSetGuard],
        },
        CheckoutDeliveryMode: {
          component: DeliveryModeComponent,
          // In the CheckoutDeliveryMode, we need to also check if the payment details are set, so we add the PaymentDetailsSetGuard
          guards: [
            AuthGuard,
            CartNotEmptyGuard,
            ShippingAddressSetGuard,
            PaymentDetailsSetGuard,
          ],
        },
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
export class AppModule {}
```

### Adding Another Checkout Step

To add an extra checkout step, the approach is similar to changing the order of the checkout flow: you provide the checkout configuration in the storefront configuration, and set the page, slots, and components in CMS. The following is an example:

```ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      ...restOfConfig,
      routing: {
        routes: {
          // Create a route for your new checkout step
          checkoutCharity: { paths: ['checkout/charity'] },
        },
      },
      checkout: {
        steps: [
          {
            id: 'shippingAddress',
            name: 'checkoutProgress.shippingAddress',
            routeName: 'checkoutShippingAddress',
            type: [CheckoutStepType.SHIPPING_ADDRESS],
          },
          {
            id: 'deliveryMode',
            name: 'checkoutProgress.deliveryMode',
            routeName: 'checkoutDeliveryMode',
            type: [CheckoutStepType.DELIVERY_MODE],
          },
          {
            id: 'paymentDetails',
            name: 'checkoutProgress.paymentDetails',
            routeName: 'checkoutPaymentDetails',
            type: [CheckoutStepType.PAYMENT_DETAILS],
          },
          // Add the charity step here, before the review order step
          {
            id: 'charity',
            name: 'checkoutProgress.charity', // Provide translation for this key
            routeName: 'checkoutCharity',
            type: [],
          },
          {
            id: 'reviewOrder',
            name: 'checkoutProgress.reviewOrder',
            routeName: 'checkoutReviewOrder',
            type: [CheckoutStepType.REVIEW_ORDER],
          },
        ],
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
export class AppModule {}
```

### Combining Checkout Steps

Combining checkout steps is also very similar to the previous examples. In most cases, the required steps are the following:

- Configure new pages, slots, and components in CMS
- Adjust the configuration of the steps (for example, add/combine/remove steps)
- Map your own Angular components to the CMS components
- Review the component guards and adjust if needed
- Check for missing translations

In addition to combining steps, the following example shows how to create a new component, which is very similar to the `DeliveryModeComponent` except that it has a **Save** button instead of a **Next** button. Note, this **Save** button only saves information, without a redirect.

``` ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      routing: {
        routes: {
          // Add a new route for the combined step
          checkoutDeliveryModePaymentDetails: {
            paths: ['checkout/delivery-and-payment'],
          },
        },
      },
      checkout: {
        steps: [
          {
            id: 'shippingAddress',
            name: 'checkoutProgress.shippingAddress',
            routeName: 'checkoutShippingAddress',
            type: [CheckoutStepType.SHIPPING_ADDRESS],
          },
          // Replace two steps with one
          {
            id: 'deliveryModePaymentDetails',
            name: 'checkoutProgress.deliveryModePaymentDetails', // Provide translation for this key
            routeName: 'checkoutDeliveryModePaymentDetails',
            // This step sets both the delivery mode and the payment details, so you have to define both of these types
            type: [
              CheckoutStepType.DELIVERY_MODE,
              CheckoutStepType.PAYMENT_DETAILS,
            ],
          },
          {
            id: 'reviewOrder',
            name: 'checkoutProgress.reviewOrder',
            routeName: 'checkoutReviewOrder',
            type: [CheckoutStepType.REVIEW_ORDER],
          },
        ],
      },
      cmsComponents: {
        CheckoutPaymentDetails: {
          component: PaymentMethodsComponent,
          // DeliveryModeSetGuard is removed because it is set on the same page
          guards: [AuthGuard, CartNotEmptyGuard, ShippingAddressSetGuard],
        },
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
```

**Note:** You can use this same approach to combine all the steps into a single-step checkout.

### Express Checkout

The following scenario describes how to provide express checkout for users who have previously ordered from this store. In this example, when the **Express Checkout** button is clicked, the user is brought directly to the Review Order page, which is populated with the default address, the default payment method, and the fastest shipping method.

Clicking the default checkout button redirects to the `/checkout` route. To invoke express checkout, you need to pass the additional `express` query param.

The first step in setting up express checkout is to create an `ExpressCheckoutGuard`. The following is an example:

``` ts
import { Injectable } from '@angular/core';
import {
  CanActivate,
  Router,
  UrlTree,
  ActivatedRouteSnapshot,
} from '@angular/router';
import { CheckoutConfig } from '../config/checkout-config';
import {
  RoutingConfigService,
} from '@spartacus/core';

@Injectable({
  providedIn: 'root',
})
export class ExpressCheckoutGuard implements CanActivate {
  constructor(
    private router: Router,
    private config: CheckoutConfig,
    private routingConfigService: RoutingConfigService,
    private checkoutConfigService: CheckoutConfigService,
  ) {}

  canActivate(route: ActivatedRouteSnapshot): Observable<boolean | UrlTree> {
    // Check for the express query param
    if (route.queryParams.express) {
      // To avoid a long example, the following are only steps, instead of real code:
      // 1. Fetch the default delivery address, payment method and delivery mode.
      // 2. Set those defaults in the order.
      // 3. Watch for order details and return the review order URL.
      const checkoutStep: CheckoutStep = this.checkoutConfigService.getCheckoutStep(
        CheckoutStepType.REVIEW_ORDER
      );

      return this.router.parseUrl(
        checkoutStep &&
          this.routingConfigService.getRouteConfig(
            checkoutStep.routeName
          ).paths[0]
      );
    } else {
      // Redirect to the first step in the default checkout flow
      return of(
        this.router.parseUrl(
          this.routingConfigService.getRouteConfig(
            this.config.checkout.steps[0].routeName
          ).paths[0]
        )
      );
    }
  }
}
```

Now that you have created the `ExpressCheckoutGuard`, you can use it in the Checkout Orchestrator. The following is an example:

``` ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      cmsComponents: {
        CheckoutOrchestrator: {
          component: CheckoutOrchestratorComponent,
          // Replace the CheckoutGuard with the ExpressCheckoutGuard for the Checkout Orchestrator
          guards: [AuthGuard, CartNotEmptyGuard, ExpressCheckoutGuard],
        },
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
```

Express checkout is now ready. The only steps that remain are to create express checkout links, and to place them on the page.
