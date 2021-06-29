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

CDS, CPQ and CDC libraries are not owned by the Spartacus core team (but we do release them).

## Integration library guidelines

- Integration teams will have their own separate branch in the Spartacus repo (for example, `integration/cds`)
- Integration teams will incorporate the latest changes from `develop` as often as possible (to avoid merge conflicts).
- Integration teams will need to add their build, validation and test steps to the `.travis.yml` file on their branch, in order for them to describe their Continuous Integration process. They will require to include the tests and validations that they consider necessary for the continuous integration of their library.
- Integration teams don't have to run all of the Spartacus core validations as part of their CI process (though it might be recommended).
- At the moment of attempting to incorporate the integration library itself (or incorporate new changes to it) to the Spartacus main `develop` branch, the core team will run a full validation and regression tests on it. _This will not include the tests for the integration_. Integration library owners need to make sure that their integration is stable and passes all requirements to be released.
- Once the integration library has been released, the integration team who owns the library will be responsible for keeping it stable for subsequent releases.

## Why this approach?

- Spartacus is built on [Travis CI](https://travis-ci.com/github/SAP/spartacus). Necessary build steps are described on a `travis.yml` file, and only a build file per branch is supported. Therefore, having a separate branch allows teams to customize their builds.
- Spartacus team does not want to run all validations and testing for all integration libraries as part of each build. At the same time, we don't want integration teams to be doing the same for all of Spartacus.
