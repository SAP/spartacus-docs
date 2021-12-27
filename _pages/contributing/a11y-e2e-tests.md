---
title: Accessibility E2E Tests
---

In Spartacus, keyboard accessibility is verified and maintained within feature-specific end-to-end tests. 

Keyboard accessibility guidelines can be found here:
https://sap.github.io/spartacus-docs/keyboard-accessibility/

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Testing Keyboard A11Y with `domSnapshot()`

You can place this method in any line of the test where you would like to verify that keyboard accessibility is functional. Calling this method will iterate through elements of the page via simulating pressing the TAB key at the given state of the test's execution. 

### Verifying the DOM Snapshot

When this command is first called, it will fail the test and create a draft snapshot file as indicated by the error message that will be thrown during the test execution. This file is a "draft" snapshot that shows all iterable accessible elements in the DOM at the given point. It is up to the developer to verify elements of the page at the current state are accessible by the TAB key and to match the elements with the draft snapshot created.

Once verified, the developer can move the generated draft snapshot file into the snapshot folder for the test to pass this assertation as also indicated in the error message.

### Example

We have a simple template with a button on it and a paragraph of text.

`.../test-page.html`
```html
<button> Test Button </button>
<p> This button is a test button. </p>
```

And a simple cypress test that clicks the button.

`.../test-page.e2e-spec.ts.json`

```ts
describe('Test Page', () => {

  ...

  it('should click the button', () => {
    cy.get('button').click();
  })

  ...

```

Now we can add the `domSnapshot()` method to verify keyboard accessibility on this page.

##### Add `domSnapshot()` into a scenario

This is a quick and easy way to drop in the check before we click the button.

`.../test-page.e2e-spec.ts`

```ts
describe('Test Page', () => {

  ...

  it('should click the button', () => {
    cy.domSnapshot();
    cy.get('button').click();
  })

  ...

```

##### Create a special scenario for `domSnapshot()` (easier to maintain)

It can be preferable to keep the accessibility verification logic in its own scenario to make maintaining e2e tests easier. However, this does not necessarily make sense in all test scenarios.

`.../test-page.e2e-spec.ts`

```ts
describe('Test Page', () => {

  ...

  it('should verify keyboard accessibility', () => {
    cy.domSnapshot();
  })

  it('should click the button', () => {
    cy.get('button').click();
  })

  ...

```

##### Understanding the Output and Verification

After running either test, the test will fail with an error message asking you to verify the generated draft snapshot. It should look something like this:

`.../cypress/fixtures/a11y/tab/drafts/.../test-page.e2e-spec.ts.json`

```json
[
  {
    "element": "<button> Test Button </button>"
  },
]
```

Notice how the snapshot only contains the button element and not the paragraph element. This is because only the DOM element is accessible via the TAB key when using the keyboard. 

However, if we were to see any other unexpected elements in this snapshot, we could conclude that there is something wrong with the accessibility on the page and we should fix it before creating another snapshot.

If everything is in order, we can move the snapshot to the designated directory (ie. `.../cypress/fixtures/a11y/tab/snapshots/.../test-page.e2e-spec.ts.json`).

Run the test again and it should now pass.

Congratulations! You have now verified keyboard accessibility in your test. :)

### Maintaining Keyboard Accessibility

We monitor that pages remain keyboard accessible by checking for changes in the DOM at given states. Upon any DOM change that might affect the accessibility of the keyboard at the asserted state, the test will fail and a new draft snapshot will be generated to be verified once again.

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

## Deprecated A11Y E2E Tests

Tabbing order e2e tests `tabbing-order.e2e-spec.ts` are being or have already been removed since Spartacus version `5.0` due to the migration of tests to utilize `domSnapshot()`.

For information on how keyboarding was tested in previous versions of Spartacus, please check here:

https://sap.github.io/spartacus-docs/4.x/a11y-e2e-tests/
