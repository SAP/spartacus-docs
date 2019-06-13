---
title: Extending Checkout (DRAFT)
permalink: /Extending-Checkout/
---

## Overview

One of the principle we try to follow with spartacus is to be CMS driven. We tried to follow the same idea while working on checkout feature.
Every checkout page is based on CMS pages, slots and components. Thanks to this you can easily change content of each page, add new components, make single step checkout or create very sophisticated multi step checkout flow. Only minimal amount of configuration is required in storefront application.

## Routing and Configuration

In checkout you often have links from on step to another. That is the reason for registering each checkout page as semantic page in storefront config.
Below is our default route configuration for checkout (you don't have to write this, it is already in library):

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

The config above is for our default 4 steps checkout. You might notice that for 4 steps we defined 5 semantic pages. We have additional general route `checkout` which we link to from every component that should redirect to checkout. From this page you get redirected to correct checkout step.

If you want to link to checkout you always point to this page, no matter your checkout setup. On this page in case of multi step checkout you would use your `CheckoutGuard` (more about this in next section). The guard will take care of redirecting to correct checkout step. In case you would want to create single step checkout I would recommend to set all components on this route and remove that guard from component configuration.

Apart from route config there is one other configuration for checkout. In this configuration you define responsibility of each step, route to page and order of steps. Below you can see default configuration (included in library).

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

### Configuration Specification

- **id** - should be an unique value. You could use it when you would need to find specific step in configuration.
- **name** - used in `CheckoutProgress` component which shows steps already completed. We use that name as a translation key.
- **routeName** - this attribute specifies semantic page for this particular step.
- **type** - used by checkout guards. For more information, see [Protecting Routes]({{ site.baseurl }}#protecting-routes) section).

Order in which you define the steps in array is used in navigation buttons. Example: You are on delivery-mode step. Based on the config, delivery mode component back button points to previous step `shippingAddress` and the next button points to `paymentDetails`. If you change order of steps in configuration buttons will automatically reflect those changes and link to correct pages.

## Components

Every checkout component is a CMS component (in the default checkout, all components are [CMSFlexComponents](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/Customizing-CMS-Components/#placeholder-components). You can do with them everything you can do with any other CMS component. Comparing to other CMS components these ones have more guards defined in configuration.

## Protecting Routes

Across spartacus codebase we try to remove page guards and replace them with component guards. The same rule applies in checkout. You protect routes by applying guards in cms component mapping.
Component guards have the same API as page guards. As part of the checkout we expose following guards: `ShippingAddressSetGuard`, `DeliveryModeSetGuard`, `PaymentDetailsSetGuard` and `CheckoutGuard`.

### Example

You want to restrict access to order review only when shipping address, delivery mode and payment details are correctly set. In that case for your review order component you set guards to `guards: [ShippingAddressSetGuard, DeliveryModeSetGuard, PaymentDetailsSetGuard]`. If you access review order page  we start by checking guards for every component on that page. Only if every guard returns `true` we display the page. In case that some guard returns `false` or redirect url we redirect to provided url.

Example behavior:

- user sets the shipping address
- comes back to shop after few days (browser autosuggest review-order page from previous order)
- user follows suggestion
- `ShippingAddressSetGuard` returns `true`
- `DeliveryModeSetGuard` returns `checkout/delivery-mode` redirect
- `PaymentDetailsSetGuard` return `checkout/payment-details` redirect
- users is redirected to delivery mode selection page

Order in guards is important (first redirect is used). Most of the time you should define guards in the same order as user sets the data in checkout flow.

### CheckoutGuard

Special `CheckoutGuard` is responsible for redirects to correct step. Default implementation redirects every checkout request to first step. You can replace it with your own guard (e.g. redirect user to first step that is not set). A custom example is provided in the [Express Checkout Guard]({{ site.baseurl }}#express-checkout) section.

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
