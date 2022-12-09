---
title: SmartEdit Contract in Spartacus
---

The following sections describe how the SmartEdit Contract is implemented in Spartacus.

For information on setting up SmartEdit in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "smartEdit-setup-instructions-for-spartacus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/smartEdit-setup-instructions-for-spartacus.md %}).

For general information on SmartEdit Contracts, see [SmartEdit Contract for Storefronts](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/622cebcb444b42e18de2147775430b9d.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## SmartEdit Contract Implementation

To make Spartacus work with SmartEdit, you need to implement the SmartEdit Contract in Spartacus. The SmartEdit Contract consists of the following:

- The `webApplicationInjector.js` file that must be included in each page.
- A preview ticket API mechanism
- An HTML Markup Contract

 For information on how to include the `webApplicationInjector.js` file in your app, see [{% assign linkedpage = site.pages | where: "name", "smartEdit-setup-instructions-for-spartacus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/smartEdit-setup-instructions-for-spartacus.md %}).

## Preview Ticket API Mechanism

### Getting the cmsTicketId

The `cmsTicketId` is also know as the `previewToken`.

When Spartacus is launched in SmartEdit, SmartEdit sends a request to Spartacus with `cmsTicketId` as the parameter. The following is an example:

```text
https://localhost:4200/cx-preview?cmsTicketId=6477500489900224fda62f41-167a-40fe-9ecc-39019a64ebb9
```

By default, SmartEdit appends `/cx-preview` to the storefront URI so that it can preview your storefront. However, you can configure SmartEdit to route the request to the another endpoint in your app. Use the `storefrontPreviewRoute` property in an ImpEx to specify your custom storefront route as shown in the following example:

```text
INSERT_UPDATE SmartEditConfiguration;key[unique=true];value
;storefrontPreviewRoute;"""my-custom-preview"""
```

The `cmsTicketId` is generated in the back end. It contains information required by SmartEdit, such as the `catalogVersion`. For more information, see [Preview API](https://help.sap.com/docs/SAP_COMMERCE/9d346683b0084da2938be8a285c0c27a/3a3bda5d50614f2aa4a299b600281360.html?locale=en-US).

Spartacus receives the `cmsTicketId` from the request sent from SmartEdit.

### Using the Smartedit Interceptor

To allow SmartEdit to load pages in Spartacus, SmartEdit needs to be sent all the required context data. This includes the site, content catalog, and content catalog version, and can also specify the language, date, and time. As a result, the `cmsTicketId` needs to be appended to any CMS requests sent from Spartacus to the back end.

For this purpose, Spartacus has the `CmsTicketInterceptor`. If a `cmsTicketId` exists and requests are specified with `cms`, the interceptor adds `cmsTicketId` as one of the request parameters. The following is an example:

```text
https://localhost:9002/rest/v2/electronics-spa/cms/pages?fields=DEFAULT&lang=en&curr=USD&cmsTicketId=6477500489900224fda62f41-167a-40fe-9ecc-39019a64ebb9
```

## HTML Markup Contract

The HTML markup contract stipulates that every CMS component and every content slot must be wrapped in an HTML tag and include specific elements.

### Properties in CMS Items Received from the Back End

If CMS requests are sent with a `cmsTicketId`, a `properties` field is included in the response JSON data. The `properties` field contains groups of dynamic attributes that are required for the containing CMS items. For example, the `properties` in a CMS page could have the following data:

```json
...
"label" : "homepage",
"properties" : {
    "smartedit" : {
        "classes" : "smartedit-page-uid-homepage smartedit-page-uuid-eyJpdGVtSWQiOiJob21lcGFnZSIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ== smartedit-catalog-version-uuid-electronics-spaContentCatalog/Staged"
        }
    }
}
```

In the `smartedit` group, there is a `classes` attribute. The value of `classes` is the required SmartEdit Contract for this particular CMS page. Accordingly, you need to add these `classes` into the class list of the HTML body tag. If you check the HTML page source, you will see the body tag has this `classes` attribute. The following is an example:

```typescript
<body class="smartedit-page-uid-homepage smartedit-page-uuid-eyJpdGVtSWQiOiJob21lcGFnZSIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ== smartedit-catalog-version-uuid-electronics-spaContentCatalog/Staged">
    <cx-storefront ng-version="8.0.0" class="stop-navigating"><header><cx-page-layout section="header" ng-reflect-section="header" class="header"><!--bindings={
...
```

CMS slots and components also contain `properties`. You need to add these attributes to component or slot tags. The following is an example of the `HelpLink` component.

```json
{
    "uid" : "HelpLink",
    "uuid" : "eyJpdGVtSWQiOiJIZWxwTGluayIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ==",
    "typeCode" : "CMSLinkComponent",
    "modifiedTime" : "2019-07-02T13:44:27.77-04:00",
    "name" : "Help Link",
    "container" : "false",
    "external" : "false",
    "url" : "/faq",
    "linkName" : "Help",
    "properties" : {
        "smartedit" : {
            "catalogVersionUuid" : "electronics-spaContentCatalog/Staged",
            "componentType" : "CMSLinkComponent",
            "componentId" : "HelpLink",
            "classes" : "smartEditComponent",
            "componentUuid" : "eyJpdGVtSWQiOiJIZWxwTGluayIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ=="
        }
    },
    "target" : "false"
}
```

The following is an example of what you see in the relevant page source:

```html
<cx-link data-smartedit-catalog-version-uuid="electronics-spaContentCatalog/Staged" data-smartedit-component-type="CMSLinkComponent" data-smartedit-component-id="HelpLink" class="smartEditComponent" data-smartedit-component-uuid="eyJpdGVtSWQiOiJIZWxwTGluayIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ==" data-smart-edit-component-process-status="removeComponent" data-smartedit-element-uuid="8505cd4a-11b3-4fc8-b278-6f8ff74e50b3" style="position: relative;">
```

### The DynamicAttributeService

Spartacus has a `DynamicAttributeService`. It can add dynamic attributes to the DOM. These attributes are extracted from the `properties` of the CMS items that are received from the back end.

**Note:** There can be many different groups of properties, one of which is `smartedit`. However, SAP Commerce Cloud allows AddOns to create different groups. For example, the Personalization feature may add the `script` group.

Spartacus has the `addAttributesToComponent` function for adding attributes to components, and the `addAttributesToSlot` function for adding attributes to slots.

The following is an example of how to call the `addAttributesToComponent` function:

```typescript
this.dynamicAttributeService.addAttributesToComponent(
      elementRef.nativeElement,
      this.renderer,
      this.cxComponentWrapper
    );
```

The following is an example of how to call the `addAttributesToSlot` function:

```typescript
this.dynamicAttributeService.addAttributesToSlot(
        this.elementRef.nativeElement,
        this.renderer,
        slot
    );
```

## Rerendering Components and Content Slots After Editing

After you make changes to components or content slots, SmartEdit renders only the changed content so that you can quickly see your changes reflected on the page.

For pages rendered by the front end, the storefront rerenders the pages instead of SmartEdit. In this case, Spartacus implements the `renderComponent` function in the `window.smartedit namespace` as shown in the following example:

```typescript
window.smartedit.renderComponent = function(componentId, componentType, parentId) { ... };
```

If the `parentId` does not exist, the CMS item is considered a slot, and `renderComponent` then actually refreshes the whole CMS page. If the `parentId` does exist, the CMS item is considered a component, in which case, only this CMS component is refreshed.

## Default Preview Category or Product

Each site has a `defaultPreviewCategory`, `defaultPreviewProduct` and `defaultPreviewCatalog`. The following is an example:

```text
UPDATE CMSSite;uid[unique=true];defaultPreviewCategory(code, $productCV);defaultPreviewProduct(code, $productCV);defaultPreviewCatalog(id)
;$spaSiteUid;575;2053367;$productCatalog
```

When you open a category or product page in SmartEdit, along with the CMS pages being loaded, the default preview product or category is also loaded.

In SmartEdit, a product with code `2053367` is opened in the product details page, as shown in the following example:

![Screen Shot 2019-07-04 at 8 51 30 AM](https://user-images.githubusercontent.com/44440575/60668058-0d998480-9e39-11e9-98a7-b75422a44c77.png)

Similarly, for the category page, category `575` is opened in the product list page, as shown in the following example:

![Screen Shot 2019-07-04 at 8 52 02 AM](https://user-images.githubusercontent.com/44440575/60668153-46d1f480-9e39-11e9-885c-d12cc6a62020.png)

## WCMS Cockpit Preview URL and Spartacus Context

The WCMS Cockpit Preview URL must match the default context for your Spartacus web site.

For example, if you go to `https://localhost:4200`, you see the default URL path (or context), such as `https://localhost:4200/en/USD`. The Preview URL (which is set in Backoffice) must match the default that the context uses, otherwise errors will occur using SmartEdit. The default context installed by Spartacus schematics is `https://localhost:4200/en/USD`.
