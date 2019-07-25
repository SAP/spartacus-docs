---
title: Continuous Integration
---

## Continuous integration

Before code is integrated to our main line of development, a Continuous Integration process runs to certify that the changes are good to be integrated.

We use [Travis CI](https://travis-ci.org) as our continous integration service.

Every time code is pushed to the Spartacus repository (regardless of if a pull requests has been made), a build in our [public Travis CI](https://travis-ci.org/SAP/cloud-commerce-spartacus-storefront) is triggered. The build will execute the following steps (for all of our libraries):

- Check for prettier compliance
- Check for tslint compliance
- Run all the unit tests
- Run Sonar checks
- Build the Spartacus project sources
- Publish [Snapshot builds]

Configuration for Travis CI builds can be found in the `.travis.yml` file at the root of Spartacus project.

## End to end tests

When a build is triggered, a parallel process is also triggered on a [Jenkins server](https://jkmaster.test.c3po.b2c.ydev.hybris.com) that will run all of the end to end tests for our libraries. E2E test results are reported as pass/fail to the Pull Request checks on github.

Unfortunately, at the moment the Jenkins server is not public, therefore external contributors cannot see the E2E tests results. We will transition to a public server to do this very soon.
