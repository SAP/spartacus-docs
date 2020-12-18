---
title: Adding a Form to a Simple Page
---

This page will explain how to add new form to a simple page:

- Create JSON form definition for a new form
- In impex file create YFormDefinition definition with a reference to newly created JSON definition

    ```typescript
    INSERT_UPDATE YFormDefinition; applicationId[unique = true]; formId[unique = true]; version; title; description; content[translator = de.hybris.    platform.commerceservices.impex.impl.FileLoaderValueTranslator];
    ; insurance ; new_form ; 1 ; New Form ; "New Form" ; $siteResource/forms/new-form.json
    ```

- Create "NewFormComponent" with reference to previously added YFormDefinition

    ```typescript
    INSERT_UPDATE CMSFormSubmitComponent; $contentCV[unique = true];    uid[unique = true]; name; visible; &componentRef; applicationId;   formId
    ; ; NewFormComponent ; New Form Component ; true ;  NewFormComponent ; insurance ; new_form
    ```

- Last step is to connect this component to some page through content slot

    ```typescript
    INSERT_UPDATE ContentSlot; $contentCV[unique = true]; uid[unique    = true]; name; active; cmsComponents(&componentRef);
    ; ; Section2Slot-newFormPage ; Section2 Slot for New Form Page ;    true ; NewFormComponent
    ```
