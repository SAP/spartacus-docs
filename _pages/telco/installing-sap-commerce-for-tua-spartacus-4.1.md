---
title: Installing SAP Commerce Cloud for use with TUA Spartacus 4.1
---

The following instructions describe how to install and configure SAP Commerce Cloud (release 2011) with Telco & Utilities Accelerator (supports both release 2108, latest patch) for use with a TUA Spartacus storefront. In these instructions, SAP Commerce and Telco & Utilities Accelerator are installed on your local computer, so `localhost` is used in the browser URLs.

The installation procedure includes steps for creating and using a `b2c_telco_spa` recipe that makes use of the TUA Spartacus Sample Data (`b2ctelcospastore`), but you can use your own sample data or recipe as long as it includes the `cmsocc`, `commercewebservices`, `acceleratorocc` extensions and TUA module.

**Note:** If you are trying out TUA Spartacus for the first time and intend to use the default sample data, you must use the TUA Spartacus Sample Data store extension (should be part of your list of extensions). The TUA Spartacus Sample Data is a set of data (product offerings and content) for the telco industry.

However, installing the TUA Spartacus Sample Data is not required in all cases. The TUA Spartacus layout is CMS driven as much as possible, but there are a few areas where the CMS structure does not provide enough information. To address this, TUA Spartacus includes a layout configuration that provides additional information for the layout rendering of the CMS content (specifically, the order of the page slots). This configuration is provided in the `TmaB2cStorefrontModule`. It is important to understand that this specific configuration is tightly coupled to the TUA Spartacus sample data, and that whenever you change the sample data (something that happens in all projects), you should introduce your own layout configuration. When you are ready to introduce your own layout configuration, do not import the `TmaB2cStorefrontModule`, but instead, use the `StorefrontModule` that does not provide any layout configuration. The `StorefrontModule` is not dependent on the TUA Spartacus sample data, and is most likely a good starting point for your custom project.

To install and configure SAP Commerce Cloud for use with TUA Spartacus, you must complete the following procedures:

- [Setting Up SAP Commerce Cloud with TUA using the TUA Spartacus Sample Data Store Extension](#setting-up-sap-commerce-cloud-with-tua-using-the-tua-spartacus-sample-data-store-extension)
- [Configuring OCC Credentials](#configuring-occ-credentials)
- [Updating System and User Credentials](#updating-system-and-user-credentials)
- [Configuring CORS](#configuring-cors)
- [Alternate Method for Setting the SAP Commerce Admin Password](#alternate-method-for-setting-the-sap-commerce-admin-password)
- [Supporting Regions in the Billing Address](#supporting-regions-in-the-billing-address)
- [Possible Issues](#possible-issues)
  - [Failure at the Payment Step in Checkout](#failure-at-the-payment-step-in-checkout)

## Setting Up SAP Commerce Cloud with TUA using the TUA Spartacus Sample Data Store Extension

Some of the steps in this procedure are derived from the documentation for installing SAP Commerce using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.

1. Unzip the SAP Commerce and Telco & Utilities Accelerator zip archives.

   **Note:** Use the latest patches for SAP Commerce Cloud version 2011 and Telco & Utilities Accelerator version 2108.

1. [Download](https://github.com/SAP/spartacus-tua/releases) the TUA Spartacus Sample Data Store Extension.

    The TUA Spartacus Sample Data is provided in the following zip files:

    - `b2ctelcospastore.zip`
    - `utilitiesspastore.zip`
    - `mediaspastore.zip`
    - `b2btelcospastore.zip`

1. Unzip the sample data.

    **Note:** You can either use both the store extensions, or only one of them, depending on your needs (specific to Telco or to Utilities).

    - Sample data for Telco is stored in the following archive files:
        - `b2ctelcospastore.zip`.

    - Sample data for Utilities is stored in the following archive files:
        - `utilitiesspastore_2007.zip`.

    - Sample data for Media is stored in the following archive files: 
        - `mediaspastore.zip`.

    - Sample data for B2B Telco is stored in the following archive files: 
        - `b2btelcospastore.zip`.

1. Move:
    - the `b2ctelcospastore` folder from extracted `b2ctelcospastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

    - the `utilitiesspastore` folder from extracted `utilitiesspastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

    - the `mediaspastore` folder from extracted `mediaspastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

    - the `b2btelcospastore` folder from extracted `b2btelcospastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

    **Note:** The `b2ctelcospastore`, `utilitiesspastore`, `mediaspastore`, and `b2btelcospastore` folder can be stored anywhere in the modules folder. The `b2c-telco-accelerator` folder is chosen as it contains other TUA sample data.

1. Unzip TUA cms extension for utilities:

    - In case you decided to use utilities sample data please unzip the `b2ctelcocms.zip` too.
     
    - Move the `b2ctelcocms` folder in the same location with `utilitiesspastore` folder.

1. In the `sap-commerce-folder>/installer/recipes` folder, create a copy of the `b2c_telco` folder.

1. Rename the copy of the `b2c_telco` folder to `b2c_telco_spa`.

1. In `b2c_telco_spa`, the `build.gradle` file should have the following content:

    If you want to use the two sample data extensions, for Telco and Utilities, the `build.gradle` file must have the following structure:

   ```java
    apply plugin: 'installer-platform-plugin'
	apply plugin: 'installer-addon2-plugin'
	

	def pl = platform {
	localProperties {
	    property 'kernel.events.cluster.jgroups.channel', 'disable'
	    property 'datahub.publication.saveImpex', ''
	    property 'commerceservices.default.desktop.ui.experience', 'responsive'
	    property 'kernel.autoInitMode', 'update'
	    property 'installed.tenants', 'junit'
        property 'occ.rewrite.overlapping.paths.enabled', 'true'
        property 'api.compatibility.b2c.channels', 'B2B'
	}
	afterSetup {
	    ensureAdminPasswordSet()
	}
	

	extensions {
	    extName 'acceleratorcms'
	    extName 'adaptivesearchbackoffice'
	    extName 'adaptivesearchsolr'
	    extName 'addonsupport'
	    extName 'b2ctelcobackoffice'
	    extName 'b2ctelcofulfillmentprocess'
	    extName 'b2ctelcocms'
	    extName 'b2ctelcospastore'
	    extName 'utilitiesspastore'
	    extName 'mediaspastore'
	    extName 'b2ctelcotmfwebservices'
	    extName 'b2ctelcowebservices'
	

	    extName 'b2ctelcocommercewebservicescommons'
	    extName 'b2ctelcoocc'
	    extName 'b2ctelcoserviceabilityclient'	
	    extName 'commerceservicesbackoffice'
	    extName 'solrfacetsearchbackoffice'
	    extName 'solrserver'
	    extName 'subscriptionbackoffice'
	    extName 'yacceleratorcore'
	    extName 'commercewebservices'
	

	    extName 'cmsbackoffice'
	    extName 'cmswebservices'
	    extName 'previewwebservices'
	    extName 'smarteditwebservices'
	    extName 'cmssmarteditwebservices'
	    extName 'permissionswebservices'
	    extName 'cmssmartedit'
	    extName 'cmsocc'
		extName 'acceleratorocc'
	    extName 'customersupportbackoffice'
	

	    extName 'personalizationwebservices'
	    extName 'previewpersonalizationweb'
	    extName 'personalizationcmsweb'
	    extName 'personalizationsmartedit'
	    extName 'personalizationservicesbackoffice'
	    extName 'personalizationcmsbackoffice'
	    extName 'personalizationservices'
	    extName 'personalizationfacades'
	

	    extName 'acceleratorservices'
	    extName 'assistedservicefacades'
	

	    extName 'rulebuilderbackoffice'
	    extName 'couponbackoffice'
	    extName 'droolsruleengineservices'
	    extName 'couponfacades'
	    extName 'couponservices'
	    extName 'b2ctelcoserviceabilityclient'
	    extName 'billingaccountservices'
	    extName 'billingaccounttmfwebservices'
	    extName 'agreementservices'
	    extName 'agreementtmfwebservices'
	    extName 'subscribedproductservices'
	    extName 'subscribedproducttmfwebservices'
	}
	}
	

	task setup () {
	doLast {
	

	    pl.setup()
	

	    copy {
	    from "${installerHome}/recipes/b2c_telco_spa/logback.xml"
	    into "${suiteHome}/hybris/bin/platform/tomcat/lib"
	    }
	    copy {
	    from "${installerHome}/recipes/b2c_telco_spa/sbg_properties"
	    into "${suiteHome}/hybris/bin/platform/tomcat/lib"
	    exclude "**/*.txt"
	    }
	}
	}
	

	task buildSystem(dependsOn: setup) {
	doLast {
	    pl.build()
	}
	}
	

	task initialize (dependsOn: buildSystem) {
	doLast {
	    pl.initialize()
	}
	}
	

	task start () {
	doLast {
	    pl.start()
	}
	}
	

	task startInBackground () {
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
    If you want to use only Telco sample data then remove the following lines from the `build.gradle` file:

    ```bash
    extName 'utilitiesspastore'
    extName 'mediaspastore'
    extName 'b2ctelcocms'
    extName 'b2btelcospastore'
    ```
1. Open a terminal or command prompt window inside the `sap-commerce-folder>/installer` folder.

1. Set up the recipe using the following commands:
    
    For Windows:

    ```bash
    install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
    ```
    For Unix:

    ```bash
    ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
   ```

   **Note:** Starting with release 1905, SAP  Cloud releases do not ship with a default admin password. You must specify a password when running the preceding recipe commands, or you can specify a password in the `custom.properties` file that is stored in `sap-commerce-folder>\installer\customconfig`. See the following [Alternate Method for Setting the SAP Commerce Admin Password](#alternate-method-for-setting-the-sap-commerce-admin-password) procedure for information on setting a password in the `custom.properties` file.

1. Initialize the system using the following command. From the `sap-commerce-folder>/installer` folder run the following commands:

   For Windows:

   ```bash
   install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```
   For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```

   Initialization of the `b2c_telco_spa` recipe can take about 20 minutes. Sample data for this recipe includes telco-specific data and content.

1. Start SAP Commerce Cloud with the following command. From the `sap-commerce-folder>/installer` folder, run the following commands 

   For Windows:

   ```bash
   install.bat -r b2c_telco_spa start
   ```
   For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa start
   ```

1. Verify that the system is working.

   - Access Admin Console: https://localhost:9002
   - Access Backoffice: https://localhost:9002/backoffice
   

   **Note:** When setting up your Spartacus storefront, set the base site in `app.module.ts` to `telcospa` and/or `utilitiesspa` and/or `mediaspa` and/or `b2btelcospa` depending on which sample data you want to use. Following are the samples:

    Telco:

    ```ts
    context: {
    baseSite: ['telcospa']
    },
    ```

    Utilities:

    ```ts
    context: {
    baseSite: ['utilitiesspa']
    },
    ```
    
    Media:

    ```ts
    context: {
    baseSite: ['mediaspa']
    },
    ```

    B2B Telco:

    ```ts
    context: {
    baseSite: ['b2btelcospa']
    },
    ```

    All four:

    ```ts
    context: {
    baseSite: ['telcospa', 'utilitiesspa’, 'mediaspa', 'b2btelcospa']
    },
    ```

## Configuring OCC Credentials

By default, SAP  Cloud replies to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/rest/v2/swagger-ui.html
- Display information about the `telcospa` base store: https://localhost:9002/occ/v2/telcospa/basestores/telcospa
- Display information about the `utilitiesspa` base store: https://localhost:9002/rest/v2/utilitiesspa/basestores/utilitiesspa
- Display information about the `mediaspa` base store: https://localhost:9002/occ/v2/utilitiesspa/basestores/mediaspa

To register users and check out, SAP Commerce Cloud must be configured with a client ID and password. When required, your TUA Spartacus storefront sends this client ID and password when communicating with the backend. 
For more information about OCC configuration, see [Defining OAuth Clients in an Impex File](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html#loio4079b4327ac243b6b3bd507cda6d74ff) in the SAP Help Portal.

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

   You have now added a client ID and password to your TUA Spartacus storefront configuration.

5. You can verify that the OAuth client has been successfully defined by entering the following curl command in a terminal or command prompt window:

   ```bash
   curl -k -d "client_id=mobile_android&client_secret=secret&grant_type=client_credentials" -X POST https://localhost:9002/authorizationserver/oauth/token
   ```

   The curl command sends a POST request for an access token, using the client ID and password that you added to the backend. The command should return something similar to the following:

   ```bash
   {
     "access_token" : "zOM6rJ-TnoUM8xvibfy-VK-m8Xw",
     "token_type" : "bearer",
     "expires_in" : 43170,
     "scope" : "basic openid"
   }
   ```


## Updating System and User Credentials

**Note:** Updating system and user credentials (2005 only) is optional.

If you are using SAP Commerce Cloud 2005, you may need to enable users and passwords for certain functionality to work. For more information, see [Setting Passwords for Default Users](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/2005/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html).

You can now start Spartacus! After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. [Building the TUA Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/telco/building-the-tua-storefront-from-libraries.md %}) for more information.

## Configuring CORS

CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain TUA Spartacus functionality, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.

You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.

To configure CORS settings for OCC REST APIs, add the following to your SAP Commerce Cloud configuration (`local.properties` file of your config folder):

```sql
corsfilter.commercewebservices.allowedOrigins=*
corsfilter.commercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents
```

```sql
corsfilter.b2ctelcotmfwebservices.allowedOrigins=*
corsfilter.b2ctelcotmfwebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.b2ctelcotmfwebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents
```

```sql
corsfilter.acceleratorservices.allowedOrigins=*
corsfilter.acceleratorservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.acceleratorservices.allowedHeaders=origin content-type accept authorization cache-control
```

```sql
corsfilter.subscribedproducttmfwebservices.allowedOrigins=http://localhost:4200 https://localhost:4200 http://b2ctelco.telcospa:4200 https://b2ctelco.telcospa:4200
corsfilter.subscribedproducttmfwebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.subscribedproducttmfwebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents
```

```sql
corsfilter.billingaccounttmfwebservices.allowedOrigins=http://localhost:4200 https://localhost:4200 http://b2ctelco.telcospa:4200 https://b2ctelco.telcospa:4200
corsfilter.billingaccounttmfwebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.billingaccounttmfwebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents
```

```sql
corsfilter.agreementtmfwebservices.allowedOrigins=http://localhost:4200 https://localhost:4200 http://b2ctelco.telcospa:4200 https://b2ctelco.telcospa:4200
corsfilter.agreementtmfwebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.agreementtmfwebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents
```

**Note:** The `x-anonymous-consents` custom header is included in the above example, but it can be removed if you plan to disable the anonymous consent feature. However, do not remove this header if you do not plan to disable the anonymous consent feature. For more information, see [Anonymous Consent]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}).

For more information about CORS, see [commerceservices Extension](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/8b85a20586691014bacda05068f9c842.html) in the SAP Help Portal.

## Alternate Method for Setting the SAP Commerce Admin Password

Instead of including the admin password in every install command as required for release 2005, you can create a configuration file that is used each time.

1. Create a file named `custom.properties` inside the `installer/customconfig` folder of your SAP Commerce folder.

2. Add the following line: `initialpassword.admin=Y0urFav0r!tePassw0rd`

   Change `Y0urFav0r!tePassw0rd` to the password you'd like to use.

3. Save the file.

The next time you run the recipe install command, the settings inside `custom.properties` are used to build the `local.properties` file, and there's no need to include `-A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd`.

## Supporting Regions in the Billing Address

A specific configuration can be entered if the payment provider requires the `regions` field as part of the billing address data.

TUA Spartacus automatically picks up on the configuration and displays the `regions` field in the form.

1. If you do not have a `custom.properties` file, create a file named `custom.properties` inside the `installer/customconfig` folder of your SAP Commerce folder.

2. Add the following line to your `custom.properties` file:

    ```text
    mockup.payment.label.billTo.region=billTo_state
    ```

3. Save the file.

The next time you run the recipe install command, the settings inside `custom.properties` are used to build the `local.properties`.

**Note:** If you wish this configuration to be present without reinstalling, you can add the property to your `local.properties` file.

## Possible Issues

### Failure at the Payment Step in Checkout

You may encounter the following error message:

```text
POST http://localhost:4200/acceleratorservices/sop-mock/process 404 (Not Found)
```

This issue is caused by an incorrect configuration of the `sop.post.url` property.

Make sure this property is set to `sop.post.url=https://localhost:9002/acceleratorservices/sop-mock/process`.

**Note:** Please make sure that you have the website properties properly set for your `telcospa` base site to point to your environment. For your **localhost** environment, they should have the following values: 
- `website.telcospa.http=http://localhost:9001`
- `website.telcospa.https= https://localhost:9002`
- `website.utilitiesspa.http=http://localhost:9001`  
- `website.utilitiesspa.https=https://localhost:9002`
- `website.mediaspa.http=http://localhost:9001`  
- `website.mediaspa.https=https://localhost:9002`
