---
title: Continuous Integration
---

Before code is integrated to our main line of development, a continuous integration process runs to certify that the changes can be safely integrated.

We use [Travis CI](https://travis-ci.org) for our continuous integration service.

Every time code is pushed to the Spartacus repository (regardless of whether a pull requests has been made), a build in our [public Travis CI](https://travis-ci.org/SAP/spartacus) is triggered. For all of our libraries, the build executes the following steps:

- Checks for prettier compliance
- Checks for tslint compliance
- Runs all the unit tests
- Runs Sonar checks
- Builds the Spartacus project sources
- Publishes [snapshot builds]({{ site.baseurl }}{% link _pages/install/snapshot-builds.md %})

The configuration for Travis CI builds can be found in the `.travis.yml` file at the root of Spartacus project.

## End-to-End Tests

When a build is triggered, a parallel process is also triggered on a [Travis server](https://app.travis-ci.com/github/SAP/spartacus/branches) that runs all of the end-to-end (E2E) tests for our libraries. The E2E test results are reported as pass or fail to the Pull Request checks on GitHub.

Unfortunately, at the moment, the Jenkins server is not public, and as a result, external contributors cannot see the E2E test results. We hope to transition to a public server in the near future.
