---
title: End-to-End Test Guidelines
---

It is a good practice to write end-to-end tests for both desktop and mobile experiences. By using the `viewportContext()` and `cy.onMobile()` utils, you can avoid having to write duplicate code for both the mobile and desktop tests.

The `viewportContext()` allows you to easily run the same e2e tests for a given set of viewports, whether it is both viewports (`['desktop', 'mobile']`), only `['mobile']`, or only `['desktop']`.

Furthermore, if a part of a test is specific only to the mobile experience, you can wrap it inside a callback that is passed to the `cy.onMobile()` util function. And of course, the same can be done for the desktop experience with the `cy.onDesktop()` util function.

The following is an example

```typescript
describe('Added to cart modal', () => {
  viewportContext(['mobile', 'desktop'], () => {
    /* Every tests HERE will be run both for mobile and desktop viewports */

    it('adding different products to cart', () => {
      cy.onMobile(() => {
      // HERE is a part of the test that will run only for mobile viewport
        cy.get('cx-searchbox cx-icon[aria-label="search"]').click();
      });

      /* HERE rest of the test that will run both for mobile and desktop viewports */
    });
  });
});
```

## Debugging for Only One Viewport

For debugging purposes, you might want to temporarily use only one viewport to run your e2e tests. In this case, you just need to set the Cypress `'VIEWPORT'` env variable in the appropriate `cypress.<...>.json` file, as shown in the following example:

```json
{
  /* ... */
  "env": {
    "VIEWPORT": "mobile"
  }
}
```
