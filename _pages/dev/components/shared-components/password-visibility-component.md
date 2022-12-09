---
title: Password Visibility Component
feature:
  - name: Password Visibility Component
    spa_version: 5.0
    cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

When users enter a password, the password visibility component allows users to toggle between hiding the input text with asterisks (`*`), or seeing the password in plain text.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Adding a Password Visibility Toggle to a Password Input Field

The password visibility component can be added to any `<input>` HTML element of type `password`.

1. Import the `PasswordVisibilityToggleModule` into the relevant component module, as shown in the following example:

    ```ts
    @NgModule({
      imports: [PasswordVisibilityToggleModule]
    })
    ```

1. Insert the `cxPasswordVisibilitySwitch` directive in an `<input>` HTML element to bind the password visibility component to the target input, as shown in the following example:

    ```html
    <input
      type="password"
      cxPasswordVisibilitySwitch
    />
    ```

## Enabling the Password Visibility Toggle

By default, all password inputs in the Spartacus libraries use the password visibility toggle. This feature can be disabled by providing a configuration for the `FormConfig`, as shown in the following example:

```ts
@NgModule({
 providers: [
    provideConfig(<FormConfig>{
      form: {
        passwordVisibilityToggle: false,
      },
    }),
  ],
})
```

**Note:** This is a global configuration. When it is provided, it enables or disables all password visibility toggles across the storefront. Also, if this feature is disabled, the `cxPasswordVisibilitySwitch` directive does not create the password visibility toggle component in the template.

## Extending the Password Visibility Toggle

The password visibility component has two states, `showState` and `hideState`. You can configure these states using the `icon`, `inputType`, and `ariaLabel` properties of the `PasswordInputState` interface.
