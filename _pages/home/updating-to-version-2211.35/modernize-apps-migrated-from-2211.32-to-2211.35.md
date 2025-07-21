---
title: Modernizing Your Storefront App After Upgrading to Version 2211.36
---

New Angular 19 apps are configured a bit differently than Angular 17 apps that have been migrated to version 19. This applies to all Spartacus apps that have updated from version 2211.32.1 to version 2211.36. It is highly recommended that you modernize your Angular 19 app to be as similar as possible to a new Angular 19 app. This will help with updating to new versions of Angular and Spartacus in the future.

## Automatic Migration

Spartacus includes specially-prepared schematics to automatically modernize your app to be as similar as possible to a newly created Angular 19 apps. To modernize your app using these schematics, run the following command from your project root directory:

```bash
ng g @spartacus/schematics:modernize-app-migrated-from-2211_32-to-2211_36
```

If you encounter any issues, you can finish the migration by completing the steps in the following sections.

## Manual Migration For All Spartacus Apps

The following steps apply to all storefront apps that have been updated to version 2211.36.

**Note:** These steps are provided for reference and for troubleshooting purposes. You should only follow these steps if you run into issues with the automatic migration described above.

1. In the `architect > build > options > assets` section of `angular.json`, replace the two string values in the array, `"src/favicon.ico"` and `"src/assets"`, with a single `{ "glob": "**/*", "input": "public" }` object. The updated array should appear as follows:

   ```json
   "assets": [
     {
       "glob": "**/*",
       "input": "public"
     },
   ```

2. Make this same change in the `architect > test > options > assets` section of `angular.json`.
3. In the `"compilerOptions"` section of `tsconfig.json`, do the following:
   1. Add a new option: `"isolatedModules": true`
   2. Remove the following options: `"sourceMap": true`, `"declaration": false`, `"useDefineForClassFields": false`, and `"lib": ["ES2022", "dom"]`
   3. Change the value of `"moduleResolution"` from `"node"` to `"bundler"`

   The updated `"compilerOptions"` section should appear as follows:

   ```json
     "compilerOptions": {
        "isolatedModules": true,
        "moduleResolution": "bundler",
   ```

4. Rename the `src/assets` folder to `/public`, and then move this folder to the project's root folder.

   For example, you can do this by running the following command on Mac or Linux:

   ```bash
   mv src/assets public
   ```

5. Move the `src/favicon.ico` file to the `/public` folder.

   For example, you can do this by running the following command on Mac or Linux:

   ```bash
   mv src/favicon.ico public
   ```

6. In `src/main.ts`, add a `{ ngZoneEventCoalescing: true }` option to the second argument of the `platformBrowserDynamic().bootstrapModule()` call.

   The updated call should appear as follows:

   ```ts
   platformBrowserDynamic().bootstrapModule(AppModule, {
     ngZoneEventCoalescing: true,
   })
   ```

## Additional Migration Steps For Projects Using SSR

The following steps apply to all storefront apps that use server-side rendering (SSR).

1. Move the `server.ts` file from the root folder to the `/src` folder (`server.ts` -> `src/server.ts`).

   For example, you can do this by running the following command on Mac or Linux:

   ```bash
   mv server.ts src/server.ts
   ```

2. In the `server.ts` file, update the `AppServerModule` import path from `./src/main.server` to `./main.server`.

   The updated `AppServerModule` import path should appear as follows:

   ```ts
   import AppServerModule from './main.server';
   ```

3. In the `architect > build > options > ssr > entry` section of `angular.json`, replace `"server.ts"` with `"src/server.ts"`.

   The updated section should appear as follows:

   ```json
   "ssr": {
     "entry": "src/server.ts"
   }
   ```

4. In the `"files"` array of `tsconfig.app.json`, replace `"server.ts"` with `"src/server.ts"`.

   The updated array should appear as follows:

   ```json
   "files": [
     "src/main.ts",
     "src/main.server.ts",
     "src/server.ts"
   ],
   ```

## Migration Steps For Projects Using Lazy Loaded i18n

If your project uses [lazy loaded i18n](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/775e61ed219c4999852d43be5244e94a.html?q=i18n#lazy-loading), and if you stored your i18n files in the `src/assets/` folder, the previous migration steps required you to move these files to the `public/` folder.

As a result, you need to update the Spartacus config for the lazy loading of i18n files to use the new path. This may be in your `spartacus-configuration.module.ts` file, for example.

Look for an import, such as `../../assets/i18n-assets/${lng}/${ns}.json`, and replace it with `../../../public/i18n-assets/${lng}/${ns}.json`.

The following is an example of how the updated config should appear:

```ts
providers: [
  provideConfig({
    i18n: {
      backend: {
        loader: (lng: string, ns: string) =>
          import(`../../../public/i18n-assets/${lng}/${ns}.json`),
```

Congratulations! You have now modernized your migrated storefront app to look like a new Angular 19 app, and you have completed the update to Spartacus 2211.36.
