---
title: Installing SAP Commerce Cloud for use with Spartacus
---

The following instructions describe how to install and configure SAP Commerce Cloud release 1905 for use by a Spartacus storefront. SAP Commerce Cloud is installed to your local computer, so `localhost` is used in the browser URLs.

This example uses the `b2c_acc_plus` recipe included in SAP Commerce Cloud as an example, but you can use you own sample data or recipe as long as it includes cmsoccaddon and ycommercewebservices.

The steps described in this document are:

1. Set up SAP Commerce Cloud
2. Configure OCC credentials
3. Configure CORS (optional to start but required for checkout)
4. Install the Spartacus sample data addon (optional)

At the end of this document, an alternate method for setting the SAP Commerce Cloud admin password is provided.

# Setting up SAP Commerce Cloud

For more information concerning installation of SAP Commerce Cloud using recipes, see [this help document](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/1905/en-US/8c46c266866910149666a0fe4caeee4e.html?q=Installing%20SAP%20Commerce%20Using%20Installer%20Recipes).

1. Unzip the SAP Commerce Cloud zip archive.

   Note: The name of the zip archive for release 1905 starts with `CXCOMM1905#...`. This folder will be referred to as `CXCOMM*` for the rest of these instructions.

2. Open a terminal or command prompt window inside the `CXCOMM*\installer` folder.

3. Set up the recipe using the following command:

   ```
   ./install.sh -r b2c_acc_plus -A local_property:initialpassword.admin=nimda
   ```

   If you are using Windows, change `./install.sh` to `install.bat`.

   Note: Starting with release 1905, SAP Commerce Cloud releases do not ship with a default admin password. You must specify a password when running recipe commands (as shown above), or in a file named `custom.properties` stored in `CXCOMM*\installer\customconfig`.

4. Initialize the system using the following command:

   ```
   ./install.sh -r b2c_acc_plus -A local_property:initialpassword.admin=nimda initialize
   ```

   Initialization of the out-of-the-box b2c_acc_plus recipe can take about 30 minutes. Sample data for this recipe includes Electronics and Apparel sample stores.

5. Start SAP Commerce Cloud with the following command:

   ```
   ./install.sh -r b2c_acc_plus -A local_property:initialpassword.admin=nimda start
   ```

6. Verify that the system is working.

   - Display the Admin Console: https://localhost:9002
   - Display Backoffice: https://localhost:9002/backoffice
   - Display the Accelerator Electronics storefront: https://localhost:9002/yacceleratorstorefront/?site=electronics

# Configuring OCC credentials

Out-of-the-box, SAP Commerce Cloud will reply to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/rest/v2/swagger-ui.html
- Display information about the Electronics base store: https://localhost:9002/rest/v2/electronics/basestores/electronics

To be able to register users and check out, SAP Commerce Cloud must be configured with a client ID and password. Your Spartacus storefront sends this client ID and password when communicating with the backend when required.

Note: For more information about OCC configuration, see [this help document](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html#loio4079b4327ac243b6b3bd507cda6d74ff).

To configure SAP Commerce Cloud to accept OCC REST API calls:

1. Display the Admin Console: https://localhost:9002.

2. Point to the Console tab, then click Impex Import.

3. Copy-paste the following code into the Import Content field.

   ```sql
   INSERT_UPDATE OAuthClientDetails;clientId[unique=true]    ;resourceIds       ;scope        ;authorizedGrantTypes                                            ;authorities             ;clientSecret    ;registeredRedirectUri
                                   ;client-side              ;hybris            ;basic        ;implicit,client_credentials                                     ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_implicit_callback;
                                   ;mobile_android           ;hybris            ;basic        ;authorization_code,refresh_token,password,client_credentials    ;ROLE_CLIENT             ;secret          ;http://localhost:9001/authorizationserver/oauth2_callback;
   ```

   The above sample and the sample from SAP Commerce Cloud documentation add the following client ID and password:

   - client ID: mobile_android
   - password (or secret): secret

   This client ID and password is what you add to your Spartacus storefront configuration. Note that these are just samples; you would use something different for your production environments.

4. Click the Import Content button.

5. You can verify that it's working using the following curl command:

   ```bash
   curl -k -d "client_id=mobile_android&client_secret=secret&grant_type=client_credentials" -X POST https://localhost:9002/authorizationserver/oauth/token
   ```

   The curl command sends a POST request for an access token, using the client ID and password added to the backend. The command should return something similar to the following:

   ```bash
   {
     "access_token" : "550d9a25-87c8-4e76-af21-6174a1e56d5c",
     "token_type" : "bearer",
     "expires_in" : 41809,
     "scope" : "basic openid"
   }
   ```

**You can now start Spartacus!** After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for more information.

# Configuring CORS (optional to start but required for checkout)

CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain Spartacus functionality such as checkout and consent management may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.

To configure CORS settings for OCC REST APIs, adding the following to your SAP Commerce Cloud configuration. (These settings can be added using the Admin Console as well.)

```
corsfilter.ycommercewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.ycommercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.ycommercewebservices.allowedHeaders=origin content-type accept authorization cache-control
```

For more information, [this help document](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html).

# Installing the Spartacus sample data addon (optional)

The [Spartacus Sample Data Addon]({{ site.baseurl }}/assets/other/spartacussampledataaddon.zip) makes a copy of the Electronics storefront with changes that better suit the design of the out-of-the-box Spartacus style and content.

The name of the new storefront base site is **electronics-spa**.

#### Step 1: Download and install the Spartacus sample data addon

1. [Download]({{ site.baseurl }}/assets/other/spartacussampledataaddon.zip) the Spartacus sample data add-on.

2. Unzip the archive.

3. Move the `spartacussampledataaddon` folder to `hybris/bin/modules/b2c-accelerator`.

   The `spartacussampledataaddon` folder can be stored anywhere in the `modules` folder. The `b2c-accelerator` folder is chosen as it contains other B2C sample data.

#### Step 2: Create a new Spartacus-specific recipe

1. In the `installer/recipes` folder, duplicate the `b2c_acc_plus` folder.

2. Rename the copy of the `b2c_acc_plus` folder to `b2c_for_spartacus`.

3. In `b2c_for_spartacus`, open `build.gradle` with a text editor.

4. In the list of extensions, add the following:

   ```
   extName 'spartacussampledataaddon'
   ```

   You can put the new entry anywhere in the list of extensions, but it's usually added near electronicsstore. Example:

   ```
   extName 'electronicsstore'
   extName 'apparelstore'
   extName 'spartacussampledataaddon'

   ```

   Note: As the Spartacus sample data copies data from the Electronics store, the `electronicsstore` extension is required. Additionally, the time to initialize is longer as SAP Commerce Cloud is building both Electronics and Electronics for Spartacus.

5. In `addons { forStoreFronts('yacceleratorstorefront')`, add `spartacussampledataaddon` to the `names` list. Example:

   ```
    addons {
        forStoreFronts('yacceleratorstorefront') {
            names('spartacussampledataaddon', 'captchaaddon', ...

   ```

6. Save the file.

#### Step 3: Set up SAP Commerce Cloud

Install the new recipe according to the instructions at the top of this document, but substituting the new recipe name. For example, to perform the first step:

```
./install.sh -r b2c_for_spartacus -A local_property:initialpassword.admin=nimda

```

When setting up your Spartacus storefront, set the base site in `app.module.ts` to **electronics-spa** (Electronics for Spartacus).

# Alternate method for setting the SAP Commerce Cloud admin password

Instead of including the admin password in every install command as required for release 1905, you can create a configuration file that is used each time.

1. Create a file named `custom.properties` inside the `installer/customconfig` folder of your SAP Commerce Cloud folder.

2. Add the following line: `initialpassword.admin=nimda`

   Change `nimda` to the password you'd like to use. The use of `nimda` is by convention of older releases.

3. Save the file.

The next time you run the recipe install command, the settings inside `custom.properties` are used to build the `local.properties` file, and there's no need to include `-A local_property:initialpassword.admin=nimda`.

# Possible Issues

## Failure at the Payment Step in Checkout

You may encounter the following error message:

```
Http failure response for https://electornics.local:9002/acceleratorservices/sop-mock/process: 0 Unknown Error
```

This issue is caused by incorrect configuration of the `website.electronics.http` and `https` properties.

Make sure these properties are set to:

`website.electronics.http`: &nbsp; `http://localhost:9001/yacceleratorstorefront`

`website.electronics.https`: &nbsp; `https://localhost:9002/yacceleratorstorefront`
