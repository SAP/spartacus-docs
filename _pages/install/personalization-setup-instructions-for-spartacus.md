---
title: Personalization Setup Instructions for Spartacus
---

For the following steps, the Electronics sample site is used along with the Spartacus Sample Data Addon.

## Back End Extension Requirements

Make sure all the required personalization extensions and AddOns are installed in your SAP Commerce Cloud instance. For more information, see the [Personalization installation instructions](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/latest/en-US/6a0dae49ef2c4fe3b475084079cb7360.html) for your release.

## Back End CORS Settings

As described in [Configure Personalization for Commerce Web Services](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/latest/en-US/e970070f997041c7b3f3e77fcb762744.html), add `occ-personalization-id` and `occ-personalization-time` to the following settings:

- `corsfilter.commercewebservices.allowedHeaders`
- `corsfilter.commercewebservices.exposedHeaders`

**Note:** These settings are for SAP Commerce Cloud version 2005 or newer. For SAP Commerce Cloud version 1905 or older, use the following settings instead:

- `corsfilter.ycommercewebservices.allowedHeaders`
- `corsfilter.ycommercewebservices.exposedHeaders`

If a setting doesn't exist, create it.

If the setting already exists, add the new values to the end, including a space before. For example, `allowedHeaders` might look like this:

```sql
origin content-type accept authorization occ-personalization-id occ-personalization-time
```

**Note:** You can edit these settings using HAC, but you can also add these parameters to `local.properties` in the `hybris/config` folder or in the `project.properties` file of ycommercewebservices.

## Personalization Configuration in Backoffice

1. In Backoffice, go to `Personalization > Configuration > Personalization Configuration`.

2. Select **Electronics Site**.

3. In the Properties tab, General section, add **Spartacus Electronics Site** to **Set of base sites**.

4. In the Commerce Web Services tab, set **Personalization for Commerce Web Services** to **True**.

  To test that the configuration is working:

  - Send an OCC REST API call to your site. You should see `Occ-Personalization-Id` in the response header. 
  - Send the call again but with `Occ-Personalization-Id: yourid` in the header,  and you should also see `Occ-Personalization-Time`.

## Enabling Personalization in Spartacus

In `app.module.ts`, add the following to the settings in the `B2cStorefrontModule.withConfig` section:

```
personalization: {
  enabled: true,
},
```

## Testing Personalization

To test your own configurations, you can try out the steps in the following Personalization tutorials:

- [Add a Personalization to a Page](https://enable.cx.sap.com/media/Add+a+Personalization+to+a+Page+-+SAP+Commerce+Cloud/1_0nu4ayiu)
- [Create Personalized Search Results](https://enable.cx.sap.com/media/Create+Personalized+Search+Results+-+SAP+Commerce+Cloud/1_5dhey09h)

For more information, see [Peronalization](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/latest/en-US/2aee3397ba474c0ba959e43f0fc5d3d4.html) in the SAP Help Portal.

## Setting Up Personalization Context For Spartacus (Optional)

The personalization context contains information about personalization details like segments and actions which influence displayed content. Such information can be used by reporting tools.

Sample personalization context :

```json
{
  "actions": [
    {
      "action_code": "actionCanonLoverSpa",
      "action_type": "CxCmsActionResult",
      "variation_code": "canonLoverSpa",
      "variation_name": "canonLoverSpa",
      "customization_code": "CategoryLoversSpa",
      "customization_name": "CategoryLoversSpa"
    },
    {
      "action_code": "canonLoverSearchProfileActionSpa",
      "action_type": "CxSearchProfileActionResult",
      "variation_code": "canonLoverSpa",
      "variation_name": "canonLoverSpa",
      "customization_code": "CategoryLoversSpa",
      "customization_name":"CategoryLoversSpa"
    }
  ],
  "segments": [
    "USER_ANONYMOUS",
    "CanonLover",
    "CATEGORY brand_10"
  ]
}
```

### Back End

1. The `personalizationaddon` extension.

    The `personalizationaddon` is needed to expose the personalization context on the storefront.
    It should be added to `localextension.xml`.

    ```java
    ...
    <extension name="personalizationaddon" />
    ...
    ```

2. The PersonalizationScriptComponent

    The personalizationaddon contains the PersonalizationScriptComponent, which should be inserted into PlaceholderContentSlot. 
    You can run the impex below to add PersonalizationScriptComponent to your content catalog. 
    Remember to set **$contentCatalog** parameter to the proper content catalog value.
  
   ```sql
   $contentCatalog = electronics-spaContentCatalog
   $stageContentCV = catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]), CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
  
   # -----------------------------------------------------------------------
   # Component needed for personalization context visible in storefront
   # -----------------------------------------------------------------------
  
   INSERT_UPDATE PersonalizationScriptComponent; $stageContentCV[unique = true]; uid[unique = true]             ; name                  ;
                                               ;                          ; PersonalizationScriptComponent ; PersonalizationScript ; PersonalizationScript ; ;
  
   INSERT_UPDATE ContentSlot; $stageContentCV[unique = true]; uid[unique = true]     ; active; cmsComponents(uid, $stageContentCV)[mode = append]
                            ;                          ; PlaceholderContentSlot ; true  ; PersonalizationScriptComponent
     
     
     
     
     
   $onlineContentCV = catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]), CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
     
     
   # -----------------------------------------------------------------------
   # Component needed for personalization context visible in storefront
   # -----------------------------------------------------------------------
     
   INSERT_UPDATE PersonalizationScriptComponent; $onlineContentCV[unique = true]; uid[unique = true]             ; name                  ;
                                               ;                          ; PersonalizationScriptComponent ; PersonalizationScript ; PersonalizationScript ; ;
     
   INSERT_UPDATE ContentSlot; $onlineContentCV[unique = true]; uid[unique = true]     ; active; cmsComponents(uid, $onlineContentCV)[mode = append]
                            ;                          ; PlaceholderContentSlot ; true  ; PersonalizationScriptComponent
   
    ```

### Frontend - Spartacus

Spartacus contains **PersonalizationContextService**, which enables access to personalization context. 
If you would like to use information from personalization context, you can subscribe to it and get PersonalizationContext object.

```ts
export interface PersonalizationContext {
  actions: PersonalizationAction[];
  segments: string[];
}

export interface PersonalizationAction {
  action_name: string;
  action_type: string;
  customization_name?: string;
  customization_code?: string;
  variation_name?: string;
  variation_code?: string;
}
```

Below you can find a sample test service, which displays personalization context in the console. 

```ts
import { Injectable } from '@angular/core';
import {PersonalizationContextService} from "./personalization-context.service";
  
@Injectable({
  providedIn: 'root',
})
export class PersonalizationTestService {
  constructor(
    protected service : PersonalizationContextService
  ) {
  
    this.service.getPersonalizationContext().subscribe(evt => console.log(evt));
  
  }
  
  getServiceName(): String {
    return 'PersonalizationTestService';
  }
}
```
