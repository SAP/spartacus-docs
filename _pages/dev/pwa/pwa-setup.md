---
title: PWA setup (Draft)
---

This guide describes how to add Progressive Web Application support to the Spartacus app.

Spartacus supports the latest major version of `@angular/pwa`.

## Steps

Add the Angular PWA dependency to your shell app

```bash
ng add @angular/pwa
```

> _Note #1:_ If you have more than one project in your workspace, use the --project flag to add PWA to your main project.
>
> _Note #2:_ If you already have the _@angular/pwa_ dependency, you'll have to do the following:
>
> - Remove it from package.json
> - Run _yarn_ to remove the dependencies from your app
> - Reinstall them again using _ng_

Adding the dependency using _ng_ will also trigger the angular PWA schematic, which will do some additional tasks for you:

- Create default PWA configuration files
- Create icons
- Update angular.json file to include PWA related resources in your build
- Update project files for PWA readiness

Update your `ngsw-config.json`, as follows:

```json
{
  "index": "/index.html",
  "assetGroups": [
    {
      "name": "app",
      "installMode": "prefetch",
      "resources": {
        "files": ["/favicon.ico", "/index.html", "/*.css", "/*.js"]
      }
    }
  ]
}
```

Build your app in prod mode

```bash
ng build --prod
```

The build will generate the required files to register your service worker and serve your app in PWA mode.

> _Note:_ Our PWA module assumes a _production===true_ flag, which is set using our _environment.production_ file. This setting needs to be set manually by customers.

Finally, deploy and serve your app using an HTTP server.

> For testing purposes, we recommend to install [http-server](https://www.npmjs.com/package/http-server) as a dev dependency and serve the app using `http-server ./dist/your-app`
>
> Double check that the service worker is running and add-to-homescreen feature works.

## Caveats

- The default ng server ([webpack devserver](https://webpack.js.org/configuration/dev-server/)) does not provide support for service workers. Therefore, you must use a separate HTTP server to support PWA.

- PWA is only supported in secure mode. Therefore, the http server of your choice will need to serve Spartacus in Secure (HTTPS) mode.
