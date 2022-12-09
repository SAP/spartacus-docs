---
title: Installing SAP Commerce Cloud for use with TUA Spartacus 1.2
---

The following instructions describe how to install and configure SAP Commerce Cloud (release 1905) with Telco & Utilities Accelerator (release 2003, latest patch) for use with a TUA Spartacus storefront. In these instructions, SAP Commerce Cloud and Telco & Utilities Accelerator are installed on your local computer, so `localhost` is used in the browser URLs.

The installation procedure includes steps for creating and using a `b2c_telco_spa` recipe that makes use of the TUA Spartacus Sample Data (`b2ctelcospastore`), but you can use your own sample data or recipe as long as it includes the `cmsoccaddon`, `ycommercewebservices`, `acceleratorwebservicesaddon` extensions and TUA module.

**Note:** If you are trying out TUA Spartacus for the first time and intend to use the default sample data, you must use the TUA Spartacus Sample Data store extension (should be part of your list of extensions). The TUA Spartacus Sample Data is a set of data (product offerings and content) for the telco industry.

However, installing the TUA Spartacus Sample Data is not required in all cases. The TUA Spartacus layout is CMS driven as much as possible, but there are a few areas where the CMS structure does not provide enough information. To address this, TUA Spartacus includes a layout configuration that provides additional information for the layout rendering of the CMS content (specifically, the order of the page slots). This configuration is provided in the `TmaB2cStorefrontModule`. It is important to understand that this specific configuration is tightly coupled to the TUA Spartacus sample data, and that whenever you change the sample data (something that happens in all projects), you should introduce your own layout configuration. When you are ready to introduce your own layout configuration, do not import the `TmaB2cStorefrontModule`, but instead, use the `StorefrontModule` that does not provide any layout configuration. The `StorefrontModule` is not dependent on the TUA Spartacus sample data, and is most likely a good starting point for your custom project.

To install and configure SAP Commerce Cloud for use with TUA Spartacus, you must complete the following procedures:

1. Setting up SAP Commerce Cloud with Telco & Utilities Accelerator
2. Configuring OCC credentials
3. Configuring CORS

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Setting Up SAP Commerce Cloud with Telco & Utilities Accelerator

Some of the steps in this procedure are derived from the documentation for installing SAP Commerce using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.

1. Unzip the SAP Commerce and Telco & Utilities Accelerator zip archives.

   Note: Use the lastest patches for SAP Commerce Cloud version 1905 and Telco & Utilities Accelerator version 2003.

1. [Download](https://github.com/SAP/spartacus-tua/releases) the TUA Spartacus Sample Data Store Extension.

    The TUA Spartacus Sample Data Store Extension is the extension provided in the following zip file: `b2ctelcospastore.zip`.
  
    

1. Unzip the `b2ctelcospastore.zip` archive.

1. Move the `b2ctelcospastore` folder to `sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

   The `b2ctelcospastore` folder can be stored anywhere in the `modules` folder. The `b2c-telco-accelerator` folder is chosen as it contains other TUA sample data.

1. In the `sap-commerce-folder>/installer/recipes` folder, duplicate the `b2c_telco` folder.

1. Rename the copy of the `b2c_telco` folder to `b2c_telco_spa`.

1. In `b2c_telco_spa`, the `build.gradle` file should have the following content:

   ```java
   apply plugin: 'installer-platform-plugin'
   apply plugin: 'installer-addon2-plugin'

   def pl = platform {

       localProperties {
	        	  property 'kernel.events.cluster.jgroups.channel', 'disable'
		        property 'datahub.publication.saveImpex', ''
		        property 'commerceservices.default.desktop.ui.experience', 'responsive'
		        property 'kernel.autoInitMode', 'update'
		        property 'installed.tenants', 'junit, api, foo'

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
			extName 'b2ctelcospastore'
			extName 'b2ctelcoaddon'
			extName 'b2ctelcotmfwebservices'
			extName 'b2ctelcowebservices'
		
			extName 'b2ctelcooccaddon'
			extName 'commerceservicesbackoffice'
			extName 'solrfacetsearchbackoffice'
			extName 'solrserver'
			extName 'subscriptionbackoffice'
			extName 'yacceleratorstorefront'
			extName 'yacceleratorcore'
			extName 'ycommercewebservices'
            extName 'pcmbackofficesamplesaddon'

			extName 'cmsbackoffice'
			extName 'cmswebservices'
			extName 'previewwebservices'
			extName 'smarteditwebservices'
			extName 'cmssmarteditwebservices'
			extName 'permissionswebservices'
			extName 'smarteditaddon'
			extName 'cmssmartedit'
			extName 'cmsoccaddon'
			extName 'customerticketingaddon'
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
			extName 'assistedservicestorefront'
			extName 'assistedservicecustomerinterestsaddon'

			extName 'rulebuilderbackoffice'
			extName 'couponbackoffice'
			extName 'droolsruleengineservices'
			extName 'couponfacades'
			extName 'couponservices' 
			extName 'promotionenginesamplesaddon'
			extName 'acceleratorwebservicesaddon'

	}
    addons {
        forStoreFronts('yacceleratorstorefront') { 
           names('b2ctelcoaddon', 'smarteditaddon', 'customerticketingaddon', 'assistedservicestorefront', 'assistedservicecustomerinterestsaddon', 'pcmbackofficesamplesaddon', 'promotionenginesamplesaddon')
		   template 'yacceleratorstorefront'
		}

		forStoreFronts('ycommercewebservices') {
		   names('b2ctelcooccaddon','cmsoccaddon','acceleratorwebservicesaddon')
		   template 'ycommercewebservices'
			
		}
      
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

1. Open a terminal or command prompt window inside the `sap-commerce-folder>/installer` folder.

1. Set up the recipe using the following commands for Windows:

   ```bash
   install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
   ```
For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
   ```

   **Note:** Starting with release 1905, SAP Commerce Cloud releases do not ship with a default admin password. You must specify a password when running recipe commands (as shown above), or you can specify a password in a file named `custom.properties` stored in `sap-commerce-folder>\installer\customconfig`. See the [Alternate Method for Setting the SAP Commerce Admin Password](#alternate-method-for-setting-the-sap-commerce-admin-password) procedure below for information on setting a password in the `custom.properties` file.

1. Initialize the system using the following command. From the `sap-commerce-folder>/installer` folder run the following commands for Windows:

   ```bash
   install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```
For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```

   Initialization of the b2c_telco_spa recipe can take about 20 minutes. Sample data for this recipe includes telco specific data and content.

1. Start SAP  Cloud with the following command. From the `sap-commerce-folder>/installer` folder, run the following commands for Windows:

   ```bash
   install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd start
   ```
For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd start
   ```

1. Verify that the system is working.

   - Access Admin Console: https://localhost:9002
   - Access Backoffice: https://localhost:9002/backoffice
   

   **Note:** When setting up your TUA Spartacus storefront, set the base site in `app.module.ts` to `telcospa`. The following is an example:

   ```ts
   context: {
   baseSite: ['telcospa']
   },
   ```

## Configuring OCC Credentials

By default, SAP Commerce Cloud replies to OCC REST API calls that do not require authentication. For example, you can do the following:

- Display Open API documentation: https://localhost:9002/rest/v2/swagger-ui.html
- Display information about the `telcospa` base store: https://localhost:9002/rest/v2/telcospa/basestores/telcospa

In order to register users and check out, SAP Commerce Cloud must be configured with a client ID and password. When required, your TUA Spartacus storefront sends this client ID and password when communicating with the backend. 
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
     "access_token" : "550d9a25-87c8-4e76-af21-6174a1e56d5c",
     "token_type" : "bearer",
     "expires_in" : 41809,
     "scope" : "basic openid"
   }
   ```

**You can now start TUA Spartacus!** After you have configured SAP Commerce Cloud to accept OCC REST API calls, you can set up and start your storefront. See [Building the TUA Spartacus Storefront Using 1.2 Libraries]({{ site.baseurl }}{% link _pages/telco/building-the-tua-storefront-from-libraries-1-2.md %}) for more information.

## Configuring CORS

CORS (Cross-Origin Resource Sharing) defines a way for a browser and a server to decide which cross-origin requests for restricted resources can or cannot be allowed. Certain TUA Spartacus functionality, such as checkout and consent management, may not work properly if the CORS OCC REST API settings are not configured properly in SAP Commerce Cloud.

You can add these settings using the Hybris Administration Console. Hover your mouse over the **Platform** tab, click **Configuration**, then update the CORS settings.

To configure CORS settings for OCC REST APIs, add the following to your SAP Commerce configuration (`local.properties` file of your config folder):

```sql
corsfilter.ycommercewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.ycommercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.ycommercewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents
```

```sql
corsfilter.b2ctelcotmfwebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.b2ctelcotmfwebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.b2ctelcotmfwebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents
```

```sql
corsfilter.acceleratorservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.acceleratorservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.acceleratorservices.allowedHeaders=origin content-type accept authorization cache-control
```

**Note:** The `x-anonymous-consents` custom header is included in the above example, but it can be removed if you plan to disable the anonymous consent feature. However, do not remove this header if you do not plan to disable the anonymous consent feature. For more information, see [Anonymous Consent]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}).

For more information about CORS, see [ycommercewebservices Extension](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html) in the SAP Help Portal.

## Alternate Method for Setting the SAP Commerce Admin Password

Instead of including the admin password in every install command as required for release 1905, you can create a configuration file that is used each time.

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
`website.telcospa.http=http://localhost:9001`
`website.telcospa.https=https://localhost:9002`
