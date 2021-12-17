---
title: Contributing Integration Libraries to Spartacus
---

The guidelines presented here are essential for anyone who is contributing an integration library to Spartacus.

For information on the various integration libraries that are available for Spartacus, see [{% assign linkedpage = site.pages | where: "name", "integrations.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/integrations.md %}).

**Note:** The following Spartacus integration libraries are developed and owned by integration teams that are within SAP but outside of the Spartacus core development team:

- [{% assign linkedpage = site.pages | where: "name", "cds-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %})
- [{% assign linkedpage = site.pages | where: "name", "configurable-products-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %})
- [{% assign linkedpage = site.pages | where: "name", "cdc-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %})
- [{% assign linkedpage = site.pages | where: "name", "digital-payments-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/digital-payments-integration.md %})

Each integration teams owns its own integration library, and the Spartacus core team takes care of releasing these libraries.

## Integration Library Guidelines

The following guidelines are intended for teams that are developing an integration library for Spartacus:

- You are encouraged to reach out to the Spartacus core team to align and make sure you can get the right assistance from the Spartacus team for your release goals and timeline.
- You develop and test your integration library on a separate `integration` branch in the Spartacus repository, such as `integration/cds`. You branch off from the `develop` branch and continue from there.
- You are encouraged to incorporate the latest changes from the `develop` branch as often as possible. This helps avoid incompatibilities, merge conflicts, and potential problems with your integration.
- You can use [Travis CI](https://app.travis-ci.com/github/SAP/spartacus) from the Spartacus core team as your CI provider. You can add your validation, build, test and other steps to the `.travis.yml` file on your corresponding integration branch, which will allow you to describe your continuous integration process. You are required to include the tests and validations that you consider necessary for the continuous integration of your library.
- You do not have to run all of the Spartacus core validations as part of your CI process (although it is recommended to do so).
- At the moment of attempting to incorporate the integration library itself to the Spartacus main `develop` branch (or incorporating new changes to the `develop` branch), the core team will run a full validation on it, including regression tests. _This will not include the tests for the integration_. As an integration library owner, you need to make sure that your integration is stable, and that it passes all the requirements to be released.
- Once the integration library has been released, you are responsible for keeping it stable for subsequent releases.

## Reasoning Behind This Approach

- As noted earlier, Spartacus is built on [Travis CI](https://travis-ci.com/github/SAP/spartacus). The necessary build steps are described in the `travis.yml` file, and only one build file per branch is supported. Therefore, having separate branches for specific integrations allows each integration team to customize their builds.
- The Spartacus team does not have the bandwidth to run all validations and testing for every integration library as part of each build or pull request. At the same time, integration teams should not need to run validations for all of the core Spartacus code either.
