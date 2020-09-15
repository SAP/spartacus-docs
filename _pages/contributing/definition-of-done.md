---
title: Definition of Done
---

This document states what the Spartacus team considers our Definition of Done. It describes a series of requirements that must be fulfilled to declare a feature or bug as `Done`.

## General requirements

All new features for Spartacus must be compliant with the following guidelines:

- [Architecture]({{ site.baseurl }}{% link _pages/dev/backend_communication/connecting-to-other-systems.md %})

- [Security]({{ site.baseurl }}{% link _pages/dev/security-best-practices.md %})

- [Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-best-practices.md %})

- UI/UX guidelines are a work in progress.

## Coding guidelines

The Spartacus team adopted the following set of rules to keep the Spartacus code readable and maintainable. As a contributor, we ask you to please follow these rules (even if you find them violated somewhere). When a file is consistently not following these rules and adhering to the rules would make the code worse, follow the local style.

### TL;DR

You can run the `build.sh` script located in the root of the project. It will run most of the checks or rules mentioned below, such as the linting and prettier checks, running unit and e2e tests, etc.

### Code Standards

There are several aspects to consider when writing code. Please review the [Coding Guidelines]({{ site.baseurl }}{% link _pages/contributing/coding-guidelines.md %}).

### Linting

We use [TSLint](https://palantir.github.io/tslint/) to analyze and improve our typescript code.

You can run the following command to lint your code:

```yarn
yarn lint
```

We also encourage to use the `TSLint` plugin in VS Code.

### Code formatting

We use [Prettier](https://prettier.io/) to format our code (and make it prettier).

To check that are all the files prettified, run the following:

```yarn
yarn prettier
```

To format and prettify your codebase, run the following:

```yarn
yarn prettier:fix
```

We also encourage to use the Prettier VS Code plugin. For more information, see [Development Tools for Spartacus]({{ site.baseurl }}{% link _pages/contributing/development-tools-for-spartacus.md %}).

### SCSS is Preprocessed (node-sass)

We use SASS for all of our CSS, which then is converted to CSS using [node-sass](https://github.com/sass/node-sass/blob/master/README.md)

Use the following command to pre-process the sass in `projects/storefrontstyles`

```yarn
yarn sass
```

### Unit Tests

We unit test our code. Please make sure the new feature or bug has unit tests and they are passing.

Run the following commands to run the unit tests for a library:

```yarn
yarn test [project]
yarn test storefrontlib
```

When you run the tests, Chrome opens, and you can see the progress of the tests, with detailed information, including whether the tests pass.

### Unit Test Code Coverage

Please make sure that unit test coverage is >= 80% for everything, and >=60% for branches.

To get the test coverage report, run the following commands:

```yarn
yarn test [project] --code-coverage
yarn test storefrontlib --code-coverage
```

Alternatively, you can run the following commands:

```yarn​
yarn test [project] --code-coverage
yarn test:core:lib
```

The coverage report can be found in `./coverage/index.html`.

### End-To-End Tests

We write end to end tests for all of our features using [Cypress](https://www.cypress.io/). Please make sure the new feature has end-to-end tests and that they are passing.

When applicable, write end-to-end tests to ensure that your new or updated feature is foolproof. If it makes sense to write end-to end tests, the minimum requirement is to write basic UI end-to-end tests. You can also consider writing UI end-to-end tests with a user-flow, but this is optional.

All newly written end-to-end tests must be reviewed, updated, and/or re-used.

Run the following commands to perform end-to-end tests:

```yarn
yarn e2e:cy:run # smoke tests
yarn e2e:cy:run:mobile # mobile tests
yarn e2e:cy:run:regression # regression tests
```

**Note:** Before running the end-to-end tests, make sure to install dependencies in `projects/storefrontapp-e2e-cypress`, and ensure the application is running.

The objective of end-to-end tests is to make sure your feature works. For example, if you are implementing a simple login screen with two buttons (such as the `Login` and `Cancel` buttons), you could write the following tests:

- Log in with valid credentials

- Attempt to log in with invalid credentials

- Fill in the input fields, then click on the `Cancel` button.

**Note:** E2E tests can currently only be run within SAP. We're working on exposing E2E tests to contributors.

### The Library Builds without Errors

Run the following command to ensure the libraries build without errors

```yarn
yarn build:libs
```

### The Shell Starts without Errors

Run the following command to ensure the shell storefront app starts without errors:

```yarn
yarn start
```

After running the command, you should see the following:

- There are no errors in the webpack terminal output
- There are no errors in the JS console in Chrome when displaying the home page.

### No Regression Errors

Check that the areas where the change is implemented still work as before. Also verify that major features (such as the homepage, search, and checkout) are not affected.

### New Feature Happy Path Works in the Shell App

Run a smoke test of the feature, deployed in a lib in the shell app.

Then determine if the new feature require changes in the shell app or the configuration files as well.

Some files and concepts live in the shell app itself. Ask yourself if the new code requires an update to the shell app or to the configuration files.

The following changes are likely candidates:

- Adding or changing a route
- Adding or changing a module (changing the path or name)
- Adding a component
- Adding a module
- Changing the way the configuration mechanism works

### Verify the Production Build Works

When you think you are done :)

Run the following commands to verify that the production build works, especially the Ahead-of-Time (AOT) compiler:

```yarn
yarn build:libs
yarn start
```

The following are some reasons why the production build might fail:

- Because of the AOT, we have to explicitly specify some types, such as function return types. Even though TypeScript does not require them, it can infer them.

- Be careful when using `index.ts` files (that is, barrel files). When running a production build, you might see the following error in the `node/webpack` console:

  ```text
  ERROR in : Encountered undefined provider! Usually this means you have a circular dependencies (might be caused by using 'barrel' index.ts files.
  ```

  This is usually caused by having an import statement as the following:

  ```typescript
  import * as fromServices from '../../services'.
  ```

  Instead, you should specifically import each class, as follows:

  ```typescript
  import { OccCmsService } from "../../services/occ-cms.service";
  import { DefaultPageService } from "../../services/default-page.service";
  ```
