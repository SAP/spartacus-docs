---
title: Installing SAP Commerce Cloud 2205 for use with Spartacus
---

**Note:** SAP Commerce Cloud 2205 requires version 3.3 or newer of the Spartacus libraries.

**Note:** SAP Commerce Cloud 2205 requires Java 17  or newer.

The following instructions describe how to install and configure SAP Commerce Cloud release 2205 for use with a Spartacus storefront. In these instructions, SAP Commerce Cloud is installed to your local computer, so `localhost` is used in the browser URLs.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Important Disclaimers

- Starting with release 2005, SAP Commerce Cloud ships with all users inactive and without passwords. These users may need to be restored for certain back end functionality to work. For example, although you will be able to add products to cart and check out, certain users are required to fulfill orders with Order Management as used in the default cx recipe. For more information, and for a sample ImpEx that enables such users, see [Setting Passwords for Default Users](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/2005/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html) on the SAP Help Portal.

- Starting with release 1905, SAP Commerce Cloud ships without a default admin password. You must specify a password when running recipe commands, or you can specify a password in a file named `custom.properties` that is stored in `CXCOMM*\installer\customconfig`. The sample `custom.properties` file included in these instructions contains the default password `nimda`. We strongly recommend you change this password to suit your requirements, as it should not be used for production servers.

- The sample custom properties file and OCC credentials supplied here are for evaluation purposes only. Aside from a default password, for example, the CORS settings are permissive to prevent access issues. We strongly recommend that a professional SAP Commerce Cloud administrator review these settings to suit your requirements, as they should not be used for production servers.
  
## Installation and Configuration Instructions

Summary:

- Step 1: Download, unzip, and create the new recipe
- Step 2: Build and initialize the recipe
- Step 3: Import OCC credentials
- Step 4: Update system and user credentials (optional)
  
### Step 1: Download, unzip, and create the new recipe

1. Download and unzip the following files:

   - SAP Commerce Cloud 2205 from the [SAP Software Downloads web site](https://launchpad.support.sap.com/#/softwarecenter/template/products/_APP=00200682500000001943&_EVENT=NEXT&HEADER=Y&FUNCTIONBAR=Y&EVENT=TREE&NE=NAVIGATE&ENR=67837800100800007216&V=MAINT&TA=ACTUAL/SAP%20COMMERCE).
   - Spartacus Sample Data extension from the [Spartacus GitHub Release page](https://github.com/SAP/spartacus/releases).
     - No changes were made to the sample data since version 2105, so you can safely use the version 2105 sample data with your installation of SAP Commerce Cloud 2205.
     - The zip file itself, `spartacussampledata.2105.zip`, is found in the the **Assets** section of the most recent release of the `@spartacus/storefront` library.
     - [Direct link to spartacussampledata.2105.zip](https://github.com/SAP/spartacus/releases/download/storefront-4.1.0/spartacussampledata.2105.zip) (newer versions of the sample data may be released in later releases).

1. Move the `custom.properties` file from `spartacussampledata/resources/installer/customconfig` to `hybris-commerce-suite-2205/installer/customconfig`.

   **Note:** The sample custom properties file is meant for development and evaluation purposes only. It is strongly recommend that you inspect this file's settings using a text editor. For more information, see [Sample Configuration Properties](#sample-configuration-properties).

1. In `hybris/bin`:
   - Create the folder `custom`.
   - Move the entire `spartacussampledata` folder to `hybris/bin/custom`.

1. In the `installer/recipes` folder:
   - Duplicate the `cx` folder.
   - Change the name of the duplicate folder to `cx-for-spa`.

1. In the new `cx-for-spa` folder:
   - Open `build.gradle` with a text editor.
   - Uncomment `//  extName 'spartacussampledata'` in the list of extensions.
   - Save and close the file.
  
### Step 2: Build and initialize the new recipe

1. Open a terminal or command prompt window inside the `installer` folder.

1. Set up the recipe using the following command:

   `./install.sh -r cx-for-spa`
  
   If you are using Windows, change `./install.sh` to `install.bat`.

1. Initialize the system using the following command:
  
   `./install.sh -r cx-for-spa initialize`

1. Start SAP Commerce Cloud using the following command:

   `./install.sh -r cx-for-spa start`

   (Using `spartacussampledata` and the full `cx` recipe, startup may take approximately 30 minutes, depending on your system.)

1. Verify that SAP Commerce Cloud is working. To do this, you can:
   - Display the Admin Console: https://localhost:9002
   - Display Backoffice: https://localhost:9002/backoffice (can take 15-20 seconds to start the first time)
   - Display the Accelerator Electronics storefront: https://localhost:9002/yacceleratorstorefront/?site=electronics

1. Verify that the Spartacus versions of the sample stores were created.
   - Display Backoffice.
   - Go to WCMS > Website. You should see "-spa" versions of the sample stores.
  
### Step 3: Import OCC credentials

Spartacus uses OCC REST API calls to get information from and make changes to the backend. To do this, the backend must be configured with certain credentials.

1. Open the Hybris Administration Console for your local SAP Commerce Cloud, in a web browser at the following address: 

   `https://localhost:9002`

1. Point to the **Console** tab, then click **Impex Import**.

1. Copy-paste the following code into the **Import content** field.

   ```sql
   INSERT_UPDATE OAuthClientDetails;clientId[unique=true]    ;resourceIds       ;scope        ;authorizedGrantTypes                                            ;authorities             ;clientSecret    ;registeredRedirectUri
                                   ;client-side              ;hybris            ;basic        ;implicit,client_credentials                                     ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_implicit_callback;
                                   ;mobile_android           ;hybris            ;basic        ;authorization_code,refresh_token,password,client_credentials    ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_callback;
   ```

1. Click the **Import content** button

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

### Step 4: Update system and user credentials (optional)

You may need to enable users and passwords for certain functionality to work.

See [this help topic](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/latest/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html) for more information.
  
### All Done

You can now start Spartacus. After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. See [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}) for more information.

## Notes

### General

- Some of the steps in this procedure are derived from the documentation for installing SAP Commerce Cloud using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.
- The default cx recipe is used to create the recipe for Spartacus. Among other extensions, the cx recipe uses the Order Management Services feature (OMS). If you make an order, OMS doesn't ship the order, so orders remain in processing. To ship the order, a Warehouse Agent must confirm order shipment. For more information, see the [OMS documentation](https://help.sap.com/viewer/9442091906534fbf837f9f3155ea7b4f/latest/en-US/8b48bef286691014a289a06b5d3b9cfe.html).

### Spartacus Sample Data Extension

- The Spartacus Sample Data extension contains both sample data modifications used by Spartacus. The extension makes a copy of the Electronics and Apparel sample stores, if present (and Powertools in a future release). If you are trying out Spartacus for the first time and intend to use the default sample data, using the Spartacus Sample Data extension is strongly recommended. However, you can use you own sample data or recipe as long as it includes extensions that support OCC APIs like `commercewebservices`.
- The Spartacus Sample Data extension copies data from other storefronts, so at minimum, `electronicsstore` extension is required. You can also use `apparelstore`, and when supported in the future, `powertoolstore`. Note that the time to initialize is longer because SAP Commerce Cloud builds the standard stores first, then the stores for Spartacus. If you do not need all these sample stores, you can comment them out in your recipe's `build.gradle` file.
- For more information about the changes that are implemented with the Spartacus Sample Data extension, see [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}).

### Sample Configuration Properties

The sample custom properties file is meant for development and evaluation purposes only. Please be careful to at least review the following properties:

- The admin password (`initialpassword.admin`) (default is `nimda`).
- CORS settings as described further in this document, and in the Spartacus documentation.

The following table summarizes the settings included in this file:

| Setting | Description |
| --- | --- |
| initialpassword.admin | Admin password so you can access the console and Backoffice |
| occ.rewrite.overlapping.paths.enabled | Defines if certain B2B OCC calls are prefixed with 'org' to avoid endpoint conflicts |
| sop.post.url | Defines where to send mock payment creation requests, so you can check out |
| corsfilter* | Defines various CORS settings required for Spartacus functionality to work (see more information below) - note that the settings are permissive and should be changed to match your site configuration |
| mockup.payment.label.billTo* | Defines extra state and phone number fields for payment, used by Spartacus |
| yacceleratorordermanagement.fraud* | Increases the fraud score limits so you mock purchases are not cancelled |
| task.polling.interval.min | Defines how long the system waits to kick off a new task - smaller values speed up order processing |
| build.parallel | Speeds up initialization if your system has multiple cores |

### Sample OCC credentials

By default, SAP Commerce Cloud successfully replies to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/occ/v2/swagger-ui.html
- Display information about the `Electronics` base store: https://localhost:9002/occ/v2/electronics/basestores/electronics

To be able to register users and check out, SAP Commerce Cloud must be configured with a client ID and password. When required, your Spartacus storefront sends this client ID and password when communicating with the back end.

- When you import the OCC credentials ImpEx, you add the client ID `mobile_android` and password (or secret): `secret`. The values for client ID and password are samples. You would use different values for your production environments.
- For more information on this topic, see [this help topic](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html).

### CORS Settings

- CORS settings **are very important for security**. We strongly recommend that a professional SAP Commerce Cloud administrator review these settings to suit your requirements, as the sample properties should not be used for production servers.
- CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain Spartacus functionality, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.
- You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.
- For information on Spartacus and CORS settings, see [{% assign linkedpage = site.pages | where: "name", "cors.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/cors.md %}).
- There are a number of other Spartacus features that also require additional CORS settings. For more information about CORS, see [ycommercewebservices Extension](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html) in the SAP Help Portal.

## Troubleshooting

- If SAP Commerce Cloud installer doesn't work, make sure there are no spaces in the path to the SAP Commerce Cloud folder.
- If Spartacus starts or partially starts, check all CORS settings. For more information, see [{% assign linkedpage = site.pages | where: "name", "cors.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/cors.md %}).
