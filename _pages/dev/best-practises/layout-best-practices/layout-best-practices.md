---
title: Layout Best Practices
---

## Layout config

By design, each Spartacus project is based on CMS components from Back Office. Spartacus has default `layoutConfig` but it is based on `SpartacusSampleData` and it is unlikely to fit in any other design.

That is why we can override the default Spartacus layout config with our own one.

The best place to do it is to create file `layout.ts` in `src/app/spartacus/configurations` folder and export it as `LayoutConfig`. We can put it here only differences with Sparactus config or provide our custom whole layout config.

Another very common case is adding additional layouts to the configuration and assigning them slots, example:

```export const customLayoutConfig: LayoutConfig = {
  layoutSlots: {
    prologue: {
      xl: {
        slots: [
          'PreHeader',
          'SearchBox',
          'SiteLogo',
        ],
      },
      lg: {
        slots: ['PreHeader'', 'SearchBox'],
      },
      slots: ['PreHeader', 'SiteLogo'],
    },
  }
};

Once we will create the file and provide our own customization we have to provide it in `src/app/spartacus/spartacus-configuration.module.ts`:

```
@NgModule({
    ...
    providers: [
        provideConfig(customLayoutConfig),
    ...

```

## Storefront layout

In many projects the cx-storefront directive usage will be sufficient, but it is highly probable that to facilitate the work on spartacus it will be easier for us to slightly modify the default storefront layout.

In this case we will recommend to:
1. Create module with component `<our-own-name>-storefront` in `src/app/<our-own-name>-storefront` folder.
2. Extend our own `<our-own-name>StorefrontComponent` with Spartacus `StorefrontComponent`.
3. Copy Spartacus Storefron Component template and paste it in our own Storefront template with our own customization. We can here:
    - modify elements order
    - add custom elements
4. Import in our Storefront Module all required modules
5. Import our Storefront module in `AppModule`

Example custom storefront template:

```
<ng-template [cxOutlet]="StorefrontOutlets.STOREFRONT" cxPageTemplateStyle>
  <cx-page-layout section="prologue"></cx-page-layout>

  <ng-template cxOutlet="cx-header">
    <header
      cxSkipLink="cx-header"
      [cxFocus]="{ disableMouseFocus: true }"
      [class.is-expanded]="isExpanded$ | async"
      (keydown.escape)="collapseMenu()"
      (click)="collapseMenuIfClickOutside($event)"
    >
      <cx-page-layout section="header"></cx-page-layout>
      <cx-page-layout section="navigation"></cx-page-layout>
    </header>
    <cx-page-slot position="BottomHeaderSlot"></cx-page-slot>
    <cx-global-message
      aria-atomic="true"
      aria-live="assertive"
    ></cx-global-message>
  </ng-template>

  <main cxSkipLink="cx-main" [cxFocus]="{ disableMouseFocus: true }">
    <router-outlet></router-outlet>
  </main>

  <ng-template cxOutlet="cx-footer">
    <footer cxSkipLink="cx-footer" [cxFocus]="{ disableMouseFocus: true }">
      <cx-page-layout section="footer"></cx-page-layout>
    </footer>
  </ng-template>

  <cx-page-layout section="bottom-info"></cx-page-layout>
</ng-template>

```
