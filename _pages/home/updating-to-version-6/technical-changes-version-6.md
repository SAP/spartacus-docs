---
title: Technical Changes in Spartacus 6.0
---

The Spartacus migration schematics scan your codebase and inject code comments whenever you use a reference to a Spartacus class or function that has changed its behavior in version 6.0, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed). After the migration schematics have finished running, inspect your code for comments that begin with `// TODO:Spartacus` to see the areas of your code that have been identified as possibly needing further work to complete your migration.

**Note:** If you happen to have in your codebase a custom function or class that has the same name as a function or class that has changed or been removed in the Spartacus public API, there is a chance that the migration script could identify your custom function or class as needing to be updated. In this case, you can ignore and remove the comment.

## Prerendering on Server

If you are using prerendering, you will need to provide the following function to your `AppServerModule`:

```ts
import { provideServer } from '@spartacus/setup/ssr';
@NgModule({
  ...
  providers: [
    ...provideServer({
      serverRequestOrigin: process.env['SERVER_REQUEST_ORIGIN'],
    }),
    ...
  ],
})
export class AppServerModule {}
```

**Note:** It is mandatory to set the `serverRequestOrigin` option for the prerendering because it cannot be automatically resolved.

In SSR mode, it will be automatically resolved from the express server, so it does not need to be set using this option. If this option is explicitly set, it will take precedence over the express server.

## SSR

### New default SsrOptimizationOptions

The following are the default options:

- `reuseCurrentRendering` is `true` by default.
- `concurrency` is set to `10` slots by default.
- `timeout` is set to `3000` ms by default.

### Merging custom SsrOptimizationOptions with the default options

Previously, when the custom `SsrOptimizationOptions` were provided as a second parameter of `NgExpressEngineDecorator.get()`, Spartacus was using only those custom settings and ignoring the defaults. Now Spartacus merges together the provided custom options with the default options. In case of a conflict for a particular option, the custom option takes precedence over the default one.

### 20 second timeout for outgoing HTTP requests in SSR

Starting from version 6.0, Spartacus includes a timeout for all outgoing HTTP requests in SSR. This timeout is set to 20 seconds by default and ensures that the server side rendering does not hang indefinitely when a third-party service is unreachable, such as during a temporary network outage.

If the timeout is reached before a response is received, the request is aborted, and a warning message is logged to the console, as follows:

```text
Request to URL '${request.url}' exceeded expected time of ${timeoutValue}ms and was aborted.
```

To change the default timeout, you can use the `config.backend.timeout.server` configuration option in Spartacus. By default, the `config.backend.timeout.server` value is set to `20_000` milliseconds (20 seconds).

## i18n (internationalization)

### Configuration of the i18next back end plugin

Previously, the i18next back end plugin (for loading JSON translations through HTTP calls) was used only when the `i18n.backend.loadPath` config property was defined. Now, to activate the back end plugin, you only need to ensure that the `i18n.backend` parent property is defined. However, if the `loadPath` child property is not defined, an error will be thrown.

### New peer dependency package of @spartacus/core

The `i18next-resources-to-backend` package is a new peer dependency of `@spartacus/core`.

### Renaming of services for `i18next` back end initialization

`I18nextHttpBackendService` is renamed to `I18nextHttpBackendInitializer` and now it is multi-provided as an injection token named `I18nextBackendInitializer`.

`I18nextBackendService` is no longer an abstract class, but a concrete service that consumes all multi-provided `I18nextHttpBackendInitializer` tokens and chooses the most applicable back end initializer to use, based on the actual `i18n` config. This allows for plugging in other back end initializers in the future (for example, back end initializers that do not use HTTP calls but JS dynamic imports).

## @spartacus/organization/administration

### UserGuard and AdminGuard are no longer provided in root injector

`UserGuard` and `AdminGuard` from `@spartacus/organization/administration` are no longer provided in the root injector (no longer `@Injectable({providedIn: 'root'})`). Instead, they are explicitly provided in the lazy loaded module `AdministrationModule` (inside `OrganizationsGuardsModule`).

## Other Changes

### OnNavigateService

When using the Spartacus implementation for Scroll Position Restoration, Spartacus needs to disable automatic scroll restoration provided by the browser `viewportScroller` to work correctly, as follows:
  
```text
viewportScroller.setHistoryScrollRestoration('manual')
```

### ParagraphComponent

- The `handleClick()` method now uses the condition `documentHost === element.host` to recognize external links.
- The `handleClick()` method now uses `router.navigateByUrl()` to navigate internal links.

### CloseAccountModalComponent

The `onSuccess()` method now uses `authService.coreLogout()` to log users out before routing to the homepage.

### QuickOrderOrderEntriesContext

The `addEntries` method now passes `productsData` to the `canAdd()` method to assist the `īsLimit()` method in recognizing limit breaches.

### CheckoutDeliveryAddressComponent

The `getCardContent()` method now uses the `getAddressNumbers()` util to get the correct phone numbers to display.

### CheckoutPaymentFormComponent

- The `getAddressCardContent()` method now uses the `getAddressNumbers()` util to get the correct phone numbers to display.
- The `getAddressCardContent()` method now has the `Observable<Card>` return type.

### CheckoutReviewSubmitComponent

The `getDeliveryAddressCard()` method now uses the `getAddressNumbers()` util to get the correct phone numbers to display.

### AddressBookComponent

The `getCardContent()` method now uses the `getAddressNumbers()` util to get the correct phone numbers to display.

### ConfiguratorFormComponent

 The view that display the current group has been carved out into a new `ConfiguratorGroupComponent` component. This was done because Spartacus needs to display a group also as part of the new conflict solver dialog that is introduced for the AVC configurator. This means that `configurator-form.component.html` is much smaller and includes `configurator-group.component.html`. Additionally, many methods previously residing in `configurator-form.component.ts` have been moved to `configurator-group.component.ts`

### Handling of attribute types

Instead of listing all possible attribute type components on `configurator-group.component.html` (SPA 5.2) or `configurator-form.component.html` (SPA 5.1 or older), the assignment of attribute type components to the attribute UI type is now part of a `ConfiguratorAttributeCompositionConfig` configuration. Each module representing an attribute type, such as `configurator-attribute-drop-down.module.ts`, for example, provides this configuration and assigns its component to its UI type. This improves extensibility because as it is now possible to replace attribute type components (as well as the attribute header and footer component) simply by adding a custom component and registering it for the desired attribute UI type.

### Consequences for all attribute type components

These changes have a couple of consequences for the components representing attribute types.

- The context for these components is no longer provided through specific `@Input()` class members but by an instance of `ConfiguratorAttributeCompositionContext`. The `configurator-attribute-composition.directive.ts` directive is responsible for providing this instance. That means all `@Input()` class members are turned into standard class members, and their initialization happens in the component constructor.
- The configuration update no longer happens using `ConfigFormUpdateEvent`, but all components that are capable of sending updates get a new dependency to `ConfiguratorCommonsService`, calling its facade method for performing an update. This also means that `@Output() selectionChange = new EventEmitter<ConfigFormUpdateEvent>()` has been removed.

#### Working with UI types not known to Spartacus

It is now possible to register custom attribute type components for UI types not known to Spartacus (not part of enumeration `Configurator.UiType`). Those UI types must be based on standard UI types (because business logic is attached to these types both in the UI and in the commerce back end) and their identifier must follow a convention described in the documentation of `Configurator.Attribute#uiTypeVariation`.

### ConfiguratorOverviewMenuComponent

By navigating to a certain overview group through the overview menu, the browser does not scroll anymore to the container of the `'#' + ovGroupId` group, but to the title of the corresponding `'#' + ovGroupId+ ' h2'` group instead.

### ConfiguratorStorefrontUtilsService

For readability purposes `--` separate is added between `prefix` and `groupId` in `createOvGroupId(prefix: string, groupId: string)` method.

### ConfiguratorAction

The type alias changed. The following new actions are included:

- `UpdateConfigurationOverview`
- `UpdateConfigurationOverviewFail`
- `UpdateConfigurationOverviewSuccess`
- `RemoveProductBoundConfigurations`
- `CheckConflictDialoge`
- `DissmissConflictDialoge`

### Action create configuration

The constructor payload gets two additional optional parameters:

- `configIdTemplate`, which is the ID of a template configuration
- `forceReset`, which forces configuration reset in the backend

## BadRequestHandler

The `handleBadPassword()` method now calls `getErrorTranslationKey()` to get more detailed information about the type of error, as well as to translate the error.

### OrderHistoryService

The `getOrderDetailsLoading()` method has been added, and it returns the order details loading state.

### OrderDetailsService

The `isOrderDetailsLoading()` method was added, and it uses the `getOrderDetailsLoading()` method to display valid state in a template.

## GoogleMapRendererService

To comply with security best practices, the Google map does not display by default in the store finder feature. For the map to display, the store finder configuration must have a google maps API key defined. To do this in your Spartacus app, define a `StoreFinderConfig` configuration block. Inside this block, define the `apiKey` property in the `googleMaps` object with the value of the API key. The following is an example:

```ts
provideConfig(<StoreFinderConfig>{
  googleMaps: { apiKey: 'your-api-key-goes-here' },
}),
```

For development or demo purposes, the special `cx-development` value can be provided as the API key value in a Spartacus based application's configuration. The store finder map component will display the map and send an empty API key value to Google Maps, which is the same as the default behavior of the component prior to version 6.0.

## Spartacus PWA schematics

- `ng g @spartacus/schematics:add-pwa` and `ng add @spartacus/schematics --pwa` have been removed and are not longer supported.
- If you would like to add Angular PWA functionality to your application, you can run the command `ng add @angular/pwa --project <project-name>` and remove the service worker references in your `app.module.ts` to have the same output as what the Spartacus custom PWA schematics previously did.

## OrderApprovalDetailsModule

Replaced `OrderDetailShippingComponent` with `OrderOverviewComponent` for `OrderApprovalDetailShippingComponent`.

## OrganizationUserRegistrationForm

Added `companyName` as an optional property into the `OrganizationUserRegistrationForm` model.
