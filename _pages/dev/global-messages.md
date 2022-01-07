---
title: Global Messages
feature:
- name: Global Messages
  spa_version: 1.0
  cx_version: n/a
---

There are several types of global messages that you can display in your storefront app. Each type of global message has its own default duration, which you can customize.

Spartacus has the following predefined global message types, which are defined in `projects/core/src/global-message/models/global-message.model.ts`:

```typescript
export enum GlobalMessageType {
  MSG_TYPE_CONFIRMATION = '[GlobalMessage] Confirmation',
  MSG_TYPE_ERROR = '[GlobalMessage] Error',
  MSG_TYPE_INFO = '[GlobalMessage] Information',
  MSG_TYPE_WARNING = '[GlobalMessage] Warning',
}
```

The global messages model is used in `projects/core/src/global-message/config/global-message-config.ts` to set the time after which the message should disappear. If you omit a particular type in the configuration, the messages for that type will not disappear.

The following is an example of the global message config:

```typescript
export type GlobalMessageTypeConfig = {
  timeout?: number;
};

@Injectable({
  providedIn: 'root',
  useExisting: Config,
})
export abstract class GlobalMessageConfig {
  globalMessages?: {
    [GlobalMessageType.MSG_TYPE_CONFIRMATION]?: GlobalMessageTypeConfig;
    [GlobalMessageType.MSG_TYPE_INFO]?: GlobalMessageTypeConfig;
    [GlobalMessageType.MSG_TYPE_ERROR]?: GlobalMessageTypeConfig;
    [GlobalMessageType.MSG_TYPE_WARNING]?: GlobalMessageTypeConfig;
  };
}
```

## Configuration

You can find the default timeout values that Spartacus uses for global messages in `projects/core/src/global-message/config/default-global-message-config.ts`. The values are set in milliseconds.

If you wish to change any of the default timeout values, you should maintain consistency between the configuration keys and the enum by providing your customized config using a factory provider. The following is an example:

```typescript
function yourGlobalMessageConfigFactory(): GlobalMessageConfig {
  return {
    globalMessages: {
      [GlobalMessageType.MSG_TYPE_CONFIRMATION]: {
        timeout: 5000,
      },
      [GlobalMessageType.MSG_TYPE_INFO]: {
        timeout: 7000,
      },
    },
  };
}
```

You then provide your customized config as follows:

```typescript
ConfigModule.withConfigFactory(yourGlobalMessageConfigFactory),
```

**Note:** Due to a limitation with Angular's config mechanisms, `withConfig` requires keys to be in the form of a string. Enums are not accepted.
