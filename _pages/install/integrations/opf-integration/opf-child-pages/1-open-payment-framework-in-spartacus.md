---
title: Open Payment Framework in Spartacus
---

If you have not already done so, you need to configure open payment framework in SAP Commerce Cloud before integrating with Spartacus. For more information, see [Open Payment Framework](link to backend docs).

Any other intro/overview/requirements?

## Enabling Open Payment Framework in Spartacus

To enable open payment framework, install the `@spartacus/opf` integration library (???). For more information, see [Installing Additional Composable Storefront Libraries](link).

### CMS Components

Are there any "base" CMS components that are part of OPF, that are included in the sample data and get set up now, regardless of which features you install? Or do all components get set up later, such with Onsite Messaging and QuickBuy?

<!-- Sample text (taken from _pages/dev/features/scheduled-replenishment.md)

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the scheduled replenishment feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section. -->

### Adding the CMS Components Manually

If there are "base" CMS components described in the section, then we would include ImpEx here to show partners how to set up their own components, since they won't actually use sample data when setting up their own storefront app.

<!-- Sample text!! Verify that it is accurate if you decided to include it!! (taken from _pages/dev/features/scheduled-replenishment.md)

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

The following procedure describes how to enable open payment framework components, which is necessary if you are not using the `spartacussampledata` extension to build your storefront. -->

Provide ImpEx examples here...

## Configuring Open Payment Framework

For open payment framework to work with your preferred payment provider, you need to configure the following:

<!-- Feel free to replace the above sentence -- it's just a placeholder intro sentence -->

- Routing URL
- baseURL
- OpfServerUrl
- googlePayApiUrl (if you are using GooglePay)

### Configuring the Routing URL

Brief introduction that describes what the routing URL is, or why you need to configure it. Is it optional? If so, describe when you should configure it, or when not to. Also describe any prerequisites, such as procedures that need to be completed before starting this procedure, or values you need to know before starting the procedure (for example, maybe you need to do some sort of configuration with the payment provider first).

### Configuring the baseURL

Brief introduction that describes what the baseURL is, or why you need to configure it. Is it optional? If so, describe when you should configure it, or when not to. Also describe any prerequisites, such as procedures that need to be completed before starting this procedure, or values you need to know before starting the procedure (for example, maybe you need to do some sort of configuration with the payment provider first).

### Configuring the OpfServerUrl

Brief introduction that describes what the OpfServerUrl is, or why you need to configure it. Is it optional? If so, describe when you should configure it, or when not to. Also describe any prerequisites, such as procedures that need to be completed before starting this procedure, or values you need to know before starting the procedure (for example, maybe you need to do some sort of configuration with the payment provider first).

### Configuring googlePayApiUrl

Brief introduction that describes what the googlePayApiUrl is, or why you need to configure it. Is it optional? If so, describe when you should configure it, or when not to. Also describe any prerequisites, such as procedures that need to be completed before starting this procedure, or values you need to know before starting the procedure (for example, maybe you need to do some sort of configuration with the payment provider first).

## Configuring Checkout

Intro. What do we need to know before configuring the checkout? The original outline suggested describing checkout patterns here.

### CMS Components for Checkout

<!-- Sample text (taken from _pages/dev/features/scheduled-replenishment.md)

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the scheduled replenishment feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section. -->

### Adding the Checkout CMS Components Manually

<!-- Sample text!! Verify that it is accurate if you decided to include it!! (taken from _pages/dev/features/scheduled-replenishment.md)

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

The following procedure describes how to enable checkout components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront. -->

Provide ImpEx examples here...

### Configuring Payment Option Info message

For accessibility purpose, when selecting a payment option, an info message explaining briefly the payment behavior is displayed.
It is visible by default with a default label:
opfCheckout.defaultPaymentInfoMessage:
"You are about to make a payment. Depending on the option selected, you will either be redirected to a secure external page or complete the process directly within this page"

Label are customizable for each payment options witch config
opf:{paymentOption?:  
 paymentInfoMessagesMap: {
213: 'opfCheckout.payPalPaymentInfoMessage' // Message key for payment method ID 213
}
enableInfoMessage: true
}

The mapping is done with configuration Id of Payement Provider (213 from above example). This value can be found in Opf workbench.

Toggling visibility
For all payment options:
Payment Info message cane be disbale for all payment options by setting
enableInfoMessage:false form above config

For specific payment option
By setting empty label, Info Message won't be displayed, eg:
213:''

### Configuring (or Using, or Working With, or Setting Up) the Checkout Orchestrator

Checkout orchestrator was listed in the original outline suggestions. If this is a topic that can stand on its own (a bit separate from checkout) then it can be made in a "level 2" header, with sub-headers and procedure (intro section, followed by "configuring checkout orchestrator", etc).

## Configuring Terms and Conditions

Two modes are available for Terms and conditions on 'Opf Checkout payment & review' page:

- explicit T&C shows a checkbox and info message on top of the page. Payment options become enabled (otherwise greyed-out) only after user accepts T&C by checking the box.
- Implicit T&C only displays an info message on top of Checkout review step, payment options are always enabled. it is the mode by default.

Switch between modes is CMS based, Spartacus detects the presence of OpfExplicitTermsAndConditionsComponent within the CMS page. If it is not present, implicit mode is displayed.
It explains why the CMS Component as property visible set to false in below impex.
To switch to Explicit mode, set the visible property as true. It can be done at anytime on backoffice UI.

### CMS Components for Terms and Conditions

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the scheduled replenishment feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section.

### Adding the Terms and Conditions CMS Components Manually

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

The following procedure describes how to enable terms and conditions components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent

## Extending Open Payment Framework

Is there anything more that partners can do with OPF to extend its functionality at a base level? If not, we can just say "No special extensibility available for this feature."
