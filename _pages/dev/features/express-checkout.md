---
title: Express Checkout
feature:
- name: Express Checkout
  spa_version: 1.2
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The express checkout feature in Spartacus allows customers to go directly to the Order Summary page when they click or tap **Proceed to Checkout**. Spartacus uses default values from the customer's account, as well as from the Spartacus configuration, to set the values for delivery address, delivery mode, and payment method. When the customer arrives at the Order Summary page, they have the option to edit any of the values that have been automatically selected.

The delivery address and payment method are set with values that are saved in the customer's account. Spartacus uses a guard to check if the customer has at least one saved delivery address and one saved payment method. If not, the customer proceeds through the multi-step checkout. If more than one value is available for the delivery address or payment method, Spartacus uses the default value that is set in the customer's account. The delivery mode is automatically selected based on the settings that you configure in Spartacus.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Express Checkout

To enable express checkout, you set the `express` flag to `true` in a configuration module, such as `spartacus-configuration.module.ts`. The following is an example:

```ts
provideConfig({
  //...
  checkout: {
    //...
    express: true,
  },
});
```

By default, the `express` flag is set to `false`.

## Configuring Express Checkout

Spartacus provides some default delivery mode preferences, as shown in the following example:

```typescript
enum DeliveryModePreferences {
  FREE = 'FREE',
  LEAST_EXPENSIVE = 'LEAST_EXPENSIVE', // but not free
  MOST_EXPENSIVE = 'MOST_EXPENSIVE',
}
```

You can then use the `defaultDeliveryMode` array to set the delivery modes in order of preference, as shown in the following example:

```typescript
provideConfig({
  //...
  checkout: {
    //...
    express: true,
    defaultDeliveryMode: [DeliveryModePreferences.FREE, DeliveryModePreferences.MOST_EXPENSIVE],
  },
});
```

You can also provide your own custom delivery codes, as shown in the following example:

```typescript
provideConfig({
  //...
  checkout: {
    //...
    express: true,
    defaultDeliveryMode: ['custom-code'],
  },
});
```

By default, the `defaultDeliveryMode` is set to `DeliveryModePreferences.FREE`.

## Choosing the Delivery Mode During Checkout

During express checkout, Spartacus chooses the first match from the delivery modes that you have provided in the `defaultDeliveryMode` array.

To show how this works in practice, let's use the following example data:

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

If you have set `defaultDeliveryMode: [DeliveryModePreferences.FREE]`, you can expect the following behavior:

- ```text
  availableDeliveryModes: [freeMode, standardMode, premiumMode]
  result: FREE_CODE
  ```

- ```text
  availableDeliveryModes: [standardMode, premiumMode]
  result: STANDARD_CODE
  ```

- ```text
  availableDeliveryModes: [premiumMode]
  result: PREMIUM_CODE
  ```

If you have set `defaultDeliveryMode: [DeliveryModePreferences.LEAST_EXPENSIVE]`, you can expect the following behavior:

- ```text
  availableDeliveryModes: [freeMode, standardMode, premiumMode]
  result: STANDARD_CODE
  ```

- ```text
  availableDeliveryModes: [standardMode, premiumMode]
  result: STANDARD_CODE
  ```

- ```text
  availableDeliveryModes: [premiumMode]
  result: PREMIUM_CODE
  ```

If you have set `defaultDeliveryMode: [DeliveryModePreferences.FREE, DeliveryModePreferences.MOST_EXPENSIVE]`, you can expect the following behavior:

- ```text
  availableDeliveryModes: [freeMode, standardMode, premiumMode]
  result: FREE_CODE
  ```

- ```text
  availableDeliveryModes: [standardMode, premiumMode]
  result: PREMIUM_CODE
  ```

- ```text
  availableDeliveryModes: [standardMode]
  result: STANDARD_CODE
  ```

If you are using a custom code and have set ```defaultDeliveryMode: [STANDARD_CODE]```, you can expect the following behavior:

- ```text
  availableDeliveryModes: [freeMode, standardMode, premiumMode]
  result: STANDARD_CODE
  ```
