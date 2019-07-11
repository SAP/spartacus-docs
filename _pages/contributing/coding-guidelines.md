---
title: Coding Guidelines
---

To keep the Spartacus code readable and maintainable, please follow our coding guidelines, even if you find them violated somewhere. If a file is consistently not following the guidelines, and adhering to the guidelines would make the code worse, then follow the local style.

## Overall Angular Guidelines

We follow [Google's Style Guide](https://angular.io/guide/styleguide).

### Coding Guidelines Check Using the CLI

Certain guideline violations can be detected automatically by a tool called codelyzer, which is bundled with the Angular CLI. You can analyze an angular app with the following command:

```
$ ng lint
```

The tool reports violations to the guidelines for the whole application. If there are no errors, it will output the following:

```
All files pass linting.
```

Otherwise, issues will be listed. The following is an example:

```
ERROR: /SAPDevelop/AngularApp/src/app/myfeature/myfeature.component.ts[7, 14]: The name of the class MyFeature should end with the suffix Component (https://angular.io/styleguide#style-02-03)

Lint errors found in the listed files.
```

If you look at the end of the error message, there is a direct link to the style guideline that is violated.

### Coding Guidelines on the Pipeline

The `ng lint` command is part of the Definition of Done and is integrated into the pipeline.

New violations on the branch result in a non-green build, and no merges are allowed.

### Coding Guidelines in the IDE

To make the standards adoption even more seamless, Visual Studio Code (VS Code) and other editors can provide live feedback from the rules reported by `ng lint`.

We use a number of VS Code extensions for code compliance. When you open the source folder in VS Code, if you are missing any of the recommended extensions, VS Code prompts you to install them.

You can see the list of recommended extensions in `.vscode/extensions.json`.

If you are missing any of the recommended extensions, please install them.

## Spartacus-Specific Guidelines

### NGRX in 'Core'

We use the NGRX store to manage the global application state in our features. Using NGRX has apparent advantages for performance, better testability, and ease of troubleshooting (with time travel and such).

- Use the store for a feature unless there is a compelling reason not to. We want to keep it consistent throughout the app.
- Use one common store for the whole app.

**Note**: Using the store does not mean that we need to cache everything. Caching should be used with intent, and where it makes sense. In general, CMS data is a good candidate for caching, while application data is not.

If a feature that use NGRX logic is meant to be called from UI components, facade service functions should be implemented ton expose features and encapsulate the NGRX code within the core lib.

### NGRX in UI Components

The complexity of NGRX is encapsulated in the core lib. Facade services are availbe from the core lib. The facade services expose the core lib features, but they hide the NGRX logic within their implemenation.

Built in Spartacus UI components should not contain NGRX logic. Instead, the UI components should call facade service functions.

### Site Context

Site context can be changed for each page. The response data may be different for different site contexts. Keep this in mind when working on pages.

Also, logged-in users and anonymous users may see different response data. When working on pages, take into consideration that a user can change their login status through login or logout.

### Naming Conventions

If you work for a team inside SAP, then component selectors should always start with `cx-` (such as `cx-banner`, for example). If you are a partner or customer, you should use a different prefix (that is, something other than `cx-`) to avoid conflicts with Spartacus libraries, and third-party libraries that are used by Spartacus.

### Modules

Try to keep modules as small as possible. In most cases, one module has only one component. Also, we should always try to reduce module dependencies.

### Testing

All code must be covered by unit tests.

With regards to end-to-end tests, new, UI-oriented features must always be covered by basic UI end-to-end tests. The file names for the tests should end with `e2e-spec.ts`. Common functions that can be re-used should be extracted into different files, and should be located in the sub-directory named `helpers`. These files should end with the file extension `.ts`.

If you decide to write an end-to-end test based on user-flow, add the word `flow` to the test's name. If you have more than one user-flow test, separate them into individual files, so they can be run in parallel. We also recommend grouping the tests in a sub-directory with a relevant name. For reference, have a look at the end-to-end tests for product search.

To know if your end-to-end test belongs to the `smoke` folder or the `regression` folder, ask yourself the following questions:

- Is the functionality fragile?

  If yes, the test belongs in the `smoke` folder. A good example of fragile functionality is the product search.

- Is the user-flow critical?

  If yes, the test belongs in the `smoke` folder. A good example of a critical user-flow are the steps to complete the checkout.

If you answered "no" to these questions, then the test belongs in the `regression` folder.

### Server-Side Rendering

Do not break server-side rendering (SSR).

For more information, see the [Server–Side Rendering Coding Guidelines]({{ site.baseurl }}{% link _pages/dev/server-side-rendering-coding-guidelines.md %}).

### Protected and Private Methods

If a method needs to be extendible, declare it as a `protected` method. Keep in mind, however, that all methods that are `protected` are a part of our public API. If you update a `protected` method, you must be careful not to introduce breaking changes as much as possible. If a method does not need to be extendible, declare it as `private` instead. For example, if you are creating helper methods in a service for code readability, it is probably better to declare these methods as `private`, unless it is essential for these methods to be extendible by customers.

### DOM Manipulation

Angular provides many ways to interact and manipulate DOM elements.

An easy way to do this is by using `ElementRef` from `@angular/core`. This is **not** the correct approach.

According to the official Angular documentation on ElementRef:

> Use this API as the last resort when direct access to DOM is needed. Use templating and data-binding provided by Angular instead. Alternatively you can take a look at `Renderer2` which provides API that can safely be used even when direct access to native elements is not supported.

If an alternative to ElementRef is needed, use `Renderer2`.

```typescript
// ElementRef
this.element.nativeElement.style.color = 'yellow';

// Renderer2
this.renderer.setStyle(this.element.nativeElement, 'color', 'yellow');
```

### Services

The information below will outline the best practices when creating a `service`.

Exports

- A service **must** be exported to allow it to be in the `public api` of the library.

Method Modifiers

- `Public` methods should be used if it is expected to be accessible through the public api.
- `Protected` methods should be used if it is expected to be overridden or extended.
- `Private` methods should be used if it is expected to only be used by the service.

Constructor Arguments

- Constructor arguments should be **atleast** protected.
- Constructor arguments should be limited. Create a new service if many injections are required.
