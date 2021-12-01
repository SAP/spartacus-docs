---
title: B2B Order Approval
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The feature allows managers to view and approve or reject orders. Whenever a customer purchases a product or places an order that requires an approval, it is sent to the manager who either approves or rejects the order.  

All orders waiting for approval will be in the pending approval state till the manager makes final decision on it. The manager views the details of the order and then decides to approve or reject the order. 

The feature includes the **Approval Dashboard**, which is displayed as a link under the main menu. This link is visible only to the company administrator and not to any other users, irrespective of their roles. The link is visible to the administrator even in case of multiple roles such as the administrator role and approver role. The administrator can view orders within the organization's main unit or child unit.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

Orders that require approval move to the pending approval state. To move to next state, it needs to be approved or rejected by the manager. This feature allows the company manager to view the order details and then approve or reject the order.

## Business Use Case

**Organization Structure**

Following diagram represents an organization structure that is grouped into different units and business units. The **Total Protect** is the main unit of the organization and is further structured into three different child units such as Coordination Center, Operation Center, and HR.

Each unit has separate users, who are employees of this organization, assigned to it. These users have different roles such as administrators or approvers or customers. In some cases, the user will have multiple roles such as an administrator and / or an approver. Such users are visible in the dashboard of the organization management that is accessible by the administrator who in turn can assign users to different units or can assign different roles to different users.

For this feature purpose, let us consider the approver role. At the parent unit level, Ross Carter is assigned as the B2B approver. In such a scenario, the approver, while accessing the approval dashboard, is able to see all orders within the company. This is because the approver is assigned to the main unit, which displays all orders within the company irrespective of the units each order belongs to. The approver can either approve or reject the listed orders for the company.

In case of Operation Center business unit, one of the child units, Mark Mann is assigned as the B2B approver. Mark would be able to view and either approve or reject the orders placed by users, in this case it is users with customer role, within this business unit.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/organization-structure2.png"></p>

As per the organization structure, Ross Carter is the B2B approver and is assigned to the **Total Protect** main parent unit. Being an approver, Ross will be able to view the **Approval Dashboard** link and access it to approve or reject orders for all users within the parent unit and child units. 

**Approve or Reject Orders**

The **Approval Dashboard** option is listed under the **My Account** main menu.

The **Order Approval Dashboard Page** displays the list of orders that are pending for approval, approved, and rejected.

The orders listed here are for Simon Peters who is from the same B2B unit, that is the Total Protect main unit, to which Ross Carter also belongs.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg.png"></p>

Details of a specific order can be viewed by clicking the required order.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg-order-details.png"></p>

The following screenshot displays orders from different users from different business units such as Coordination Center, Operation Center, and HR. These business units are the child units of the **Total Protect** main business unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg2.png"></p>

In case the approver is from a particular child unit such as Coordination Center, then the approver will be able to view and approve or reject orders pending for approval from users in this unit.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-approval-dashboard-pg3.png"></p>


## Feature Enablement

This feature is enabled through the B2B Telco SPA store implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

