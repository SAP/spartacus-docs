---
title: Open Payment Framework Global Functions
---

To help you configure your Payment Service Provider (PSP) or Gateway, the open payment framework provides a number of global functions that you can use to speed up the configuration of client-side scripts.

The global functions are organized into the following domains:

- `window.Opf.payments.checkout`, which is available on the checkout page when a payment using the Hosted-Field pattern has been selected.
- `window.Opf.payments.redirect`, which is available for redirect-based payment flows.
- `window.Opf.payments.global`, which is available globally for Call-to-Action (CTA) scripts.

All callback functions follow the `OpfPaymentMerchantCallback` type, as shown in the following example:

```typescript
type OpfPaymentMerchantCallback = (
  response?: OpfPaymentSubmitResponse | OpfPaymentSubmitCompleteResponse
) => void | Promise<void>;
```

The following list describes the available callback parameters:

- `submitSuccess` is called when a payment is successful.
- `submitPending` is called when a payment is pending.
- `submitFailure` is called when a payment fails.
- `submitCancel` is called when a payment is cancelled. This callback parameter is optional.

## Checkout Domain Functions

The following table provides descriptions and usage examples of the checkout domain functions.

| Function | Description | Interface | Usage Example |
| --- | --- | --- | --- |
| `submit` | Manages the `/gateway/submit` call for `HOSTED_FIELDS` open payment framework, which triggers a callbacks workflow in JavaScript | `function submit({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentMethod: OpfPaymentMethod, paymentSessionId?: string }): Promise<boolean>` | `window.Opf.payments.checkout.submit({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Success:', response), submitPending: (response) => console.log('Pending:', response), submitFailure: (response) => console.log('Failed:', response), submitCancel: (response) => console.log('Cancelled:', response), paymentMethod: 'APPLE_PAY' });` |
| `submitComplete` | Manages the `/gateway/submit-complete` call for `HOSTED_FIELDS` open payment framework, which triggers a callbacks workflow in JavaScript | `function submitComplete({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentSessionId?: string }): Promise<boolean>` | `window.Opf.payments.checkout.submitComplete({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Complete success:', response), submitPending: (response) => console.log('Complete pending:', response), submitFailure: (response) => console.log('Complete failed:', response), submitCancel: (response) => console.log('Complete cancelled:', response) });` |
| `throwPaymentError` | Displays a payment error dialog with customizable options | `function throwPaymentError( opfErrorDialogOptions?: OpfErrorDialogOptions ): void` | `window.Opf.payments.checkout.throwPaymentError({ title: 'Payment Error', message: 'An error occurred during payment processing' });` |
| `startLoadIndicator` | Starts a loading spinner overlay to indicate processing | `function startLoadIndicator(): void` | `window.Opf.payments.checkout.startLoadIndicator();` |
| `stopLoadIndicator` | Stops the loading spinner overlay | `function stopLoadIndicator(): void` | `window.Opf.payments.checkout.stopLoadIndicator();` |
| `reinitiatePaymentForm` | Reinitializes the payment form with an optional payment option ID | `function reinitiatePaymentForm( paymentOptionId?: number ): Promise<boolean>` | `window.Opf.payments.checkout.reinitiatePaymentForm(123).then(success => console.log('Reinitialized:', success));` |

## Redirect Domain Functions

The following table provides descriptions and usage examples of the redirect domain functions.

| Function | Description | Interface | Usage Example |
| --- | --- | --- | --- |
| `submitCompleteRedirect` | Manages the `/gateway/submit-complete` call for redirect-based payment flows with automatic redirect to the checkout review page | `function submitCompleteRedirect({ cartId: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback }): Promise<boolean>` | `window.Opf.payments.redirect.submitCompleteRedirect({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Redirect success:', response), submitPending: (response) => console.log('Redirect pending:', response), submitFailure: (response) => console.log('Redirect failed:', response), submitCancel: (response) => console.log('Redirect cancelled:', response) });` |
| `getRedirectParams` | Retrieves redirect parameters that were configured during function registration | `function getRedirectParams(): Array<OpfKeyValueMap>` | `const redirectParams = window.Opf.payments.redirect.getRedirectParams(); console.log('Redirect params:', redirectParams);` |

## Global Domain Functions

The following table provides descriptions and usage examples of the global domain functions.

| Function | Description | Interface | Usage Example |
| --- | --- | --- | --- |
| `scriptReady` | Notifies the system that a Call-to-Action (CTA) script is ready | `function scriptReady(scriptIdentifier: string): void` | `window.Opf.payments.global.scriptReady('my-cta-script');` |
| `getCart` | Retrieves the current active cart or a specific cart by ID. If no `cartId` is provided, it returns the active cart after reloading and waiting for it to be stable | `function getCart(cartId?: string): Promise<Cart \| undefined>` | `// Get active cart` <br> `window.Opf.payments.global.getCart().then(cart => { console.log('Active cart:', cart); });` <br> `// Get specific cart` <br> `window.Opf.payments.global.getCart('cart-123').then(cart => { console.log('Cart:', cart); });` |
| `setBillingAddress` | Sets the billing address for the current cart and reloads the cart | `function setBillingAddress(address: Address): Promise<unknown>` | `window.Opf.payments.global.setBillingAddress({ firstName: 'John', lastName: 'Doe', line1: '123 Main St', town: 'City', postalCode: '12345', country: { isocode: 'US' } }).then(() => { console.log('Billing address set successfully'); });` |
| `getBillingAddress` | Retrieves the billing address from the current active cart | `function getBillingAddress(): Promise<Address \| undefined>` | `window.Opf.payments.global.getBillingAddress().then(address => { console.log('Billing address:', address); });` |
| `setDeliveryAddress` | Sets the delivery address for the current cart | `function setDeliveryAddress(address: Address): Promise<string>` | `window.Opf.payments.global.setDeliveryAddress({ firstName: 'Jane', lastName: 'Doe', line1: '456 Oak Ave', town: 'City', postalCode: '67890', country: { isocode: 'US' } }).then(addressId => { console.log('Delivery address set with ID:', addressId); });` |
| `getDeliveryAddress` | Retrieves the delivery address from the current active cart | `function getDeliveryAddress(): Promise<Address \| undefined>` | `window.Opf.payments.global.getDeliveryAddress().then(address => { console.log('Delivery address:', address); });` |
| `setDeliveryMode` | Sets the delivery mode for the current cart | `function setDeliveryMode(mode: string): Promise<DeliveryMode \| undefined>` | `window.Opf.payments.global.setDeliveryMode('standard-gross').then(deliveryMode => { console.log('Delivery mode set:', deliveryMode); });` |
| `getDeliveryMode` | Retrieves the delivery mode from the current active cart | `function getDeliveryMode(): Promise<DeliveryMode \| undefined>` | `window.Opf.payments.global.getDeliveryMode().then(mode => { console.log('Current delivery mode:', mode); });` |
| `deleteAddress` | Deletes a user address by ID | `function deleteAddress(addressId: string): Promise<void>` | `window.Opf.payments.global.deleteAddress('address-123').then(() => { console.log('Address deleted successfully'); });` |
| `updateCartGuestUserEmail` | Updates the email address for a guest user cart | `function updateCartGuestUserEmail(email: string): Promise<boolean>` | `window.Opf.payments.global.updateCartGuestUserEmail('guest@example.com').then(success => { console.log('Email updated:', success); });` |
| `createCartGuestUser` | Creates a guest user for the current cart | `function createCartGuestUser(): Promise<boolean>` | `window.Opf.payments.global.createCartGuestUser().then(success => { console.log('Guest user created:', success); });` |
| `startLoadIndicator` | Starts a global loading spinner overlay to indicate processing | `function startLoadIndicator(): void` | `window.Opf.payments.global.startLoadIndicator();` |
| `stopLoadIndicator` | Stops the global loading spinner overlay | `function stopLoadIndicator(): void` | `window.Opf.payments.global.stopLoadIndicator();` |
| `throwPaymentError` | Displays a global payment error dialog with customizable options | `function throwPaymentError( opfErrorDialogOptions?: OpfErrorDialogOptions ): void` | `window.Opf.payments.global.throwPaymentError({ title: 'Payment Error', message: 'An error occurred during payment processing' });` |
| `initiatePayment` | Initiates a payment session with the provided configuration or configuration ID | `function initiatePayment( configurationIdOrPaymentConfig: string \| number \| OpfPaymentConfig ): Promise<OpfPaymentSessionData>` | `// Using configuration ID` <br> `window.Opf.payments.global.initiatePayment('123').then(sessionData => { console.log('Payment session:', sessionData); });` <br> `// Using full payment config` <br> `window.Opf.payments.global.initiatePayment({ configurationId: '123', cartId: 'cart-456', browserInfo: { ... }, resultURL: 'https://example.com/result', cancelURL: 'https://example.com/cancel' }).then(sessionData => { console.log('Payment session:', sessionData); });` |
| `verifyPayment` | Verifies a payment session with the provided verification payload | `function verifyPayment( paymentSessionId: string, paymentVerificationPayload: OpfPaymentVerificationPayload ): Promise<OpfPaymentVerificationResponse>` | `window.Opf.payments.global.verifyPayment('session-123', {` <br> `// verification payload data` <br> `}).then(response => { console.log('Verification response:', response); });` |
| `submit` | Manages the `/gateway/submit` call for the global domain, which triggers a callbacks workflow in JavaScript | `function submit({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentMethod: OpfPaymentMethod, paymentSessionId?: string }): Promise<boolean>` | `window.Opf.payments.global.submit({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Success:', response), submitPending: (response) => console.log('Pending:', response), submitFailure: (response) => console.log('Failed:', response), submitCancel: (response) => console.log('Cancelled:', response), paymentMethod: 'APPLE_PAY', paymentSessionId: 'session-456' });` |
| `submitComplete` | Manages the `/gateway/submit-complete` call for the global domain, which triggers a callbacks workflow in JavaScript | `function submitComplete({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentSessionId?: string }): Promise<boolean>` | `window.Opf.payments.global.submitComplete({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Complete success:', response), submitPending: (response) => console.log('Complete pending:', response), submitFailure: (response) => console.log('Complete failed:', response), submitCancel: (response) => console.log('Complete cancelled:', response), paymentSessionId: 'session-456' });` |

## Working With Open Payment Framework Global Functions

The following code examples demonstrate how to work with open payment framework global functions.

This is an example of using the `submit` function with all of the available callback parameters, including the cancel callback:

```ts
window.Opf.payments.checkout.submit({
  cartId: 'current-cart-id',
  additionalData: [
    { key: 'returnUrl', value: 'https://returnUrl/' },
    { key: 'allow3DS2', value: 'true' },
    { key: 'originUrl', value: 'https://originUrl/' }
  ],
  submitSuccess: (response) => {
    console.log('Payment successful:', response);
  },
  submitPending: (response) => {
    console.log('Payment pending:', response);
  },
  submitFailure: (response) => {
    console.log('Payment failed:', response);
  },
  submitCancel: (response) => {
    console.log('Payment cancelled:', response);
    // Handle cancellation by redirecting to payment selection
    window.location.href = '/checkout/payment';
  },
  paymentMethod: 'APPLE_PAY'
});
```

This is an example of using the `submitComplete` function with all of the available callback parameters, including the cancel callback:

```ts
window.Opf.payments.checkout.submitComplete({
  cartId: 'current-cart-id',
  additionalData: [
    { key: 'returnUrl', value: 'https://returnUrl/' },
    { key: 'allow3DS2', value: 'true' }
  ],
  submitSuccess: (response) => {
    console.log('Payment completion successful:', response);
  },
  submitPending: (response) => {
    console.log('Payment completion pending:', response);
  },
  submitFailure: (response) => {
    console.log('Payment completion failed:', response);
  },
  submitCancel: (response) => {
    console.log('Payment completion cancelled:', response);
    // Handle cancellation by redirecting to payment selection
    window.location.href = '/checkout/payment';
  }
});
```

This is an example of using the `submitCompleteRedirect` function with all of the available callback parameters, including the cancel callback:

```ts
window.Opf.payments.redirect.submitCompleteRedirect({
  cartId: 'current-cart-id',
  additionalData: [
    { key: 'returnUrl', value: 'https://returnUrl/' },
    { key: 'allow3DS2', value: 'true' }
  ],
  submitSuccess: (response) => {
    console.log('Redirect payment completion successful:', response);
  },
  submitPending: (response) => {
    console.log('Redirect payment completion pending:', response);
  },
  submitFailure: (response) => {
    console.log('Redirect payment completion failed:', response);
  },
  submitCancel: (response) => {
    console.log('Redirect payment completion cancelled:', response);
    // Handle cancellation for redirect flows
    window.location.href = '/checkout/review';
  }
});
```

This is an example of working with error handling:

```ts
window.Opf.payments.checkout.throwPaymentError({
  title: 'Payment Error',
  message: 'An error occurred during payment processing'
});
```

This is an example of working with loading indicators:

```ts
// Start loading
window.Opf.payments.checkout.startLoadIndicator();

// Perform payment operation
// ...

// Stop loading
window.Opf.payments.checkout.stopLoadIndicator();
```

This is an example of working with redirect parameters:

```ts
const redirectParams = window.Opf.payments.redirect.getRedirectParams();
console.log('Redirect parameters:', redirectParams);
```

This is an example of working with payment form reinitialization:

```ts
// Reinitialize with a specific payment option
window.Opf.payments.checkout.reinitiatePaymentForm(123);

// Reinitialize with the default payment option
window.Opf.payments.checkout.reinitiatePaymentForm();
```

This is an example of working with script-ready notifications:

```ts
window.Opf.payments.global.scriptReady('my-cta-script');
```

This is an example of working with cart management:

```ts
// Get the active cart
window.Opf.payments.global.getCart().then(cart => {
  console.log('Cart total:', cart.totalPrice);
});

// Get a specific cart
window.Opf.payments.global.getCart('cart-123').then(cart => {
  console.log('Cart items:', cart.entries);
});
```

This is an example of working with address management:

```ts
// Set the billing address
window.Opf.payments.global.setBillingAddress({
  firstName: 'John',
  lastName: 'Doe',
  line1: '123 Main St',
  town: 'City',
  postalCode: '12345',
  country: { isocode: 'US' }
});

// Get the billing address
window.Opf.payments.global.getBillingAddress().then(address => {
  console.log('Billing address:', address);
});

// Set the delivery address
window.Opf.payments.global.setDeliveryAddress({
  firstName: 'Jane',
  lastName: 'Doe',
  line1: '456 Oak Ave',
  town: 'City',
  postalCode: '67890',
  country: { isocode: 'US' }
});

// Delete an address
window.Opf.payments.global.deleteAddress('address-123');
```

This is an example of working with delivery mode management:

```ts
// Set the delivery mode
window.Opf.payments.global.setDeliveryMode('standard-gross').then(mode => {
  console.log('Delivery mode set:', mode);
});

// Get the delivery mode
window.Opf.payments.global.getDeliveryMode().then(mode => {
  console.log('Current delivery mode:', mode);
});
```

This is an example of working with guest user management:

```ts
// Update the guest user's email address
window.Opf.payments.global.updateCartGuestUserEmail('guest@example.com');

// Create a guest user
window.Opf.payments.global.createCartGuestUser();
```

This is an example of working with payment initiation and verification:

```ts
// Initiate a payment
window.Opf.payments.global.initiatePayment('123').then(sessionData => {
  console.log('Payment session ID:', sessionData.paymentSessionId);
});

// Verify a payment
window.Opf.payments.global.verifyPayment('session-123', {
  // verification payload
}).then(response => {
  console.log('Verification result:', response);
});
```

## Cancel Callback Scenario

The following is an example of a cancel callback implementation:

```ts
submitCancel: (response) => {
  // Log the cancellation
  console.log('Payment cancelled:', response);
  
  // Show a user-friendly message
  alert('Payment was cancelled. Please try again or select a different payment method.');
  
  // Redirect to the payment selection
  window.location.href = '/checkout/payment';
  
  // Or reset the payment form
  // resetPaymentForm();
}
```

## Payment Reinitialization on Error

The `reinitiatePaymentForm` function can be used to reset and reinitialize the payment form when an error occurs. This is particularly useful for handling payment failures and allowing users to retry.

The following is an example of reinitializing the payment on failure:

```ts
window.Opf.payments.checkout.submit({
  cartId: 'current-cart-id',
  additionalData: [
    { key: 'returnUrl', value: 'https://returnUrl/' },
    { key: 'allow3DS2', value: 'true' }
  ],
  submitSuccess: (response) => {
    console.log('Payment successful:', response);
  },
  submitPending: (response) => {
    console.log('Payment pending:', response);
  },
  submitFailure: (response) => {
    console.log('Payment failed:', response);
    
    // Show an error message to the user
    alert('Payment failed. Please try again.');
    
    // Reinitialize the payment form to allow retry
    window.Opf.payments.checkout.reinitiatePaymentForm()
      .then((success) => {
        if (success) {
          console.log('Payment form reinitialized successfully');
          // Optionally refresh the payment form UI
          refreshPaymentFormUI();
        }
      })
      .catch((error) => {
        console.error('Failed to reinitialize payment form:', error);
      });
  },
  submitCancel: (response) => {
    console.log('Payment cancelled:', response);
    
    // Reinitialize the payment form on cancellation
    window.Opf.payments.checkout.reinitiatePaymentForm()
      .then((success) => {
        if (success) {
          console.log('Payment form reset after cancellation');
        }
      });
  },
  paymentMethod: 'APPLE_PAY'
});
```

The following is an example of reinitializing with a specific payment option:

```ts
// When a specific payment option fails, reinitialize with a different option
submitFailure: (response) => {
  console.log('Payment failed:', response);
  
  // Reinitialize with a different payment option ID
  const alternativePaymentOptionId = 456; // Different payment method
  
  window.Opf.payments.checkout.reinitiatePaymentForm(alternativePaymentOptionId)
    .then((success) => {
      if (success) {
        console.log('Payment form reinitialized with alternative payment option');
        // Update the UI to show the new payment option
        updatePaymentOptionUI(alternativePaymentOptionId);
      }
    });
}
```
