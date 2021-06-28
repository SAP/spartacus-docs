---
title: Spartacus integration libraries
---

This document describes the process to contribute integration libraries to Spartacus.

Currently we have the following third party integrations with Spartacus (and counting):

- Qualtrics
- Smartedit
- Context Delivery Services (CDS)
- Product configurator (CPQ)
- CDC

## Strategy

Each integrations team will work in a separate branch updates (for example, `integration/cds`)

- Integration teams will have to incorporate the latest changes from `develop` as often as possible (to avoid merge conflicts).
- Teams will require to update the `.travis.yml` file and include only the tests and validations that they consider adequate for their integration libraries. It won't be necessary for them to run the core validations as part of CI (though it might be recommended).
- At the moment of attempting to release the integration library itself (or incorporate new changes to it) to the Spartacus main `develop` branch, the core team will run a full validation and regression tests on it. _This won't include the tests for the integration_. Integration library owners need to make sure that their integration is stable and passes all requirements to be released.
- Once the integration library has been released, the integration team who owns the library will be responsible for keeping it stable for subsequent releases.

## Why this approach?

- We build on Travis CI. Build steps are described on a `travis.yml` file, and only a build file per branch is supported. Therefore, builds cannot be customized (except on different branches).
- We do not want to run all validations and testing for all integration libraries as part of each build. At the same time, we don't want integration teams to be doing the same for all of Spartacus.
