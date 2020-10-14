---
title: Global Messages (DRAFT)
---

# Model
Global messages have predefined types in model:

```typescript
enum GlobalMessageType {
  MSG_TYPE_CONFIRMATION = '[GlobalMessage] Confirmation',
  MSG_TYPE_ERROR = '[GlobalMessage] Error',
  MSG_TYPE_INFO = '[GlobalMessage] Information',
}
```

# Configuration Model
The model is used in the configuration for setting the time after which the message should disappear.
Omitting the type in the configuration causes that such messages will not disappear.

```typescript
type GlobalMessageTypeConfig = {
  timeout?: number;
};

abstract class GlobalMessageConfig {
  globalMessages: {
    [GlobalMessageType.MSG_TYPE_CONFIRMATION]?: GlobalMessageTypeConfig;
    [GlobalMessageType.MSG_TYPE_INFO]?: GlobalMessageTypeConfig;
    [GlobalMessageType.MSG_TYPE_ERROR]?: GlobalMessageTypeConfig;
  };
}
```

# Configuration

We used the default configuration setting the timeout:

* confirmation: 3s
* info: 3s
* error: 7s


To maintain consistency of the configuration keys with the enum you should provide customized config by factory:

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

```typescript
ConfigModule.withConfigFactory(yourGlobalMessageConfigFactory),
```
Due to the underdevelopment of Angular's mechanisms, ``withConfig`` requires keys in the form of string, enums are not accepted.
