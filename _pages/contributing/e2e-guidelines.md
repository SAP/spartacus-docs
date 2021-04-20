---
title: End to end (e2e) tests in Spartacus
---

## Tests for desktop and mobile

It's a good practice to e2e test both desktop and mobile experience. There is no need to write duplicate code for mobile and desktop tests, since the following utils were introduced: `viewportContext()` and `cy.onMobile()`. The `viewportContext()` allows for easy running the same e2e tests for the given list of viewports: both [`'desktop', 'mobile']` or only `['mobile']` or only `['desktop']`. Moreover, if some part of the test is specific only to mobile, it can be wrapped inside a callback passed to the util function `cy.onMobile()`. Analogically, part of the test that is specific only to desktop, should be wrapped in `cy.onDesktop()` See example:

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

### Debugging for only one viewport

For debugging purposes you might want to temporarily specify the only one viewport that should be used to run the tests. Then there is no need to modify the code of the tests. It suffices to set the Cypress env variable `'VIEWPORT'` in the appropriate `cypress.<...>.json` file. For example:

```json
{
  /* ... */
  "env": {
    "VIEWPORT": "mobile"
  }
}
```
