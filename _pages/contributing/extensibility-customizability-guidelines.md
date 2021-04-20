---
title: Writing extensible and customizable code in Spartacus
---

### Avoid private constants for default values in the class logic
For easier extensibility and customizability, private `const`s should be avoided in the TypeScript class logic. Customers might want to eaisly customize those default values. So such a default value should be stored in a `protected readonly` field instead, unless it's justified to extract it as a separate const. It might be justified for example, when the const is used in more classes - then it should be exported in the public API using a thoughtful name.

Don't:

```typescript
// some.service.ts

const DEFAULT_VALUE = 123;

@Injectable()
export class SomeService {
  /* ... */

  method(param) {
    return param ?? DEFAULT_VALUE;
  }
}
```

Do:

```typescript
// some.service.ts

@Injectable()
export class SomeService {
  protected readonly DEFAULT_VALUE = 123;

  /* ... */

  method(param) {
    return param ?? this.DEFAULT_VALUE;
  }
}
```