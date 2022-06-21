---
title: Continuous Integration
---

Before code is integrated to our main line of development, a continuous integration process runs to certify that the changes can be safely integrated.

We use [Github Actions](https://github.com/features/actions) for our continuous integration service.

Every time code is pushed to the Spartacus repository (regardless of whether a pull requests has been made), a build in our [Github Actions CI workflow](https://github.com/SAP/spartacus/actions/workflows/ci.yml) is triggered. For all of our libraries, the build executes the following steps:

- Checks for prettier compliance
- Checks for eslint compliance
- Runs all the unit tests
- Runs all integration and end-to-end tests
- Builds the Spartacus project sources

The configuration for Travis CI builds can be found in the `.ci.yml` file in the GitHub convention folder `./github/workflows`.

## End-to-End Tests

When a build is triggered, [GitHub](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) runs it on their virtual machines that run all of the end-to-end (E2E) tests for our libraries. The E2E test results are reported as pass or fail to the Pull Request checks on GitHub.

Unfortunately, at the moment, the Jenkins server is not public, and as a result, external contributors cannot see the E2E test results. We hope to transition to a public server in the near future.
