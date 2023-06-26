---
title: Server-Side Contextual Logging
feature:
- name: Server-Side Contextual Logging
  spa_version: 6.2
  cx_version: n/a
---

TL;DR How to fully enable the feature:
1. set `logger: true` in `SsrOptimizationOptions` in your `server.ts` (read more in the section [Enabling the SSR Contextual Logging](#enabling-the-ssr-contextual-logging))
2. import `ErrorHandlingModule.forRoot()` in your app (e.g. `spartacus.module.ts`) (read more in the section [Enabling Contextual Logs In Error Handling](#enabling-contextual-logs-in-error-handling))
3. don't use the global `console` object. To log messages use `LoggerService` (read more in the section [Using The LoggerService](#using-the-loggerservice))
4. to ensure context and proper formatting for the logs output by third-party libraries in your application, verify if custom loggers can be provided and use LoggerService if possible; otherwise, the logs from the third-party libraries will be written in plain text without the request's context and proper formatting. (read more in the section [LoggerService and the Third-party Party Libraries](#loggerservice-and-the-third-party-party-libraries))
5. In the next major release, the `logger` flag will be enabled by default, so point 1 and 2 will not be necessary.
  

Server-Side Contextual Logging is a feature that has been introduced to enhance the debugging experience for developers. With this feature, developers can see the context of the printed output and the source of the log message. Additionally, it ensures that the content is formatted correctly so that it is readable by developers, as well as monitoring tools. 

In addition to the built-in solutions, this feature also comes with tools that allow customers to customize the logging experience.

Without contextual logging, the following issues arise:

- Log messages are just strings with little context about the rendered URL, making it difficult to connect the log message with the source of the log.
- The log messages' format is not standardized, which can make it difficult to read and understand the log messages.
- If the log message is multiline, it is not formatted correctly, and each line is treated as a separate log in the monitoring tools, further complicating the log viewing experience. (This can be the case e.g. for multi-line stack traces of errors.)

These issues make it difficult to read and understand log messages, particularly when log messages are coming from multiple parallel server-side-renderings and NodeJS servers. 

Thankfully, with Server-Side Contextual Logging, these issues are avoided, and developers can easily identify the source of log messages and understand them better.

Composable Storefront offers a default logger called `DefaultExpressServerLogger` to address common issues. This logger is used by default when the SSR Contextual Logging is enabled. 
This logger takes care of proper formatting and recognizes whether the output should be readable for developers or monitoring tools. It not only logs the message but also provides information about the related request that initiated the rendering process. 

The example below shows how the logger creates logs for development mode. It produces a multiline JSON output:
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
Here we can see an example of the log created for production purposes. It is a single line of JSON that is readable by monitoring tools:
```
{"message":"Rendering started (/powertools-spa/en/USD/product/3788616/bt-dy-720-e)","context":{"timestamp":"2023-06-19T23:34:37.845Z","request":{"url":"/powertools-spa/en/USD/product/3788616/bt-dy-720-e","uuid":"1ef6d1d9-65c2-43c8-860e-32d0cb1bf698","timeReceived":"2023-06-19T23:34:37.843Z"}}}
```
The following is the representation of the log message in the monitoring tool:
![Log Representation In Kibana](assets/images/../../../../../assets/images/ssr/contextual_logging_kibana_logs.png)



## Enabling the SSR Contextual Logging

To enable the SSR contextual logging, add the `logger` flag to the configuration object as the second parameter to the method that decorates `ngExpressEngine` in the `server.ts` file. The following is an example:

```ts
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/setup/ssr';

[...]

const ngExpressEngine = NgExpressEngineDecorator.get(engine, {
  //add logger flag here
  logger: true
});

[...]

```

From now on, your application will use the `DefaultExpressServerLogger` and provide request context for every logged message during server-side rendering.

Note: In a future major release, it's planned to enable the `logger` flag by default.

## Customizing the SSR Contextual Logging

The Composable Storefront offers developers the ability to customize the SSR Contextual Logging. This includes the option to provide a custom logger in place of the default one. 

To implement a custom logger, the developer must create a class that implements the `ExpressServerLogger` interface. Alternatively, they may extend the `DefaultExpressServerLogger` class if they want to expand its existing functionality. 

Once the custom logger class is created, it can be passed to the `logger` property in the configuration object. 

An example of how to do this is shown below:

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

  // don't forget to customize also other methods like: `debug`,`info`, `warn` and `error`
  [...]
}
```

An important aspect of our solution is its extensibility. We have designed our solution to be easy to extend the logger output with the crucial information from the customers' perspective. Provided logging functionality is also compatible with enterprise logging libraries used for logging in platform-server such as [Winston](https://www.npmjs.com/package/winston) or [Pino](https://www.npmjs.com/package/pino), making it easy to add their features to our system.

### Providing additional context to the logs

A real-life example may be extending the context with some custom header, e.g. `traceparent`, `content-type` or `host`.

The following is an example of a custom logger implementation that extends the `DefaultExpressServerLogger` class and adds more functionality to the built-in `mapContext` method:

```ts
import { DefaultExpressServerLogger, ExpressServerLoggerContext } from '@spartacus/setup/ssr';

export class CustomExpressServerLogger extends DefaultExpressServerLogger {
  //extend output context with traceparent header
  override protected mapContext(context: ExpressServerLoggerContext): Record<string,any> {
     const outputContext = super.mapContext(context);
     return {
      ...super.mapContext(context),
      request: {
        // 
        traceparent: context.request.get('traceparent')
      }
     }
  }
}
```

### Plugin Third-party Logger

**Disclaimer: This is only an example of how to use a third-party logger library. Do not treat this as a recommendation of the particular library.**

The following is an example of how to implement the custom logger with the `Pino` library:

```ts
import { DefaultExpressServerLogger, ExpressServerLoggerContext } from '@spartacus/setup/ssr';
import { pino } from 'pino';

class CustomPinoLogger extends DefaultExpressServerLogger {
  const logger = pino({
    // custom configuration of the pino logger
  });

  // custom implementation of the `log` method
  log(message: string, context: ExpressServerLoggerContext): void {
    // Because in the console.info() function is an alias for console.log(), we can use the same method 'logger.info() for both log and info. See more: https://nodejs.org/api/console.html#consoleinfodata-args
    this.logger.info(this.mapContext(context), message);
  }

  info(message: string, context: ExpressServerLoggerContext): void {
    this.logger.info(this.mapContext(context), message);
  }
}
```
This is an example of how logs created by `pino` library look like:

```
{"level":30,"time":1687528211674,"pid":40850,"hostname":"SHMABCD1234567","options":{"concurrency":10,"timeout":3000,"forcedSsrTimeout":60000,"maxRenderTime":300000,"reuseCurrentRendering":true,"debug":false,"logger":"CustomLogger"},"msg":"[spartacus] SSR optimization engine initialized"}

{"level":30,"time":1687528382249,"pid":40850,"hostname":"SHMABCD1234567","request":{"url":"/electronics-spa/en/USD/","uuid":"446d5d59-0111-471e-b6f3-883617a9aaba","timeReceived":"2023-06-23T13:53:02.247Z"},"msg":"Rendering started (/electronics-spa/en/USD/)"}
```
Note: Pino library [translates log levels to integer values](https://github.com/pinojs/pino/blob/master/docs/api.md#loggerlevel-string-gettersetter). For more information, see: https://www.npmjs.com/package/pino

**Caution:** The `DefaultExpressServerLogger` doesn't include any sensitive data in the logs by default. However, when using a custom logger, developers must exercise caution and be mindful of the data being provided. It's their responsibility to ensure that no sensitive information is being used or exposed.

## Using The LoggerService

From now on, `LoggerService` is the recommended way to handle logging in the Composable Storefront. It is an injectable service that provides a consistent interface for logging across the application. 

`DefaultExpressLoggerService` is used to handle any logs in the Composable Storefront when using SSR (Server-Side Rendering). It is injected and accessed through the `LoggerService`.

The following is an example of using the `LoggerService`:

```ts
import { LoggerService } from '@spartacus/core';

[...]

constructor(protected logger: LoggerService) {}

[...]

this.logger.log('Debug message');
```

### The Behavior Of The LoggerService In The Browser

By default, the `LoggerService` delegates messages to the native `console` object while preserving the default behavior of console methods. This means that the messages will be displayed in the browser console with the same styling and behavior as the native `console` messages.

Note that you can also customize the behavior of the `LoggerService` by providing your implementation of the `LoggerService` interface.

### The Behavior Of The LoggerService In The SSR Context

For server-side rendering (SSR), the Composable Storefront provides the `ExpressLoggerService` to the Angular context. This service extends the `LoggerService` and provides the `DefaultExpressServerLogger` for logging. 

Using this service guarantees that logs are properly formatted and contain the necessary context about the source of the log. 

**Note:** By default, Composable Storefront does not output any sensitive data in the logs. However, developers may include sensitive data in their log messages. If sensitive data is used, developers should be aware that it will be visible in the logs. Therefore, it is their responsibility to ensure that no sensitive data is used in the log messages.

## Enabling Contextual Logs In Error Handling

By default, Angular uses its own `ErrorHandler` to handle errors that occur during Server Side Rendering. However, this print the errors only to the console with a lack of context and a multi-line message that is not parsed correctly by monitoring tools. To improve this aspect, Composable Storefront provides `CxErrorHandler` that extends the default Angular `ErrorHandler` and uses `LoggerService` to log errors with the proper context when available.

To use `CxErrorHandler`, developers need to import the `ErrorHandlingModule`. The preferred place is the `spartacus.module.ts` file. 

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

By importing `ErrorHandlingModule`, `CxErrorHandler` will handle all errors that occur during Server Side Rendering, and these errors will be logged with an appropriate context.

**Caution:** Since user applications may contain their implementations of `ErrorHandler`, `CxErrorHandler` is not used by default when contextual logging is enabled. To use it, it is recommended to utilize the `LoggerService` by extending your error handler with its usage.

## LoggerService And The Third-party Party Libraries

`LoggerService` can be used not only to log messages added to our applications but also to those third-party libraries used in the project that want to communicate with the developers by their state. 

For example, Composable Storefront uses `LoggerService` to display logs created by the `i18next` library. This was achieved by creating a compatible plugin with the `i18next` configuration and using the capabilities provided by our logging service.

The following is an implementation of the `i18next` plugin:

```ts
import { InjectionToken, inject } from '@angular/core';

import { LoggerModule } from 'i18next';
import { LoggerService } from '../../../logger';

export const I18NEXT_LOGGER_PLUGIN = new InjectionToken<LoggerModule>(
  'I18NEXT_LOGGER_PLUGIN',
  {
    providedIn: 'root',
    factory: () => {
      const logger = inject(LoggerService);
      return {
        type: 'logger',
        log: (args) => logger.log(...args),
        warn: (args) => logger.warn(...args),
        error: (args) => logger.error(...args),
      };
    },
  }
);
```

To improve debugging, it is worth checking which libraries in your applications generate logs and whether they are open to extending logging with the logger provided by Composable Storefront.
