---
title: SAP Customer Data Cloud Integration
feature:
- name: Customer Data Cloud Integration
  spa_version: 2.1
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

SAP Customer Data Cloud allows you to enable customized registration and login, and also manage user profile and consent.

For more information see, [SAP Customer Data Cloud Integration](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US) and [SAP Customer Data Cloud](https://developers.gigya.com/) on the SAP Help Portal.

## Requirements

To integrate SAP Customer Data Cloud with Spartacus, you must have either of the following:

- SAP Commerce Cloud 2005, along with SAP Commerce Cloud, Integration Extension Pack
- SAP Commerce Cloud 1905, along with the latest version of Commerce Cloud Extension Pack

## Enabling SAP Customer Data Cloud Integration in Spartacus

To enable SAP Customer Data Cloud Integration in Spartacus, you need to configure both the Commerce Cloud back end, and the Spartacus front end.

### Configuring the Back End for SAP Customer Data Cloud Integration

The following steps describe how to configure the Commerce Cloud back end for integration with SAP Customer Data Cloud.

1. Follow the steps for [Installing SAP Commerce Cloud for use with Spartacus](https://sap.github.io/spartacus-docs/installing-sap-commerce-cloud/).

2. Enable the SAP Customer Data Cloud extensions for B2C according to [SAP Customer Data Cloud Integration Implementation](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US/2f49dd87b27740529dd8ccc3cd45ffa7.html) on the SAP Help Portal.

3. Build and update the system so that the new functionality provided by the SAP Customer Data Cloud integration extension is available.

4. Update the `mobile_android` OAuth client (created in step 1) to support the `custom` authorization grant type, and remove the `refresh_token` grant type. The following ImpEx can be used to update the grant types:

    ```plaintext
    INSERT_UPDATE OAuthClientDetails ; clientId[unique = true] ; resourceIds ; scope ; authorizedGrantTypes                                  ; authorities ; clientSecret ; registeredRedirectUri                                     
                                     ; mobile_android          ; hybris      ; basic ; authorization_code,password,client_credentials,custom ; ROLE_CLIENT ; secret       ; http://localhost:9001/authorizationserver/oauth2_callback ;  
    ```

    **Note:** Refresh tokens are not supported. This ensures that the token from Commerce Cloud and the SAP Customer Data Cloud login session are maintained for the same duration of time.

5. Define the SAP Customer Data Cloud Site configuration and link it to the `electronics-spa` site. You can also define other configurations for the integration, such as Field Mapping and Consent Templates, according to [SAP Customer Data Cloud Integration Implementation](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US/2f49dd87b27740529dd8ccc3cd45ffa7.html).

    **Note:** The various session management configurations are not supported with Spartacus Storefront.

6. Import the following ImpEx file.

    This ImpEx makes changes to `electronics-spaContentCatalog` that enable the SAP Customer Data Cloud integration in Spartacus.

    ```sql
    # -----------------------------------------------------------------------
    # [y] hybris Platform
    #
    # Copyright (c) 2018 SAP SE or an SAP affiliate company.  All rights reserved.
    #
    # This software is the confidential and proprietary information of SAP
    # ("Confidential Information"). You shall not disclose such Confidential
    # Information and shall use it only in accordance with the terms of the
    # license agreement you entered into with SAP.
    # -----------------------------------------------------------------------
    $contentCatalog=electronics-spaContentCatalog
    $contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
    $jarResourceCms=jar:de.hybris.platform.gigya.gigyaloginaddon.constants.GigyaloginaddonConstants&/gigyaloginaddon/import/cockpit/cmscockpit
    $lang=en

    # Import modulegen config properties into impex macros
    UPDATE GenericItem[processor=de.hybris.platform.commerceservices.impex.impl.ConfigPropertyImportProcessor];pk[unique=true]
    $jarResourceCms=$config-jarResourceCmsValue

    # Create PageTemplates
    INSERT_UPDATE PageTemplate;$contentCV[unique=true];uid[unique=true];name;frontendTemplateName;restrictedPageTypes(code);active[default=true]
    # Templates without a frontendTemplateName
    ;;GigyaLoginPageTemplate;Gigya Login Page Template;;ContentPage;false;


    # GIGYA Login Page Template
    INSERT_UPDATE ContentSlotName;name[unique=true];template(uid,$contentCV)[unique=true][default='GigyaLoginPageTemplate'];validComponentTypes(code);compTypeGroup(code)
    ;SiteLogo;;;logo
    ;HeaderLinks;;;headerlinks
    ;SearchBox;;;searchbox
    ;MiniCart;;;minicart
    ;NavigationBar;;;navigation
    ;Footer;;;footer
    ;TopHeaderSlot;;;wide
    ;BottomHeaderSlot;;;wide
    ;BodyContent;;;wide
    ;BottomContent;;;wide
    ;PlaceholderContentSlot;;;


    INSERT_UPDATE ContentSlotForTemplate;$contentCV[unique=true];uid[unique=true];position[unique=true];pageTemplate(uid,$contentCV)[unique=true][default='GigyaLoginPageTemplate'];contentSlot(uid,$contentCV)[unique=true];allowOverwrite
    ;;SiteLogo-GigyaLoginPage;SiteLogo;;SiteLogoSlot;true
    ;;HeaderLinks-GigyaLoginPage;HeaderLinks;;HeaderLinksSlot;true
    ;;SearchBox-GigyaLoginPage;SearchBox;;SearchBoxSlot;true
    ;;MiniCart-GigyaLoginPage;MiniCart;;MiniCartSlot;true
    ;;NavigationBar-GigyaLoginPage;NavigationBar;;NavigationBarSlot;true
    ;;Footer-GigyaLoginPage;Footer;;FooterSlot;true
    ;;TopHeaderSlot-GigyaLoginPage;TopHeaderSlot;;TopHeaderSlot;true
    ;;BottomHeaderSlot-GigyaLoginPage;BottomHeaderSlot;;BottomHeaderSlot;true
    ;;PlaceholderContentSlot-GigyaLoginPage;PlaceholderContentSlot;;PlaceholderContentSlot;true
    ;;HomepageLink-GigyaLoginPage;HomepageNavLink;;HomepageNavLinkSlot;true


    # Functional Content Pages
    INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false'];
    ;;login;Gigya Login Page;GigyaLoginPageTemplate;login
    ;;gigya-profile;Gigya profile page;AccountPageTemplate;/my-account/gigya-profile
    ;;checkout-login;Gigya Checkout Login Page;GigyaLoginPageTemplate;checkout-login


    # Remove existing profile management pages like password reset, update profile, update email and consent management page
    REMOVE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false'];
    ;;update-profile;Update Profile Page;AccountPageTemplate;update-profile
    ;;update-email;Update Email Page;AccountPageTemplate;update-email
    ;;updatePassword;Update Forgotten Password Page;AccountPageTemplate;updatePassword
    ;;consents;Consent Management Page;AccountPageTemplate;consents


    #### Gigya Login Page
    # ContentSlot
    INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef);;;
    ;;BodyContent-gigya-login;Body Content Slot for Gigya Login Page;true;GigyaRaasComponentForLogin;;;
    ;;BottomContent-gigya-login;Bottom Content Slot for Gigya Login Page;true;;;;

    # ContentSlotForPage
    INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true][default='login'];contentSlot(uid,$contentCV)[unique=true];;;
    ;;BodyContent-gigya-login;BodyContent;;BodyContent-gigya-login;;;
    ;;BottomContent-gigya-login;BottomContent;;BottomContent-gigya-login;;;


    #### Gigya Checkout Login Page
    # ContentSlot
    INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef);;;
    ;;BodyContent-gigya-checkout-login;Body Content Slot for Gigya Checkout Login Page;true;GigyaRaasComponentForLogin;;;
    ;;BottomContent-gigya-checkout-login;Bottom Content Slot for Gigya Checkout Login Page;true;;;;

    # ContentSlotForPage
    INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true][default='checkout-login'];contentSlot(uid,$contentCV)[unique=true];;;
    ;;BodyContent-gigya-checkout-login;BodyContent;;BodyContent-gigya-checkout-login;;;
    ;;BottomContent-gigya-checkout-login;BottomContent;;BottomContent-gigya-checkout-login;;;


    ###### Gigya Profile Page
    # ContentSlot

    INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef);;;
    ;;SideContent-gigya-profile;Side Content Slot for Gigya Profile;true;;;;
    ;;BodyContent-gigya-profile;Body Content Slot for Gigya Profile;true;GigyaRaasComponentForProfileUpdate;;;


    # ContentSlotForPage
    INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true][default='gigya-profile'];contentSlot(uid,$contentCV)[unique=true];;;
    ;;SideContent-gigya-profile;SideContent;;SideContent-gigya-profile;;;
    ;;BodyContent-gigya-profile;BodyContent;;BodyContent-gigya-profile;;;


    INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;target(code)[default='sameWindow']
    ;;GigyaProfileLink;GigyaProfileLink;/my-account/gigya-profile;GigyaProfileLink;


    # Remove all navigation nodes and re add them for correct ordering
    REMOVE CMSNavigationNode;uid[unique=true];$contentCV[unique=true];name;parent(uid, $contentCV);links(&linkRef);&nodeRef
    #Root node is already added... 
    ;PersonalDetailsNavNode;;Personal Details;MyAccountNavNode;;PersonalDetailsNavNode
    ;UpdateEmailNavNode;;Update Email;MyAccountNavNode;;UpdateEmailNavNode
    ;ConsentManagementNavNode;;Consent Management;MyAccountNavNode;;ConsentManagementNavNode
    ;ChangePasswordNavNode;;Change Password;MyAccountNavNode;;ChangePasswordNavNode


    # create navigation root node for my account & child nodes for the root node 
    INSERT_UPDATE CMSNavigationNode;uid[unique=true];$contentCV[unique=true];name;parent(uid, $contentCV);links(&linkRef);&nodeRef
    #Root node is already added... 
    ;GigyaProfileNavNode;;Gigya Profile;MyAccountNavNode;;GigyaProfileNavNode


    # create cms navigation entry for nvaigation child nodes
    INSERT_UPDATE CMSNavigationEntry;uid[unique=true];$contentCV[unique=true];name;navigationNode(&nodeRef);item(&linkRef);
    ;GigyaProfileNavNodeEntry;;GigyaProfileNavNodeEntry;GigyaProfileNavNode;GigyaProfileLink;


    ### RAAS Component Creation
    INSERT_UPDATE GigyaRaasComponent;$contentCV[unique=true];uid[unique=true];name;visible;embed;containerID;screenSet;startScreen;showAnonymous;showLoggedIn;profileEdit[default=false];&componentRef
    ;;GigyaRaasComponentForLogin;Gigya Raas Component for Login;true;true;login-container;Default-RegistrationLogin;gigya-login-screen;true;false;;GigyaRaasComponentForLogin
    ;;GigyaRaasComponentForProfileUpdate;Gigya Raas Component for profile update;true;true;update-container;Default-ProfileUpdate;gigya-update-profile-screen;false;true;true;GigyaRaasComponentForProfileUpdate


    # CMS Link Components
    UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];linkName[lang=$lang]
    ;;GigyaProfileLink;"Profile Details"


    # CMS Navigation Nodes
    UPDATE CMSNavigationNode;$contentCV[unique=true];uid[unique=true];title[lang=$lang]
    ;;GigyaProfileNavNode;"Profile Details"


    #### Content for Spartacus like SiteLink slots etc ####

    INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;&componentRef;target(code)[default='sameWindow'];restrictions(uid,$contentCV)
    ;;HelpLink;Help Link;/faq;HelpLink;HelpLink;
    ;;ContactUsLink;Contact Us Link;/contact;ContactUsLink;ContactUsLink
    ;;WishListLink;Wish List Link;/my-account/wishlist;WishListLink;WishListLink;;loggedInUser
    ;;OrdersLink;Orders Link;/my-account/orders;OrdersLink;OrdersLink;;loggedInUser


    INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
    ;;SiteLinksSlot;Slot contains some links;true;OrdersLink,WishListLink,StoreFinderLink,ContactUsLink,HelpLink


    INSERT_UPDATE ContentSlotName;name[unique=true];template(uid,$contentCV)[unique=true];validComponentTypes(code);compTypeGroup(code)
    ;SiteLinks;GigyaLoginPageTemplate;CMSLinkComponent;;


    INSERT_UPDATE ContentSlotForTemplate;$contentCV[unique=true];uid[unique=true];position[unique=true];pageTemplate(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true];allowOverwrite
    ;;SiteLinksSlot-GigyaLoginPage;SiteLinks;GigyaLoginPageTemplate;SiteLinksSlot;true



    ###### SiteContext Slot and Components ######
    INSERT_UPDATE CMSSiteContextComponent;$contentCV[unique=true];uid[unique=true];name;context(code);&componentRef
    ;;LanguageComponent;Site Languages;LANGUAGE;LanguageComponent
    ;;CurrencyComponent;Site Currencies;CURRENCY;CurrencyComponent

    INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
    ;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent

    INSERT_UPDATE ContentSlotName;name[unique=true];template(uid,$contentCV)[unique=true];validComponentTypes(code);compTypeGroup(code)
    ;SiteContext;GigyaLoginPageTemplate;CMSSiteContextComponent;;

    INSERT_UPDATE ContentSlotForTemplate;$contentCV[unique=true];uid[unique=true];position[unique=true];pageTemplate(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true];allowOverwrite
    ;;SiteContextSlot-GigyaLoginPage;SiteContext;GigyaLoginPageTemplate;SiteContextSlot;true
    ```

### Configuring Spartacus for SAP Customer Data Cloud Integration

Perform the following steps after you have set up your Spartacus Storefront. For more information, see [Building the Spartacus Storefront from Libraries](https://sap.github.io/spartacus-docs/building-the-spartacus-storefront-from-libraries/).

1. Install the SAP Customer Data Cloud Integration library by running the following command from within the root directory of your storefront application:

    ```bash
    npm i @spartacus/cdc
    ```

2. Import the `CdcModule` by adding the following line below the existing import statements at the top of `app.module.ts`:

    ```ts
    import { CdcModule } from '@spartacus/cdc';
    ```

3. Add the `CdcModule` to `app.module.ts`.
    The following is an example:

    ```ts
    @NgModule({
      imports: [
        CdcModule.forRoot({
            cdc: [
                {
                    baseSite: 'electronics-spa',
                    javascriptUrl: 'https://cdns.<data-center>.gigya.com/JS/gigya.js?apikey=<Site-API-Key>',
                    sessionExpiration: 120,
                },
            ],
        }),
        ...
    ```

    The following is a summary of the parameters of the `CdcModule`:

    - **baseSite** refers to the CMS Site that the Customer Data Cloud Site configuration should be applied to. The same should be configured in SAP Commerce Cloud Backoffice as well.

    - **javascriptUrl** specifies the URL of the Web SDK that you wish to load. This is constructed using the value of the Site API Key, and the data center where the Customer Data Cloud site is created. For example, `https://cdns.<data-center>.gigya.com/JS/gigya.js?apikey=<Site-API-Key>`

    - **sessionExpiration** is the time (in seconds) that defines the session expiry of the SAP Customer Data Cloud session. This should match with the session expiration time of the OAuth Client to ensure that both the Customer Data Cloud session and the SAP Commerce Cloud token live for the same time.

4. Build and start the storefront app to verify your changes.
