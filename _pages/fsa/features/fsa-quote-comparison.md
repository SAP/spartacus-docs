---
title: FSA Quote Comparison
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

The Quote Comparison feature allows insurance customers to compare quotes of the same category. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The main idea of this feature is to enable customers to see the differences between quotes before deciding which to choose. 
In the default implementation, the customer can compare up to three quotes from the same product category, but this number is configurable. 
After comparing quotes and choosing one, the customer proceeds with the checkout process for the chosen quote.

## Selecting Quotes for Comparison

The customer can start quote comparison from two pages:
- the **Quote & Applications** page of the **My Account** area
- the **Quote Details** page

### Selecting Quotes from Quote & Applications Page

On the Quotes & Applications page, there are three main actions that the customer can do: 

1. **Filter Quotes** - Initially all quotes are visible. Filtering helps customers to quickly find the ones needed for comparison. Customers can filter quotes by category (Auto, Travel, Renewal Quotes, etc.).
2. **Compare Quotes** - Disabled until the customer selects two quotes for comparison. This action redirects the customer to the Quote Comparison page.
3. **Clear All** - Disabled until the customer selects at least one quote. This action resets all selected quotes.

Below is an illustration of the default state (disabled) and the active state (enabled) for all three actions.

![CTAs - Default State]({{ site.baseurl }}/assets/images/fsa/quote-comparison/CTAs-default-state.png)
![CTAs - Active State]({{ site.baseurl }}/assets/images/fsa/quote-comparison/CTAs-active-state.png)

Each quote card contains a checkbox named 'Select/Deselect', which allows the user to choose quotes. 
Selecting one card of a specific category disables checkboxes on quotes from other categories. 
Also, selecting three cards from the same category disables all other cards from that category.

![Disabled State of the Checkbox]({{ site.baseurl }}/assets/images/fsa/quote-comparison/comparing-quotes-4th-disabled.png)

Next to each checkbox title, there is an info tooltip, with the purpose to inform the user about the required behavior for quote comparison.

![Checkbox Tooltip Info]({{ site.baseurl }}/assets/images/fsa/quote-comparison/checkbox-tooltip.png)

### Selecting Quotes from Quote Details Page

As previously mentioned, the customer can initiate the quote comparison from the Quote Details page as well.

By clicking the **DETAILS** button on the quote card from the Quotes & Applications page, the user is redirected to the Quote Details page to see an overview of the relevant information for the chosen quote.
Beside retrieving the quote, the user can also choose to compare it with another quote of the same product category. 

![Compare Button on the Quote Details Page]({{ site.baseurl }}/assets/images/fsa/quote-comparison/quote-details-compare-button.png)

By clicking the **COMPARE** button, the user is redirected back to the Quotes & Applications page, where they can select other quotes for comparison. 
The quote whose details the user was seeing previously is already selected. 

## Quote Comparison Page Contents

After selecting quotes for comparison, the customer clicks the **COMPARE** button and is redirected to the Quote Comparison page. 
In the default implementation, the quotes information is divided into following sections for easier comparison:

1. Quote General Information
2. Quote Billing Events
3. Quote Optional Extras

The customer can see the differences between quotes and decide which one is better. 
The customer then selects the desired quote by clicking the **SELECT QUOTE** link. 
The link guides the customer to the checkout process where they can complete the purchase.

![Selecting Quote]({{ site.baseurl }}/assets/images/fsa/quote-comparison/quotes-comparison-travel-full-page.png)


## Configuration

The content of the Quote Comparison page can be configured to suit the company's needs. 
To accomplish that, you need to set a configuration file:

```ts
export function fsDefaultQuoteComparisonConfigFactory(): QuoteComparisonConfig {
  return {
    categoryConfig: [
      {
        categoryCode: 'insurances_auto',
        visibleInsuredObjects: [
          'vehicleMake',
          'vehicleModel',
          'vehicleType',
          'vehicleYear',
          'vehicleAnnualMileage',
          'vehicleValue',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_travel',
        visibleInsuredObjects: [
          'tripDestination',
          'tripStartDate',
          'costOfTrip',
          'tripEndDate',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_savings',
        visibleInsuredObjects: [
          'contributionFrequency',
          'contribution',
          'annualContributionIncrease',
          'retirementAge',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_property_homeowners',
        visibleInsuredObjects: [
          'propertyType',
          'propertyValue',
          'ccaBuiltYear',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_property_renters',
        visibleInsuredObjects: [
          'propertyType',
          'propertyValue',
          'ccaBuiltYear',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_life',
        visibleInsuredObjects: [
          'lifeCoverageRequire',
          'lifeCoverageLast',
          'lifeMainDob',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'banking_current_account',
        visibleInsuredObjects: ['accountType', 'debit-card-design'],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'banking_credit_card',
        visibleInsuredObjects: ['debit-card-design', 'minimum-card-amount'],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'banking_loans',
        visibleInsuredObjects: [
          'loan-amount',
          'loan-term',
          'repayment-frequency',
          'loanPurpose',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'banking_fixed_term_deposit',
        visibleInsuredObjects: [
          'term-amount',
          'deposit-term',
          'maturity-option',
        ],
        billingEvents: true,
        optionalProducts: true,
      },
      {
        categoryCode: 'insurances_event',
        visibleInsuredObjects: [],
        billingEvents: true,
        optionalProducts: true,
      },
    ],
  };
}
```

Function `fsDefaultQuoteComparisonConfigFactory` returns the object of the `QuoteComparisonConfig` type:

```typescript
export abstract class QuoteComparisonConfig {
  categoryConfig?: CategoryComparisonConfig[];
}
 
export class CategoryComparisonConfig {
  categoryCode: string; // represents category code of the product
  billingEvents: boolean; // responsible for visibility of the billing events accordion on the quote comparison page
  optionalProducts: boolean; // responsible for visibility of the optional products accordion on the quote comparison page
  visibleInsuredObjects: string[]; // represents all properties from insured objects displayed in the General Information accordion on the quote comparison page
}
```

