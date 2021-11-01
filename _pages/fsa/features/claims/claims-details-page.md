---
title: Claims Details Page
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries.

The Claims Details page allows financial customers to view all the details related to their claim on a separate page in the **Claims** section of the **My Account** area.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Accessing the Claims Details Page

The customer can preview their claims in the **Claims** section of the My Account area. Each claim is displayed as a card, similar to other sections of My Account (e.g. Quotes and Applications, Policies). The claims card contains general information about the claim, such as incident type, claim and policy numbers, claim handler's name and email address, date of loss. When the user clicks the Details button on the claim card, a separate Claim Details page opens. 

**Note**: In the current implementation, the claim process is enabled for Auto Insurance.  

![Claims section in the My Account area]({{ site.baseurl }}/assets/images/fsa/claims/claims_section_in_my_account.png)  


## Claims Details Page Contents

### Non-integration Scenario

On the Claims Details page, the customer can see:
- General information, the same as the one on the card  
- List of documents connected with the claim, which can be downloaded  

![Claims Details page without integrations]({{ site.baseurl }}/assets/images/fsa/claims/claims_details_page.png)

### Integration Scenario

When a claim request submitted over Financial Services Accelerator reaches SAP Claims Management, a claim is created if all data is valid. The claim-related information is then sent back to Financial Services Accelerator as a response to the claim request call. Same as in the non-integration, customers can see all their claims reported to SAP Claims Management (FS-CM) or other back-end systems under the **Claims** section of **My Account** area.  

Besides general information and documents, in the integrated scenario, the Claims Details page can also contain:

- List of sub-claims with payment details
- List of roles and persons involved

![Claims Details page with integrations]({{ site.baseurl }}/assets/images/fsa/claims/claims_details_roles_accordion.png)


#### Sub-claim Information

The customer can have more than one sub-claim associated with a single claim. Each sub-claim is presented in a separate accordion and contains information about the sub-claim type and status, the claimant's name, as well as a list of performed financial transactions with payment details. 

![Sub-claims in the integrated scenario with SAP Claims Management: main claim and two sub-claims]({{ site.baseurl }}/assets/images/fsa/claims/claims_details_page_integrations_subclaims.png)


#### Roles and Persons Involved

A list of all persons involved in a claim can also be presented on the Claims Details page. For each person, the following information is displayed: 

- Role (e.g. policyholder, claimant, payee)
- Name 
- Address
- Phone number 

![Roles section on the Claims Details page]({{ site.baseurl }}/assets/images/fsa/claims/claims_details_page_roles_section.png) 