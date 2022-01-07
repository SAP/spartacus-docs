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

Apart from units and user roles, there are cost center and budgets that can be assigned to any of the units listed. The cost center or budgets are defined by either of these units. The company administrator oversees these data and manages them in the organization dashboard, which only the company administrator can view and access.

The dashboard link, under the main menu, is visible only to the administrator. For all other users, irrespective of their roles, the dashboard link is not visible and will not have access to this page.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure.png"></p>

As per the organization structure, Lisa Richards is the B2B admin user and is assigned to the **Total Protect** main parent unit. Being an administrator, Lisa will be able to see the **My Company** link under the **My Account** main menu. To view the organization page and explore the different types of entities listed:

1. Log in to the TUA Spartacus.

1. Click **My Account** to view the **My Company** link.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-submenu1.png"></p>

1. Click **My Company** to view the organization page that displays different entities such as **Users**, **Cost Centers**, **Units**, **Budgets**, **Purchase Limits**, and **User Groups**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-homepage.png"></p>

1.  Click **Units** to view more details. The **Total Protect** organization structure includes the following three child units.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-child-units.png"></p>

1.  Administrator will be able to view the child units of the B2B parent unit, the users, approvers, and all other details relevant to a particular unit that is required to be updated by the administrator.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-units-users-approvers.png"></p>

1.  Click **Organization** to go back to the **My Company** home page.

1.  Click **Users** to view all user details of the parent and child units. Administrator can enable or disable a user, update the password, and view the list of approvers for an user.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list.png"></p>

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list-details.png"></p>

1.  The administrator can also assign a user to a particular user group or remove a user from a user group.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/assign-unsassign-usergroup.png"></p>

1.  Click **ADD** to add a new user, assign a role and a unit.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/add-assign-role-unit-to-user.png"></p>

1.  Click **Cost Centers** from the **Organization** page.

1.  Administrator will be able to add a new Unit and also check and modify the details of a cost center.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cost-center-details.png"></p>

1.  Click **Budgets** from the **Organization** page.

1.  The **Budgets** page is similar to the **Cost Center** page where the Administrator can add a new unit, check and modify the budget details, and change the cost center to which the budget needs to be assigned.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budgets-page.png"></p>

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budget-page-cost-center-details.png"></p>

1.  Click **Purchase Limits** from the **Organization** page to view the list of purchase limits. The purchase limits can be enabled or disabled. Also, if required, modify the purchase limits code and type and assign it to a different B2B unit..

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/purchase-limits.png"></p>

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
