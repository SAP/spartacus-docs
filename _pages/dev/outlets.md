---
title: Outlets
---

Outlets allow you to customize the standard UI that is provided by Spartacus. Outlets let you plug custom UIinto the standard Spartacus DOM. This is particularly helpful if the UI is not driven by CMS components, or if you wish to change a granular piece in the UI.

Outlets use a string to reference a named outlet. The outlet names are either hard-coded in Spartacus, or driven by content. In the latter case, the outlets are driven by the customer's CMS setup.

## Template-Driven Outlets

The basic syntax for adding UI is based on a `TemplateRef` that can be added by the `ng-template` component. The `cxOutletRef` is used to add a reference to an outlet. The following is an example:

```html
<ng-template cxOutletRef="header">
    Custom UI replacing the header
</ng-template>
```

The `cxOutletRef` directive is exported from the `OutletRefModule`. If you wish to use the directive in your application, make sure that you import this module.

By default, the UI provided to the outlet replaces the default UI in Spartacus. By using the `cxOutletPos`, you can add custom UI before or after the standard UI.

The following is an example where the UI is added before the standard header in Spartacus:

```html
<ng-template cxOutletRef="header" cxOutletPos="before">
    Custom UI added before the UI.
</ng-template>
```

Alternatively, you can use `OutletPosition.BEFORE` or `OutletPosition.AFTER`.

## Component-Driven Outlets

While the usage of `ng-template` is convenient, it is limited when no `TemplateRef` is available. Also, there may be scenarios where you wish to add a component dynamically, outside the UI, using typescript.

Instead of using a template, you can add a component factory to an outlet reference. With this technique, you can dynamically load a component and bring it into the UI. An actual example of this is the `AsmLoaderModule`, which loads the ASM experience dynamically in the `cx-storefront` outlet reference, and only when needed.

The following is an example of adding UI dynamically by passing in a component factory:

```typescript
const factory = this.componentFactoryResolver.resolveComponentFactory(MyComponent);
this.outletService.add('cx-storefront', factory, OutletPosition.BEFORE);
```

**Note**: The component-driven outlets feature is introduced with version 1.3 of the Spartacus libraries. Prior to version 1.3, only template content can be added to outlets.

## Stacked Outlets

{% capture version_note %}
The Stacked Outlets feature is introduced with version 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

You can use an outlet reference multiple times. When the same outlet reference is used multiple times, the different outlets are stacked. This means that all UI for a given outlet reference is appended to the given outlet reference.

An exception to stacked outlets is when the (default) `OutletPosition.REPLACE` is used. The outlet is only replaced once.

## Outlet Context

Whenever an outlet is created, the given context of the UI is injected into the outlet template. The context can be conveniently used in the template by using the `let-[var]` syntax. The following is an example:

```html
<ng-template cxOutletRef="header" let-model>
    The context is directly available in the custom UI: {{model}}
</ng-template>
```

**Note**: The context model depends on where outlets are used.

## Available Outlet References

There are two categories of outlet references, as follows:

- Data-driven (CMS-driven) outlet references
- Software-driven outlet references

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

**Note**: cx-storefront, cx-header and cx-footer have been added in release 1.3.

## Specific sections on the Product Detail Page.

-   `PDP.INTRO` – wraps the introduction of the PDP
-   `PDP.PRICE` – wraps the price on the PDP
-   `PDP.SHARE` – wraps the share on the PDP
-   `PDP.SUMMARY` – wraps the summary on the PDP

## Deferred loading

Outlets are driven deferred loading of the Spartacus UI, a technique that is used to postpone the initial rendering of CMS components. Any component that is outside the viewport is not rendered in advance. For more information, see [Deferred Loading]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}).
