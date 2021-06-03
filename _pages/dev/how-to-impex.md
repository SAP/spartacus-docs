---
title: SAP Commerce Cloud - ImpEx
---

ImpEx is a text-based import and export functionality, which is shipped with SAP Commerce Cloud. It allows basic operations, such as creating, updating, removing, and exporting Platform items. All input are from comma-separated value.

For more information, see [ImpEx](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/8bee5297866910149854898187b16c96.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## How to create PageTemplates

Step 1: You would need to first create a PageTemplate, which define the layout for pages using the following fields below:

```text
INSERT_UPDATE PageTemplate;$contentCV[unique=true];uid[unique=true];name;frontendTemplateName;restrictedPageTypes(code);active[default=true]
```

- `frontendTemplateName` is used to define the JSP that shuold be used to render the page for pages with multiple layouts.
- `restrictedPageTypes` is used to restrict templates to page types.

### ContentSlotNames

Step 2 - Each PageTemplates can have multiple content slot names which helps with the positioning, where we can state a list of valid components for the slot.
There exists standard set of slots, such as SiteLogo, HeaderLinks MiniCart and NavigationBar, and a number of specific slots for each template.

```text
INSERT_UPDATE ContentSlotName;name[unique=true];template(uid,$contentCV)[unique=true][default='CategoryPage'];validComponentTypes(code);compTypeGroup(code)
```

- Below the `INSERT_UPDATE`, we can see a number of content slot name available for the specific PageTemplate as specified in the statement `default='CategoryPage'`.
- `validComponentType` or `compTypeGroup` defined the valid components for the slot.

### ContentSlotForTemplate

Step 3 - We need to bind the content slots to page templates as it defines the relationship between team.

```text
INSERT_UPDATE ContentSlotForTemplate;$contentCV[unique=true];uid[unique=true];position[unique=true];pageTemplate(uid,$contentCV)[unique=true][default='ProductDetailsPageTemplate'];contentSlot(uid,$contentCV)[unique=true];allowOverwrite
```

### Create pages using the template

Step 4 - Finally, pages are created using the template

```text
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false'];previewImage(code, $contentCV)[default='ContentPageModel__function_preview']
```

- `masterTemplate`: By specifying the page template you have created, you can create a `page`.
