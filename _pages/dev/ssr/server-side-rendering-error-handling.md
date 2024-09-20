---
title: SSR Error Handling
feature:
  - name: SSR Error Handling
    spa_version: 2211.29
    cx_version: n/a
---

SSR Error Handling functionality provides the missing behavior to how Angular engine handles errors during rendering pages on the server. It ensures the Spartacus application reacts on the encountered errors by providing default set of tools to handle them and, at the same time, giving a possibility to customize the experience. This feature is crucial for the SEO of the page and the overall UX.

**Note:** Angular SSR by default doesn't ignore an error only if occurred in the APP_INITIALIZER or synchronous bootstrap of the root component.

New Spartacus apps created since v2211.29, have the SSR Error Handling enabled by default.

If your Spartacus app was created before v2211.29, to benefit from all aspects of SSR error handling, you must do the following:
- Enable `propagateErrorsToServer` feature toggle to start propagating to the ExpressJS server the errors caught during server-side rendering, where eventually they will be properly handled. For more information, see [Propagating Errors To The Server](#propagating-errors-to-the-server).
- Enable `ssrStrictErrorHandlingForHttpAndNgrx` feature toggle to seal the Angular application from the asynchronous errors that occur in NgRx flow and HTTP calls during the rendering process. For more information, see [Strict Error Handling for HTTP And NgRx](#strict-error-handling-in-angular-for-http-and-ngrx).
- Enable `ssrFeatureToggle.avoidCachingErrors` in `SsrOptimizationOptions` to not cache pages for which error occurred during rendering. For more information, see [Cache management and error handling](#cache-management-and-error-handling).
- use `defaultExpressErrorHandlers` middleware in `server.ts` to handle errors in ExpressJS. For more information, see [Using Default ExpressJS Error Handlers](#using-default-expressjs-error-handlers).
- make sure that `provideServer()` config function is provided in the `app.server.module.ts` file. It contains elements required for SSR Error Handling to work properly.

**Note:** The SSR Error Handling is available starting from Spartacus 2211.29. For new application, the feature is enabled fy default. For migrated application. the feature is disabled by default and can be enabled by using mentioned feature toggles. After expiration of the feature toggle period, the feature will be enabled by default.
**Note:** Together with SSR Error Handling, Spartacus provides `ssrFeatureToggles` that allow you to enable or disable features specific for `OptimizedSsrEngine`. For more information, see [SSR Feature Toggles](TODO: add link to page when is read).

Without SSR Error Handling, the following issues arise:

- with the default Angular SSR behavior (used under the hood of Spartacus SSR), when the asynchronous error occurs during the rendering (e.g. API call, runtime error in the code), rendering process will not stop and eventually returns possibly malformed HTML to the client with the improper HTTP status code `200`. This can lead to the client-side errors and the page not being rendered correctly.
- when customer enters the URL unknown for the application, Spartacus returns an error page, but with misleading status `200`.

Both scenarios may drastically affect the SEO of the page due to fact the wrong status code in the response to the client might lead to indexing by Google the malformed pages and unknown URLs.

See below the sequence diagram of rendering the Angular app for an incoming request in SSR, with Spartacus OptimizedSsrEngine included. It shows how an asynchronous error happening during the rendering is ignored and a malformed HTML is returned to a client:
![Rendering Sequence Without SSR Error Handling](../../../assets/images/ssr/error_handling_rendering_sequence_without_improvements.png)

To solve the issues, Spartacus provided CxCommonEngine - a wrapper for CommonEngine which allows to react on asynchronous errors that occurred during SSR. Thanks to this, it is possible to return an error with the appropriate status code instead of the rendered HTML which is potentially malformed.

See below the sequence diagrams showing how the path from the incoming request to the error response looks with the attached CxCommonEngine:

![Rendering Sequence With SSR Error Handling](../../../assets/images/ssr/error_handling_rendering_sequence_with_improvements.png)

To propagate errors from the Angular app to ExpressJS, Spartacus introduce a new contract between the Angular app and ExpressJS.
See below the diagram showing the connections between elements of the contract (arrows represent the flow of data/error):

![SSR Error Handling Contract](../../../assets/images/ssr/error_handling_contract_between_angular_and_expressjs.png)

**Note:** Please note the difference between 2 types of error handlers in 2 different layers:
- Angular `ErrorHandler` class - recieves errors that happened during the Angular app rendering (on the server side). Spartacus provides a custom version of it - the `CxErrorHandler` - which propagates those errors to the next layer - ExpressJS.
- Express error handlers functions - recieve errors propagated from the Angular app rendering. It is responsible for sending an appropriate HTTP status code and HTML content to the client of SSR,

## Propagating errors to the server

To propagate errors caught during server-side rendering to the ExpressJS server, the `CxErrorHandler` provided together with `Standardized SSR logging` feature has been extended. Now the error handler acts differently based on the platform it is running on thanks to multi error handlers:
- `LoggingErrorHandler`, which logs the error using `LoggerService`;
- `PropagatingToServerErrorHandler`, specially for SSR Error Handling purposes, which passes the error to the `CxCommonEngine` thanks to `PROPAGATE_ERROR_TO_SERVER` injection token. For more, see [CxCommonEngine](#cx-common-engine).

To read more about Multi error handlers, see [Multi error handlers](#multi-error-handlers).

**Note:** If you're providing custom Angular `ErrorHandler`, extend the `CxErrorHandler` from Spartacus to ensure benefits from the SSR Error Handling.

## CxCommonEngine

[`CxCommonEngine`](https://github.com/SAP/spartacus/blob/develop/core-libs/setup/ssr/engine/cx-common-engine.ts) is a core element of SSR Error Handling. It is a wrapper for Angular's [CommonEngine](https://github.com/angular/angular-cli/blob/e56adb062b86ecc538346412856bba57a8f378cf/packages/angular/ssr/src/common-engine.ts#L56) that allows to react on asynchronous errors that occurred during SSR. 

Thanks to this extension, it's possible to react on propagated errors and ExpressJS application will receive the error instead of malformed HTML.

## Multi error handlers
Spartacus brings possibility to provide multiple implementations of the Angular `ErrorHandler` class that can react on the error caught during server-side rendering. They can be provided via the token `MULTI_ERROR_HANDLER`. They will be all executed one by one by the Spartacus `CxErrorHandler` for each captured error. 
Default multi-provided error handlers are:
- `LoggingErrorHandler` - logs the error using `LoggerService`;
- `PropagatingToServerErrorHandler` - passes the error to the `CxCommonEngine` thanks to `PROPAGATE_ERROR_TO_SERVER` injection token.

To create a custom multi-provided error handler, you need to implement and interface `MultiErrorHandler` and provide the handler in a module.
The following is an example of how to crate a multi-provided error handler:
```ts
@Injectable({
  providedIn: 'root',
})
export class MyMultiErrorHandler implements MultiErrorHandler {
  handleError(error: unknown): void {
    /* custom error handling logic */
  }
}
```
```ts
@NgModule({
  providers: [
    {
      provide: MULTI_ERROR_HANDLER,
      useClass: MyMultiErrorHandler,
      multi: true,
    },
  ],
})
export class MyModule {}
```

**Note:** All multi-provided error handlers are executed. The order of execution is same as the order they are provided. 


## Using default ExpressJS error handlers

To handle errors in ExpressJS that were caught during server-side rendering, Spartacus provides a set of default error handlers that can be used in the `server.ts` file:

```ts
/* ... */
export function app(): express.Express {
  const server = express();
  const distFolder = join(process.cwd(), 'dist/my-app/browser');
  const indexHtml = existsSync(join(distFolder, 'index.original.html'))
    ? 'index.original.html'
    : 'index.html';
  const indexHtmlContent = readFileSync(join(distFolder, indexHtml), 'utf8');

  /* ... */

  server.use(defaultExpressErrorHandlers(indexHtmlContent));

  return server;
}
```

The [`defaultExpressErrorHandlers`](https://github.com/SAP/spartacus/blob/develop/core-libs/setup/ssr/error-handling/express-error-handlers/express-error-handlers.ts) function takes the `documentContent` as an argument, which is the content of the application's `index.html` file. The function returns an error handler which drives `Fallback to CSR` strategy and sends the `documentContent` with the proper status code based on the error type. By default, the function returns `404` status code for `CmsPageNotFoundOutboundHttpError` and `500` status code for other errors.

The benefits of such a approach are:
- we send a semantic HTTP response code, e.g. 404 or 500  - so Search Engines avoid indexing such an error page or re-attempt to visit it sometime later.
- we send HTML content being a "CSR Fallback" - so real users _might_ see a correct content of the page in CSR, if the error that happened in SSR doesn't repeat in CSR

### Customizing ExpressJS error handlers

As the final handling takes place in the ExpressJS middleware, error handling can be customized to fit the specific needs of the application.
The following is an example of custom error handler middleware that returns a custom error page:
```ts
//server.ts
export const customErrorPageErrorHandlers: ErrorRequestHandler = async (
  err,
  _req,
  res,
  _next
) => {
  const statusCode =
    err instanceof CmsPageNotFoundOutboundHttpError
      ? HttpResponseStatus.NOT_FOUND
      : HttpResponseStatus.INTERNAL_SERVER_ERROR;

  const html = `
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ERROR</title>
      </head>
      <body>
        <h1>${
          statusCode === HttpResponseStatus.NOT_FOUND
            ? 'Oups! Page not found (404)'
            : 'Internal Server Error (500)'
        }</h1>
      </body>
    </html>
    `;
  res.status(statusCode).send(html);
};
```
To use the custom error handler, replace the `defaultExpressErrorHandlers` with the `customErrorPageErrorHandlers` in the `server.ts` file:
```ts
//server.ts
import { APP_BASE_HREF } from '@angular/common';
import {
  ngExpressEngine as engine,
} from '@spartacus/setup/ssr';
import { customErrorPageErrorHandlers } from './custom-error-handler';

import express from 'express';
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'path';

export function app(): express.Express {
  const server = express();
  const distFolder = join(process.cwd(), 'dist/my-app/browser');
  const indexHtml = existsSync(join(distFolder, 'index.original.html'))
    ? join(distFolder, 'index.original.html')
    : join(distFolder, 'index.html');
  const indexHtmlContent = readFileSync(indexHtml, 'utf-8');

  /* ... */

  //server.use(defaultExpressErrorHandlers(indexHtmlContent)); <-- replace with custom error handler
  server.use(customErrorPageErrorHandlers);

  return server;
}
```

If you find the functionality of `defaultExpressErrorHandlers` sufficient but want a customize how one type of error is handled, you can provide a custom error handler before the `defaultExpressErrorHandlers`. Make sure to call `next(err)` in the custom error handler to let the `defaultExpressErrorHandlers` take care of the error not handled by the custom handler.
The following is an example of how to provide a custom error handler for `CmsPageNotFoundOutboundHttpError`:
```ts
//custom-error-handler.ts
export const customCmsPageNotFoundErrorHandler: ErrorRequestHandler = async (
  err,
  _req,
  res,
  next
) => {
  const errorPage = /*...*/;
  if (err instanceof CmsPageNotFoundOutboundHttpError) {
    res.status(HttpResponseStatus.NOT_FOUND).send(errorPage);
  } else {
    next(err);
  }
};
```

```ts
//server.ts
import { APP_BASE_HREF } from '@angular/common';
import {
  ngExpressEngine as engine,
} from '@spartacus/setup/ssr';
import { customErrorPageErrorHandlers } from './custom-error-handler';

import express from 'express';
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'path';

export function app(): express.Express {
  const server = express();
  const distFolder = join(process.cwd(), 'dist/my-app/browser');
  const indexHtml = existsSync(join(distFolder, 'index.original.html'))
    ? join(distFolder, 'index.original.html')
    : join(distFolder, 'index.html');
  const indexHtmlContent = readFileSync(indexHtml, 'utf-8');

  /* ... */

  server.use(customErrorPageErrorHandlers); // <-- custom error handler for 404 provided before default error handlers.
  server.use(defaultExpressErrorHandlers(indexHtmlContent));

  return server;
}
```

## Strict error handling in Angular for HTTP and NgRx

 To seal the Angular application from the asynchronous errors that occur in NgRx flow and HTTP calls to backend during the rendering process, Spartacus provides set of tools to handle them.

### Handling HTTP errors

To handle HTTP errors, Spartacus provides `HttpErrorHandlerInterceptor` that catches the HTTP errors and forward them to the `CxErrorHandler`. The interceptor by default helps to distinguish two types of error by wrapping them with custom error classes before passing them to the `CxErrorHandler`:
- `OutboundHttpError` - represents an outbound HTTP error that occurs when communicating with the backend.
- `CmsPageNotFoundOutboundHttpError` - represents an outbound HTTP error specific to a CMS page not found. Extends the base OutboundHttpError class.

Thanks to this, when such semantic errors are propagated to ExpressJS and handled there by `defaultExpressErrorHandlers` middleware, it can distinguish the errors and return an appropriate status code to the client (e.g. 404 or 500).

**Note:** Make sure your custom Angular HTTP interceptors are provided after `HttpErrorHandlerInterceptor` (so they run as next in the sequence). If they catch any error, make sure to rethrow the error downstream to next interceptors. Otherwise, Spartacus `HttpErrorHandlerInterceptor` will not capture such an error, and therefore it won't be able to propagate it to ExpressJS layer and cause sending and appropriate HTTP error status code to the client of the SSR.  

Spartacus `HttpErrorHandlerInterceptor` treats all outbound HTTP as a reason to make SSR fail. 

However, if this assumption is not true for your application, you can customize it by over-providing Spartacus `HttpErrorHandlerInterceptor`. It might be useful in one of the following cases:
- when you don't want some backend HTTP errors to make SSR fail (e.g. when some HTTP errors from backend are considered really not important for the final HTML result of SSR)
- when you want some backend HTTP success responses to be treated as errors making SSR to fail (e.g. when backend responds with status 200 and a custom payload indicating and error like `{ "ok": false, ... }`

### Handling NgRx errors

Spartacus treats any NgRx action containing the property `error` as a reason for SSR to fail. To handle them, Spartacus provides elements of NgRx flow that helps to catch the errors and forward them to the `CxErrorHandler`:
- `CxErrorHandlerEffect` - an effect that catches all dispatched NgRx Actions with the property `error` and forwards such an error to the `CxErrorHandler`.
- `ErrorAction` - an interface with a property `error`, used in `CxErrorHandlerEffect` to filter error actions.

The following is an example of how to implement the `ErrorAction` interface in your custom failure action: 
```ts
export class MyActionFail implements ErrorAction {
  readonly type = MY_ACTION_FAIL;
  public error: Object;
  constructor(public payload: Object) {
    this.error = payload;
  }
}
```
Please make sure that all your custom NgRx Actions of type Fail contain the property `error`.

**Note:** If in your case some exceptional NgRx actions with the property `error` should not make SSR fail, you can customize the behavior by over-providing Spartacus `ErrorActionService`.

## Don't use the RESPONSE token for setting status code

Before the provided solutions, one of the way to react on handled errors was to manually inject `RESPONSE` token in their code and call `this.response.set(<custom-status>)`. Customers who have so far used this approach should no longer do so as it's not guaranteed to work correctly with the new contract between Angular app and ExpressJS. If there is a need for handling any custom error, it can be done by injecting `ErrorHandler` and calling `this.errorHandler.handleError(<custom-error>)` instead.

```ts
@Injectable()
export class MyService {
  const errorHandler = inject(ErrorHandler);

  myMethod() {
    try {
      // some code that may throw an error
    } catch (error) {
      this.errorHandler.handleError(error);
    }
  }
}
```

## Cache management and error handling

It is not recommended to cache pages for which an error occurred during rendering due to several reasons:
- *Serving Incorrect Content:* If a page with rendering errors is cached, subsequent requests to that page will receive the erroneous content. This can lead to a poor user experience and confusion, as users might see incomplete or broken pages.

- *Difficulty in Debugging:* When errors are cached, it becomes harder to identify and debug issues. Developers might not be aware that users are receiving erroneous content, making it challenging to diagnose and fix the underlying problem.

- *Performance Degradation:* While caching is generally used to improve performance, caching pages with errors can have the opposite effect. Users might repeatedly encounter the same error, leading to frustration and potentially increasing the load on support channels.

To avoid caching such pages, Spartacus provides changes to the part of `OptimizedSsrEngine`, the `RenderingCache` class, responsible for caching renders. From now, the caching strategy can be controlled by the new `SsrOptimizationOptions` property, `shouldCacheRenderingResult`:
```ts
shouldCacheRenderingResult?: ({
    options,
    entry,
  }: {
    options: SsrOptimizationOptions;
    entry: Pick<RenderingEntry, 'err' | 'html'>;
  }) => boolean;
```
By default, all html rendering results are cached. By default, also all errors are cached (unless the separate option `avoidCachingErrors` is enabled).
If needed, the caching strategy can be easily customized by providing an own function.

## Error Handling and Logging

All errors caught during server-side rendering are logged using the `LoggerService` provided by Spartacus, which means they are presented in a standardized way:
- multiline JSON output in development mode, developer-friendly

![SSR Error Handling - Error Log in Dev Mode](../../../assets/images/ssr/error-handling-error-log-in-dev.png)
- single line JSON output in production mode, that are seamlessly parsed by monitoring tools.
![SSR Error Handling - Error Log in Dev Mode](../../../assets/images/ssr/error-handling-error-log-in-prod.png)

Apart from that, `OptimizedSsrEngine` informs if request is resolved with the server-side rendering error. 
The following is an example of the log message if error occurred during rendering process.
![SSR Error Log](../../../assets/images/ssr/error-handling-ssr-result-log.png)

Such logs are crucial for monitoring and debugging purposes, as they provide information about the error and the related request.











