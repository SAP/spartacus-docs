---
title: Password Visibility Toggle Component
feature:
  - name: Password Visibility Toggle Component
    spa_version: 5.0
    cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The password visibility toggle component allows users to alternate the appearance of a password input between plain text and censored text.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Adding a Password Visibility Toggle to a Password Input Field

The password visibility toggle component can be added to any `<input>` HTML element of type `password`. The following steps describe how to add this toggle.

1. Import the `PasswordVisibilityToggleModule` into the relevant component module, as shown in the following example:

    ```ts
    @NgModule({
      imports: [PasswordVisibilityToggleModule]
    })
    ```

1. Insert the `cxPasswordVisibilitySwitch` directive in an input HTML element to bind the password visibility toggle component to the target input.
    
    ```html
    <input
      type="password"
      cxPasswordVisibilitySwitch
    />
    ```
   
## Enabling Password Visibility Toggle

By default, all password inputs within the Spartacus libraries use the password visibility toggle. This feature can be disabled by providing a configuration for the `FormConfig`, as shown in the following example:

**Note:** this is a global configuration and when it's provided it will enable or disable all password visibility toggles across the storefront. Also, if this feature is disabled, the `cxPasswordVisibilitySwitch` directive does not create the password visibility toggle component in the template.

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

## Extending Password Visibility Toggle

The password visibility toggle component has two states, `showState` and `hideState`. You can configure these states using the properties `icon`, `inputType`, and `ariaLabel` of the `PasswordInputState` interface.

