---
title: Accessibility E2E Tests
---

During development of a11y feature, we decided to go with TDD approach (or something similar to it). We have created separate e2e tests located in:

```
projects\storefrontapp-e2e-cypress\cypress\integration\accessibility\tabbing-order.e2e-spec.ts
```

This test is split into 2 sections:

- Tests which don't require user to be logged in (eg. homepage, login page, ...)
- Tests which require user to be logged in (eg. my account pages, cart, ...)

For now, the tests cover tabbing through the application. After creating a new test (assuming the order of tabbing is correct), it should show which interactable elements are out of reach for tab button - the test will simply fail.

When you add a new test, please run cypress as usual, but choose `tabbing-order` test.

## The code

To implement a11y e2e test, you have to add a bit of code to the current set of tests.

Apart from the e2e spec file, we also use helpers and other files, located in:

```
projects\storefrontapp-e2e-cypress\cypress\helpers\accessibility\
```

### Config

```
(projects\storefrontapp-e2e-cypress\cypress\helpers\accessibility\tabbing-order.config.ts)
```

Firstly, you have to add a new property to the config object. The name should be short and descriptive.

```ts
login: [ // 1
{ value: 'userId', type: TabbingOrderTypes.FORM_FIELD }, // 2
{ value: 'password', type: TabbingOrderTypes.FORM_FIELD },
{ value: 'Forgot password?', type: TabbingOrderTypes.LINK },
{ value: 'Sign In', type: TabbingOrderTypes.BUTTON },
{ value: 'Register', type: TabbingOrderTypes.BUTTON },
]
```

1. login is of type `TabElement[]` - check it for more details about items of this array
2. type is an enum `TabbingOrderTypes` - check it for more elements (currently we support around 20 of different types)

### Test helper file _new implementation method_

```
(projects\storefrontapp-e2e-cypress\cypress\helpers\accessibility\tabbing-order\)
```

Now, you have to add a helper file. Some pages/views/etc might have a few additional steps and the file will be bigger/more complex. Please check other, already created helpers, for more info.

```
import {
getFormFieldByValue,
checkAllElements,
TabElement,
} from '../tabbing-order';
const containerSelector = '.AccountPageTemplate'; // 1

export function registerTabbingOrder(config: TabElement[]) { // 2
cy.visit('/login/register'); // 3
verifyTabbingOrder(containerSelector, config); // 4
}
```

1. create a variable with container which is holding your feature - CSS-like selector
2. names of the exported functions should have `TabbingOrder` suffix, and should take `config` as a parameter
3. visit a page, where your feature is located - cypress functionality
4. use predefined function `verifyTabbingOrder(containerSelector, config)`

### A11y spec file

```
(projects\storefrontapp-e2e-cypress\cypress\integration\accessibility\tabbing-order.e2e-spec.ts)
```

Now it's time to use the helper file and the config, we previously created.

```
describe('Register page', () => { // 1
it('should allow to navigate with tab key', () => { // 2
registerTabbingOrder(config.register); // 3
});
});
```

1. describe's name should point the desired page that we test
2. `should allow to navigate with tab key` is used in every test - use as is
3. use your helper and config prop you created

### Group Skipping

If your particular feature using a unique route happens to use Group Skipping to improve the user experience on the keyboard, you also need to implement a test configuration for it.

Similar to the method to verify tabbing order, perform the following steps:

Add the `GroupSkippingPageConfig` to the appropriate `GroupSkippingConfig` in the helper file

```
(projects\storefrontapp-e2e-cypress\cypress\helpers\accessibility\group-skipping\group-skipping.config.ts)
```

- `pageUrl`: Route of the page where your feature is implemented
- `expectedSkippierCount`: The number of skiplinks expected to be generated on the page

## Fixes

If your tests fail, please create a new ticket with some details about the error and label it as `feature/accessibility`.
