---
title: Open Payment Framework Global Functions
---

For configuring a PSP/Gateway, the open payment framework provides a number of global functions that can be consumed to speed up the configuration of client-side scripts.

## Available Domains

The global functions are organized into three domains:

- **`window.Opf.payments.checkout`** - Available on checkout page when a payment using Hosted-Field pattern has been selected
- **`window.Opf.payments.redirect`** - Available for redirect-based payment flows
- **`window.Opf.payments.global`** - Available globally for CTA (Call-to-Action) scripts

---

## Checkout Domain Functions

| Function | Description | Interface | Usage Example |
|----------|-------------|-----------|---------------|
| **submit** | Manages `/gateway/submit` call for HOSTED_FIELDS OPF which triggers javascript callbacks workflow | `function submit({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentMethod: OpfPaymentMethod, paymentSessionId?: string }): Promise<boolean>` | ```javascript window.Opf.payments.checkout.submit({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Success:', response), submitPending: (response) => console.log('Pending:', response), submitFailure: (response) => console.log('Failed:', response), submitCancel: (response) => console.log('Cancelled:', response), paymentMethod: 'APPLE_PAY' }); ``` |
| **submitComplete** | Manages `/gateway/submit-complete` call for HOSTED_FIELDS OPF which triggers javascript callbacks workflow | `function submitComplete({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentSessionId?: string }): Promise<boolean>` | ```javascript window.Opf.payments.checkout.submitComplete({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Complete success:', response), submitPending: (response) => console.log('Complete pending:', response), submitFailure: (response) => console.log('Complete failed:', response), submitCancel: (response) => console.log('Complete cancelled:', response) }); ``` |
| **throwPaymentError** | Displays a payment error dialog with customizable options | `function throwPaymentError( opfErrorDialogOptions?: OpfErrorDialogOptions ): void` | ```javascript window.Opf.payments.checkout.throwPaymentError({ title: 'Payment Error', message: 'An error occurred during payment processing' }); ``` |
| **startLoadIndicator** | Starts a loading spinner overlay to indicate processing | `function startLoadIndicator(): void` | ```javascript window.Opf.payments.checkout.startLoadIndicator(); ``` |
| **stopLoadIndicator** | Stops the loading spinner overlay | `function stopLoadIndicator(): void` | ```javascript window.Opf.payments.checkout.stopLoadIndicator(); ``` |
| **reinitiatePaymentForm** | Reinitializes the payment form with an optional payment option ID | `function reinitiatePaymentForm( paymentOptionId?: number ): Promise<boolean>` | ```javascript window.Opf.payments.checkout.reinitiatePaymentForm(123).then(success => console.log('Reinitialized:', success)); ``` |

---

## Redirect Domain Functions

| Function | Description | Interface | Usage Example |
|----------|-------------|-----------|---------------|
| **submitCompleteRedirect** | Manages `/gateway/submit-complete` call for redirect-based payment flows with automatic redirect to checkout review page | `function submitCompleteRedirect({ cartId: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback }): Promise<boolean>` | ```javascript window.Opf.payments.redirect.submitCompleteRedirect({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Redirect success:', response), submitPending: (response) => console.log('Redirect pending:', response), submitFailure: (response) => console.log('Redirect failed:', response), submitCancel: (response) => console.log('Redirect cancelled:', response) }); ``` |
| **getRedirectParams** | Retrieves redirect parameters that were configured during function registration | `function getRedirectParams(): Array<OpfKeyValueMap>` | ```javascript const redirectParams = window.Opf.payments.redirect.getRedirectParams(); console.log('Redirect params:', redirectParams); ``` |

---

## Global Domain Functions

| Function | Description | Interface | Usage Example |
|----------|-------------|-----------|---------------|
| **scriptReady** | Notifies the system that a CTA (Call-to-Action) script is ready | `function scriptReady(scriptIdentifier: string): void` | ```javascript window.Opf.payments.global.scriptReady('my-cta-script'); ``` |
| **getCart** | Retrieves the current active cart or a specific cart by ID. If no cartId is provided, it returns the active cart after reloading and waiting for it to be stable | `function getCart(cartId?: string): Promise<Cart \| undefined>` | ```javascript // Get active cart window.Opf.payments.global.getCart().then(cart => { console.log('Active cart:', cart); }); // Get specific cart window.Opf.payments.global.getCart('cart-123').then(cart => { console.log('Cart:', cart); }); ``` |
| **setBillingAddress** | Sets the billing address for the current cart and reloads the cart | `function setBillingAddress(address: Address): Promise<unknown>` | ```javascript window.Opf.payments.global.setBillingAddress({ firstName: 'John', lastName: 'Doe', line1: '123 Main St', town: 'City', postalCode: '12345', country: { isocode: 'US' } }).then(() => { console.log('Billing address set successfully'); }); ``` |
| **getBillingAddress** | Retrieves the billing address from the current active cart | `function getBillingAddress(): Promise<Address \| undefined>` | ```javascript window.Opf.payments.global.getBillingAddress().then(address => { console.log('Billing address:', address); }); ``` |
| **setDeliveryAddress** | Sets the delivery address for the current cart | `function setDeliveryAddress(address: Address): Promise<string>` | ```javascript window.Opf.payments.global.setDeliveryAddress({ firstName: 'Jane', lastName: 'Doe', line1: '456 Oak Ave', town: 'City', postalCode: '67890', country: { isocode: 'US' } }).then(addressId => { console.log('Delivery address set with ID:', addressId); }); ``` |
| **getDeliveryAddress** | Retrieves the delivery address from the current active cart | `function getDeliveryAddress(): Promise<Address \| undefined>` | ```javascript window.Opf.payments.global.getDeliveryAddress().then(address => { console.log('Delivery address:', address); }); ``` |
| **setDeliveryMode** | Sets the delivery mode for the current cart | `function setDeliveryMode(mode: string): Promise<DeliveryMode \| undefined>` | ```javascript window.Opf.payments.global.setDeliveryMode('standard-gross').then(deliveryMode => { console.log('Delivery mode set:', deliveryMode); }); ``` |
| **getDeliveryMode** | Retrieves the delivery mode from the current active cart | `function getDeliveryMode(): Promise<DeliveryMode \| undefined>` | ```javascript window.Opf.payments.global.getDeliveryMode().then(mode => { console.log('Current delivery mode:', mode); }); ``` |
| **deleteAddress** | Deletes a user address by ID | `function deleteAddress(addressId: string): Promise<void>` | ```javascript window.Opf.payments.global.deleteAddress('address-123').then(() => { console.log('Address deleted successfully'); }); ``` |
| **updateCartGuestUserEmail** | Updates the email address for a guest user cart | `function updateCartGuestUserEmail(email: string): Promise<boolean>` | ```javascript window.Opf.payments.global.updateCartGuestUserEmail('guest@example.com').then(success => { console.log('Email updated:', success); }); ``` |
| **createCartGuestUser** | Creates a guest user for the current cart | `function createCartGuestUser(): Promise<boolean>` | ```javascript window.Opf.payments.global.createCartGuestUser().then(success => { console.log('Guest user created:', success); }); ``` |
| **startLoadIndicator** | Starts a global loading spinner overlay to indicate processing | `function startLoadIndicator(): void` | ```javascript window.Opf.payments.global.startLoadIndicator(); ``` |
| **stopLoadIndicator** | Stops the global loading spinner overlay | `function stopLoadIndicator(): void` | ```javascript window.Opf.payments.global.stopLoadIndicator(); ``` |
| **throwPaymentError** | Displays a global payment error dialog with customizable options | `function throwPaymentError( opfErrorDialogOptions?: OpfErrorDialogOptions ): void` | ```javascript window.Opf.payments.global.throwPaymentError({ title: 'Payment Error', message: 'An error occurred during payment processing' }); ``` |
| **initiatePayment** | Initiates a payment session with the provided configuration or configuration ID | `function initiatePayment( configurationIdOrPaymentConfig: string \| number \| OpfPaymentConfig ): Promise<OpfPaymentSessionData>` | ```javascript // Using configuration ID window.Opf.payments.global.initiatePayment('123').then(sessionData => { console.log('Payment session:', sessionData); }); // Using full payment config window.Opf.payments.global.initiatePayment({ configurationId: '123', cartId: 'cart-456', browserInfo: { ... }, resultURL: 'https://example.com/result', cancelURL: 'https://example.com/cancel' }).then(sessionData => { console.log('Payment session:', sessionData); }); ``` |
| **verifyPayment** | Verifies a payment session with the provided verification payload | `function verifyPayment( paymentSessionId: string, paymentVerificationPayload: OpfPaymentVerificationPayload ): Promise<OpfPaymentVerificationResponse>` | ```javascript window.Opf.payments.global.verifyPayment('session-123', { // verification payload data }).then(response => { console.log('Verification response:', response); }); ``` |
| **submit** | Manages `/gateway/submit` call for global domain which triggers javascript callbacks workflow | `function submit({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentMethod: OpfPaymentMethod, paymentSessionId?: string }): Promise<boolean>` | ```javascript window.Opf.payments.global.submit({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Success:', response), submitPending: (response) => console.log('Pending:', response), submitFailure: (response) => console.log('Failed:', response), submitCancel: (response) => console.log('Cancelled:', response), paymentMethod: 'APPLE_PAY', paymentSessionId: 'session-456' }); ``` |
| **submitComplete** | Manages `/gateway/submit-complete` call for global domain which triggers javascript callbacks workflow | `function submitComplete({ cartId?: string, additionalData: Array<OpfKeyValueMap>, submitSuccess: OpfPaymentMerchantCallback = noop, submitPending: OpfPaymentMerchantCallback = noop, submitFailure: OpfPaymentMerchantCallback = noop, submitCancel?: OpfPaymentMerchantCallback, paymentSessionId?: string }): Promise<boolean>` | ```javascript window.Opf.payments.global.submitComplete({ cartId: 'cart-123', additionalData: [{key: 'returnUrl', value: 'https://returnUrl/'}], submitSuccess: (response) => console.log('Complete success:', response), submitPending: (response) => console.log('Complete pending:', response), submitFailure: (response) => console.log('Complete failed:', response), submitCancel: (response) => console.log('Complete cancelled:', response), paymentSessionId: 'session-456' }); ``` |

---

## Callback Types

All callback functions follow the `OpfPaymentMerchantCallback` type:

```typescript
type OpfPaymentMerchantCallback = (
  response?: OpfPaymentSubmitResponse | OpfPaymentSubmitCompleteResponse
) => void | Promise<void>;
```

**Callback Parameters:**
- `submitSuccess`: Called when payment is successful
- `submitPending`: Called when payment is pending
- `submitFailure`: Called when payment fails
- `submitCancel`: Called when payment is cancelled (optional)

---

## Usage Examples

### Basic Submit Usage with Cancel Callback

```javascript
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
    // Handle cancellation - e.g., redirect to payment selection
    window.location.href = '/checkout/payment';
  },
  paymentMethod: 'APPLE_PAY'
});
```

### Submit Complete with Cancel Callback

```javascript
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
    // Handle cancellation - e.g., redirect to payment selection
    window.location.href = '/checkout/payment';
  }
});
```

### Redirect Submit Complete with Cancel Callback

```javascript
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

### Error Handling

```javascript
window.Opf.payments.checkout.throwPaymentError({
  title: 'Payment Error',
  message: 'An error occurred during payment processing'
});
```

### Loading Indicators

```javascript
// Start loading
window.Opf.payments.checkout.startLoadIndicator();

// Perform payment operation
// ...

// Stop loading
window.Opf.payments.checkout.stopLoadIndicator();
```

### Redirect Parameters

```javascript
const redirectParams = window.Opf.payments.redirect.getRedirectParams();
console.log('Redirect parameters:', redirectParams);
```

### Payment Form Reinitialization

```javascript
// Reinitialize with specific payment option
window.Opf.payments.checkout.reinitiatePaymentForm(123);

// Reinitialize with default payment option
window.Opf.payments.checkout.reinitiatePaymentForm();
```

### Script Ready Notification

```javascript
window.Opf.payments.global.scriptReady('my-cta-script');
```

### Cart Management

```javascript
// Get active cart
window.Opf.payments.global.getCart().then(cart => {
  console.log('Cart total:', cart.totalPrice);
});

// Get specific cart
window.Opf.payments.global.getCart('cart-123').then(cart => {
  console.log('Cart items:', cart.entries);
});
```

### Address Management

```javascript
// Set billing address
window.Opf.payments.global.setBillingAddress({
  firstName: 'John',
  lastName: 'Doe',
  line1: '123 Main St',
  town: 'City',
  postalCode: '12345',
  country: { isocode: 'US' }
});

// Get billing address
window.Opf.payments.global.getBillingAddress().then(address => {
  console.log('Billing address:', address);
});

// Set delivery address
window.Opf.payments.global.setDeliveryAddress({
  firstName: 'Jane',
  lastName: 'Doe',
  line1: '456 Oak Ave',
  town: 'City',
  postalCode: '67890',
  country: { isocode: 'US' }
});

// Delete address
window.Opf.payments.global.deleteAddress('address-123');
```

### Delivery Mode Management

```javascript
// Set delivery mode
window.Opf.payments.global.setDeliveryMode('standard-gross').then(mode => {
  console.log('Delivery mode set:', mode);
});

// Get delivery mode
window.Opf.payments.global.getDeliveryMode().then(mode => {
  console.log('Current delivery mode:', mode);
});
```

### Guest User Management

```javascript
// Update guest user email
window.Opf.payments.global.updateCartGuestUserEmail('guest@example.com');

// Create guest user
window.Opf.payments.global.createCartGuestUser();
```

### Payment Initiation and Verification

```javascript
// Initiate payment
window.Opf.payments.global.initiatePayment('123').then(sessionData => {
  console.log('Payment session ID:', sessionData.paymentSessionId);
});

// Verify payment
window.Opf.payments.global.verifyPayment('session-123', {
  // verification payload
}).then(response => {
  console.log('Verification result:', response);
});
```

---

## Cancel Callback Scenarios

### Example Cancel Callback Implementation

```javascript
submitCancel: (response) => {
  // Log the cancellation
  console.log('Payment cancelled:', response);
  
  // Show user-friendly message
  alert('Payment was cancelled. Please try again or select a different payment method.');
  
  // Redirect to payment selection
  window.location.href = '/checkout/payment';
  
  // Or reset the payment form
  // resetPaymentForm();
}
```

---

## Payment Reinitialization on Error

The `reinitiatePaymentForm` function can be used to reset and reinitialize the payment form when errors occur. This is particularly useful for handling payment failures and allowing users to retry.

### Example: Reinitialize Payment on Failure

```javascript
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
    
    // Show error message to user
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
    
    // Reinitialize payment form on cancellation
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

### Example: Reinitialize with Specific Payment Option

```javascript
// When a specific payment option fails, reinitialize with a different option
submitFailure: (response) => {
  console.log('Payment failed:', response);
  
  // Reinitialize with a different payment option ID
  const alternativePaymentOptionId = 456; // Different payment method
  
  window.Opf.payments.checkout.reinitiatePaymentForm(alternativePaymentOptionId)
    .then((success) => {
      if (success) {
        console.log('Payment form reinitialized with alternative payment option');
        // Update UI to show the new payment option
        updatePaymentOptionUI(alternativePaymentOptionId);
      }
    });
}
```

