---
title: Save for Later / Selective Cart
---
This feature is not supported in MVP. To prevent the button from showing, customers should remove the relevant view (disable selective cart):

- Ensure that in the cart configuration, selective cart is disabled. The used configuration should contain

```
cart: {
  selectiveCart: {
    enabled: false,
  },
},
```

- Deactivate the saveForLater component that is assigned to CMS component SaveForLaterComponent: Introduce a new module that clears the assigned SPA components for that CMS component. 

```
@NgModule({
  imports: [CommonModule, I18nModule, CartSharedModule],
  providers: [
    provideDefaultConfig(<CmsConfig | FeaturesConfig>{
      cmsComponents: {
        SaveForLaterComponent: {},
      },
    }),
  ],
  declarations: [SaveForLaterComponent],
  exports: [SaveForLaterComponent],
  entryComponents: [SaveForLaterComponent],
})
```