# Outlets

Outlets have been added to Spartacus as a mechanism to customize the standard UI provided by Spartacus. “Outlets” let you plug custom UI into the standard Spartacus DOM. This is particular helpful if the UI is not driven by a CMS components or if you like to change a granular piece in the UI.

Outlets are _referenced_ by a name, and are either provided in the Spartacus code or driven by content. In the latter case, the outlets are driven by the customer CMS setup.

## Template driven outlets

The basic syntax for adding UI is based on an a `TemplateRef` which can be added by the `ng-template` component. The `cxOutletRef` is used to add a reference to an outlet.

```html
<ng-template cxOutletRef="header">
    Custom UI replacing the header
</ng-template>
```

By default, the UI provided to the outlet will replace the default UI in Spartacus. By using the `cxOutletPos`, you can add custom UI _before_ or _after_ the standad UI.

The following snippet shows an example where the UI is added before the standard header in Spartacus. Alternatively, `OutletPosition.BEFORE` or `OutletPosition.AFTER` can be used.

```html
<ng-template cxOutletRef="header" cxOutletPos="before">
    Custom UI added before the UI.
</ng-template>
```

## Component driven outlets

While the usage of ng-template is conveniet, it is limited when there is no template ref available. There are scenario's where we like to add a component dynamically outside the UI, in typescript.

Instead of using an template, you can add a component factory to an outlet reference. With this technique you can dynamically load a component and bring it inot the UI. A good example of this is the `AsmLoaderModule`, which loads the ASM experience dynamically in the `cx-storefront` outlet reference, only if needed.

The following code snippet shows an example if adding UI dynamically by passing in a component factory.

```typescript
const factory = this.componentFactoryResolver.resolveComponentFactory(MyComponent);
this.outletService.add('cx-storefront', factory, OutletPosition.BEFORE);
```

## Stacked Outlets

You can use an outlet reference multiple times. When the same outlet references is used multiple times, the different outlets are stacked. This means that all UI for a given outlet reference is appended to the given outlet Outlet reference.

An exception to stacked outlets is when the (default) `OutletPosition.REPLACE` is used. The outlet will only be replaced once.

## Outlet Context

Whenever an outlet is created, the given context of the UI will be injected into the outlet template. The context can be conveniently used in the template by using the `let-[var]` syntax. The example below shows an example:

```html
<ng-template cxOutletRef="header" let-model>
    The context is directly available in the custom UI: {{model}}
</ng-template>
```

**Note**: The context model depends on where outlets are used.

## Available outlet references

There are various types of outlet references that can be used:

There are two categories of outlet references:

1. Data (CMS) driven outlet references
2. Software driven outlet references

### CMS outlet refrences

The data driven outlets are given by the CMS structure. THere are 3 types:

-   CMS Page layout name  
    Each page layout is available as an outlet reference.
-   CMS page slot positions  
    Each slot position can be used as an outlet reference. While positions can be reused cross diferenet page templates, the outlet UI is not limited by a specific page. Every occurence of the position refernece ...
-   CMS Component type  
    Each component type is available as an outlet. While component type driven outlets can be used, it is generally considered best practice to leverage [Customizing CMS Components](customizing-cms-components.md) for introducing custom component UI.

### Software driven outlet references

There are a number of outlet references which are explicitely added to Spartacus.

-   hard coded sections:
    -   `cx-storefront`  
        There's no outlet available for the overall storefront experience or for adding UI to the header and footer. This can be useful when we like to introduce additional UI to the storefront, either because of replacing or adding before or after.
    -   `cx-header` – wraps the `<header>` to allow for customisations of the header.
    -   `header` – wraps all page-slots for the header section
    -   `navigation`– wraps all page-slots for the navigation section
    -   `cx-footer` – wraps the `<header>` to allow for customisations of the header.
    -   `footer` – wraps all page-slots for the footer section

## Specific sections on the Product Detail Page.

-   `PDP.INTRO` – wraps the introduction of the PDP
-   `PDP.PRICE` – wraps the price on the PDP
-   `PDP.SHARE` – wraps the share on the PDP
-   `PDP.SUMMARY` – wraps the summary on the PDP

## Deferred loading

Outlets are driven deferred loading of the Spartacus UI, a technique that is used to postpone the initial rendering of CMS components. Any component that is outside the viewport is not rendered in advance. See [deferred loading](performance/deferred-loading.md) for more information.
