---
title: Technical Changes in TUA Spartacus 4.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Detailed List of Changes in 4.0

### API Endpoints

-   `tma-spartacus-b2c-configuration.module`
-   `tma-spartacus-b2b-configuration.module` 
-   In 3.2.0, the endpoints are in `app.module.ts`

### Recipes

The Recipes folder now includes separate recipes for B2b and B2c.

### Items Removed

Following items are removed: 
-   `tma-storefront.module`
-   `tma-storefront-foundation.module`
-   `tma-b2c-storefront.module`

### Files Added

### B2c
-   `tma-spartacus.module`
-   `tma-spartacus-b2c-features.module`
-   `tma-spartacus-b2c-configuration.module`

### B2b
-   `tma-b2b-spartacus.module`
-   `tma-spartacus-b2b-configuration.module`
-   `tma-spartacus-b2b-features.module`

### New Features Added

-   `tma-asm-feature.module`
-   `tma-checkout-feature.module`
-   `tma-user-feature.module`

### New Routing Module Added

The `app-routing.module` is added. Before the addition of new module, these were part of `tma-storefront.module.ts`

1.  Add the following import in the file:
```bash
    import { NgModule } from '@angular/core';    
    import { RouterModule } from '@angular/router';
```
1.  Configure the Ng modules in your `AppModule` 
    ```ts
    @NgModule({
      imports: [
        RouterModule.forRoot([], {
            anchorScrolling: 'enabled',
            relativeLinkResolution: 'corrected',
            initialNavigation: 'enabled',
        }),
      ],
    })
        export class AppRoutingModule {}  
    ```


## Components and Methods-related Changes Introduced in 3.0

### TmfEndpointsService

#### Remove Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| getRawEndpoint | Returns the endpoint starting from the TMF baseUrl (no base site ) |

### TmfEndpointsService

#### New Methods

| Method Name                  | Description                                                                                                                         |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| getEligibleSubscriptionTerms               | Returns the eligible subscription terms |
| getHighestPriorityPriceContext       | Returns the highest priority price context for the selected term |
| getEachRespectiveTierUsagePrices | Returns a list that contains only the respective tier usage charge                                                                        |
| getHighestApplicableTierUsagePrices | Returns a list that contains only highest applicable tier usage charges                      |
| getVolumeUsagePrices    | Returns a list that contains only the usage charges without usage type                                            |
| getAverageCostPerMonth            | Returns the average cost per month based on the consumption and term provided                                                  |
| getAverageCostPerYear                | Returns the average cost per year based on the consumption and term |
| getFormattedContractTerm                | Returns the formatted form of the contract term |
| getUsageUnits                | Returns the usage units of the product |
| getStandalonePrices                | Returns the standalone prices of the product |

### TmfEndpointsService

#### Removed Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| getTmfProductMap | Returns `tmfProductMap` of the given product Id |

#### New Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| getbaseEndpointWithDefaultVersion | Returns base URL of the provided endpoint |

### TmaChecklistActionService

#### New Methods

| Method Name                         | Description                                                                                           |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------- |
| getChecklistActionsFor                         |
| getAverageCostPerYear               | Returns checklist actions for multiple product offerings based on process type                          |

### AppointmentService

#### New Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| cancelAppointment  | Returns cancelled appointment |

### TmaCartPriceService

#### New Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| getMaximumtierEnd   | Returns the maximum tier ending for the provided prices |
                                         |

                                                                    |

## Updated Components

### TmaAddToCartComponent

This component is responsible to add an SPO to the cart. If the product offering requires the checklist actions to be performed then:

- The **Add to Cart** button is disabled and unless all the configured checklists are fulfilled, the button remains disabled.
- A customer is promoted to login to add a product to the cart.

Added a spinner in the **Add to Cart** button, so that the user can click only once and background process is completed.

### TmaGuidedSellingCurrentSelectionComponent

The **JourneyChecklistStepComponent** is removed from this component. Now the user is not prompted to fulfil the checklist actions upon adding a BPO to the cart from the configurable guided selling journey.

### TmaAddressFormComponent

An input `hasError` is added. This *Boolean* field controls the visibility of the address form. If any server error or serviceability error occurs, the error is shown instead of the form.

### TmaAddedToCartDialogComponent

A public methods `entryHaveInstallationDetails` and `AppointmentDetailsComponent` are removed. 

### TmaCartItemListComponent

The attribute `cartPage` is renamed to `showEdit`. 

**Note:** The *Boolean* attributes decide if an `edit` icon should be displayed or not. For example, the `installation address` is editable on the cart page, but not on the review order page.

### TmaCartItemComponent

When the `Cart` page is loaded, every cart entry is evaluated to check if it has a checklist actions or not. If an entry requires checklist actions; for example, MSISDN to be fulfilled, then suitable links `Add desired Phone Number` is shown. Similarly, suitable links for other checklist actions are also shown. Checklist actions that are fulfilled are displayed. The user can also update the checklist actions.

### TmaGuidedSellingAddedToCartDialogComponent

The `AppointmentDetailsComponent` is deleted. Now, when the BPO is added to the cart from the CGS journey, a user is not prompted to fulfill the checklist actions.

### TmaProductListItemComponent

In the `Product Listing Page (list view)`, if the product offering requires a checklist to be fulfilled, then instead of the current **Add to Cart** button, a user sees **See Details** button. The **See Details** button redirects a user to the `Product Details Page` in which, a user can configure the required checklist actions.

### TmaProductGridItemComponent

In the `Product Listing Page (grid view)`, if the product offering requires a checklist  to be fulfilled, then instead of the current **Add to Cart** button, a user sees **See Details** button. This **See Details** button redirects a user to the `Product Details Page` in which a user can configure the required checklist actions.

### TmaCartTotalsComponent

The **Checkout** button is disabled if the checklist actions are not fulfilled.
Note: The **Checkout** button is disabled only for the checklist actions that are configured in the `checklistActionTypes` array  that is defined in the config file. A customer can checkout the product offering if other checklist actions, which are not implemented and are not defined in the `checklistActionTypes` array.

### TmaProductListComponent

A `TmaProductListComponentService` is created by extending the `ProductListComponentService`. The public optional constructor `TmaProductSearchService` is added, so that if the product is serviceable, it shows the **Add to Cart** button instead of **See Details** button.

### JourneyChecklistInstallationAddressFormComponent

The `Region` field, `Country` field, and `Address` field information is now stored in the session storage instead of local storage.

### JourneyChecklistAppointmentFormComponent

The `Region` field, `Country` field, and `Address` field information is now stored in the session storage instead of local storage.

### TmaGuidedSellingProductListItemComponent

 A `TmaProductListComponentService` is created by extending the `ProductListComponentService`.

### SubscriptionDetailsComponent

 This component is updated to include the termination button component (See `TerminationButtonComponent`)  in case of subscribed product being eligible for termination.

### TmaOrderDetailItemsComponent

 This component is updated to show the details of the shipping status if the order has product entries.

### TmfProductComponent

 This component displays the subscribed product detail as play card on the frontend.

## New Components

### ServiceabilityFormComponent

This component wraps the `TmaAddressFormComponent`. The **Check Availability** button performs serviceability check for the product offerings. If a product offering is serviceable at the provided installation address then the product details dialog component is rendered. If a product offering is not serviceable at the provided installation address then an error message will be displayed.

### ServiceabilityBannerComponent

The Banner of the TUA Spartacus is configured with this component. It renders the banner image, product (SPO and BPO), and the button label information, which is configured in at the backend.

### ProductDetailsDialogComponent

When Serviceability check is successful then the `ProductDetailsDialogComponent` shows the product details along with the **Add to Cart** button. When the product offering is successfully added, the cart page is displayed.

### ServiceabilityButtonComponent

This component is handled from the backend by the `CMSFlexComponent` and `ServiceabilityButtonComponent`. It is placed on the header slot of the `BroadBandCategoryPage`.

- If the installation address is not specified then the user can click the **Check offerings available in your area** button and specify the installation address. This action opens the `ServiceabilityCategoryFormComponent` component.
 
- If the installation address is specified, the user can click the **Change Address** button that opens the `ServiceabilityCategoryFormComponent` with prepopulated existing address. The use can update a new address to check the serviceability of the selected product offering at the new installation address.

### ServiceabilityCategoryFormComponent

This component shows the `add address` form. It obtains the address from the address that is specified by the user and stores in the session storage.

The service qualification calls the address that is specified by the user. Check if the service qualification system is available and performs effective product search.

### TerminationButtonComponent

The **Terminate** button component enables the user to terminate the subscribed product if the selected product is eligible for termination. When the customer clicks the **Terminate** button, subscribed Id added to cart with the terminate process, default delivery address, and default delivery mode.

### TmaOrderDetailShippingComponent

This component displays shipping details in the order details page.

### TmaOrderOverviewComponent

This component displays payment and shipping data if the order has entries of the product.

### TerminationConfirmComponent

This component enables a customer to confirm termination of a subscription. Upon confirmation, the purchase journey is redirected to the order details page.

### RenewSubscriptionComponent

This component displays the renewal button with the renewal banner component. It adds the subscribed product to the cart entries with Retention process type. The label of the button is controlled by the hybris component `TmaRenewSubscriptionBannerComponent`.

### RenewSubscriptionBannerComponent

This component displays the renewal banner, eligible subscription terms and relevant applicable prices for retention if the customer is eligible for retention. The Angular web component is mapped with `TmaRenewSubscriptionBannerComponent` of Hybris.

### RenewSubscriptionBannerComponent

This component displays the renewal banner, eligible subscription terms and relevant applicable prices for retention if the customer is eligible for retention. The Angular web component is mapped with `TmaRenewSubscriptionBannerComponent` of Hybris.

The banner is displayed when the following conditions are fulfilled:
- Subscription base that is eligible for Retention
- Standalone price for retention
- Subscribed product is not part of any bundle

The banner displays the following:

- The media attached with the web component
- All eligible terms for retention process type in a drop-down.
- The highest priority price is displayed on the banner after selecting a particular subscription term. 
- The Renewal button to renew the subscription is displayed (see `RenewSubscriptionComponent` for more information)

### SubscriptionDetailComponent

This component displays all subscribed products and there details. The Angular web component is mapped with the `AccountSubscriptionDetailsComponent` of Hybris.

The component displays:
 
The Renew banner (See `RenewSubscriptionBannerComponent` for more information) 
All subscribed products information will be displayed as play cards (See `TmfProductComponent` for more details)

## Renamed Components

### JourneyChecklistLogicalResourceFormComponent

The `JourneyChecklistLogicalResourceComponent` is renamed to `JourneyChecklistLogicalResourceFormComponent`. It allows to add or update an  entry in an MSISDN:

- If an entry does not have an MSISDN then the component creates a reservation
- If an entry has MSISDN then the component allows to update reservation

### JourneyChecklistLogicalResourceDisplayComponent

The `LogicalResourceComponent` is renamed to `JourneyChecklistLogicalResourceDisplayComponent`. It prompts the customer to select the desired phone number, and opens the `JourneyChecklistLogicalResourceFormComponent`

If an MSISDN is already associated then it displays the selected MSISDN (Phone Number) with an edit icon.

### JourneyChecklistLogicalResourceDisplayComponent

The `LogicalResourceComponent` is renamed to `JourneyChecklistLogicalResourceDisplayComponent`. It prompts the customer to select the desired phone number, and opens the `JourneyChecklistLogicalResourceFormComponent`

If an MSISDN is already associated then it displays the selected MSISDN (Phone Number) with an edit icon.

### JourneyChecklistInstallationAddressFormComponent

The `JourneyChecklistInstallationAddressComponent` is renamed to `JourneyChecklistInstallationAddressFormComponent`.
This component performs the serviceability check for the product offering:

- If the product offering is serviceable from the product detail page then the address is saved.
- If the product offering is serviceable at the provided installation address on the cart page then the product offering can be added or updated to the cart; else, an error message is displayed.

### JourneyChecklistInstallationAddressDisplayComponent

The `InstallationAddressComponent` is renamed to `JourneyChecklistInstallationAddressDisplayComponent`.
This component prompts the customer to add the installation address and open `JourneyChecklistInstallationAddressFormComponent`. If the installation address is already specified, then it displays the installation address with an edit icon to edit or update the address.

### JourneyChecklistInstallationAddressDisplayComponent

The `InstallationAddressComponent` is renamed to `JourneyChecklistInstallationAddressDisplayComponent`.
This component prompts the customer to add the installation address and open `JourneyChecklistInstallationAddressFormComponent`. If the installation address is already specified, then it displays the installation address with an edit icon to edit or update the address.

### JourneyChecklistInstallationAddressDisplayComponent

The `JourneyChecklistAppointmentComponent` is renamed to `JourneyChecklistAppointmentFormComponent`.
This component allows to add or update an  entry with an appointment reference:
- If the entry has no appointment then the component creates an appointment
- If the entry has appointment then the component allows to update an appointment

### JourneyChecklistAppointmentDisplayComponent

The `AppointmentComponent` is renamed to `JourneyChecklistAppointmentDisplayComponent`.
This component prompts a customer to select an appointment and open the `JourneyChecklistAppointmentFormComponent`. If an appointment is already created then the component displays the appointment and the appointment address with an edit icon to edit or update the appointment.

## Removed Components

1. AppointmentDetailsComponent
2. JourneyChecklistStepComponent

For more information, see [Updating to Version 2.0]({{ site.baseurl }}{% link _pages/telco/updating-tua-spartacus-to-3.md %}).
