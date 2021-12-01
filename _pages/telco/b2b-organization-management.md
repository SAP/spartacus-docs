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

## Business Need

Administrators need to manage their organization-related tasks whenever required. This feature enables Administrators to view and edit the company structure and the entities related to the company.

## Business Use Case

**Organization Structure**

Following diagram represents an organization structure that is grouped into different units and business units. The **Total Protect** is the main unit of the organization and is further structured into three different child units such as Coordination Center, Operation Center, and HR.

Each unit has separate users, who are employees of this organization, assigned to it. These users have different roles such as administrators or approvers or customers. In some cases, the user will have multiple roles such as an administrator and / or an approver. Such users are visible in the dashboard of the organization management that is accessible by the administrator who in turn can assign users to different units or can assign different roles to different users.

Apart from units and user roles, there are cost center and budgets that can be assigned to any of the units listed. The cost center or budgets are defined by either of these units. The company administrator oversees these data and manages them in the organization dashboard, which only the company administrator can view and access.

The dashboard link, under the main menu, is visible only to the administrator. For all other users, irrespective of their roles, the dashboard link is not visible and will not have access to this page.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure.png"></p>

As per the organization structure, Lisa Richards is the B2B admin user and is assigned to the **Total Protect** main parent unit. Being an administrator, Lisa will be able to see the **My Company** link under the **My Account** main menu. 

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-submenu1.png"></p>

The organization page under My Company displays the following entities:
-   **Users**
-   **Cost Centers**
-   **Units**
-   **Budgets**
-   **Purchase Limits**
-   **User Groups**

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-homepage.png"></p>

**Units**

The **Total Protect** organization structure includes the following three child units.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-child-units.png"></p>

Administrator can view the child units of the B2B parent unit, the users, approvers, and all other details, relevant to a particular unit, that are to be updated by the administrator.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-units-users-approvers.png"></p>

To view the next entity, navigate to the **My Company** home page by clicking **Organization**.

**Users**

Here, the administrator can view all user details of the parent and child units, and can enable or disable a user, update the password, and view the list of approvers for a user.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list.png"></p>

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list-details.png"></p>

Administrator can either assign a user or remove a user from a particular user group.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/assign-unsassign-usergroup.png"></p>

Click **ADD** to add a new user, assign a role and a unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/add-assign-role-unit-to-user.png"></p>

**Cost Centers**

The **Organization** page in **Cost Centers** allows the administrator to add a new Unit and also to check and modify the details of a cost center.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cost-center-details.png"></p>

**Budgets** 

The **Organization** page in **Budgets** allows the administrator to add a new unit, check and modify the budget details, and change the cost center to which the budget needs to be assigned. The **Budgets** page is similar to the **Cost Center** page.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budgets-page.png"></p>

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budget-page-cost-center-details.png"></p>

**Purchase Limits** 

The **Organization** page  in **Purchase Limits** allows the administrator to view the list of purchase limits. The purchase limits can be enabled or disabled, and, if required, modify the purchase limits code and type, and assign it to a different B2B unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/purchase-limits.png"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA store and usage of the SAP Commerce B2B module features together with TUA module. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version) and enables the B2B Administrators to manage their organization.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|


