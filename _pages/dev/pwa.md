# Spartacus PWA (Draft)

This guide describes how to add Progressive Web Application support to the Spartacus app.

## Steps

Add the Angular PWA dependency to your shell app, as follows:

```bash
ng add @angular/pwa --project *project-name*
```

_Note:_ If you already had the previous _@angular/pwa_ dependency, you'll have to do the following:

- Remove it from package.json
- Run _yarn_ to remove the dependencies from your app
- Reinstall them again using _ng_

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

The build will generate the necessary files to register your service worker and serve your app in PWA mode.

Finally, deploy and serve your app using an HTTP server.

## Caveats

- The default angular server does not provide support for service workers. Therefore, you must use a separate HTTP server to support PWA.

- PWA is only supported in secure mode. Therefore, the http server of your choice will need to serve Spartacus in Secure (HTTPS) mode.
