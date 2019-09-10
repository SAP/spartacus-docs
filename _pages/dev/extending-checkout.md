---
title: Extending Checkout (DRAFT)
---

## Overview

The checkout feature in Spartacus is CMS-driven, which means every page in the checkout flow is based on CMS pages, slots and components. As a result, you can change the content of each page, add new components, convert the checkout into a single-step checkout, or create very sophisticated multi-step checkout flows with only a minimal amount of configuration in the storefront application.

## Routing and Configuration

In the checkout, you often have links from on step to another, which is the reason for registering each checkout page as a semantic page in the storefront configuration.

The following is the default route configuration for checkout that ships with the Spartacus libraries:

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

Although the default checkout has four steps, the default configuration defines five semantic pages. This additional page has a general `checkout` route that is linked to from every component that should redirect to the checkout. From this general checkout page, Spartacus redirects you the correct checkout step.

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

The attributes in the `steps` array are used as follows:

- The `id` attribute should have a unique value. You can use `id` when you need to identify a specific step in the configuration.
- The `name` attribute is used in the `CheckoutProgress` component to indicate which checkout steps have been completed. The `name` is also used as a translation key.
- The `routeName` attribute specifies the semantic page for each step.
- The `type` attribute is used by the checkout guards. For more information, see [Protecting Routes](#protecting-routes).

Also, the order of the steps in the `steps` array determines which steps are previous and next for the navigation buttons in the checkout flow. For example, based on the default configuration, the **Back** button for the delivery mode component points to the previous `shippingAddress` step, while the **Next** button points to the `paymentDetails` step. If you change the order of the steps in the configuration, the navigation buttons automatically update to link to the correct pages.

## Components

Every checkout component is a CMS component. Furthermore, in the default checkout, all components are [CMSFlexComponents](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#placeholder-components). Compared to other CMS components, these components have more guards defined in the configuration, but are otherwise identical to regular CMS components.

## Protecting Routes

The checkout uses component guards instead of page guards. You protect routes by applying guards in the CMS component mapping.

Component guards have the same API as page guards. Spartacus exposes the following guards as part of the checkout:

- `ShippingAddressSetGuard`
- `DeliveryModeSetGuard`
- `PaymentDetailsSetGuard`
- `CheckoutGuard`

As an example, if you wanted to restrict access to the Review Order page, so that it displays only when the shipping address, delivery mode and payment details were correctly set, you would set guards for the review order component to `guards: [ShippingAddressSetGuard, DeliveryModeSetGuard, PaymentDetailsSetGuard]`. Then, when you try to access the Review Order page, Spartacus first checks the guards for every component on that page, and only displays the page if every guard returns `true`. If one of the guard returns `false` or a redirect URL, Spartacus redirects to the provided URL.

The following is an example scenario:

1. A user sets the shipping address.
2. The user comes back to shop after a few days, and the browser auto-suggests the Review Order page from a previous order.
3. The user follows the suggestion.
4. The `ShippingAddressSetGuard` returns `true`.
5. The `DeliveryModeSetGuard` returns `checkout/delivery-mode` redirect.
6. The `PaymentDetailsSetGuard` returns `checkout/payment-details` redirect.
7. The user is redirected to the Delivery Mode selection page.

The order of the guards is important, as the first redirect is used. In general, you should define guards in the same order as the checkout flow.

### CheckoutGuard

Special `CheckoutGuard` is responsible for redirects to correct step. Default implementation redirects every checkout request to first step. You can replace it with your own guard (e.g. redirect user to first step that is not set). A custom example is provided in the [Express Checkout Guard](#express-checkout) section.

### How Each Guard Knows Where to Redirect

In checkout configuration in each step you specify `type` attribute with type of data you set on this step. Guards look for first step that contains specific `type` and redirects to this page.

Example:

`ShippingAddressSetGuard` will search checkout config for first step with `type` containing `CheckoutStepType.shippingAddress`. Then it will read the step route and redirects to that page.
On each checkout step you can have multiple components and because of that `type` property is an array.

## CMS Catalog Content and Default Template

In default checkout we use modified `MultiStepCheckoutOrderSummaryPageTemplate`. Apart from `BodyContent` and `SideContent` we added `TopContent` and `BottomContent` for 100% section above and below `BodyContent` and `SideContent` page slots.

For default checkout flow we created impex file with all pages, slots, components and relations configured. It is available as part of `spartacussampledataaddon`.

## Extensibility

Below you can find common checkout changes you might want to implement in your application. Apart from these checkout specific extensibility options you can also extend checkout components and services like any other from spartacus library.

### Changing Steps Order

I would like to change order of 2 steps. After shipping address customer should set payment details and after that delivery mode. In default config we ask first for delivery method and then for payment details. Let's change that order.

In storefront config you have to change checkout config and change guards in CMS components used on checkout pages.

```ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      ...restOfConfig,
      checkout: {
        // you have to specify all steps (we don't merge this configuration with default one)
        steps: [
          {
            id: 'shippingAddress',
            name: 'checkoutProgress.shippingAddress',
            routeName: 'checkoutShippingAddress',
            type: [CheckoutStepType.SHIPPING_ADDRESS],
          },
          // changed payment details step to be before delivery mode
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
          // default CheckoutPaymentDetails uses DeliveryModeSetGuard, but in our case we won't have delivery mode details set
          // override component guards with new set without DeliveryModeSetGuard
          guards: [AuthGuard, CartNotEmptyGuard, ShippingAddressSetGuard],
        },
        CheckoutDeliveryMode: {
          component: DeliveryModeComponent,
          // in CheckoutDeliveryMode we need to also check if payment details are set, so we add PaymentDetailsSetGuard
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

### Introducing Another Checkout Step

Another use case you might need in checkout is to add a new step.

You follow the similar approach to the previous example. In storefront config you provide checkout config.
Apart from that change you have to set page, slots and components in CMS.

```ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      ...restOfConfig,
      routing: {
        routes: {
          // Create route for your new checkout step
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
          // Let's add charity step before our order review
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

Combining steps is also very similar to other examples.
For most cases you will follow similar checklist:

- configure new pages, slots and components in CMS
- adjust steps config (add/combine/remove steps)
- map your own Angular components to CMS components
- review components guards and adjust if needed
- check missing translations

In this example I also created new component which is very similar to DeliveryModeComponent only that instead of **Next** button, there is **Save** button (it only saves information without redirect).

``` ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      routing: {
        routes: {
          // add new route for combined step
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
          // replace two steps with one
          {
            id: 'deliveryModePaymentDetails',
            name: 'checkoutProgress.deliveryModePaymentDetails', // provide translation for this key
            routeName: 'checkoutDeliveryModePaymentDetails',
            // in this step we set delivery mode and payment details, so you have to define both of these types
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
          // we have to remove DeliveryModeSetGuard, since you set this on the same page
          guards: [AuthGuard, CartNotEmptyGuard, ShippingAddressSetGuard],
        },
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
```

You can go very far with combining steps (example: creating single step checkout).

### Express Checkout

In my store I would like to provide express checkout for users who previously ordered something.
Clicking **Express checkout** button would use for order default address, default payment method and fastest shipping method.
You would go directly to order review page only to confirm those information.

Clicking default checkout button would redirect to `/checkout` route. To invoke express checkout you would need to pass additional query param `express`.

First step of this feature would be creating `ExpressCheckoutGuard`.

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
    // check express query param
    if (route.queryParams.express) {
      // To avoid long example here is only steps instead of real code
      // 1. fetch default delivery address, payment method and delivery mode
      // 2. set in order those defaults
      // 3. watch for order details and return review order url
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
      // redirect to first step on default checkout flow
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

Now you can use created guard in Checkout Orchestrator.

``` ts
@NgModule({
  imports: [
    B2cStorefrontModule.withConfig({
      cmsComponents: {
        CheckoutOrchestrator: {
          component: CheckoutOrchestratorComponent,
          // replace CheckoutGuard with ExpressCheckoutGuard for Checkout Orchestrator
          guards: [AuthGuard, CartNotEmptyGuard, ExpressCheckoutGuard],
        },
      },
    }),
  ],
  bootstrap: [StorefrontComponent],
})
```

That's all. Express checkout is ready. The only thing left to do is creating express checkout links and placing it on the page.
