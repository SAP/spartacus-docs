---
title: Schematics
---

Spartacus schematics allow you to install Spartacus libraries in your project. The following sections describe what the Spartacus schematics do, and also provide information about the various options and commands you can use with the schematics. If you are a developer and are looking for more technical information, see the [README](https://github.com/SAP/spartacus/blob/develop/projects/schematics/README.md) in the Spartacus schematics project.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before using Spartacus schematics, ensure that you have all of the necessary prerequisites.

{% include docs/frontend_requirements.html %}

## Adding Spartacus Core Libraries and Features to Your Angular Project

You can add Spartacus core libraries and features to your Angular project by running the following command from your project root:

```shell
ng add @spartacus/schematics@latest
```

**Note:** If you are using schematics to set up your Spartacus project for the first time, there are important considerations to be aware of. For example, Spartacus does not support B2C and B2B storefronts running together in a single storefront application. For more information, see [Setting Up Your Project Using Schematics]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries-5-x.md %}#setting-up-your-project-using-schematics).

The following is a description of the various options you can use with the `ng add @spartacus/schematics@latest` command:

- `baseUrl` sets the base URL of your CX OCC back end.
- `baseSite` is a comma-separated list of base site(s) to use with Spartacus.
- `currency` is a comma-separated list of currencies to use in Spartacus.
- `language` is a comma-separated list of languages to use in Spartacus.
- `urlParameters` is a comma-separated list that represents the order of site-context parameters, such as `['baseSite', 'language', 'currency']`, for example.
- `occPrefix` sets the OCC API prefix, such as `/occ/v2/`, for example.
- `useMetaTags` determines whether or not to configure the `baseUrl` and `mediaUrl` in the meta tags from `index.html`.
- `featureLevel` sets the application feature level. The default value is the same as the version of the Spartacus packages you are working with. For example, the `featureLevel` for `@spartacus/schematics@3.2.0` is `3.2`.
- `overwriteAppComponent` overwrites the content of `app.component.html`. The default value is `true`.
- `pwa` includes progressive web application (PWA) features when building the application.
- `ssr` includes the server-side rendering (SSR) configuration.
- `lazy` installs features with lazy loading configured for each of the feature modules. The default value is `true`.
- `project` allows you to specify the project that you want to configure your Spartacus application in. The default is the workspace default project.
- `interactive` allows you to bypass the schematics prompts and install Spartacus with a predefined set of features.
- `theme` allows you to import the CSS for a built-in theme, such as `santorini`. If you do not set a value for this parameter, the default Sparta theme is used.

The following is an example that generates an application that is ready to be used with the electronics storefront, that sets the `baseUrl` and the `baseSite`, and that also enables server-side rendering:

```shell
ng add @spartacus/schematics@latest --base-url https://spartacus-demo.eastus.cloudapp.azure.com:8443/ --base-site=electronics-spa --ssr
```

Another example is the following, which generates an application that is ready to be used with both an apparel storefront and an electronics storefront, that sets the `baseUrl`, `baseSite`, `currency`, and `language`, and also enables server-side rendering:

```shell
ng add @spartacus/schematics@latest --base-url https://spartacus-demo.eastus.cloudapp.azure.com:8443/ --base-site=apparel-uk-spa,electronics-spa --currency=gbp,usd --language=uk,en --ssr
```

This next example bypasses the schematics prompts and installs Spartacus with a predefined set of features:

```shell
ng add @spartacus/schematics@latest --base-url https://spartacus-demo.eastus.cloudapp.azure.com:8443/ --base-site=electronics-spa --no-interactive
```

To see which features are included when you use the `--no-interactive` flag, see [schema.json](https://github.com/SAP/spartacus/blob/develop/projects/schematics/src/add-spartacus/schema.json#L40).

### Additional Commands for Core Libraries and Features

By default, the `ng add @spartacus/schematics` command adds only a basic configuration of Spartacus. The following is a description of the commands you can use to extend your application:

- `ng g @spartacus/schematics:add-pwa` adds a Spartacus-specific PWA module.
- `ng g @spartacus/schematics:add-ssr` adds the SSR configuration.
- `ng g @spartacus/schematics:add-cms-component` generates a CMS component, and adds the CMS component mapping to the specified module, or to a newly-generated module, if no module is specified. For more information, see [CMS Component Schematic](#cms-component-schematic), below.

### How Spartacus Schematics Work

When you run `ng add @spartacus/schematics`, the command does the following:

1. Adds the required dependencies.
2. Sets up Spartacus modules in the project and provides the default configuration. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).
3. Imports Spartacus styles to `main.scss`.
4. Adds the `cx-storefront` component to your `app.component`.
5. Optionally updates `index.html` with the Spartacus URL endpoints in meta tags.
6. If the `--ssr` flag is included, the command does the following:
   - Adds server-side rendering dependencies.
   - Provides additional files that are required for SSR.

## CMS Component Schematic

The following is a description of the available options for the CMS component schematic:

- `--declare-cms-module` specifies which module the newly-generated CMS component is added to. If no module is specified, a new module is generated.
- `--cms-component-data`, alias `--cms`, injects the `CmsComponentData` into the new component. By default, this option is set to `true`.
- `--cms-component-data-model`, alias `--cms-model`, specifies the model class for the `CmsComponentData`, such as `MyModel`, for example. This argument is required if `--cms-component-data` is set to `true`.
- `--cms-component-data-model-path`, alias `--cms-model-path`, specifies the import path for the `CmsComponentData`. The default is `@spartacus/core`.

Aside from these custom options, the `add-cms-component` supports almost all options that are available for the Angular component and module schematics. The full list can be seen in this [schema.json](https://github.com/SAP/spartacus/blob/develop/projects/schematics/src/add-cms-component/schema.json) file.

The following Angular options are not supported:

- Deprecated options.
- The `--module` option for components. If you want to specify an existing module for a component, use `--declare-cms-module`. The `module` option is only applied to the Angular `module` schematic.
- The `--skip-import` option.

### Using the 'add-cms-component' Schematic

The following are some examples of how the `add-cms-component` schematic can be used:

- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel` generates the `my-awesome-cms.component.ts` component and the `my-awesome-cms.module.ts` module.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --declare-cms-module=my-cms-path/my-cms` generates the `my-awesome-cms.component.ts` component and adds it to the specified CMS mapping for `my-cms-path/my-cms.module.ts`.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app` generates the `my-awesome-cms.component.ts` component and the `my-awesome-cms.module.ts` module, and imports them to the specified `app.module.ts`.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app --declare-cms-module=my-cms-path/my-cms` generates the `my-awesome-cms.component.ts` component and adds it to the specified `my-cms-path/my-cms.module.ts` module. It also imports `my-cms.module.ts` to the specified `app.module.ts`.

## Installing Additional Spartacus Libraries

You need to first install the Spartacus core libraries before you can install additional Spartacus libraries. For more information, see [Adding Spartacus Core Libraries and Features to Your Angular Project](#adding-spartacus-core-libraries-and-features-to-your-angular-project), above.

**Note:** To install additional Spartacus libraries using schematics, your app structure needs to match the Spartacus reference app structure. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

### Integration Libraries and Feature Libraries

During the initial set up of your storefront using schematics, you have the option to install a number of Spartacus features, which is done by installing the relevant integration or feature libraries. The following is a list of the integration libraries and feature libraries that you can install, along with information about what is included in each package.

- `@spartacus/asm` includes the [{% assign linkedpage = site.pages | where: "name", "asm.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/asm.md %}).
- `@spartacus/cart` includes the [{% assign linkedpage = site.pages | where: "name", "saved-cart.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/saved-cart.md %}), [{% assign linkedpage = site.pages | where: "name", "quick-order.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/quick-order.md %}), and [{% assign linkedpage = site.pages | where: "name", "cart-import-export.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-import-export.md %}) features.
- `@spartacus/cdc` includes the [{% assign linkedpage = site.pages | where: "name", "cdc-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %}).
- `@spartacus/cds` includes the [{% assign linkedpage = site.pages | where: "name", "cds-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %}).
- `@spartacus/order` includes the Order History, Replenishment Order History, [{% assign linkedpage = site.pages | where: "name", "cancellations-and-returns.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cancellations-and-returns.md %}), and the business logic to placing or scheduling an oder features.
- `@spartacus/organization` includes the Organization Administration and Order Approval features. Both are required for [{% assign linkedpage = site.pages | where: "name", "b2b-commerce-organization.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/b2b-commerce-organization.md %}) to work.
- `@spartacus/product` includes the [{% assign linkedpage = site.pages | where: "name", "bulk-pricing.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/bulk-pricing.md %}), [{% assign linkedpage = site.pages | where: "name", "variants.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/variants.md %}) and [{% assign linkedpage = site.pages | where: "name", "image-zoom.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/image-zoom.md %}) features.
- `@spartacus/product-configurator` includes the [{% assign linkedpage = site.pages | where: "name", "configurable-products-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %}).
- `@spartacus/qualtrics` includes the [{% assign linkedpage = site.pages | where: "name", "qualtrics-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/qualtrics-integration.md %}).
- `@spartacus/smartedit` includes the [{% assign linkedpage = site.pages | where: "name", "smartEdit-setup-instructions-for-spartacus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/smartEdit-setup-instructions-for-spartacus.md %}).
- `@spartacus/storefinder` includes the [{% assign linkedpage = site.pages | where: "name", "store-locator.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/store-locator.md %}) feature.
- `@spartacus/tracking` includes the [{% assign linkedpage = site.pages | where: "name", "tag-management-system.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system.md %}) feature and the [{% assign linkedpage = site.pages | where: "name", "personalization-setup-instructions-for-spartacus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/personalization-setup-instructions-for-spartacus.md %}).
- `@spartacus/user` includes the Account and Profile features. The Account feature contains components such as the login form, and also exposes the general method for getting user details. The Profile feature is responsible for functionality such as closing an account, updating a profile, updating an email, updating a password, resetting a password, and registering. It is highly recommended to install both of these features.
- `@spartacus/checkout` - includes basic checkout, b2b checkout, and b2b scheduled replenishment checkout functionalities.

If you do not install a particular integration library or feature library during the initial set up of your storefront, you can always install any of these libraries later on using schematics. The command to install a library is the following:

```shell
ng add <package-name>
```

For example, you can install the `@spartacus/asm` library with the following command:

```shell
ng add @spartacus/asm
```

You can also include options when you use the `ng add` command, as follows:

- `lazy` installs features with lazy loading configured for each of the feature modules within the library. The default is `true`.
- `project` allows you to specify the project that you want to configure the Spartacus feature library in. The default is the workspace default project.
- `features` makes it possible to select features without the interactive prompt.

The following is an example of the `ng add` command that installs Personalization without the configuration for lazy loading, and without prompting to install any of the other features from the `@spartacus/tracking` library:

```shell
ng add @spartacus/tracking --no-lazy --features "Personalization"
```
