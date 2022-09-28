---
title: Extending Checkout
---

The checkout feature in Spartacus is CMS-driven, which means every page in the checkout flow is based on CMS pages, slots and components. As a result, you can change the content of each page, add new components, convert the checkout into a single-step checkout, or create very sophisticated multi-step checkout flows with only a minimal amount of configuration in the storefront application.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Routing and Configuration

In the checkout, you often have links from one step to another, which is the reason for registering each checkout page as a semantic page in the storefront configuration.

The following is the default route configuration for checkout:

```typescript
provideConfig({
  routing: {
    routes: {
      checkout: {
        paths: ['checkout'],
      },
      checkoutDeliveryAddress: {
        paths: ['checkout/delivery-address']
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
provideConfig({
  checkout: {
    steps: [
      {
        id: 'deliveryAddress',
        name: 'checkoutProgress.deliveryAddress',
        routeName: 'checkoutDeliveryAddress',
        type: [CheckoutStepType.DELIVERY_ADDRESS],
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
}),
```

The attributes in the `steps` array work as follows:

- The `id` attribute should have a unique value. You can use `id` when you need to identify a specific step in the configuration.
- The `name` attribute is used in the `CheckoutProgress` component to indicate which checkout steps have been completed. The `name` is also used as a translation key.
- The `routeName` attribute specifies the semantic page for each step.
- The `type` attribute is used by the checkout guards. For more information, see [Protecting Routes](#protecting-routes).

Also, the order of the steps in the `steps` array determines which steps are "previous" and "next" for the navigation buttons in the checkout flow. For example, based on the default configuration, the **Back** button for the delivery mode component points to the previous `shippingAddress` step, while the **Next** button points to the `paymentDetails` step. If you change the order of the steps in the configuration, the navigation buttons automatically update to link to the correct pages.

## Components

Every checkout component is a CMS component. Furthermore, in the default checkout, all components are [CMSFlexComponents]({{ site.baseurl }}/customizing-cms-components/#placeholder-components). Compared to other CMS components, these components have more guards defined in the configuration, but are otherwise identical to regular CMS components.

## Protecting Routes

The checkout uses component guards instead of page guards. You protect routes by applying guards in the CMS component mapping.

Component guards have the same API as page guards. Spartacus exposes the following guards as part of the checkout:

- `CheckoutStepsSetGuard`
- `CheckoutGuard`
- `CheckoutAuthGuard`
- `CartNotEmptyGuard`
- `NotCheckoutAuthGuard`

## CheckoutStepsSetGuard

As an example, if you wanted to restrict access to the Review Order page, so that it displays only when the delivery address, delivery mode and payment details were correctly set, you would set guards for the review order component to `guards: [CheckoutStepsSetGuard]`.

```typescript
    provideDefaultConfig(<CmsConfig>{
      cmsComponents: {
        CustomCheckoutName: {
          component: CustomNameComponent,
          guards: [CheckoutStepsSetGuard],
        },
      },
    }),
```

Then, when you try to access the Review Order page, Spartacus first checks the guards for every component on that page, and only displays the page if every guard returns `true`. If one of the guard returns `false`, or returns a redirect URL, Spartacus redirects to the provided URL.

The following is an example scenario:

1. A user sets the shipping address.
2. The user comes back to shop after a few days, and the browser auto-suggests the Review Order page from a previous order.
3. The user follows the suggestion.
4. The `CheckoutStepsSetGuard` of method `isDeliveryAddress` returns `true`.
5. The `CheckoutStepsSetGuard` of method `isDeliveryModeSet` returns `checkout/delivery-mode` redirect.
6. The `CheckoutStepsSetGuard` of method `isPaymentDetailsSet` returns `checkout/payment-details` redirect.
7. The user is redirected to the Delivery Mode selection page.

Note: Since Spartacus 2.1 and above, we have unified the guards to use `CheckoutStepsSetGuard` instead. With previous Spartacus versions, we depended on `ShippingAddressSetGuard`, `DeliveryModeSetGuard`, and`PaymentDetailsSetGuard`.

The following is an example on how you can extend the `CheckoutStepsSetGuard` in order to change the behavior on what the function(s) would return.

```typescript
@Injectable({
  providedIn: 'root',
})
export class CustomCheckoutStepsSetGuard extends CheckoutStepsSetGuard {
  constructor(
    protected checkoutStepService: CheckoutStepService,
    protected routingConfigService: RoutingConfigService,
    protected checkoutDeliveryAddressFacade: CheckoutDeliveryAddressFacade,
    protected checkoutPaymentFacade: CheckoutPaymentFacade,
    protected checkoutDeliveryModesFacade: CheckoutDeliveryModesFacade,
    protected router: Router
  ) {
    super(
      checkoutStepService,
      routingConfigService,
      checkoutDeliveryAddressFacade,
      checkoutPaymentFacade,
      checkoutDeliveryModesFacade,
      router
    );
  }

  protected isDeliveryModeSet(
    step: CheckoutStep
  ): Observable<boolean | UrlTree> {
    // insert custom logic
    // ...
  }
}
```

Note: make sure to place the dependency provider and have it use the `CustomCheckoutStepsSetGuard` in your module.

```typescript
@NgModule({
  ...
  providers: [
    {
      provide: CheckoutStepsSetGuard,
      useClass: CustomCheckoutStepsSetGuard
    }
  ]
})
export class SomeModuleName {}
```

### CheckoutGuard

A special `CheckoutGuard` is responsible for redirecting to the correct step. The default implementation redirects every checkout request to the first step. You can replace this with your own guard (for example, you could redirect users to the first step that is not set). A custom example is provided in the [Express Checkout](#express-checkout) section, below.

### CheckoutAuthGuard

`CheckoutAuthGuard` is responsible for handling guest and authenticated users to allow them to checkout. However, if they are an anonymous user, it will redirect the user to the login page.

### CartNotEmptyGuard

`CartNotEmptyGuard` is responsible for redirecting the user if they are trying to visit a checkout route when there active cart is currently empty. If the active cart is empty, it redirects the user to homepage, else it will allow them to go through the checkout flow.

### NotCheckoutAuthGuard

- TBD (pretty redundant I think)

### Configuring Where Guards Redirect To

In the checkout configuration, for each step, you specify a `type` attribute and the type of data that should be set. A guard looks for the first step that contains the specific `type` and then redirects to this step.

For example, `CheckoutStepsSetGuard` searches the checkout configuration for every step with a `type` containing `CheckoutStepType.deliveryAddress`, `CheckoutStepType.deliveryMode`, `CheckoutStepType.paymentDetails`, `CheckoutStepType.reviewOrder`, then reads the step route and redirects to that page.

Note that, on each checkout step, you can have multiple components. As a result, the `type` property is an array.

## CMS Catalog Content and Default Template

In the default checkout, Spartacus uses a modified `MultiStepCheckoutOrderSummaryPageTemplate`. In addition to `BodyContent` and `SideContent`, Spartacus includes `TopContent` and `BottomContent` for 100% of the sections above and below the `BodyContent` and `SideContent` page slots.

For the default checkout flow, Spartacus includes an impex file with all pages, slots, components and relations configured. This impex is available as part of the `spartacussampledata` extension. For more information, see [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %})

## Extensibility

The following sections describe some common ways to modify the checkout. Of course, you can also extend checkout services and components like any other services and components that are shipped with the Spartacus libraries.

### Changing the Order of the Checkout Flow

The following scenario describes how to change the order of two steps. In the default configuration, the checkout flow starts with setting a shipping address, followed by setting the delivery mode, and finally by filling in the payment details. In this scenario, the configuration is modified so that the payment details step occurs before the delivery mode step.

To achieve this, you change the checkout configuration in the storefront configuration, and change the guards in the CMS components that are used on the checkout pages. The following is an example:

```ts
provideConfig({
  ...restOfConfig,
  checkout: {
    // You must specify all of the steps (this configuration is not merged with the default one)
    steps: [
      {
        id: 'deliveryAddress',
        name: 'checkoutProgress.deliveryAddress',
        routeName: 'checkoutDeliveryAddress',
        type: [CheckoutStepType.DELIVERY_ADDRESS],
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
      guards: [CheckoutAuthGuard, CartNotEmptyGuard, ShippingAddressSetGuard],
    },
    CheckoutDeliveryMode: {
      component: DeliveryModeComponent,
      // In the CheckoutDeliveryMode, we need to also check if the payment details are set, so we add the PaymentDetailsSetGuard
      guards: [
        CheckoutAuthGuard,
        CartNotEmptyGuard,
        ShippingAddressSetGuard,
        PaymentDetailsSetGuard,
      ],
    },
  },
}),
```

### Adding Another Checkout Step

To add an extra checkout step, the approach is similar to changing the order of the checkout flow: you provide the checkout configuration in the storefront configuration, and set the page, slots, and components in CMS. The following is an example:

```ts
provideConfig({
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
```

### Combining Checkout Steps

Combining checkout steps is also very similar to the previous examples. In most cases, the required steps are the following:

- Configure new pages, slots, and components in CMS
- Adjust the configuration of the steps (for example, add/combine/remove steps)
- Map your own Angular components to the CMS components
- Review the component guards and adjust if needed
- Check for missing translations

In addition to combining steps, the following example shows how to create a new component, which is very similar to the `DeliveryModeComponent` except that it has a **Save** button instead of a **Next** button. Note, this **Save** button only saves information, without a redirect.

```ts
provideConfig({
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
        id: 'deliveryAddress',
        name: 'checkoutProgress.deliveryAddress',
        routeName: 'checkoutDeliveryAddress',
        type: [CheckoutStepType.DELIVERY_ADDRESS],
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
      guards: [CheckoutAuthGuard, CartNotEmptyGuard],
    },
  },
}),
```

**Note:** You can use this same approach to combine all the steps into a single-step checkout.

### Express Checkout

The following scenario describes how to provide express checkout for users who have previously ordered from this store. In this example, when the **Express Checkout** button is clicked, the user is brought directly to the Review Order page, which is populated with the default address, the default payment method, and the fastest shipping method.

Clicking the default checkout button redirects to the `/checkout` route. To invoke express checkout, you need to pass the additional `express` query param.

The first step in setting up express checkout is to create an `ExpressCheckoutGuard`. The following is an example:

```ts
import { Injectable } from '@angular/core';
import {
  CanActivate,
  Router,
  UrlTree,
  ActivatedRouteSnapshot,
} from '@angular/router';
import { CheckoutConfig } from '../config/checkout-config';
import { RoutingConfigService } from '@spartacus/core';

@Injectable({
  providedIn: 'root',
})
export class ExpressCheckoutGuard implements CanActivate {
  constructor(
    private router: Router,
    private config: CheckoutConfig,
    private routingConfigService: RoutingConfigService,
    private checkoutConfigService: CheckoutConfigService
  ) {}

  canActivate(route: ActivatedRouteSnapshot): Observable<boolean | UrlTree> {
    // Check for the express query param
    if (route.queryParams.express) {
      // To avoid a long example, the following are only steps, instead of real code:
      // 1. Fetch the default delivery address, payment method and delivery mode.
      // 2. Set those defaults in the order.
      // 3. Watch for order details and return the review order URL.
      const checkoutStep: CheckoutStep =
        this.checkoutConfigService.getCheckoutStep(
          CheckoutStepType.REVIEW_ORDER
        );

      return this.router.parseUrl(
        checkoutStep &&
          this.routingConfigService.getRouteConfig(checkoutStep.routeName)
            .paths[0]
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

```ts
provideConfig({
  cmsComponents: {
    CheckoutOrchestrator: {
      component: CheckoutOrchestratorComponent,
      // Replace the CheckoutGuard with the ExpressCheckoutGuard for the Checkout Orchestrator
      guards: [CheckoutAuthGuard, CartNotEmptyGuard, ExpressCheckoutGuard],
    },
  },
}),
```

Express checkout is now ready. The only steps that remain are to create express checkout links, and to place them on the page.

## B2B Checkout

In the Spartacus B2B storefront, the checkout includes the same steps as the B2C storefront, with the addition of a step for selecting the payment method. This step allows you to choose if you want to pay with an account or with a credit card, and also allows you to enter an optional PO number.

With the credit card payment option, the B2B checkout is configured to work the same as the B2C checkout.

With the account payment option, you can only select the addresses of cost centers that you are assigned to as a purchaser. Also, when you select the account payment option, it allows you to skip the payment details step.

### Known Issues

When you start the checkout process, if the screen is blank and seems to be stuck loading, it means that you are missing the payment method step from your CMS. To resolve this issue, make sure that you are using `spartacussampledata` version 5.0.0 or newer, and that you are using SAP Commerce Cloud 2105 or newer.

If you only want to add the payment method step, you can do so by running the following ImpEx:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;CheckoutPaymentType;Checkout Payment Type Page;MultiStepCheckoutSummaryPageTemplate;/checkout/payment-type

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutPaymentType;Checkout Payment Type Slot;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,CheckoutPaymentTypeComponent,CheckoutProgressMobileBottomComponent
;;SideContentSlot-checkoutPaymentType;Order Summary Slot;CheckoutOrderSummaryComponent

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;CheckoutPaymentTypeComponent;Checkout Payment Type Component;CheckoutPaymentType
```
