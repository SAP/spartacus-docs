---
title: Installing SAP Commerce Cloud 1905
---

The following instructions describe how to install and configure SAP Commerce Cloud release 1905 for use with a Spartacus storefront. In these instructions, SAP Commerce Cloud is installed to your local computer, so `localhost` is used in the browser URLs.

The installation procedure includes steps for creating and using a `b2c_for_spartacus` recipe that makes use of the Spartacus Sample Data Addon, but you can use you own sample data or recipe as long as it includes the `cmsoccaddon` and `ycommercewebservices` extensions.

**Note:** If you are trying out Spartacus for the first time and intend to use the default sample data, you must install the Spartacus Sample Data Addon. The Spartacus Sample Data Addon makes a copy of the Electronics storefront with changes to content that work with the default Spartacus storefront.

However, installing the Spartacus Sample Data Addon is not required in all cases. The Spartacus layout is CMS driven as much as possible, but there are a few areas where the CMS structure does not provide enough information. To address this, Spartacus includes a layout configuration that provides additional information for the layout rendering of the CMS content (specifically, the order of the page slots). This configuration is provided in the `B2cStorefrontModule`. It is important to understand that this specific configuration is tightly coupled to the Spartacus sample data, and that whenever you change the sample data (something that happens in all projects), you should introduce your own layout configuration. When you are ready to introduce your own layout configuration, do not import the `B2cStorefrontModule`, but instead, use the `StorefrontModule` that does not provide any layout configuration. The `StorefrontModule` is not dependent on the Spartacus sample data, and is most likely a good starting point for your custom project.

For more information about the changes that are implemented with the Spartacus Sample Data AddOn, see [Spartacus Sample Data Addon]({{ site.baseurl }}{% link _pages/install/spartacussampledataaddon.md %}).

To install and configuring SAP Commerce Cloud for use with Spartacus, you must complete the following procedures:

1. [Setting up SAP Commerce Cloud](#setting-up-sap-commerce-cloud)
2. [Configuring OCC credentials](#configuring-occ-credentials)
3. [Configuring CORS](#configuring-cors)

## Setting Up SAP Commerce Cloud with the Spartacus Sample Data Addon

Some of the steps in this procedure are derived from the documentation for installing SAP Commerce Cloud using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.

1. Unzip the SAP Commerce Cloud zip archive.

   Note: The name of the zip archive for release 1905 starts with `CXCOMM1905#...`. This folder will be referred to as `CXCOMM*` for the rest of these instructions.

1. [Download](https://github.com/SAP/spartacus/releases) the Spartacus Sample Data AddOn.

    The Spartacus Sample Data AddOn is versioned and released with the Spartacus `storefront` library. You can download the latest version by clicking on `spartacussampledataaddon.zip` in the **Assets** section of the most recent release of the `storefront` library.
  
    Of course, previous versions are also available. For example, to download the Spartacus Sample Data AddOn for the `2.0.0-next.3` release, you can access the **Assets** section of the `@spartacus/storefront@2.0.0-next.3` library [here](https://github.com/SAP/spartacus/releases/tag/storefront-2.0.0-next.3).


1. Unzip the `spartacussampledataaddon.zip` archive.

1. Move the `spartacussampledataaddon` folder to `hybris/bin/modules/b2c-accelerator`.

   The `spartacussampledataaddon` folder can be stored anywhere in the `modules` folder. The `b2c-accelerator` folder is chosen as it contains other B2C sample data.

1. In the `installer/recipes` folder, duplicate the `b2c_acc_plus` folder.

1. Rename the copy of the `b2c_acc_plus` folder to `b2c_for_spartacus`.

1. In `b2c_for_spartacus`, open `build.gradle` with a text editor.

1. In the list of extensions, add the following:

   ```java
   extName 'spartacussampledataaddon'
   ```

   You can put the new entry anywhere in the list of extensions, but it's usually added near `electronicsstore`. The following is an example:

   ```java
   extName 'electronicsstore'
   extName 'apparelstore'
   extName 'spartacussampledataaddon'

   ```

   **Note:** The Spartacus Sample Data AddOn copies data from the `Electronics` store, so the `electronicsstore` extension is required. Additionally, the time to initialize is longer because SAP Commerce Cloud builds the `Electronics` and `Apparel` stores, as well as the `Electronics for Spartacus` store. If you do not need to install the `Apparel` store, you can speed up initialization by removing `extName 'apparelstore'` from the `build.gradle` file.

1. In the `addons { forStoreFronts('yacceleratorstorefront')` section of the `build.gradle` file, add `'spartacussampledataaddon'` to the `names` list. The following is an example:

   ```ts
    addons {
        forStoreFronts('yacceleratorstorefront') {
            names('spartacussampledataaddon', 'captchaaddon', ...

   ```

1. Save the file.

1. Open a terminal or command prompt window inside the `CXCOMM*\installer` folder.

1. Set up the recipe using the following command:

   ```bash
   ./install.sh -r b2c_for_spartacus -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
   ```

   If you are using Windows, change `./install.sh` to `install.bat`.

   **Note:** Starting with release 1905, SAP Commerce Cloud releases do not ship with a default admin password. You must specify a password when running recipe commands (as shown above), or you can specify a password in a file named `custom.properties` stored in `CXCOMM*\installer\customconfig`. See the [Alternate Method for Setting the SAP Commerce Cloud Admin Password](#alternate-method-for-setting-the-sap-commerce-cloud-admin-password) procedure below for information on setting a password in the `custom.properties` file.

1. Initialize the system using the following command:

   ```bash
   ./install.sh -r b2c_for_spartacus -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```

   Initialization of the b2c_for_spartacus recipe can take about 30 minutes. Sample data for this recipe includes `Electronics`, `Apparel`, and `Electronics for Spartacus` sample stores.

1. Start SAP Commerce Cloud with the following command:

   ```bash
   ./install.sh -r b2c_for_spartacus -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd start
   ```

1. Verify that the system is working.

   - Display the Admin Console: https://localhost:9002
   - Display Backoffice: https://localhost:9002/backoffice
   - Display the Accelerator Electronics storefront: https://localhost:9002/yacceleratorstorefront/?site=electronics

**Note:** When setting up your Spartacus storefront, set the base site in `app.module.ts` to `electronics-spa`. The following is an example:

```ts
context: {
  baseSite: ['electronics-spa']
},
```  

## Configuring OCC Credentials

By default, SAP Commerce Cloud replies to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/rest/v2/swagger-ui.html
- Display information about the `Electronics` base store: https://localhost:9002/rest/v2/electronics/basestores/electronics

To be able to register users and check out, SAP Commerce Cloud must be configured with a client ID and password. When required, your Spartacus storefront sends this client ID and password when communicating with the back end. For more information about OCC configuration, see [Defining OAuth Clients in an Impex File](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html#loio4079b4327ac243b6b3bd507cda6d74ff) in the SAP Help Portal.

The following procedure describes how to configure SAP Commerce Cloud to accept OCC REST API calls.

1. Open the Hybris Administration Console in a web browser at the following address: `https://localhost:9002`.

2. Hover your mouse over the **Console** tab, then click **Impex Import**.

3. Copy-paste the following code into the **Import content** field.

   ```sql
   INSERT_UPDATE OAuthClientDetails;clientId[unique=true]    ;resourceIds       ;scope        ;authorizedGrantTypes                                            ;authorities             ;clientSecret    ;registeredRedirectUri
                                   ;client-side              ;hybris            ;basic        ;implicit,client_credentials                                     ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_implicit_callback;
                                   ;mobile_android           ;hybris            ;basic        ;authorization_code,refresh_token,password,client_credentials    ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_callback;
   ```

   When you import this sample (which is the same as the sample that is provided in the SAP Commerce Cloud documentation), you add the following client ID and password:

    - client ID: `mobile_android`
    - password (or secret): `secret`

   **Note:** The values for client ID and password are just samples. You would use different values for your production environments.

4. Click the **Import content** button.

   You have now added a client ID and password to your Spartacus storefront configuration.

5. You can verify that the OAuth client has been successfully defined by entering the following curl command in a terminal or command prompt window:

   ```bash
   curl -k -d "client_id=mobile_android&client_secret=secret&grant_type=client_credentials" -X POST https://localhost:9002/authorizationserver/oauth/token
   ```

   The curl command sends a POST request for an access token, using the client ID and password that you added to the back end. The command should return something similar to the following:

   ```bash
   {
     "access_token" : "550d9a25-87c8-4e76-af21-6174a1e56d5c",
     "token_type" : "bearer",
     "expires_in" : 41809,
     "scope" : "basic openid"
   }
   ```

**You can now start Spartacus!** After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for more information.

## Configuring CORS

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

## Alternate Method for Setting the SAP Commerce Cloud Admin Password

Instead of including the admin password in every install command as required for release 1905, you can create a configuration file that is used each time.

1. Create a file named `custom.properties` inside the `installer/customconfig` folder of your SAP Commerce Cloud folder.

2. Add the following line: `initialpassword.admin=Y0urFav0r!tePassw0rd`

   Change `Y0urFav0r!tePassw0rd` to the password you'd like to use.

3. Save the file.

The next time you run the recipe install command, the settings inside `custom.properties` are used to build the `local.properties` file, and there's no need to include `-A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd`.

## Supporting Regions in the Billing Address

A specific configuration can be entered if the payment provider requires the `regions` field as part of the billing address data.

Spartacus automatically picks up on the configuration and displays the `regions` field in the form.

1. If you do not have a `custom.properties` file, create a file named `custom.properties` inside the `installer/customconfig` folder of your SAP Commerce Cloud folder.

2. Add the following line to your `custom.properties` file:

    ```
    mockup.payment.label.billTo.region=billTo_state
    ```

3. Save the file.

The next time you run the recipe install command, the settings inside `custom.properties` are used to build the `local.properties`.

**Note:** If you wish this configuration to be present without reinstalling, you can add the property to your `local.properties` file.

## Possible Issues

### Failure at the Payment Step in Checkout

You may encounter the following error message:

```
POST http://localhost:4200/acceleratorservices/sop-mock/process 404 (Not Found)
```

This issue is caused by an incorrect configuration of the `sop.post.url` property.

Make sure this property is set to `sop.post.url=https://localhost:9002/acceleratorservices/sop-mock/process`.
