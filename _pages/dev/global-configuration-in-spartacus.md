---
title: Global Configuration in Spartacus
---

Spartacus uses a mechanism that provides global configuration during app initialization (that is, when the application is bootstrapped). This configuration does not change while the application is running. Each storefront module that uses this configuration usually provides typing with some defaults for its part of the configuration.

**Note:** The configuration in the main app module takes precedence over other configurations, and can be used to override any configuration that has been provided elsewhere.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Providing Global Configurations in Spartacus

The following sections describe the different ways you can provide global configuration in Spartacus.

### provideConfig

Using `provideConfig` is the preferred way for providing global configuration in Spartacus.

If you want to contribute to the global configuration using `provideConfig`, just add it to a providers array in an Angular module.

### ConfigModule.withConfig

Using `ConfigModule.withConfig` is the legacy method of providing global configuration in Spartacus.

Importing `ConfigModule.withConfig(config: Config)` is useful when you want to use the configuration in your module and contribute to it at the same time.

### StorefrontLib.withConfig

Using `StorefrontLib.withConfig` is no longer supported in Spartacus.

### ConfigModule.withConfigFactory and provideConfigFactory

The `ConfigModule.withConfigFactory` and `provideConfigFactory` work the same as their counterparts (that is, `ConfigModule.withConfig` and `provideConfig`, respectively), but they use the factory instead of a plain object to provide the configuration. This is useful in the case of config generation or config composition.

### Limitations

It may be helpful to decompose and merge some objects before providing them to the config. For example, you may want to use default translations and only customize a few, as shown in the following example:

```typescript
i18n: {
    resources: {
        ...translations,
        ...customTranslations
    }
}
```

Unfortunately, the objects that are transformed with the object spread operator and then passed to `ConfigModule.withConfig` (or `provideConfig`) will disappear in the AOT compilation because of a known Angular issue. Instead, you can use `ConfigModule.withConfigFactory` or `provideConfigFactory`.

For more information, see [Angular issue #28078](https://github.com/angular/angular/issues/28078), as well as this [StackOverflow explanation](https://stackoverflow.com/questions/50141412/when-using-aot-changes-to-objects-passed-to-forroot-are-discarded-when-injected).

## Modifying the Configuration at Runtime

The global configuration mechanism in Spartacus is not designed to modify the configuration after the application has started. If you need to modify the configuration at runtime (that is, after bootstrap), you can put the configuration in a store, or expose it in a service, ideally as an observable stream that can easily react to changes.

However, the general recommendation is that any value that can change over time should be part of the application state, rather than part of the application configuration.

## Default Values

Each module typically provides a default configuration that is required for basic functionality. A default configuration is any configuration that is provided inside the related module. It usually contains reasonable defaults or configurations that are required for a module to operate.

You do not need to provide defaults for all required configurations. For example, it may be difficult to choose reasonable defaults for some options. In this case, it is recommended to use config validators to validate the configuration and warn (in development mode) if a required config is missing.

**Note:** Using `provideDefaultConfig` and `provideDefaultConfigFactory` are the preferred ways to provide default configurations in libraries. Using `provideDefaultConfig` inside libraries helps avoid issues with the default configuration overwriting the one that is provided in the shell app (which can occur because of the order of the imports).

## Overriding Values

The Spartacus configuration mechanism is built upon, and subject to, the rules of the standard Angular Dependency Injection mechanism. Each configuration chunk, whether default or overriding, is provided separately by Angular's multi provider feature, and all chunks are merged in a factory that is used to inject the configuration.

### How the Merging Process Works

Each configuration chunk is a plain JS object that contributes to one global configuration object, using deep object merging. The benefits of this solution are the following:

- flexibility
- the ability to enhance the configuration in feature modules
- the ability to easily provide defaults in modules
- the ability to override any part on the configuration on top (in the shell app)
- the ability to set the configuration just before app bootstrap (for example, using meta tags)

**Note:** Deep merging works only for objects. Arrays are overwritten without merging.

The following are some examples of configuration merging:

- Simple merge:

  - Chunk 1: `{ site: { occ-prefix: 'rest-api' } }`
  - Chunk 2: `{ site: { base-site: 'electronics' } }`
  - Merged: `{ site: { occ-prefix: 'rest-api', base-site: 'electronics' } }`

- Merge with overwrite:

  - Chunk 1: `{ site: { occ-prefix: 'rest-api' } }`
  - Chunk 2: `{ site: { base-site: 'electronics', occ-prefix: 'aaa' } }`
  - Merged: `{ site: { occ-prefix: 'aaa', base-site: 'electronics' } }`

- Array overwrite:

  - Chunk 1: `{ config-values: ['a', 'b' ] }`
  - Chunk 2: `{ config-values: ['c'] }`
  - Merged: `{ config-values: ['c'] }`

The order in which chunks are merged depends on the order in which they were provided. This has the following implications:

- With a configuration that is defined using the `ConfigModule.withConfig` import, the order of the imports also defines the order of the chunks. This also applies to modules that use `ConfigModule.withConfig` inside.
- With direct providing (using `provideConfig` or a `ConfigChunk` token), this approach always overwrites the configuration from imported modules (both `ConfigModule.forRoot()` and feature modules with a default configuration). Each consecutive config chunk that is provided directly is able to overwrite the previous one.

If the configuration is provided in a module that is two levels deep (for example, an imported module imports another module (a sub-module), which provides its configuration), then the sub-module configuration must actually be provided before the parent module is imported, so that any configuration that is defined in the upper level can still override it, if necessary.

## Config Validators

Config validators can be used to implement runtime checks that warn you when the config is not valid. For example, you can receive a warning if some part of the configuration is missing, or if some parts are mutually exclusive, or if some parts have incorrect values.

**Note:** By default, config validators can only provide warnings in development mode.

The config validator is a simple function that only returns a validation error message if a validation fails. Each config validator should be provided using `provideConfigValidator`.

## Implementing Configuration in New Features

Using the techniques describes in the previous sections, you can use the Spartacus global configuration out of the box, without any specific prerequisites. However, the following best practices explain how to implement a feature module that uses and contributes to the global configuration:

- Define an abstract class for your part of the configuration.

  It is recommended that you use an abstract class instead of an interface, not only to provide typings, but also to provide an injection token. This simplifies configuration usage inside your module, and in some advanced scenarios, can facilitate separate configuration for your module.

  By convention, all Spartacus storefront modules use the `config` folder for this purpose, such as `my-module/config/my-module-config.ts`.

- Define defaults.

  Export the default configuration, preferably as a `const`-typed plain object value.  

  By convention, all Spartacus modules use the `config` folder for this purpose, such as `my-module/config/default-my-module-config.ts`.

- Provide the default to the configuration.

  In your feature module, import `ConfigModule.withConfig(),` and pass the default config there (for example, `ConfigModule.withConfig(defaultMyModuleConfig),`).

- Provide global configuration using your typed abstract class.

  This step is not technically needed, because you can always inject the global config. However, it is recommended because it defines proper config encapsulation, allows for easy injection, and provides type safety for your module. The following is an example:

  ```typescript
  { provide: MyModuleConfig, useExisting: Config }
  ```

- Add an interface to the `storefrontConfiguration` type.

  If you are developing a core storefront feature and want to make your configuration options available to use with `B2cStorefrontModule.withConfig()`, import and include your new type to the global `StorefrontModuleConfig` type in `projects/storefrontlib/src/lib/storefront-config.ts`.
