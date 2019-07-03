---
title: How Smartedit Contract is implemented in Spartacus
---

## Useful links

[SmartEdit Setup Instructions for Spartacus](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/smartEdit-setup-instructions-for-spartacus/)

[SmartEdit Contract for Storefronts](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1808/en-US/622cebcb444b42e18de2147775430b9d.html#loio622cebcb444b42e18de2147775430b9d)

## SmartEdit contract implementation

To make Spartacus work with SmartEdit, we need implement the SmartEdit contract in Spartacus.

### The SmartEdit Contract consists of the following

#### 1. The webApplicationInjector.js file that must be included in each page

[SmartEdit Setup Instructions for Spartacus](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/smartEdit-setup-instructions-for-spartacus/) has the details of how to include this js file into your app.

#### 2. A preview ticket API mechanism

##### 2.1. Get `cmsTicketId` (also called `previewToken`)

When Spartacus is launched in SmartEdit, SmartEdit sends a request to Spa which has `cmsTicketId` as the parameter.

```typescript
e.g. https://localhost:4200/cx-preview?cmsTicketId=6477500489900224fda62f41-167a-40fe-9ecc-39019a64ebb9
```

By default, SmartEdit appends `/cx-preview` to the storefront URI so that it can preview your storefront. But you can configure SmartEdit to route the request to the another endpoint in your app. Use the storefrontPreviewRoute property in an impex to specify your custom storefront route as shown in the following example:

```typescript
INSERT_UPDATE SmartEditConfiguration;key[unique=true];value
;storefrontPreviewRoute;"""my-custom-preview"""
```

`cmsTicketId` is generated in backend. It contains many information required by SmartEdit, such as `site-id` or `catalogVersion`. For the details, pleae read "Preview API" section in [SmartEdit Contract for Storefronts](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1808/en-US/622cebcb444b42e18de2147775430b9d.html#loio622cebcb444b42e18de2147775430b9d).

Spartacus gets `cmsTicketId` from the request sent from SmartEdit.

##### 2.2. Smartedit Interceptor

To make SmartEdit be able to load pages in Spartacus, it needs to get all the required context data, which includes site, content catalog, and content catalog version, and can also be for a specified language, or date and time. Therefore, `cmsTicketId` needs to be appended to any CMS requests sent from Spartacus to backend.

In Spartacus, we have `CmsTicketInterceptor`. If `cmsTicketId` exists and requests are `cms` specified, it adds `cmsTicketId` as one of the request parameters.

```typescript
e.g. https://localhost:9002/rest/v2/electronics-spa/cms/pages?fields=DEFAULT&lang=en&curr=USD&cmsTicketId=6477500489900224fda62f41-167a-40fe-9ecc-39019a64ebb9
```

#### 3. HTML Markup Contract

The HTML markup contract stipulates that every CMS component and every content slot must be wrapped in an HTML tag and include specific elements.

Sending CMS requests with `cmsTicketId`, there will be `properties` field in the response JSON data. `properties` contains groups of dynamic attribute required for the containing CMS items. For example, `properties` in CMS page may have these data:

```typescript
...
"label" : "homepage",
"properties" : {
    "smartedit" : {
        "classes" : "smartedit-page-uid-homepage smartedit-page-uuid-eyJpdGVtSWQiOiJob21lcGFnZSIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ== smartedit-catalog-version-uuid-electronics-spaContentCatalog/Staged"
        }
    }
}
```

In the group `smartedit`, there is `classes`. It is the required SmartEdit contract for this CMS page. So, we need add these "classes" into the class list of the html body tag. If you check the html page source, you will see the body tag has the "classes".

```typescript
<body class="smartedit-page-uid-homepage smartedit-page-uuid-eyJpdGVtSWQiOiJob21lcGFnZSIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ== smartedit-catalog-version-uuid-electronics-spaContentCatalog/Staged">
    <cx-storefront ng-version="8.0.0" class="stop-navigating"><header><cx-page-layout section="header" ng-reflect-section="header" class="header"><!--bindings={
...
```

CMS slots and components also contain the `properties`. We need add these attributes to component/slot tags. The following is an exmpple of "HelpLink" component.

```typescript
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

In the page source, you will see this:
```typescript
<cx-link data-smartedit-catalog-version-uuid="electronics-spaContentCatalog/Staged" data-smartedit-component-type="CMSLinkComponent" data-smartedit-component-id="HelpLink" class="smartEditComponent" data-smartedit-component-uuid="eyJpdGVtSWQiOiJIZWxwTGluayIsImNhdGFsb2dJZCI6ImVsZWN0cm9uaWNzLXNwYUNvbnRlbnRDYXRhbG9nIiwiY2F0YWxvZ1ZlcnNpb24iOiJTdGFnZWQifQ==" data-smart-edit-component-process-status="removeComponent" data-smartedit-element-uuid="8505cd4a-11b3-4fc8-b278-6f8ff74e50b3" style="position: relative;">
```

##### `DynamicAttributeService`

In Spartacus, we have `DynamicAttributeService`. It can add dynamic attributes to DOM. These attributes are extracted from the `properties` of CMS items received from backend.

There can by many different groups of properties, one of them is `smaredit`. But EC allows addons to create different groups. For example, personalization may add `script` group etc.

To add SmartEdit HTML Markup contract to Slot, we have this function:
```typescript
private addSmartEditContract(slot: ContentSlotData): void {
    this.dynamicAttributeService.addDynamicAttributes(
      slot.properties,
      this.hostElement.nativeElement,
      this.renderer
    );
}
```