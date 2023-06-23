---
title: Server-Side Contextual Logging
feature:
- name: Server-Side Contextual Logging
  spa_version: 6.2
  cx_version: n/a
---

<TODO Verify names in code examples>

Server-Side Contextual Logging is a feature that has been introduced to enhance the debugging experience for developers. With this feature, developers can see the context of the printed output and the source of the log message. Additionally, it ensures that the content is formatted correctly so that it is readable by developers, as well as monitoring tools. 

In addition to the built-in solutions, this feature also comes with tools that allow customers to customize the logging experience. 

Without contextual logging, the following issues arise:

- Log messages are just strings with little context about the rendered URL, making it difficult to connect the log message with the source of the log.
- Log messages are not standardized, which can make it difficult to read and understand the log messages.
- If the log message is multiline, it is not formatted correctly, and each line is treated as a separate log in the monitoring tools, further complicating the log viewing experience.

These issues make it difficult to read and understand log messages, particularly when log messages are coming from multiple parallel server-side-renderings and NodeJS servers. 

Thankfully, with Server-Side Contextual Logging, these issues are avoided, and developers can easily identify the source of log messages and understand them better.

Composable Storefront offers a default logger called `DefaultExpressServerLogger` to address common issues. This logger is used by default when the SSR Contextual Logging is enabled. 
This logger takes care of proper formatting and recognizes whether the output should be readable for developers or monitoring tools. It not only logs the message but also provides information about the request that initiated the rendering process. 

The example below shows how the logger creates logs for development mode. It produces a multiline JSON output:
```json
{
  "message": "Rendering started (/powertools-spa/en/USD/product/3788616/bt-dy-720-e)",
  "context": {
    "timestamp": "2023-06-19T23:34:37.845Z", // timestamp of the log
    "request": {
      "url": "/powertools-spa/en/USD/product/3788616/bt-dy-720-e", // URL of the request
      "uuid": "1ef6d1d9-65c2-43c8-860e-32d0cb1bf698", // UUID of the request
      "timeReceived": "2023-06-19T23:34:37.843Z" // timestamp of the request
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

From now on, your application will use the `DefaultExpressServerLogger` and provide logging context for all server-side rendered requests

## Customizing the SSR Contextual Logging

The Composable Storefront offers developers the ability to customize the SSR Contextual Logging. This includes the option to provide a custom logger in place of the default one. 

To implement a custom logger, the developer must create a class that implements the `ExpressServerLogger` interface. Alternatively, they may extend the `DefaultExpressServerLogger` class. 

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

The following is an example of a custom logger implementation:

```ts
import { ExpressServerLogger } from '@spartacus/setup/ssr';

export class CustomExpressServerLogger implements ExpressServerLogger {

  //custom implementation of the `log` method
  log(message: string, context: ExpressServerLoggerContext): void {
    console.log({ message: `[My Custom LOG]: ${message}`, ...context });
  }

  [...]
}
```

An important aspect of our solution is its extensibility. We have designed our solution to be compatible with enterprise logging libraries used for logging in platform-server such as [Winston](https://www.npmjs.com/package/winston) or [Pino](https://www.npmjs.com/package/pino), making it easy to add their features to our system.

The following is an example of how to implement the custom logger with the `Pino` library:

```ts
import { DefaultExpressServerLogger, ExpressServerLoggerContext } from '@spartacus/setup/ssr';
import { pino } from 'pino';

class CustomLogger extends DefaultExpressServerLogger {
  private logger = pino({ customLevels: { log: 15 }, level: 'log' }); // as there is no `log` level in pino, we need to define it here;

  [...]

  // custom implementation of the `log` method
  log(message: string, context: ExpressServerLoggerContext): void {
    // custom log level is used here
    this.logger.log(this.handleContext(context), message);
  }

  warn(message: string, context: ExpressServerLoggerContext): void {
    //built-in log level is used here
    this.logger.warn(this.handleContext(context), message);
  }

  [...]

  // method to handle the context before it is passed to the logger
  protected handleContext(context: ExpressServerLoggerContext) {
    const { request, ...restOfContext } = context;
    // `mapRequest` is used to map the request to the log message. This is a method provided in the `DefaultExpressServerLogger` class.
    // NOTE: for some cases request object is not passed to the context, so we need to check if it exists
    const mappedRequest = request ? this.mapRequest(request) : undefined;
    return { ...restOfContext, request: mappedRequest };
  }
}
```
This is an example of how logs created by `pino` library look like:
```
{"level":15,"time":1687528211674,"pid":40850,"hostname":"SHMABCD1234567","options":{"concurrency":10,"timeout":3000,"forcedSsrTimeout":60000,"maxRenderTime":300000,"reuseCurrentRendering":true,"debug":false,"logger":"CustomLogger"},"msg":"[spartacus] SSR optimization engine initialized"}

{"level":15,"time":1687528382249,"pid":40850,"hostname":"SHMABCD1234567","request":{"url":"/electronics-spa/en/USD/","uuid":"446d5d59-0111-471e-b6f3-883617a9aaba","timeReceived":"2023-06-23T13:53:02.247Z"},"msg":"Rendering started (/electronics-spa/en/USD/)"}
```
For more information, see: https://www.npmjs.com/package/pino

Note: This is only an example of how to use a third-party logger library. Do not treat this as a recommendation of the particular library.

**Caution:** The `DefaultExpressServerLogger` doesn't include any sensitive data in the logs by default. However, when using a custom logger, developers must exercise caution and be mindful of the data being provided. It's their responsibility to ensure that no sensitive information is being used or exposed.

## Using the LoggerService

`DefaultExpressLoggerService` is used to handle any logs in the Composable Storefront when using SSR (Server-Side Rendering). It is injected and accessed through the `LoggerService`.

From now on, `LoggerService` is the recommended way to handle logging in the Composable Storefront. It is an injectable service that provides a consistent interface for logging across the application. 

The following is an example of using the `LoggerService`:

```ts
import { LoggerService } from '@spartacus/core';

[...]

constructor(protected logger: LoggerService) {}

[...]

this.logger.log('Debug message');
```

### The Behavior of the LoggerService in the Browser

By default, the `LoggerService` delegates messages to the native `console` object while preserving the default behavior of console methods. This means that the messages will be displayed in the browser console with the same styling and behavior as the native `console` messages.

Note that you can also customize the behavior of the `LoggerService` by providing your implementation of the `LoggerService` interface.

### The Behavior Of The LoggerService in the SSR Context

For server-side rendering (SSR), the Composable Storefront provides the `ExpressLoggerService` to the Angular context. This service extends the `LoggerService` and provides the `DefaultExpressServerLogger` for logging. 

Using this service guarantees that logs are properly formatted and contain the necessary context about the source of the log. 

**Note:** By default, Composable Storefront does not output any sensitive data in the logs. However, developers may include sensitive data in their log messages. If sensitive data is used, developers should be aware that it will be visible in the logs. Therefore, it is their responsibility to ensure that no sensitive data is used in the log messages.

## LoggerService And Error Handling

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

## LoggerService and the 3rd Party Libraries

`LoggerService` can be used not only to log messages added to our applications but also those that third-party libraries used in the project want to communicate to us. Composable Storefront uses `LoggerService` to display logs created by the `i18next` library. This was achieved by creating a compatible plugin with the `i18next` configuration and using the capabilities provided by our logging service. The following is an implementation of the `i18next` plugin:

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

To improve debugging, it is worth checking which libraries in your applications generate logs and whether they are open to extending logging with the logger provided by us.
