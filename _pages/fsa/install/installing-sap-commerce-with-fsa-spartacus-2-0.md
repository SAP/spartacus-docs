---
title: Installing SAP Commerce Cloud for Use with FSA Spartacus 2.0
---

The following instructions describe how to install and configure SAP Commerce (release 2011, patch 2) with Financial Services Accelerator (release 2102) for use with FSA Spartacus storefront. In these instructions, SAP Commerce and Financial Services Accelerator are installed on your local computer, so localhost is used in the browser URLs.

The installation procedure includes steps for installing and using a financial_spa and financial_spa_integrations recipes that make use of the FSA Spartacus Sample Data (*financialspastore*), but you can use your own sample data or recipe as long as it includes the *cmsocc*, *commercewebservices*, *acceleratorocc* extensions and the FSA module.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Installation and Configuration Instructions

Summary:

- [Step 1: Setting up SAP Commerce with Financial Services Accelerator](#step-1-setting-up-sap-commerce-with-financial-services-accelerator)
- [Step 2: Configuring OCC credentials](#step-2-configuring-occ-credentials)
- [Step 3: Configuring CORS](#step-3-configuring-cors)
- [Step 4: Update system and user credentials (optional)](#step-4-update-system-and-user-credentials-optional)

### Step 1: Setting up SAP Commerce with Financial Services Accelerator

Some steps in this procedure derive from the documentation for installing SAP Commerce using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/2011/en-US/8c46c266866910149666a0fe4caeee4e.html) on the SAP Help Portal.

1. Unzip the SAP Commerce and Financial Services Accelerator zip archives.

   **Note**: Use the SAP Commerce version 2011.2 and Financial Services Accelerator version 2102.

2. In the "sap-commerce-folder/installer/recipes" folder, you should be able to see the financial_spa and financial_spa_integrations recipes.

   **Note**: The procedure for installing the financial_spa_integrations recipe is exactly the same as for the financial_spa recipe. The financial_spa_integrations recipe is used for installing SAP for Insurance integrations with FSA Storefront.

3. In the financial_spa folder, the build.gradle file should have the following content:

    ```typescript
    apply plugin: 'installer-platform-plugin'
    apply plugin: 'installer-addon2-plugin'
    
    def pl = platform {
        localProperties {
            property 'storefront.show.debug.info', 'false'
            property 'promotions.legacy.mode', 'true'
        }
    
        extensions {
            extName 'financialspastore'
            extName 'financialprocess'
            extName 'financialsmartedit'
            extName 'financialwebservices'
            extName 'financialb2bocc'
            extName 'financialb2bbackoffice'
    
            extName 'backofficesolrsearch'
            extName 'configurablebundlebackoffice'
            extName 'solrfacetsearchbackoffice'
            extName 'solrserver'
    
            extName 'xyformsbackoffice'
            extName 'adaptivesearchsolr'
            extName 'adaptivesearchbackoffice'
            extName 'commerceservicesbackoffice'
            extName 'customersupportbackoffice'
    
            extName 'assistedservicewebservices'
    
            extName 'yacceleratorfulfilmentprocess'
            extName 'yacceleratorcore'
    
            extName 'cmsocc'
            extName 'acceleratorocc'
            extName 'cmswebservices'
            extName 'previewwebservices'
            extName 'smarteditwebservices'
            extName 'cmssmarteditwebservices'
            extName 'permissionswebservices'
            extName 'odata2webservices'
            extName 'cmssmartedit'
            extName 'cmsbackoffice'
            extName 'pcmbackoffice'
            extName 'subscriptionbackoffice'
        }
    
        addons {
        }
    }
    
    task setup {
        doLast {
            pl.setup()
        }
    }
    
    task buildSystem(dependsOn: setup) {
        doLast {
            pl.build()
        }
    }
    
    task initialize(dependsOn: buildSystem) {
        doLast {
            pl.initialize()
        }
    }
    
    task start {
        doLast {
            pl.start()
        }
    }
    
    task startInBackground {
        doLast {
            pl.startInBackground()
        }
    }
    
    task stopInBackground {
        doLast {
            pl.stopInBackground()
        }
    }
    ```

    **Note**: The FSA Spartacus Sample Data store extension (financialspastore) is already in the list of extensions for both financial_spa and financial_spa_integrations recipes.

4. Open a terminal or command prompt window inside the "sap-commerce-folder/installer" folder.

5. Set up the recipe using the following commands.

    For Unix:

    ```typescript
    ./install.sh -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
    ```

    For Windows:

    ```typescript
    install.bat -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
    ```

6. Initialize the system using the following commands.

    For Unix:

    ```typescript
    ./install.sh -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
    ```

    For Windows:

    ```typescript
    install.bat -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
    ```

7. Start the SAP Commerce running the following commands from the sap-commerce-folder>/installer folder.

    For Unix:

    ```typescript
    ./install.sh -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd start
    ```

    For Windows:

    ```typescript
    install.bat -r financial_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd start
    ```

8. Verify that the SAP Commerce Cloud is working. To do this, you can:

    - Display the Admin Console: `https://localhost:9002` or
    - Display the Backoffice: `https://localhost:9002/backoffice` (note that starting the Backoffice for the first time can take 15-20 seconds).

9. Verify that the FSA Spartacus versions of the sample store were created:
    - Display the Backoffice or
    - Go to **WCMS** > **Website**. You should see the financial sample store.

### Step 2: Configuring OCC credentials

FSA Spartacus uses OCC REST API calls to get information from and make changes to the back end. To do this, the back end must be configured with certain credentials.

1. Open the Hybris Administration Console for your local SAP Commerce Cloud in a web browser at the following address: `https://localhost:9002`.
2. Navigate to the **Console** tab, then click **Impex Import**.
3. Copy the following code into the **Import content** field.

    ```sql
    INSERT_UPDATE OAuthClientDetails;   clientId[unique=true];  resourceIds     ;scope;     authorizedGrantTypes         ;authorities             ;clientSecret    ;registeredRedirectUri
   ;client-side              ;hybris            ;basic        ;implicit,client_credentials                                     ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_implicit_callback;
   ;mobile_android           ;hybris            ;basic        ;authorization_code,refresh_token,password,client_credentials    ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_callback;
    ```

    **Note**: The values for the client ID and the password are just samples. You can use different values for your production environments.

4. Click **Import content**. You have now added a client ID and password to your FSA Spartacus storefront configuration.

You can verify that the OAuth client has been successfully defined by entering the following curl command in the terminal or the command prompt window:

```typescript
curl -k -d "client_id=mobile_android&client_secret=secret&grant_type=client_credentials" -X POST https://localhost:9002/authorizationserver/oauth/token
```

The curl command sends a POST request for an access token, using the client ID and password that you added to the back end. The command should return something similar to the following:

```typescript
{
  "access_token" : "550d9a25-87c8-4e76-af21-6174a1e56d5c",
  "token_type" : "bearer",
  "expires_in" : 43199,
  "scope" : "basic openid"
}
```

### Step 3: Configuring CORS

CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain FSA Spartacus functionalities, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce. You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.

To configure CORS settings for OCC REST APIs, add the following to your SAP Commerce configuration (the local.properties file of your config folder):

```typescript
corsfilter.commercewebservices.allowedOrigins=http://localhost:4200
corsfilter.commercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference
corsfilter.commercewebservices.exposedHeaders=x-anonymous-consents

corsfilter.acceleratorservices.allowedOrigins=http://localhost:4200
corsfilter.acceleratorservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.acceleratorservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents
corsfilter.acceleratorservices.exposedHeaders=x-anonymous-consents
```

**Note**: The x-anonymous-consents custom header is included in the above example, but it can be removed if you plan to disable the anonymous consent feature. However, do not remove this header if you do not plan to disable the anonymous consent feature. For more information, see [Anonymous Consent]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}).

### Step 4: Update system and user credentials (optional)

As you are using SAP Commerce Cloud 2011, you may need to enable users and passwords for certain functionalities to work.

For more information, see [Setting Passwords for Default Users](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/2011/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html).

**All Done! You can now start FSA Spartacus!**

After you have configured SAP Commerce to accept OCC REST API calls, you can set up and start your storefront. See [Building FSA Spartacus storefront from 2.0 libraries]({{ site.baseurl }}{% link _pages/fsa/install/building-the-fsa-storefront-from-libraries-2-0.md %}) for more information.

## Alternate Method for Setting the SAP Commerce Admin Password

Instead of including the admin password in every install command, you can create a configuration file.

1. Create a file named custom.properties inside the installer/customconfig folder of your SAP Commerce folder.
2. Add the following line: initialpassword.admin=Y0urFav0r!tePassw0rd. Replace Y0urFav0r!tePassw0rd with the password you want to use.
3. Save the file.

Next time you run the recipe install command, the settings inside custom.properties will be used to build the `local.properties file and there is no need to include -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd`.

## CORS Settings

- CORS settings **are very important for security**. We strongly recommend that a professional SAP Commerce Cloud administrator reviews these settings to suit your requirements, as the sample properties should not be used for production servers.
- CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain Spartacus functionalities, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.
- You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.
- For information on Spartacus and CORS settings, see [Cross-Origin Resource Sharing]({{ site.baseurl }}{% link _pages/install/cors.md %}).
- Several other Spartacus features also require additional CORS settings. For more information about CORS, see the [ycommercewebservices Extension](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html) on the SAP Help Portal.

## Troubleshooting

### Failure at the Payment Step in the Checkout

You may encounter the following error message:

```typescript
POST http://localhost:4200/acceleratorservices/sop-mock/process 404 (Not Found)
```

This issue is caused due to an incorrect configuration of the `sop.post.url` property.

Make sure this property is set to `sop.post.url=https://localhost:9002/acceleratorservices/sop-mock/process`.
