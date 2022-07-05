---
title: Continuous Integration
---

Before code is integrated to our main line of development, a continuous integration process runs to certify that the changes can be safely integrated.

We use [Github Actions](https://github.com/features/actions) for our continuous integration service.

Every time code is pushed to the Spartacus repository (regardless of whether a pull requests has been made), a build in our [Github Actions CI workflow](https://github.com/SAP/spartacus/actions/workflows/ci.yml) is triggered. For all of our libraries, the build executes the following steps:

- Builds the Spartacus libraries from sources
- Checks for eslint compliance
- Checks for prettier compliance
- Runs all the unit tests
- Runs all cypress end-to-end tests
- Plus other additional checks

The configuration for Github actions based builds can be found in the `.ci.yml` file in the folder `./github/workflows`.

## End-to-End Tests

When a build is triggered, [GitHub](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) runs it on their virtual machines that run the end-to-end (E2E) tests for our libraries. The E2E test results are reported as pass or fail to the Pull Request checks on GitHub.

We use [Cypress](https://www.cypress.io/) as our E2E test framework. E2E test results are reported to the [Cypress Dashboard](https://dashboard.cypress.io/projects/k3nmep/runs).

