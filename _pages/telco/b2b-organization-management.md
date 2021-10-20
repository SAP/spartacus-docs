---
title: B2B Organization Management
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The feature allows B2B Administrators to view and edit the company structure and the entities related to the company. They will be able to manage their company-related activities such managing company’s units, employees, user groups, budgets, cost, and purchase limits. Administrators view and edit existing units, and also create new units within their company. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisite

To be updated...

## Business Need

Administrators need to manage their organization-related tasks whenever required. This feature enables Administrators to view and edit the company structure and the entities related to the company.

## Business Use Case

**Organization Structure**

Following diagram represents an organization structure that is grouped into different units and business units. The **Total Protect** is the main unit of the organization and is further structured into three different child units such as Coordination Center, Operation Center, and HR.

Each unit has separate users, who are employees of this organization, assigned to them. These users have different roles such as administrators or approvers or customers. In some cases, the user will have multiple roles such as an administrator and / or an approver. Such users are visible in the dashboard of the organization management that is accessible by the administrator who in turn can assign users to different units or can assign different roles to different users.

Apart from the units and roles of users, there is also cost center and budgets that can be assigned to any on the units listed. The cost center or budgets could have been defined by either of these units. The company administrator oversees these data and manages them in the organization dashboard, which is available only for the company administrators.

The dashboard link, under the main menu, is visible only to the administrator. For all other users, irrespective of their roles, the dashboard link is not visible and will not have access to this page.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure.png"></p>

1. Log in to the TUA Spartacus.

1. Navigate to **Account** -> **Subscriptions**. All subscriptions of the logged in customer are displayed.
1. Click ... **Terminate** button....

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/1banner-termination-button.png"></p>

1.  Click **Terminate** ...

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/confirmation-message.png"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA store and usage of the SAP Commerce B2B module features together with TUA module. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version) and enables the B2B Administrators to manage their organization.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Organization Management

To be updated...

## Supported Backend Functionality

To be updated

## Components

| Component   Name                 	| Status  	| Description                                                                                                                                                                                                         	|
|----------------------------------	|---------	|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| ...       	| ...     	| To be updated.               	|
| ...              	| ... 	| To be updated.                                                       	|
| ...             	| ... 	| To be updated.                                                                                                                          	|
| ... 	| ... 	| To be updated.

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [To be updated](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html)
