---
title: Schematics
---

Spartacus schematics allow you to install Spartacus libraries in your project. The following sections describe what the Spartacus schematics do, and also provide information about the various options and commands you can use with the schematics. If you are a developer and are looking for more technical information, see the [README](https://github.com/SAP/spartacus/blob/develop/projects/schematics/README.md) in the Spartacus schematics project.

## Prerequisites

Before using Spartacus schematics, ensure that you have all of the necessary prerequisites.

{% include docs/frontend_requirements.html %}

## Adding Spartacus Core Libraries and Features to Your Angular Project

You can add Spartacus core libraries and features to your Angular project by running the following command from your project root:

```shell
ng add @spartacus/schematics
```

The following is a description of the various options you can use with the `ng add @spartacus/schematics` command:

- `baseUrl` sets the base URL of your CX OCC back end.
- `baseSite` is a comma-separated list of base site(s) to use with Spartacus.
- `currency` is a comma-separated list of currencies to use in Spartacus.
- `language` is a comma-separated list of languages to use in Spartacus.
- `occPrefix` sets the OCC API prefix, such as `/occ/v2/`, for example.
- `useMetaTags` determines whether or not to configure the `baseUrl` and `mediaUrl` in the meta tags from `index.html`.
- `featureLevel` sets the application feature level. The default value is `2.0`.
- `overwriteAppComponent` overwrites the content of `app.component.html`. The default value is `true`.
- `pwa` includes progressive web application (PWA) features when building the application.
- `ssr` includes the server-side rendering (SSR) configuration.

The following is an example that generates an application that is ready to be used with the electronics storefront, that sets the `baseUrl` and the `baseSite`, and that also enables server-side rendering:

```shell
ng add @spartacus/schematics --baseUrl https://spartacus-demo.eastus.cloudapp.azure.com:8443/ --baseSite=electronics-spa --ssr
```

Another example is the following, which generates an application that is ready to be used with both an apparel storefront and an electronics storefront, that sets the `baseUrl`, `baseSite`, `currency`, and `language`, and also enables server-side rendering:

```shell
ng add @spartacus/schematics --baseUrl https://spartacus-demo.eastus.cloudapp.azure.com:8443/ --baseSite=apparel-uk-spa,electronics-spa --currency=gbp,usd --language=uk,en --ssr
```

### Additional Commands for Core Libraries and Features

By default, the `ng add @spartacus/schematics` command adds only a basic configuration of Spartacus. The following is a description of the commands you can use to extend your application:

- `ng g @spartacus/schematics:add-pwa` adds a Spartacus-specific PWA module.
- `ng g @spartacus/schematics:add-ssr` adds the SSR configuration.
- `ng g @spartacus/schematics:add-cms-component` generates a CMS component, and adds the CMS component mapping to the specified module, or to a newly-generated module, if no module is specified. For more information, see [CMS Component Schematic](#cms-component-schematic), below.

### How Spartacus Schematics Work

When you run `ng add @spartacus/schematics`, the command does the following:

1. Adds the required dependencies.
2. Imports the Spartacus modules in the `app.module` and sets up the default configuration.
3. Imports Spartacus styles to `main.scss`.
4. Adds the `cx-storefront` component to your `app.component`.
5. Optionally updates `index.html` with the Spartacus URL endpoints in meta tags.
6. If the `--pwa` flag is included, it adds PWA service worker support for your project.
7. If the `--ssr` flag is included, the command does the following:
   - Adds server-side rendering dependencies.
   - Provides additional files that are required for SSR.

## CMS Component Schematic

The following is a description of the available options for the CMS component schematic:

- `--declareCmsModule` specifies which module the newly-generated CMS component is added to. If no module is specified, a new module is generated.
- `--cmsComponentData`, alias `--cms`, injects the `CmsComponentData` into the new component. By default, this option is set to `true`.
- `--cmsComponentDataModel`, alias `--cms-model`, specifies the model class for the `CmsComponentData`, such as `MyModel`, for example. This argument is required if `--cmsComponentData` is set to `true`.
- `--cmsComponentDataModelPath`, alias `--cms-model-path`, specifies the import path for the `CmsComponentData`. The default is `@spartacus/core`.

Aside from these custom options, the `add-cms-component` supports almost all options that are available for the Angular component and module schematics. The full list can be seen in this [schema.json](https://github.com/SAP/spartacus/blob/develop/projects/schematics/src/add-cms-component/schema.json) file.

The following Angular options are not supported:

- Deprecated options.
- The `--module` option for components. If you want to specify an existing module for a component, use `--declareCmsModule`. The `module` option is only applied to the Angular `module` schematic.
- The `--skipImport` option.

### Using the 'add-cms-component' Schematic

The following are some examples of how the `add-cms-component` schematic can be used:

- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel` generates the `my-awesome-cms.component.ts` component and the `my-awesome-cms.module.ts` module.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --declareCmsModule=my-cms-path/my-cms` generates the `my-awesome-cms.component.ts` component and adds it to the specified CMS mapping for `my-cms-path/my-cms.module.ts`.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app` generates the `my-awesome-cms.component.ts` component and the `my-awesome-cms.module.ts` module, and imports them to the specified `app.module.ts`.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app --declareCmsModule=my-cms-path/my-cms` generates the `my-awesome-cms.component.ts` component and adds it to the specified `my-cms-path/my-cms.module.ts` module. It also imports `my-cms.module.ts` to the specified `app.module.ts`.

## Installing Additional Spartacus Libraries

You need to first install the Spartacus core libraries before you can install additional Spartacus libraries. For more information, see [Adding Spartacus Core Libraries and Features to Your Angular Project](#adding-spartacus-core-libraries-and-features-to-your-angular-project).

### Organization Library

You can add the Organization library by running the following command:

```shell
ng add @spartacus/organization
```

When you run this command, you are presented with an interactive menu that allows you to select which Organization features you want to install.

### Misc Library

You can add the Misc library by running the following command:

```shell
ng add @spartacus/misc
```

When you run this command, you are presented with an interactive menu that allows you to select which Misc features you want to install.
