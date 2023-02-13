---
title: FSA User Request Framework
---

**Note**: This feature is introduced with version 1.0 of the FSA Spartacus libraries.

The User Request Framework is a flexible, lightweight framework for implementing various types of user requests, originating from the customer towards the company. 


***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The User Request framework is intended for light-weight request procedures, in which the definition of the process can be created and stored in the database, along with step definitions, all of which can be configured by the business user.
For more information, see [User Request Framework](https://help.sap.com/docs/FINANCIAL_SERVICES_ACCELERATOR/a7d0f0c5faa44002bf81e1a9a91c77e2/e565d508786748b2a752b4faccf860d2.html?version=latest) documentation on the SAP Help Portal.

## Use Cases

The framework is implemented on the FSA Spartacus storefront as part of the following processes: 

- **First Notice of Loss** - a process in which the user reports a claim directly on the insurance storefront. 
  The claim reporting process includes four sample steps that capture all the relevant information required for recording a loss event. 
  For more information on how the FNOL process is implemented on the FSA Spartacus storefront, see [Claims]({{ site.baseurl }}{% link _pages/fsa/features/claims/claims.md %}).
- **Policy Change** - a process in which the user modifies their existing insurance policy online. 
  Financial Service Accelerator provides several sample policy change processes out of the box, all of them based on the sample Auto Insurance product. 
  Users can easily change mileage, add or remove coverages, and/or add additional drivers to their policies through a guided step-by-step procedure. 
  For more information on how this feature is implemented in FSA Spartacus, see [Policy Change]({{ site.baseurl }}{% link _pages/fsa/features/fsa-policy-change.md %}).
 
Although the current implementation of the Financial Services Accelerator uses the User Request Framework for changing policies and reporting claims, it can be extended and used for other request types (contact request, service request, etc.). 
All user request processes are fully configurable in the Backoffice. 

## Financial Services Accelerator Trail - Customized FNOL Process 

The Financial Services Accelerator Customized FNOL Process Trail demonstrates how to create a new user request process in Financial Services Accelerator, using as an example the First Notice of Loss process for Travel Insurance.
For more information, see [Configurable FNOL Process]({{ site.baseurl }}{% link _pages/fsa/features/user-request-framework/fsa-configurable-fnol-process.md %}).