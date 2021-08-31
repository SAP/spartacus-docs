---
title: Contributing Integration Libraries to Spartacus
---

A number of best practices are recommended to successfully contribute an integration library to Spartacus.

For information on the various integration libraries that are available for Spartacus, see [{% assign linkedpage = site.pages | where: "name", "integrations.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/integrations.md %}).

**Note:** The following integration libraries are released by the Spartacus core team, but are owned by the relevant integration team:

- Context-Driven Services
- Configurable Products
- CPQ Configurable Products
- SAP Customer Data Cloud
- SAP Digital Payments

## Integration Library Guidelines

The following guidelines are recommended for any team that is contributing an integration library to Spartacus:

- You should have your own separate branch in the Spartacus repository, such as `integration/cds`, for example.
- You should incorporate the latest changes from the `develop` branch as often as possible (to avoid merge conflicts).
- You need to add your build, validation, and test steps to the `.travis.yml` file on your branch, which allows you to describe your continuous integration process. You are required to include the tests and validations that you consider necessary for the continuous integration of your library.
- You do not have to run all of the Spartacus core validations as part of your CI process (although it might be recommended).
- At the moment of attempting to incorporate the integration library itself to the Spartacus main `develop` branch (or incorporating new changes to the the `develop` branch), the core team will run a full validation on it, including regression tests. _This will not include the tests for the integration_. As an integration library owner, you need to make sure that your integration is stable, and that it passes all the requirements to be released.
- Once your integration library has been released, you are responsible for keeping it stable for subsequent releases.

## Reasoning Behind This Approach

- Spartacus is built on [Travis CI](https://travis-ci.com/github/SAP/spartacus). The necessary build steps are described in a `travis.yml` file, and only one build file per branch is supported. Therefore, having separate branches for specific integrations allows each integration team to customize their builds.
- The Spartacus team does not have the bandwidth to run all validations and testing for every integration library as part of each build. At the same time, integration teams should not need to run validations for all of the core Spartacus code either.
