---
title: Server-Side Contextual Logging
feature:
  - name: Server-Side Contextual Logging
    spa_version: 6.2
    cx_version: n/a
---

Server-side contextual logging enhances the debugging experience by letting you see the source of your log messages, as well as the context in the printed output. Furthermore, the content is formatted so that logs are easier to read, and easier to parse for monitoring tools. Server-side contextual logging also provides tools that allow you to customize the logging experience.

To benefit from all aspects of server-side contextual logging, you must do the following:

- Set `logger: true` in the `SsrOptimizationOptions` of your `server.ts` file. For more information, see [Enabling SSR Contextual Logging](#enabling-ssr-contextual-logging).
- Import `ErrorHandlingModule.forRoot()` in your storefront app, in the `spartacus.module.ts` file, for example. For more information, see [Enabling Contextual Logs In Error Handling](#enabling-contextual-logs-in-error-handling).
- Use the `LoggerService` instead of the native `console` object in your custom code. For more information, see [Using the LoggerService](#using-the-loggerservice).
- Ensure that any third-party libraries you are using can be configured to use the Spartacus `LoggerService`. For more information, see [LoggerService and Third-party Party Libraries](#loggerservice-and-third-party-party-libraries).

Without contextual logging, the following issues arise:

- Log messages are simply strings with little context about the rendered URL, making it difficult to connect the log message with the source of the log.
- The format of the log messages is not standardized, which can make it difficult to read and understand the messages.
- Log messages that span multiple lines are not formatted correctly, and each line is treated as a separate log in the monitoring tools, which further complicates the log viewing experience. For example, this can be the case for multiline stack traces of errors.

These issues make it difficult to read and understand log messages, particularly when log messages are coming from multiple parallel server-side-renderings and NodeJS servers. With server-side contextual logging, these issues are avoided because you can easily identify the source of your log messages, and also read them more easily.

Spartacus provides a default logger called `DefaultExpressServerLogger` that addresses common issues. This logger is used by default when server-side contextual logging is enabled. This logger takes care of proper formatting, and recognizes whether the output should be human-readable, or read by monitoring tools. The logger not only logs the messages, it also provides information about the related request that initiated the rendering process.

The following example shows how the logger creates logs in development mode by producing a multiline JSON output:

```json
{
  "message": "Rendering started (/powertools-spa/en/USD/product/3788616/bt-dy-720-e)",
  "context": {
    "timestamp": "2023-06-19T23:34:37.845Z", // timestamp of the log
    "request": {
      "url": "/powertools-spa/en/USD/product/3788616/bt-dy-720-e", // URL of the request
      "uuid": "1ef6d1d9-65c2-43c8-860e-32d0cb1bf698", // random UUID of the request
      "timeReceived": "2023-06-19T23:34:37.843Z" // timestamp when the request was received
    }
  }
}
```

The following is an example of a log created for production purposes. It is a single line of JSON that can be read by monitoring tools:

```text
{"message":"Rendering started (/powertools-spa/en/USD/product/3788616/bt-dy-720-e)","context":{"timestamp":"2023-06-19T23:34:37.845Z","request":{"url":"/powertools-spa/en/USD/product/3788616/bt-dy-720-e","uuid":"1ef6d1d9-65c2-43c8-860e-32d0cb1bf698","timeReceived":"2023-06-19T23:34:37.843Z"}}}
```

The following is an example of the log message in the monitoring tool:

![Log Representation In Kibana](assets/images/../../../../../assets/images/ssr/contextual_logging_kibana_logs.png)

## Enabling Server-Side Contextual Logging

To enable server-side contextual logging, in the `server.ts` file, set the `logger` option to `true` in the `SsrOptimizationOptions` that are passed to the `NgExpressEngineDecorator.get()` method. The following is an example:

```ts
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/setup/ssr';

[...]

const ngExpressEngine = NgExpressEngineDecorator.get(engine, {
  //add the logger flag here
  logger: true
});

[...]
```

With this configuration, your application uses the `DefaultExpressServerLogger` and provides request context for every logged message during server-side rendering.

## Enabling Contextual Logs in Error Handling

By default, Angular uses its own [`ErrorHandler`](https://angular.io/api/core/ErrorHandler) to handle errors that occur during server-side rendering. However, this only prints errors to the console with a lack of context, and creates multiline messages that are not parsed correctly by monitoring tools. To improve logging of errors, you have to import the Spartacus `ErrorHandlingModule.forRoot()` in `spartacus.module.ts`, as shown in the following example:

```ts
import { ErrorHandlingModule } from '@spartacus/setup/ssr';

@NgModule({
  imports: [
    [...]
    ErrorHandlingModule.forRoot()
  ]
})
export class SpartacusModule {}
```

The `ErrorHandlingModule.forRoot()` under the hood provides the Spartacus `CxErrorHandler` that extends the default Angular `ErrorHandler`. And thanks to that, all errors that occur during server-side rendering are passed to `LoggerService`, so these errors are logged with an appropriate context. For more information about the `LoggerService`, see [Using the LoggerService](#using-the-loggerservice).

**Note:** If you already provide in your application a custom Angular `ErrorHandler`, importing `ErrorHandlingModule.forRoot()` might cause the Spartacus `CxErrorHandler` to overwrite (or be overwritten with) your error handler (depending on the order of providers). In such a case, it is recommended that your custom `ErrorHandler` should extend Spartacus `CxErrorHandler` and use it's method `super.handleError()` to preserve the default Spartacus behavior as well as your custom one.

## LoggerService and Third-party Party Libraries

To ensure that you have context and proper formatting for the logs that are output by third-party libraries in your application, it is recommended that you verify whether custom loggers can be provided, and that you use the `LoggerService` if possible. Otherwise, the logs from third-party libraries will be written in plain text, without the request's context and without proper formatting.

For example, Spartacus depends on the third party library `i18next` and configures a custom [logger plugin](https://www.i18next.com/misc/creating-own-plugins#logger) for `i18next`, so `i18next` prints all its logs using the Spartacus `LoggerService`.

Similarly, you should check which other third party libraries are used in your application, and whether those libraries allow to configure a custom logging strategy. If so, configure them to use the Spartacus `LoggerService` to ensure that the logs are written with proper context and formatting.

For more information about the `LoggerService`, see [Using the LoggerService](#using-the-loggerservice).

## Customizing Server-Side Contextual Logging

You can customize server-side contextual logging, and even provide a custom logger in place of the default one.

To implement a custom logger, you create a class that implements the `ExpressServerLogger` interface. It's recommended to extend the `DefaultExpressServerLogger` class to expand its existing functionality.

After the custom logger class is created, it can be passed to the `logger` property in the configuration object. The following is an example:

```ts
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/setup/ssr';
import { CustomExpressServerLogger } from './custom-express-server-logger';

[...]

const ngExpressEngine = NgExpressEngineDecorator.get(engine, {
  // pass custom logger here
  logger: new CustomExpressServerLogger()
});

[...]
```

The following is an example of a custom `ExpressServerLogger` implementation:

```ts
import { ExpressServerLogger } from '@spartacus/setup/ssr';

export class CustomExpressServerLogger implements ExpressServerLogger {

  //custom implementation of the `log` method
  log(message: string, context: ExpressServerLoggerContext): void {
    console.log({ message: `[My Custom LOG]: ${message}`, ...context });
  }

  // don't forget to also customize other methods, such as `debug`,`info`, `warn` and `error`
  [...]
}
```

### Providing Additional Context to the Logs

In a real-world example, you may wish to extend the context of your logs with a custom header, such as `traceparent`, `content-type`, or `host`.

The following is an example of a custom logger implementation that extends the `DefaultExpressServerLogger` class and adds more functionality to the built-in `mapContext` method:

```ts
import {
  DefaultExpressServerLogger,
  ExpressServerLoggerContext,
} from '@spartacus/setup/ssr';

export class CustomExpressServerLogger extends DefaultExpressServerLogger {
  //extend output context with traceparent header
  protected override mapContext(
    context: ExpressServerLoggerContext
  ): Record<string, any> {
    const outputContext = super.mapContext(context);
    return {
      ...outputContext,
      request: {
        ...outputContext?.request,
        traceparent: context.request?.get('traceparent'),
      },
    };
  }
}
```

**Note:** The `DefaultExpressServerLogger` does not include any sensitive data in the logs. However, when implementing your custom logger, you must exercise caution and be careful about the data being provided. It is your responsibility to ensure that no sensitive information is being used or exposed.

### Integrating with Third-Party Loggers

**Note:** The following example should not be treated as a recommendation for working with any specific third-party loggers. It is provided for demonstration purposes only.

The following is an example of how to integrate a third-party logger []`Pino`](https://getpino.io):

```ts
import {
  DefaultExpressServerLogger,
  ExpressServerLoggerContext,
} from '@spartacus/setup/ssr';
import { pino } from 'pino';

class CustomPinoLogger extends DefaultExpressServerLogger {
  protected pino = pino({
    // custom configuration of the Pino logger
  });

  info(message: string, context: ExpressServerLoggerContext): void {
    this.pino.info(this.mapContext(context), message);
  }

  log(message: string, context: ExpressServerLoggerContext): void {
    // Because the console.log() function is an alias for console.info(), we can use the same 'logger.info()' method for both log and info. For more information, see: https://nodejs.org/api/console.html#consoleinfodata-args
    this.pino.info(this.mapContext(context), message);
  }

  warn(message: string, context: ExpressServerLoggerContext): void {
    this.pino.warn(this.mapContext(context), message);
  }

  error(message: string, context: ExpressServerLoggerContext): void {
    this.pino.error(this.mapContext(context), message);
  }

  debug(message: string, context: ExpressServerLoggerContext): void {
    this.pino.debug(this.mapContext(context), message);
  }
}
```

For more information about the API of the `Pino` library, see their [API documentation](https://getpino.io/#/docs/api).

The following is an example of what the logs created by the `Pino` library look like:

```text
{"level":30,"time":1687528211674,"pid":40850,"hostname":"SHMABCD1234567","options":{"concurrency":10,"timeout":3000,"forcedSsrTimeout":60000,"maxRenderTime":300000,"reuseCurrentRendering":true,"debug":false,"logger":"CustomLogger"},"msg":"[spartacus] SSR optimization engine initialized"}

{"level":30,"time":1687528382249,"pid":40850,"hostname":"SHMABCD1234567","request":{"url":"/electronics-spa/en/USD/","uuid":"446d5d59-0111-471e-b6f3-883617a9aaba","timeReceived":"2023-06-23T13:53:02.247Z"},"msg":"Rendering started (/electronics-spa/en/USD/)"}
```

**Note:** The Pino library [translates log levels to integer values](https://github.com/pinojs/pino/blob/master/docs/api.md#loggerlevel-string-gettersetter).

## Using the LoggerService

In your custom code you must use the `LoggerService` instead of the native `console` object to benefit from the enhanced logging capabilities provided in Spartacus.

The following is an example of using the `LoggerService`:

```ts
import { LoggerService } from '@spartacus/core';

[...]

constructor(protected logger: LoggerService) {}

[...]

this.logger.debug('Debug message');
```

### LoggerService Behavior in the Browser

By default, the `LoggerService` delegates messages to the native `console` object while preserving the default behavior of the `console` methods. This means that messages are displayed in the browser console with the same styling and behavior as the native `console` messages.

You can also customize the behavior of the `LoggerService` by providing your own implementation of the `LoggerService`.

### LoggerService Behavior in an SSR Context

For server-side rendering, Spartacus by default overwrites `LoggerService` with the `ExpressLoggerService` , which uses `DefaultExpressServerLogger` for logging under the hood.
