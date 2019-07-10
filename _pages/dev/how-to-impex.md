---
title: SAP Commerce - ImpEx (DRAFT)
---

ImpEx is a text-based import and export functionality, which is shipped with SAP Commerce. It allows basic operations, such as creating, updating, removing, and exporting Platform items. All input are from comma-separated value.

More information can be found here. 
[ImpEx](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/6.2.0.0/en-US/8bee5297866910149854898187b16c96.html)

## How to create PageTemplates

You would need to first create a PageTemplate using the following fields below:

```
INSERT_UPDATE PageTemplate;$contentCV[unique=true];uid[unique=true];name;frontendTemplateName;restrictedPageTypes(code);active[default=true]
;;CategoryTemplate;Category Template;category/productPage;CategoryPage
```
- Below the `INSERT_UPDATE` statement is a sample data we created for a page template. In this case, we created a page template of CategoryTemplate.
- `frontendTemplateName` is used to define the JSP that shuold be used to render the page for pages with multiple layouts.
- `RestrictedPageTypes` is used to restrict templates to page types.

Finaly, you would need to add a velocity template that are in the CMS Cockpit as these give a better layout for editing pages.

```
UPDATE PageTemplate;$contentCV[unique=true];uid[unique=true];velocityTemplate[translator=de.hybris.platform.commerceservices.impex.impl.FileLoaderValueTranslator]
;;CategoryPageTemplate;$jarResourceCms/structure-view/structure_categoryPageTemplate.vm
```

Note: 
- FileLoaderValueTranslator loads a file into a string property.
- As you can see, all items are comma-separated value.

### ContentSlotNames

Each PageTemplates can have multiple content slot names, where we can state a list of valid components for the slot.
There exists standard set of slots, such as SiteLogo, HeaderLinks MiniCart and NAvigationBar, and a number of specific slots for each template.

```
# Error Page Template
INSERT_UPDATE ContentSlotName;name[unique=true];template(uid,$contentCV)[unique=true][default='CategoryPage'];validComponentTypes(code);compTypeGroup(code)
;SiteLogo;;;logo
;HeaderLinks;;;headerlinks
;SearchBox;;;searchbox
;MiniCart;;;minicart
;NavigationBar;;;navigation
;MiddleContent;;CMSParagraphComponent,SimpleResponsiveBannerComponent
;BottomContent;;;wide
;SideContent;;;narrow
;Footer;;;footer
;TopHeaderSlot;;;wide
;BottomHeaderSlot;;;wide
;PlaceholderContentSlot;;;
```

- Below the `INSERT_UPDATE`, we can see a number of content slot name available for the specific PageTemplate as specified in the statement `default='CategoryPage'`.