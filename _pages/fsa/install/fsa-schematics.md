---
title: Schematics
---

FSA Spartacus schematics allow you to install FSA Spartacus libraries in your project. The following sections describe what the FSA Spartacus schematics do, and also provide information about the various options and commands you can use with the schematics. If you are a developer and are looking for more technical information, see the [README](https://github.com/SAP/spartacus/blob/develop/projects/schematics/README.md) in the Spartacus schematics project.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before using Spartacus schematics, ensure that the following requirements are met:

RELEASE 1.0

- Angular CLI: Version 9.1 or later, < 10.0
- node.js: Version 10.14.1 or later, < 13.0
- yarn: Version 1.15 or later

RELEASE 2.0

- Angular CLI: Version 10.1 or later, < 11.
- node.js: The most recent 12.x version is recommended, < 13.
- yarn: Version 1.15 or later

## Adding FSA Spartacus Libraries to Your Angular Project

You can add FSA Spartacus libraries to your Angular project by running the following command from your project root:

```shell
ng add @spartacus/fsa-schematics
```

The following is a description of the various options you can use with the `ng add @spartacus/fsa-schematics` command:

- `baseUrl` sets the base URL of your CX OCC back end.
- `baseSite` is a comma-separated list of base site(s) to use with Spartacus.
- `currency` is a comma-separated list of currencies to use in Spartacus.
- `language` is a comma-separated list of languages to use in Spartacus.
- `occPrefix` sets the OCC API prefix, such as `/occ/v2/`, for example.
- `clientId` used to authorize financial user. Default value is: financial_customer
- `clientSecret` used to authorize financial user. Default value is: secret
- `consignmentTracking` sets consignment tracking on or off. Default value is: true
- `overwriteAppComponent` overwrites the content of app.component.html. The default value is true.

*Note:* Default values will be applied if no option is passed to ng add @spartacus/fsa-schematics command.

To have a clear picture on how some of these properties can be used, user can enter the following command that sets baseSite(s), currency(ies), and language(s):

```shell
ng add @spartacus/fsa-schematics --baseSite=sample-financial-site --currency=usd,eur --language=en,de,fr
```

## How FSA Spartacus Schematics Work

When you run `ng add @spartacus/fsa-schematics`, the command does the following:

1. Adds the required dependencies.
1. Imports the FSA Spartacus modules in the `app.module` and sets up the default configuration.

    The following is an example:

    ```ts
    FSStorefrontModule.withConfig({
      backend: {
        occ: {
          prefix: '/occ/v2/',
          baseUrl: 'https://yourUrl:9002' // this is the baseUrl you entered when prompted via ng add @spartacus/fsa-schematics command
        }
      },
      context: {
        baseSite: [
          'financial',
        ],
        language: ['en', 'de'],
        currency: ['EUR'],
        urlParameters: ['baseSite', 'language', 'currency'],
      },
      authentication: {
        client_id: 'financial_customer',
        client_secret: 'secret'
      },
      features: {
        consignmentTracking: true,
      }
    }),
    ```

1. Imports FSA Spartacus styles to `styles.scss`:

    ```shell
    @import '~@spartacus/fsa-styles/index
    ```
