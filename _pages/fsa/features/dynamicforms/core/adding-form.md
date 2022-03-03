---
title: Adding Form to a Simple Page
---

This page explains how to add a form to a simple page.

## Procedure

To add a form to a simple page:

- Create JSON form definition for a new form. For more information, see [Form Definition - JSON Structure]({{ site.baseurl }}{% link _pages/fsa/features/dynamicforms/json-structure.md %}).

- In the ImpEx file, create a YFormDefinition with a reference to the newly created JSON definition:

    ```typescript
    INSERT_UPDATE YFormDefinition; applicationId[unique = true]; formId[unique = true]; version; title; description; content[translator = de.hybris.    platform.commerceservices.impex.impl.FileLoaderValueTranslator];
    ; insurance ; new_form ; 1 ; New Form ; "New Form" ; $siteResource/forms/new-form.json
    ```

- Create a new CMS component (e.g.,"NewFormComponent") with a reference to the previously added YFormDefinition:

    ```typescript
    INSERT_UPDATE CMSFormSubmitComponent; $contentCV[unique = true];    uid[unique = true]; name; visible; &componentRef; applicationId;   formId
    ; ; NewFormComponent ; New Form Component ; true ;  NewFormComponent ; insurance ; new_form
    ```

- Connect the component with a page through a content slot:

    ```typescript
    INSERT_UPDATE ContentSlot; $contentCV[unique = true]; uid[unique    = true]; name; active; cmsComponents(&componentRef);
    ; ; Section2Slot-newFormPage ; Section2 Slot for New Form Page ;    true ; NewFormComponent
    ```
