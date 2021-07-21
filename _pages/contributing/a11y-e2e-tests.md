---
title: Accessibility E2E Tests
---

Accessibility in Spartacus has its own set of end-to-end tests, which are located in `projects/storefrontapp-e2e-cypress/cypress/integration/accessibility/tabbing-order.e2e-spec.ts`.

These include tests that require a user to be logged in (for the My Account pages and the cart, for example), as well as tests that do not require a user to be logged in (for the Home page and Login page, for example).

Currently, the tests cover tabbing through the application. For every new feature, a new test should be written manually that checks how the tabbing is intended to work. If some aspect of the tabbing does not work properly (for example, the tabbing order is not as intended, or an interactable element cannot be reached by tabbing), the test should fail.

To run a new test that you have added to `tabbing-order.e2e-spec.ts`, choose the `tabbing-order` test when you run Cypress.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Implementing a New A11y E2E Test

You can create a new a11y e2e test by updating the existing set of tests, as described in the following procedure.

1. Add a a new property to the config object in `projects/storefrontapp-e2e-cypress/cypress/helpers/accessibility/tabbing-order.config.ts`.

    The name should be short and descriptive. The following is an example:

    ```ts
    login: [
        { value: 'userId', type: TabbingOrderTypes.FORM_FIELD },
        { value: 'password', type: TabbingOrderTypes.FORM_FIELD },
        { value: 'Forgot password?', type: TabbingOrderTypes.LINK },
        { value: 'Sign In', type: TabbingOrderTypes.BUTTON },
        { value: 'Register', type: TabbingOrderTypes.BUTTON },
      ]
    ```

    The following are some details about the above example:

    - The `login` is of type `TabElement[]`.

    - The `type` is a `TabbingOrderTypes` enum, which supports many types of elements. You can see all the supported types by looking up the definition of the `TabbingOrderTypes` enum in the Spartacus source code.

1. Add a new helper file to `projects/storefrontapp-e2e-cypress/cypress/helpers/accessibility/tabbing-order/`.

    The following is an example of the `login.ts` helper file:

    ```ts
    import { verifyTabbingOrder } from '../tabbing-order';
    import { fillLoginForm } from '../../auth-forms';
    import { user } from '../../../sample-data/checkout-flow';
    import { TabElement } from '../tabbing-order.model';

    const containerSelector = '.LoginPageTemplate';

    export function loginTabbingOrder(
      config: TabElement[],
      prefillForm: boolean = false
    ) {
      cy.visit('/login');

      if (prefillForm) {
        const { email: username, password } = user;
        fillLoginForm({ username, password });
      }

      verifyTabbingOrder(containerSelector, config);
    }
    ```

    Some pages or views might require additional steps, and the helper file may be bigger or more complex than the example shown above. You can see other examples by looking at existing helper files in `projects/storefrontapp-e2e-cypress/cypress/helpers/accessibility/tabbing-order/`.

    The following are some details about the above example:

    - With `const containerSelector`, you create a variable for holding your feature using a CSS-like selector.
    - Exported functions, such as the `loginTabbingOrder` function in this example, should always have the `TabbingOrder` suffix, and should always take `config` as a parameter.
    - `cy.visit` is an example of Cyprus functionality. In this example, it tells Cyprus to access a page where your feature is located.
    - Your exported function should always use the predefined `verifyTabbingOrder(containerSelector, config)` function.

1. In `projects/storefrontapp-e2e-cypress/cypress/integration/accessibility/tabbing-order.e2e-spec.ts`, import the `TabbingOrder` function from the helper file you created in the previous step.

    The following is an example:

    ```ts
    import { loginTabbingOrder } from '../../helpers/accessibility/tabbing-order/login';
    ```

1. In the same file (`tabbing-order.e2e-spec.ts`), add the test.

    The following is an example:

    ```ts
    context('Login page', () => {
    it('should allow to navigate with tab key (empty form)', () => {
      loginTabbingOrder(config.login);
    });

    it('should allow to navigate with tab key (filled out form)', () => {
      loginTabbingOrder(config.login, true);
      });
    });
    ```

    The following are some details about the above example:

    - The `context` should point to the page you want to test.
    - The string `'should allow to navigate with tab key'` is used in every test and should be included in all new tests.
    - The `loginTabbingOrder` is the function you created in your `login.ts` helper file, and `(config.login)` refers to the `login` property you added to the config object in `projects/storefrontapp-e2e-cypress/cypress/helpers/accessibility/tabbing-order.config.ts` (in step 1 of this procedure).

## Group Skipping

If your feature uses a unique route and also uses group skipping to improve the user experience on the keyboard, you need to implement a test configuration for this aspect of your feature.

The approach is similar to how you verify the tabbing order. In `projects/storefrontapp-e2e-cypress/cypress/helpers/accessibility/group-skipping/group-skipping.config.ts`, you add the `GroupSkippingPageConfig` to the relevant `GroupSkippingConfig`, as shown in the following example:

```ts
export interface GroupSkippingPageConfig {
  pageUrl: string;
  expectedSkipperCount: number;
}
export interface GroupSkippingConfig {
  [name: string]: GroupSkippingPageConfig;
}
export const groupSkippingConfigNotLoggedIn: GroupSkippingConfig = {
  home: { pageUrl: '/', expectedSkipperCount: 3 },
  login: { pageUrl: '/login', expectedSkipperCount: 3 },
  register: { pageUrl: '/login/register', expectedSkipperCount: 3 },
  /* ... */
};
```

The following are some details about the above example:

- The `pageUrl` is the route of the page where your feature is implemented.
- The `expectedSkipperCount` is the number of skip links expected to be generated on the page.

## Fixes

If your tests fail, create a new GitHub issue with details about the error, and use the `feature/accessibility` label.
