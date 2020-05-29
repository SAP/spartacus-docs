---
title: Installing SAP Commerce Cloud 2005 for use with Spartacus
---

The following instructions describe how to install and configure SAP Commerce Cloud release 2005 for use with a Spartacus storefront. In these instructions, SAP Commerce Cloud is installed to your local computer, so `localhost` is used in the browser URLs.

The installation procedure includes steps for creating and using a `cx-for-spa` recipe that makes use of the Spartacus Sample Data Addon, but you can use you own sample data or recipe as long as it includes extensions that support OCC APIs like `commercewebservices`.

**Note:** If you are trying out Spartacus for the first time and intend to use the default sample data, you must install the Spartacus Sample Data Addon. The Spartacus Sample Data Addon makes a copy of the storefronts with changes to content that work with Spartacus storefronts.

To install and configuring SAP Commerce Cloud for use with Spartacus, you must complete the following procedures:

1. [Setting up SAP Commerce Cloud](#setting-up-sap-commerce-cloud)
2. [Importing default system and OCC credentials](#importing-default-system-and-occ-credentials)


## Setting Up SAP Commerce Cloud with the Spartacus Sample Data Addon

Some of the steps in this procedure are derived from the documentation for installing SAP Commerce Cloud using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.


### Step 1: Initial setup

1. Unzip the SAP Commerce Cloud zip archive.

   Note: The name of the zip archive starts with `CXCOMM1905#...`. This folder will be referred to as `CXCOMM*` for the rest of these instructions.

1. [Download](https://github.com/SAP/spartacus/releases) the Spartacus Sample Data AddOn.

    The Spartacus Sample Data AddOn is versioned and released with the Spartacus `storefront` library. You can download the latest version by clicking on `spartacussampledataaddon.zip` in the **Assets** section of the most recent release of the `storefront` library.
  
    Previous versions are also available. For example, to download the Spartacus Sample Data AddOn for the `2.0.0-next.3` release, you can access the **Assets** section of the `@spartacus/storefront@2.0.0-next.3` library [here](https://github.com/SAP/spartacus/releases/tag/storefront-2.0.0-next.3).


1. Unzip the `spartacussampledataaddon.zip` archive.

1. Move the `spartacussampledataaddon` folder to `hybris/bin/modules/custom` (you likely have to create this folder).


### Step 2: Copy and update the default cx recipe

1. In the `installer/recipes` folder, duplicate the `cx` folder.

1. Rename the copy of the `cx` folder to `cx-for-spa`.

1. In `cx-for-spa`, open `build.gradle` with a text editor.

1. In the list of extensions, uncomment the following line:

   ```java
   //  extName 'spartacussampledataaddon'
   ```

   **Note:** The Spartacus Sample Data AddOn copies data from other storefronts, so at minimum, `electronicsstore` extension is required. You can also use `apparelstore`, and when supported in the future, `powertoolstore`. Note that the time to initialize is longer because SAP Commerce Cloud builds the standard stores first, then the stores for Spartacus. If you do not need all these sample stores, you can comment them out in your `build.gradle` file.

1. In the `addons forStoreFronts('yacceleratorstorefront,yb2bacceleratorstorefront') {` section of the `build.gradle` file, uncomment the following line:

   ```java
   // 'spartacussampledataaddon',
   ```

1. Save the file.


### Step 3: Add the sample custom.properties file

**Note:** Starting with release 1905, SAP Commerce Cloud releases do not ship with a default admin password. You must specify a password when running recipe commands (as shown above), or you can specify a password in a file named `custom.properties` stored in `CXCOMM*\installer\customconfig`. The following procedure uses the `custom.properties` file. An example file is provided with other required configuration settings.

1. [Download](https://github.com/SAP/spartacus/releases) the sample `custom.properties` file for the 2005 release.

1. Move this file to `../installer/customconfig`. The file must be named `custom.properties`.

1. Inspect the file's default settings using a text editor. 

   The default settings are designed to work with a local installation.
   Some changes you may want to make include:
  
   - Setting `initialpassword.admin` (default is `nimda`).
   - Changing CORS settings as described below and in the Spartacus dcoumentation.
   - Setting `sop.post.url` to the proper location (payments may not otherwise work).
   - Changing `task.polling.interval.min`, so when testing certain features, processing is faster.
   
   **Warning**: The sample custom properties file supplied here is for evaluation purposes only, for setting up your server quickly. In particular, the CORS settings are permissive to prevent issues with trying out Spartacus. It is strongly recommended that a professional SAP Commerce Cloud administrator review these settings for production servers.

### Step 4: Build and initialize the recipe

1. Open a terminal or command prompt window inside the `CXCOMM*\installer` folder.

1. Set up the recipe using the following command:

   ```bash
   ./install.sh -r cx-for-spa
   ```
   If you are using Windows, change `./install.sh` to `install.bat`.

1. Initialize the system using the following command:

   ```bash
   ./install.sh -r cx-for-spa initialize
   ```

1. Start SAP Commerce Cloud with the following command:

   ```bash
   ./install.sh -r cx-for-spa start
   ```

1. Verify that the system is working.

   - Display the Admin Console: https://localhost:9002
   - Display Backoffice: https://localhost:9002/backoffice (can take 15-20 seconds to start the first time)
   - Display the Accelerator Electronics storefront: https://localhost:9002/yacceleratorstorefront/?site=electronics
   
1. Verify that the Spartacus versions of the sample stores were created. 
   - Display Backoffice
   - Go to WCMS > Website
   
   You should see "-spa" versions of the sample stores.


## Importing default system and OCC credentials

For security reasons, starting with release 2005, SAP Commerce Cloud releases do not ship with any default system credentials. The system credentials must be imported after first initialization. In addition, Spartacus requires specific OCC REST API credentials, to be able to communicate with the backend.

To import the default system and OCC credentials:

1. Open the Hybris Administration Console in a web browser at the following address: `https://localhost:9002`.

1. Point to the **Console** tab, then click **Impex Import**.

### For default system credentials: 

1. [Download](https://github.com/SAP/spartacus/releases) the default credentials impex file.
   
1. Open the default credentials impex file, select all, and copy.
   
1. Paste into the the **Import content** field.
   
1. Click the **Import content** button.
   
Reference: https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/2005/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html#loio726867ad08024fc7a090c1bb801b319f.

### For OCC credentials: 

1. Copy-paste the following code into the **Import content** field.

   ```sql
   INSERT_UPDATE OAuthClientDetails;clientId[unique=true]    ;resourceIds       ;scope        ;authorizedGrantTypes                                            ;authorities             ;clientSecret    ;registeredRedirectUri
                                   ;client-side              ;hybris            ;basic        ;implicit,client_credentials                                     ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_implicit_callback;
                                   ;mobile_android           ;hybris            ;basic        ;authorization_code,refresh_token,password,client_credentials    ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_callback;
   ```

   When you import this sample (which is the same as the sample that is provided in the SAP Commerce Cloud documentation), you add the client ID `mobile_android` and password (or secret): `secret`.

   **Note:** The values for client ID and password are just samples. You would use different values for your production environments.

1. Click the **Import content** button.

You can verify that the OAuth client has been successfully defined by entering the following curl command in a terminal or command prompt window:

```bash
curl -k -d "client_id=mobile_android&client_secret=secret&grant_type=client_credentials" -X POST https://localhost:9002/authorizationserver/oauth/token
```

The curl command sends a POST request for an access token, using the client ID and password that you added to the back end. The command should return something similar to the following:

```json
{
  "access_token" : "550d9a25-87c8-4e76-af21-6174a1e56d5c",
  "token_type" : "bearer",
  "expires_in" : 41809,
  "scope" : "basic openid"
}
```

## All done!

You can now start Spartacus. After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for more information.


## Notes

### What's included in the sample custom properties file

**Warning**: The sample custom properties file supplied in this document is for evaluation purposes only, for setting up your server quickly. In particular, the CORS settings are permissive to prevent issues with trying out Spartacus. It is strongly recommended that a professional SAP Commerce Cloud administrator review these settings for production servers.

The following sample custom properties are included in the file and are meant for development or evaluation purposes:

|initialpassword.admin|Admin password so you can access the console and Backoffice|
|occ.rewrite.overlapping.paths.enabled|Defines if certain B2B OCC calls are prefixed with 'org' to avoid endpoint conflicts|
|sop.post.url|Defines where to send mock payment creation requests, so you can check out|
|corsfilter*|Defines various CORS settings required for Spartacus functionality to work (see more information below) - note that the settings are permissive and should be changed to match your site configuration|
|mockup.payment.label.billTo*|Defines extra state and phone number fields for payment, used by Spartacus|
|yacceleratorordermanagement.fraud*|Increases the fraud score limits so you mock purchases are not cancelled|
|task.polling.interval.min|Defines how long the system waits to kick off a new task - smaller values speed up order processing|
|build.parallel|Speeds up initialization if your system has multiple cores|

### About OCC Credentials

By default, SAP Commerce Cloud replies to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/rest/v2/swagger-ui.html
- Display information about the `Electronics` base store: https://localhost:9002/rest/v2/electronics/basestores/electronics

To be able to register users and check out, SAP Commerce Cloud must be configured with a client ID and password. When required, your Spartacus storefront sends this client ID and password when communicating with the back end. For more information about OCC configuration, see [Defining OAuth Clients in an Impex File](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html#loio4079b4327ac243b6b3bd507cda6d74ff) in the SAP Help Portal.


### CORS Settings

CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain Spartacus functionality, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.

You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.

To configure CORS settings for OCC REST APIs, add the following to your SAP Commerce Cloud configuration:

```sql
corsfilter.ycommercewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.ycommercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.ycommercewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents
```

**Note:** The `x-anonymous-consents` custom header is included in the above example, but it can be removed if you plan to disable the anonymous consent feature. However, do not remove this header if you do not plan to disable the anonymous consent feature. For more information, see [Anonymous Consent]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}).

There are a number of other Spartacus features that also require additional CORS settings. These features are not enabled by default, so you do not need to add these settings if you do not plan to enable these features. If you do intend to enable any of the following features, see the relevant documentation for more information:

- [Assisted Service Module]({{ site.baseurl }}{% link _pages/dev/features/asm.md %})
- [Context-Driven Services Integration]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %})
- [Personalization Setup Instructions for Spartacus]({{ site.baseurl }}{% link _pages/install/personalization-setup-instructions-for-spartacus.md %})

For more information about CORS, see [ycommercewebservices Extension](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html) in the SAP Help Portal.


### About Spartacus Sample Data Addon

Installing the Spartacus Sample Data Addon is not required in all cases. The Spartacus layout is CMS driven as much as possible, but there are a few areas where the CMS structure does not provide enough information. 

To address this, Spartacus includes a layout configuration that provides additional information for the layout rendering of the CMS content (specifically, the order of the page slots). This configuration is provided in `B2cStorefrontModule` for the B2C storefronts such as Electronics. It is important to understand that this specific configuration is tightly coupled to the Spartacus sample data, and that whenever you change the sample data (something that happens in all projects), you should introduce your own layout configuration. 

When you are ready to introduce your own layout configuration, do not import  `B2cStorefrontModule`, but instead, use `StorefrontModule` which does not provide any layout configuration. The `StorefrontModule` is not dependent on the Spartacus sample data, and is most likely a good starting point for your custom project.

For more information about the changes that are implemented with the Spartacus Sample Data AddOn, see [Spartacus Sample Data Addon]({{ site.baseurl }}{% link _pages/install/spartacussampledataaddon.md %}).
