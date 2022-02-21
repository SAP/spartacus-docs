---
title: Technical Changes in TUA Spartacus 3.1
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Components and Methods-related Changes Introduced in 3.1

### TmaCartPriceService

#### Remove Method

| Method Name       | Description                                             |
| ----------------- | ------------------------------------------------------- |
| getMaximumTierEnd | Returns the maximum tier ending for the provided prices |

#### New Method

| Method Name                  | Description                                                                                                                         |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| calculatePrice               | Returns the final price after applying alterations (TmaPrice has one time $10, and has alterations of $2, so the final price is $8) |
| calculateTotalDiscount       | Returns the total discount applied on a price (OriginalPrice is 10, and has discountedPrice is 8, so total discount available is 2) |
| computePayOnCheckoutDiscount | Returns the price discount applied on `payOncheckout` charge                                                                        |
| flattenPriceTreeWithDiscount | Transforms the price and price alteration composite structure to a simplified array of prices with alterations                      |
| getCycledPriceAlterations    | Returns a list of all alternations for a charge, if any alternation has a cycle attached                                            |
| getFormattedPrice            | Returns the formatted form of the price provided (as $ 15.00) currency is appended                                                  |

### TmaPriceService

#### Remove Methods

| Method Name                         | Description                                                                                           |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------- |
| getAverageCostPerMonth              | Returns the average cost per month based on the consumption and term provided                         |
| getAverageCostPerYear               | Returns the average cost per year based on the consumption and term provided                          |
| getEachRespectiveTierUsagePrices    | Returns a list that contains only the each respective tier usage charges                              |
| getFormattedContractTerm            | Returns the formatted form of the contract term provided                                              |
| getHighestApplicableTierUsagePrices | Returns a list that contains only the highest respective tier usage charges                           |
| getMaximumTierEnd                   | Returns the highest tier end for the prices provided                                                  |
| getMinimumPrice                     | Returns the minimum price of a product                                                                |
| getNotApplicableUsagePrices         | Returns a list that contains only the per unit usage charges, which do not have a `usageType` defined |
| getUsageUnits                       | Returns the usage units for the product provided                                                      |
| getVolumeUsagePrices                | Returns a list that contains only the volume usage charges                                            |

#### New Method

| Method Name                   | Description                                                                                                                    |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| calculatePrice                | Returns the cumulative sum of prices after alternations                                                                        |
| calculateTotalDiscount        | Return the total discount applied on a price (OriginalPrice is 10, and discountedPrice is 8, so total discount available is 2) |
| getCycledPriceAlterations     | Returns a list of all alternations for a price, if any alternation has a cycle attached                                        |
| getDiscounts                  | Returns a list of discount charges for product offering prices                                                                 |
| getHighestPriorityPriceForSPO | Returns the highest priority price of an SPO product                                                                           |
| getUsagePrices                | Returns a list that contains usage product offering prices                                                                     |
| sumOfCharges                  | Returns the sum of the charges with discounts filtered out                                                                     |

## Updated Components

### TmaProductSummaryComponent

This component extends the `ProductSummaryComponent` to display information about the prices of the product offering in the Product Details Page (PDP). It displays the price charges. For more information, see `TmaPriceDisplayComponent`.

**Note:** If a product offering has multiple prices, highest priority pricing is used to determine the price.

### TmaProductDetailsTabComponent

This component extends the `ProductDetailsTabComponent` to display detailed prices of the product offering in the Product Details tab of the Product Details Page (PDP). The followings information is displayed:

- Contract Duration: `<contract term name>`

For example, Contract Duration: 12 Months - monthly billing.

**Note:** If a product offering does not have a contract term, recurring prices, or usage charges, this section will not be displayed. No charges will be shown in this component. All product charges are shown in a price tree in the product summary component.

### TmaProductListItemComponent

This component extends the `ProductListItemComponent` to display information about the prices of the product offering in the `Product Grid Item` page. It displays the price charges. For more information, see `TmaPriceDisplayComponent`.

### TmaProductGridItemComponent

This component extends the `ProductGridItemComponent` to display information about the prices of the product offering in the `Product Grid Item` page. It displays the price charges. For more information, see `TmaPriceDisplayComponent`.

### TmaUsageChargeComponent

This component displays the usage charge details in the product pages in the following format:

`<value><currency>/<usageUnit> for <cycle start> to <cycle end> <usageUnit>`

For example, Inside "Per Minutes Charges (Charged By Each Respective Tier)" TmaPriceDisplayComponent, Usage Charge as 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan.

### TmaOneTimeChargeComponent

This component displays the one time charges in the product pages in the following format:  

`<value><currency> <billingEvent>`

For example, Inside "Activation Charges" TmaPriceDisplayComponent, One Time Charge as 50.0 $ On Checkout for Product signatureUnlimitedPlan.

### TmaRecurringChargeComponent

This component displays the recurring charges in the product pages in the following format:

`<value><currency> <billingEvent>`

For example, Inside "Service Charges" TmaPriceDisplayComponent, Recurring Charges as 50.0 $ monthly for the signatureUnlimitedPlan product.

### CartItemOneTimeChargeComponent

This component displays one time charges on the cart item in the following format:

`<value><currency> <billingEvent>`

For example, one time charge of 50.0 $ On Checkout for Product signatureUnlimitedPlan.

### CartItemRecurringChargeComponent

This component displays the recurring charges on the cart item in the following format:

`<value><currency> <billingEvent>`

For example, recurring charges of 50.0 $ monthly for Product signatureUnlimitedPlan.

### CartItemUsageChargeComponent

This component displays the usages charges on the cart item in the following format:

`<value><currency> /<usageUnit> for <cycle start> to <cycle end> <usageUnit>`

For example, usage charge of 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan.

### TmaCartItemComponent

This component displays the details of the cart items in the following format:

`<discounted value>`

For example, $50 $32 for Product signatureUnlimitedPlan.

The component is updated to show pay now prices with alterations if applicable and it has modified the display of the appointment details to move at the cart entry level. For more information, see `TmaCartItemListComponent`.

### TmaAddedToCartDialogComponent

This component is added to the cart dialog to show the entries added to the cart. It is updated to show the formatted "pay now" price of the cart for composite pricing and to include the `AppointmentDetailsComponent` in the `Add to Cart` dialog.

### TmfProductComponent

This component displays the prices of the subscription order. It is updated to include the `TmaCartItemPriceDisplayComponent`.

### TmaGuidedSellingProductGridItemComponent

This component displays product details in a grid. It is updated to include price display component. The followings is displayed: Price Charges. For more information, see `TmaPriceDisplayComponent`.

### TmaGuidedSellingProductListItemComponent

This component that displays product details in a list. It is updated to include price display component. The followings is displayed: Price Charges. For more information, see `TmaPriceDisplayComponent`.

### TmaGuidedSellingCurrentSelectionComponent

This component displays the **Add to Cart** button for a BPO, which calls the checklist action and opens the checklist action stepper if any checklist actions for the Appointment or the Installation Address are present. If multiple products require Installation Address and/or Appointment, the user is prompted to provide one-time information, so that the same information is copied for similar other products, which require Installation Address and/or Appointment.

### TmaGuidedSellingAddedToCartDialogComponent

The guided selling is added to the cart dialog to show the entries added to the cart. It is updated to show the formatted "pay now" price of the cart for composite pricing. The component is updated to display the `AppointmentDetailsComponent`. For more information, see `AppointmentDetailsComponent`.

### JourneyChecklistStepComponent

This component is updated to include:

- The `JourneyChecklistInstallationAddressComponent`.
- The **Next** Button To save the address in the address book of the user and navigate to the next step, which can be either **Add to Cart** or the selecting an appointment.

### JourneyChecklistAppointmentComponent

This component displays the available time slots to the customer.

- The **Please Call to Schedule** option is selected by default.
- The other values are in the following format: Month Date, Year Time (AM/PM). For example, Sept 9,2020 12:00 PM.

### AppointmentComponent

This component displays the displays the appointment details in the order page, order-history page, cart summary page, and on the cart pop-up in the following format:

`Appointment: Month Date, Year Time (AM/PM)`

For example: Appointment: Sept 9,2020 12:00 PM or Appointment: Please Call to Schedule.

**Contract Duration:** The contract duration is displayed in the "Appointment: Month Date, Year Time (AM/PM)" format. For example, Appointment: Sept 9,2020 12:00 PM or Appointment: Please Call to Schedule.

### TmaCartItemListComponent

This component is updated to include the `AppointmentDetailsComponent` on the cart entry level.

- For SPO, it displays at the Cart or the Order Entry Level.
- For BPO, it displays at the BPO level.

### TmaAddToCartComponent

This component displays the **Add to Cart" button, which is enhanced to call checklist actions, and open checklist action stepper if any checklist actions for the Appointment or the Installation Address are present.

## New Components

### TmaPriceDisplayComponent

This component displays prices in the product pages. It includes subsequent product charge types components in the following format:

`<POP Name> (In Case No <UsageType>) is present`

For example, Activation Charges for Product signatureUnlimitedPlan.

`<POP Name> (Charged By <UsageType> if UsageType is present)`

For example, Per MB charges (charged by highest applicable tier) for the signatureUnlimitedPlan product.

It displays all the usage charges, such as:

- one time charges. For more information, see `TmaOneTimeChargeComponent`.
- recurring charges. For more information, see `TmaRecurringChargeComponent`.
- usage charges. For more information, see `TmaUsageChargeComponent`.
- alteration charges. For more information, see `TmaAlterationDetailsComponent`.

### TmaAlterationDetailsComponent

This component displays alteration charges in the product pages in the following format:

`-<value><currency> OFF <billingEvent> : Without Cycle`

For example, A-10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan or -20.0 % OFF On Checkout for Product signatureUnlimitedPlan.

`-<value><currency> OFF <billingEvent>  for <cycle start> to <cycle end>:  With Cycle`

For example, -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan.

### TmaCartitemPriceDisplayComponent

This component displays prices on the cart. It includes subsequent cart charge types components, such as Hierarchical Price in case:

`No (<UsageType>) is present`

For example, Hierarchical Price for the product signatureUnlimitedPlan if added in the Cart Hierarchical Price:

`(Charged By <UsageType>) if UsageType is present`

For Example:  Hierarchical Price (Charged By Each Respective Tier) for Product signatureUnlimitedPlan if Added in Cart.

It displays all usage charges for:

- one time charges. For more information, `CartItemOneTimeChargeComponent`.
- recurring charges. For more information, `CartItemOneTimeChargeComponent`.
- usage charges. For more information, `CartItemOneTimeChargeComponent`.
- alteration charges. For more information, `CartItemOneTimeChargeComponent`.

### CartItemAlterationsDetailsComponent

This component displays alteration charges on the cart pages in the following format:

`-<value><currency> OFF <billingEvent> : Without Cycle`

For example: -10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan or -20.0 % OFF On Checkout for Product signatureUnlimitedPlan.

`-<value><currency> OFF <billingEvent>  for <cycle start> to <cycle end>:  With Cycle`

For example: -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan.

### JourneyChecklistInstallationAddressComponent

This component wraps the `TmaAddressFormComponent` for the checklist pertaining to the installation address. It is intended for populating the address while editing.

### InstallationAddressComponent

This component displays the installation address details in the Order page, Order History page, Cart summary, and Cart pop-up. The
"Installation Address" details contains: Building Number, Street Name, City, State or Province (Optional), Country, and Postal Code.

### AppointmentDetailsComponent

This component is a wrapper for the `AppointmentComponent` and `InstallationAddressComponent`. It is responsible for editing an appointment, hence has an **Edit** icon.

### TmaAddressFormComponent

This components is used for populating address details, such as House/Building Number, Street, Apartment/Unit/Suite(Optional), City, Country, State/Province (appears only if the country is United States), and Zip/Postal code.

## Removed Components

1. TmaProductFacetNavigationComponent
2. TmaVolumeChargeComponent
3. TmaPerUnitChargeCo

For more information, see [Updating to Version 2.0]({{ site.baseurl }}{% link _pages/telco/updating-tua-spartacus-to-2.md %}).