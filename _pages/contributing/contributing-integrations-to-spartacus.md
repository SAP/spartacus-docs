---
title: Contributing Integration Libraries to Spartacus
---

This guide describes a series of guidelines to successfully contribute an integration library to Spartacus.

For information on the various integration libraries that are available for Spartacus, see [{% assign linkedpage = site.pages | where: "name", "integrations.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/integrations.md %}).

**Note:** The following Spartacus integration libraries are owned by other teams at SAP (which we call Integration teams) but they are released by the Spartacus core team:

- Context-Driven Services (CDS)
- Configurable Products (CPQ)
- SAP Customer Data Cloud (CDC)
- SAP Digital Payments

## Integration Library Guidelines

- It is encouraged for integration teams to reach out to the Spartacus core team to align and make sure they can get the right assistance from the Spartacus team for their release goals and timeline.
- Integration teams develop and test their integration library on a separate `integration` branch in the Spartacus repository, such as `integration/cds`, for example. They branch off of develop and go from there.
- It is encouraged for the integration teams to incorporate the latest changes from the `develop` branch as often as possible (to avoid incompatibilities, merge conflicts and potential problems on their integrations).
- Integration teams can use [Travis CI](https://app.travis-ci.com/github/SAP/spartacus) from the Spartacus core team as their CI provider. They can add their validation, build, test and other steps to the `.travis.yml` file on their corresponding integration branch, which will allows them to describe their continuous integration process. Teams are required to include the tests and validations that they consider necessary for the continuous integration of their library.
- Integration teams do not have to run all of the Spartacus core validations as part of their CI process (although it is recommended to do so).
- At the moment of attempting to incorporate the integration library itself to the Spartacus main `develop` branch (or incorporating new changes to the the `develop` branch), the core team will run a full validation on it, including regression tests. _This will not include the tests for the integration_. Integration library owners need to make sure that their integration is stable, and that it passes all the requirements to be released.
- Once the integration library has been released, integration teams are responsible for keeping it stable for subsequent releases.

## Reasoning Behind This Approach

- As it was mentioned before, Spartacus is built on [Travis CI](https://travis-ci.com/github/SAP/spartacus). The necessary build steps are described in `travis.yml` file, and only one build file per branch is supported. Therefore, having separate branches for specific integrations allows each integration team to customize their builds.
- The Spartacus team does not have the bandwidth to run all validations and testing for every integration library as part of each build or pull request. At the same time, integration teams should not need to run validations for all of the core Spartacus code either.
