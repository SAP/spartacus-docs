# Getting Started

Spartacus schematics allows you to install Spartacus libraries in your project

## Adding Spartacus libraries to your Angular project

Run the following command from your project root:

`ng add @spartacus/schematics`

### Available options

- `baseUrl`: Base url of your CX OCC backend
- `baseSite`: Name of your base site
- `occPrefix`: The OCC API prefix. E.g.: /occ/v2/
- `useMetaTags`: Whether or not to configure baseUrl and mediaUrl in the meta tags from `index.html`
- `featureLevel`: Application feature level. (default: _2.0_)
- `overwriteAppComponent`: Overwrite content of app.component.html file. (default: true)
- `pwa`: Include PWA features while constructing application.
- `ssr`: Include Server-side Rendering configuration.

### Other commands

By default, `ng add @spartacus/schematics` will add only basic spartacus configuration. You are able extend application with features like _PWA_ or _SSR_ with commands listed below:

- `ng g @spartacus/schematics:add-pwa` - adds Spartacus-specific PWA module
- `ng g @spartacus/schematics:add-ssr` - adds server-side rendering configuration
- `ng g @spartacus/schematics:add-cms-component` - generates a cms component, and adds the CMS component mapping to the specified module (or generates a new module). For more see [CMS component schematic](#CMS-component-schematic)

## Steps performed by Spartacus schematics

1. Add required dependencies
2. Import Spartacus modules in app.module and setup default configuration
3. Import Spartacus styles to main.scss
4. Add `cx-storefront` component to your app.component
5. (Optionally) update index.html with Spartacus URL endpoints in meta tags
6. If `--pwa` flag included:
   - Add PWA/ServiceWorker support for your project
7. If `--ssr` flag included:
   - Add ssr dependencies
   - Provide additional files required for SSR

## CMS component schematic

### Available options for CMS component schematic

The following options are available:

- `--declareCmsModule` - specifies to which module to add the newly generated CMS component. If omitted, a new module is generated.
- `--cmsComponentData`, alias `--cms` - inject the _CmsComponentData_ in the new component. By default it is _true_
- `--cmsComponentDataModel`, alias `--cms-model` - Specify the model class for the _CmsComponentData_, e.g. _MyModel_. This argument is required if _--cmsComponentData_ is _true_.
- `--cmsComponentDataModelPath`, `--cms-model-path` - Specify the import path for the _CmsComponentData_. Default is _@spartacus/core_.

Besides the custom options, the `add-cms-component` supports almost all options that are available for the Angular's component and module schematics. The full list can be seen [here](https://github.com/SAP/cloud-commerce-spartacus-storefront/blob/develop/projects/schematics/src/add-cms-component/schema.json).

The following Angular's options are _not_ supported:

- deprecated options.
- _--module_ option for component - if you want to specify an existing module for the component, use _--declareCmsModule_. The _module_ option is only applied to the Angular's _module_ schematic.
- _--skipImport_ option.

### Examples

Here are some examples how the `add-cms-component` schematic can be used:

- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel` - generates _my-awesome-cms.component.ts_ component and _my-awesome-cms.module.ts_ module
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --declareCmsModule=my-cms-path/my-cms` - generates _my-awesome-cms.component.ts_ and adds it to the specified _my-cms-path/my-cms.module.ts._'s CMS mapping.
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app` - generates _my-awesome-cms.component.ts_ component, _my-awesome-cms.module.ts_ module and imports it to the specified _app.module.ts_
- `ng g @spartacus/schematics:add-cms-component myAwesomeCms --cms-model=MyModel --module=app --declareCmsModule=my-cms-path/my-cms` - generates _my-awesome-cms.component.ts_ component and adds it to the specified _my-cms-path/my-cms.module.ts_ module. It also imports _my-cms.module.ts_ to the specified _app.module.ts_
