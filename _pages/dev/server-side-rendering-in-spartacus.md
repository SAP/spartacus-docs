---
title: Server-Side Rendering in Spartacus (DRAFT)
---

## Installation steps using Angular Schematics ( Recommended)

The easiest way to add SSR support in your application is to use schematics. This way you don't need to add anything manually, all files will be created and modified automatically.

```bash
ng add @spartacus/schematics --ssr
```

## Installation steps (Manual)

The following steps can be performed to run your Spartacus shell app that includes the Spartacus libraries in SSR mode.

Add the following dependencies to `package.json`:

```json
"@angular/platform-server": "~8.2.7",
"@nguniversal/express-engine": "^8.1.1",
"@nguniversal/module-map-ngfactory-loader": "^8.1.1"
```

Add the following developer dependencies to `package.json`:

```json
 "ts-loader": "^5.3.2”
 "webpack-cli": "^3.3.2”
```

Update the following files:

### src/main.ts

```typescript
//from
platformBrowserDynamic().bootstrapModule(AppModule).catch(err => console.error(err));
//to
document.addEventListener('DOMContentLoaded', () => {
  platformBrowserDynamic().bootstrapModule(AppModule);
});
```

### src/app/app.module.ts

Add the following lines to `app.module.ts`:

```typescript
import { BrowserModule, BrowserTransferStateModule } from '@angular/platform-browser';
//from:
BrowserModule,
//to
BrowserModule.withServerTransition({ appId: 'spartacus-app' }),
BrowserTransferStateModule
```

### src/index.html

Add the following meta attribute and replace OCC_BASE_URL with the URL of your backend instance:

```html
 <meta name="occ-backend-base-url" content="OCC_BASE_URL" />
```

Add the following configuration to your existing angular.json (under projects.<your-project-name>.architect):

```json
"server": {
  "builder": "@angular-devkit/build-angular:server",
  "options": {
    "outputPath": "dist/server",
    "main": "src/main.server.ts",
    "tsConfig": "tsconfig.server.json"
  }
}
```

Add the following files to your existing shell app:

### tsconfig.server.json

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "../out-tsc/app",
    "baseUrl": "./",
    "module": "commonjs",
    "types": []
  },
  "exclude": ["test.ts", "e2e/src/app.e2e-spec.ts", "**/*.spec.ts"],
  "angularCompilerOptions": {
    "entryModule": "src/app/app.server.module#AppServerModule"
  }
}
```

### src/main.server.ts

```typescript
import { enableProdMode } from '@angular/core';

import { environment } from './environments/environment';

if (environment.production) {
  enableProdMode();
}

export { AppServerModule } from './app/app.server.module';
export { ngExpressEngine } from '@nguniversal/express-engine';
export { provideModuleMap } from '@nguniversal/module-map-ngfactory-loader';
```


### src/app/app.server.module

```typescript
import { NgModule } from "@angular/core";
import {
  ServerModule,
  ServerTransferStateModule
} from "@angular/platform-server";

import { AppModule } from "./app.module";
import { AppComponent } from "./app.component";

@NgModule({
  imports: [
    // The AppServerModule should import your AppModule followed
    // by the ServerModule from @angular/platform-server.
    AppModule,
    ServerModule,
    ServerTransferStateModule
    // ModuleMapLoaderModule // <-- *Important* to have lazy-loaded routes work
  ],
  bootstrap: [AppComponent]
})
export class AppServerModule {}
```

### webpack.server.config.js

```javascript
const path = require('path');
const webpack = require('webpack');

module.exports = {
  mode: 'none',
  entry: {
    server: './server.ts'
  },
  target: 'node',
  resolve: { extensions: ['.ts', '.js'] },
  optimization: {
    minimize: false
  },
  // this makes sure we include node_modules and other 3rd party libraries
  externals: [/node_modules/],
  output: {
    // Puts the output at the root of the dist folder
    path: path.join(__dirname, 'dist'),
    filename: '[name].js'
  },
  module: {
    noParse: /polyfills-.*\.js/,
    rules: [
      { test: /\.ts$/, loader: 'ts-loader' },
      {
        // Mark files inside `@angular/core` as using SystemJS style dynamic imports.
        // Removing this will cause deprecation warnings to appear.
        test: /(\\|\/)@angular(\\|\/)core(\\|\/).+\.js$/,
        parser: { system: true },
      },
    ]
  },
  plugins: [
    new webpack.ContextReplacementPlugin(
      // fixes WARNING Critical dependency: the request of a dependency is an expression
      /(.+)?angular(\\|\/)core(.+)?/,
      path.join(__dirname, 'src'), // location of your src
      {} // a map of your routes
    ),
    new webpack.ContextReplacementPlugin(
      // fixes WARNING Critical dependency: the request of a dependency is an expression
      /(.+)?express(\\|\/)(.+)?/,
      path.join(__dirname, 'src'),
      {}
    )
  ]
};

```

### server.ts

```typescript
import 'zone.js/dist/zone-node';

import * as express from 'express';
import { join } from 'path';

// Express server
const app = express();

const PORT = process.env.PORT || 4200;
const DIST_FOLDER = join(process.cwd(), 'dist/<your-project-name>');

// * NOTE :: leave this as require() since this file is built Dynamically from webpack
const {
  AppServerModuleNgFactory,
  LAZY_MODULE_MAP,
  ngExpressEngine,
  provideModuleMap,
} = require('./dist/<your-project-name>-server/main');

app.engine(
  'html',
  ngExpressEngine({
    bootstrap: AppServerModuleNgFactory,
    providers: [provideModuleMap(LAZY_MODULE_MAP)],
  })
);

app.set('view engine', 'html');
app.set('views', DIST_FOLDER);

app.get(
  '*.*',
  express.static(DIST_FOLDER, {
    maxAge: '1y',
  })
);

// All regular routes use the Universal engine
app.get('*', (req, res) => {
  res.render('index', { req });
});

// Start up the Node server
app.listen(PORT, () => {
  console.log(`Node server listening on http://localhost:${PORT}`);
});

```

* In the file above, replace `<your-project-name>` for the name of your application.

* Add the following scripts to your package.json

```json
    "build:ssr": "npm run build:client-and-server-bundles && npm run webpack:server",
    "serve:ssr": "node dist/server.js",
    "build:client-and-server-bundles": "ng build --prod && ng run <your-project-name>:server",
    "webpack:server": "webpack --config webpack.server.config.js --progress --colors"
```

* On the `build:client-and-server-bundles` script, replace `<your-project-name>` with the name of your angular application

* Build the SSR version of your spartacus shell app using the following commands:

`npm run build:ssr && npm run serve:ssr`

## Installation Steps (SPA development)

The following steps can be performed to run Spartacus in SSR mode using the Spartacus storefront app (Spartacus internal development/PR submission).

1. Make sure that the production server endpoint is set in your `environment.prod.ts` (dev mode) or `app.module.ts` (shell app mode)

```json
environment = {
  occBaseUrl: 'https://[your_endpoint]',
};
```

1. Turn PWA off (steps below)
1. Rebuild your libs (`yarn build:core:lib`)
1. Build your shell app (`yarn build`)
1. Build your shell app in ssr mode (`yarn build:ssr`)
1. start ssr server (`yarn start:ssr`)

### Service workers

As soon as a service worker is installed, Spartacus version served is the cached version of the index.html + js files. Therefore, SSR is completely skipped.

1. Check that there are no service workers registered in your app and remove them, if any
1. In your app module configuration, turn PWA off, as follows:

```json
StorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: 'https://[your_enpdoint],
        },
      },
      pwa: {
        enabled: false,
      },
};
```

## Known issues

If the backend server (endpoint) is either not valid or can't be reached, you’ll get the following error:

`TypeError: You provided 'undefined' where a stream was expected. You can provide an Observable, Promise, Array, or Iterable.`

Make sure the backend endpoint is properly configured and reachable
