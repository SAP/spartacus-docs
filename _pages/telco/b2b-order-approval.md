---
title: B2B Order Approval
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The feature allows managers to view and approve or reject orders. When a customer submits an order for a product or service, if that order requires approval, it is sent to a manager who can either approve or reject the order.   

All orders waiting for approval will have a “pending approval” status until the manager decides.  The business will define the workflow approval process for order. 

The feature includes the **Approval Dashboard**, which is displayed as a link under the **My Account** menu. This link is visible only to the company administrator and not to any other users, irrespective of their roles. The link is visible to the administrator even in case of multiple roles such as the administrator role and approver role.

The administrator can view orders within the organization’s main unit or child unit. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

Business organizations can use purchase approval workflows to set clear checks and balances for spend requests related to new equipment, new services, new hires, new budgets, and every other type of expense.  Well-designed approval workflows protect your organization from over-spending or making unnecessary purchases. 

## Business Use Case

**Organization Structure**

Following diagram represents an organization structure that is grouped into different units and business units. Total Protect is the name of the B2B company and is also the main unit of the organization. The company is further divided into three child business units including the Coordination Center, Operation Center, and Human Resources.

Each business unit has users or employees assigned. These users have different roles such as administrators, approvers, or customers. In some cases, the user will have multiple roles such as an administrator and an approver. The users are visible in the organization management dashboard that is accessible by the administrator. Administrators have the authorization assign users to different business units or can assign different roles to different users.

For the Total Protect organization, Ross Carter is assigned the B2B approver role. Through the approval dashboard, Ross Carter can see all orders within the company. This is because the approver is assigned to the main unit, which displays all orders within the company irrespective of the units each order belongs to. Ross Carter can either approve or reject the listed orders for the company.

For the Operation Center business unit, Mark Mann is assigned as the B2B approver.  Through the approval dashboard, Mark Mann can only view and either approve or reject the orders placed by users within Operation Center business unit.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure2.png"></p>

As per the organization structure, Ross Carter is the B2B approver and is assigned to the **Total Protect** main parent unit. Being an approver, Ross will be able to view the **Approval Dashboard** link and access it to approve or reject orders for all users within the parent unit and child units. 

**Approve or Reject Orders**

The **Approval Dashboard** option is listed under the **My Account** main menu.

The **Order Approval Dashboard Page** displays the list of orders that are pending for approval, approved, and rejected.

The orders listed here are for Simon Peters who is from the same B2B unit, that is the Total Protect main unit, to which Ross Carter also belongs.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg.png"></p>

Details of a specific order can be viewed by clicking the required order.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg-order-details.png"></p>

The following screenshot displays orders from different users from different business units such as Coordination Center, Operation Center, and Human Resources. These business units are the child units of the **Total Protect** main business unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg2.png"></p>

In case the approver is from a particular child unit such as Coordination Center, then the approver will be able to view and approve or reject orders pending for approval from users in this unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg3.png"></p>


## Feature Enablement

This feature is enabled through the B2B Telco SPA store implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2108 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

