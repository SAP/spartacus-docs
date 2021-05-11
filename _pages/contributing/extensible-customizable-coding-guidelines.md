---
title: Writing Extensible and Customizable Code
---

To make Spartacus code easier to extend and customize, we should avoid using private constants for default values in the TypeScript class logic. Instead, those default values should be stored in `protected readonly` fields, unless it is justified to extract them as separate constants. For example, it might be justified when a `const` is used in multiple classes. In that case, the `const` should be exported to the public API using a clear, descriptive name.

The following is an example of how to properly set a default value in the TypeScript class logic:

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

The following is an example of how *not* to set a default value in the TypeScript class logic:

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
