---
title: Express Checkout (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Express checkout allows the user to skip all steps and sees the review summary page instantly after click "Go to checkout".

The guard will check that the user has at least 1 shipping address and 1 payment method - if there are more it will choose default. After setup address, it will choose the default delivery mode for current configuration. 

If everything has been successful, the user should be redirected to review summary. Else, he will go through the checkout steps. 

In the review summary step, the user will see pre-set data, there is also the possibility to update step.


## Configuration

Functionality is steering by 2 new optional properties:

* Flag `express`: Allow for express checkout when default shipping method and payment method are available.
* Array `defaultDeliveryMode`: Default delivery mode for i.a. for express checkout. Set preferences in order with general preferences (eg. DeliveryModePreferences.LEAST_EXPENSIVE) or specific delivery codes.

```typescript
  checkout?: {
    //...
    express?: boolean;
    defaultDeliveryMode?: Array<DeliveryModePreferences | string>;
  };
```

```typescript
enum DeliveryModePreferences {
  FREE = 'FREE',
  LEAST_EXPENSIVE = 'LEAST_EXPENSIVE', // but not free
  MOST_EXPENSIVE = 'MOST_EXPENSIVE',
}
```

### Default Configuration
```typescript
  checkout: {
    //...
    express: false,
    defaultDeliveryMode: [DeliveryModePreferences.FREE],
  };
```

### Own Configuration
To provide your own configuration, you should extend B2cStorefrontModule config object like:
```typescript
  B2cStorefrontModule.withConfig({
    //...
    checkout: {
      //...
      express: true,
      defaultDeliveryMode: ['sample-code'],
    }
  })
```


### Configuration Specification

For default delivery mode we provide an array of values.

The algorithm will choose the first matched option from available.

### Examples
We have sample data:
```typescript
const [FREE_CODE, STANDARD_CODE, PREMIUM_CODE] = [
  'free-gross',
  'standard-gross',
  'premium-gross',
];
const [freeMode, standardMode, premiumMode] = [
  { deliveryCost: { value: 0 }, code: FREE_CODE },
  { deliveryCost: { value: 2 }, code: STANDARD_CODE },
  { deliveryCost: { value: 3 }, code: PREMIUM_CODE },
];
```

* For ```defaultDeliveryMode: [DeliveryModePreferences.FREE]```
we can expect behavior:

```
availableDeliveryModes: [freeMode, standardMode, premiumMode]
result: FREE_CODE
```

```
availableDeliveryModes: [standardMode, premiumMode]
result: STANDARD_CODE
```

```
availableDeliveryModes: [premiumMode]
result: PREMIUM_CODE
```


* For ```defaultDeliveryMode: [DeliveryModePreferences.LEAST_EXPENSIVE]```
we can expect behavior:

```
availableDeliveryModes: [freeMode, standardMode, premiumMode]
result: STANDARD_CODE
```

```
availableDeliveryModes: [standardMode, premiumMode]
result: STANDARD_CODE
```

```
availableDeliveryModes: [premiumMode]
result: PREMIUM_CODE
```

* For ```defaultDeliveryMode: [DeliveryModePreferences.FREE, DeliveryModePreferences.MOST_EXPENSIVE]```
we can expect behavior:

```
availableDeliveryModes: [freeMode, standardMode, premiumMode]
result: FREE_CODE
```

```
availableDeliveryModes: [standardMode, premiumMode]
result: PREMIUM_CODE
```

```
availableDeliveryModes: [standardMode]
result: STANDARD_CODE
```

* For specified codes ```defaultDeliveryMode: [STANDARD_CODE]```
we can expect behavior:

```
availableDeliveryModes: [freeMode, standardMode, premiumMode]
result: STANDARD_CODE
```
