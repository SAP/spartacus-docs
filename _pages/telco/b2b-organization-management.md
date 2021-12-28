---
title: B2B Organization Management
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The feature allows B2B Administrators to view and edit the company structure and the entities related to the company. Administrators will be able to manage their company-related activities such managing company’s units, employees, user groups, budgets, cost, and purchase limits. Administrators view and edit existing units, and also create new units within their company. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

Organizational structure provides guidance to all employees by laying out the official reporting relationships that govern the workflow of the company.  A formal outline of a company's structure makes it easier to add new positions, roles, and authorizations in the company.

Structure provides clarity, helps to manage expectations, enables better purchase decision-making, and provides consistency.  It also helps with assignment of responsibility regarding budgets, cost, purchase limits, and workflow processes.

Administrators need to manage such organizational-related activities whenever required. This feature enables administrators to view and edit the company structure and the entities related to the company. 

## Business Use Case

**Organization Structure**

Following diagram represents an organization structure that is grouped into different units and business units. **Total Protect** is the name of the B2B company and is also the main unit of the organization. The company is further divided into three child business units including the Coordination Center, Operation Center, and Human Resources.

Each business unit has users or employees assigned. These users have different roles such as administrators, approvers, or customers. In some cases, the user will have multiple roles such as an administrator and an approver. The users are visible in the organization management dashboard that is accessible by the administrator. Administrators have the authorization to assign users to different business units or can assign different roles to different users.

Apart from business units and user roles, there are cost centers and budgets that can be assigned to any of the business units listed. The cost centers or budgets are defined by either of these units. Only company administrators can manage this information through the organizational dashboard. 

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure.png"></p>

As per the organization structure, Lisa Richards is the B2B admin user and is assigned to the **Total Protect** main parent unit. Being an administrator, Lisa will be able to see the **My Company** link under the **My Account** main menu. 

1. Log in to the TUA Spartacus. 
   -  User ID: lisa.richards@totalprotect.com
   -  Password: 1234

1. Click **My Account** to view the **My Company** link.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-submenu1.png"></p>

1. Click **My Company** to view the organization page that displays different entities such as **Users**, **Cost Centers**, **Units**, **Budgets**, **Purchase Limits**, and **User Groups**.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-company-homepage.png"></p>

1. Click **Units** to view more details. The **Total Protect** organization structure includes the following three child units.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-child-units.png"></p>

1. Administrator will be able to view the child units of the B2B parent unit, the users, approvers, and all other details relevant to a particular unit that is required to be updated by the administrator.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/total-protect-units-users-approvers.png"></p>

1. Click **Organization** to go back to the **My Company** home page.

1. Click **Users** to view all user details of the parent and child units. Administrator can enable or disable a user, update the password, and view the list of approvers for an user. 

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list.png"></p>

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/users-list-details.png"></p>

1. Administrator can also assign a user to a particular user group or remove a user from a user group.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/assign-unsassign-usergroup.png"></p>

1. Click **ADD** to add a new user, assign a role and a unit.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/add-assign-role-unit-to-user.png"></p>

1. Click **Cost Centers** from the **Organization** page.

1. Administrator will be able to add a new Unit and also check and modify the details of a cost center.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cost-center-details.png"></p>

1. Click **Budgets** from the **Organization** page.

1. The **Budgets** page is similar to the **Cost Center** page where the Administrator can add a new unit, check and modify the budget details, and change the cost center to which the budget needs to be assigned.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budgets-page.png"></p>

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/budget-page-cost-center-details.png"></p>

1. Click **Purchase Limits** from the **Organization** page to view the list of purchase limits. The purchase limits can be enabled or disabled. Also, if required, modify the purchase limits code and type and assign it to a different B2B unit.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/purchase-limits.png"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA store and usage of the SAP Commerce B2B module features together with TUA module. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2108 version) and enables the B2B Administrators to manage their organization.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|


