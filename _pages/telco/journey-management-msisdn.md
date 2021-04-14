---
title: Journey Management - MSISDN
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}


As a result of Journey Management configuration, some product offerings may be defined with the requirement of an MSISDN selection. This means that the MSISDN or Mobile Number must be selected (reserved) by the customer before the order can be successfully placed. The Journey Management - MSISDN feature enables customers to make this selection during the "Add to Cart" process. The retrieval of MSISDN numbers for selection and reservation requires a third-party integration.

**Note:** This feature applies to product offerings that have a checklist policy for `MSISDN Reference` configured. For more information, see [Configuring and Enabling MSISDN in TUA](#configuring-and-enabling-msisdn-in-tua).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisite

To test this feature using a mockup service, follow the instructions to set-up soapUI. Ensure that the MSISDN system is always up and running.

**Note:** The mockup service is not recommended for the production environments as it is intended only for demonstration purpose.

1. Download [soapUI, version 5.6.0](https://www.soapui.org/downloads/latest-release/) as per your installed Operating System.
2. Navigate to the [TUA Spartacus git repository](https://github.com/SAP/spartacus-tua/releases/tag/1.1.0) and download the `mock_services.zip` file.
3. Extract the `mock_services.zip` file. The content of the ZIP when extracted is the `Resource_Pool_Management_API.xml` file.
4. Click the **Import** icon on the soapUI toolbar. The `Select soapUI Project` file dialog box opens. Import the  `Resource_Pool_Management_API.xml` file into the soapUI.
5. Right-click **MSISDN** and then click **Start Minimized**. When the mock service is up, you can see that the MSISDN mock service is also up and running.

## Business Use Case

A customer wants to purchase a product offering that requires an MSISDN selection. During the "Add to Cart" process, the customer is prompted to `Select your desired Phone Number`. The customer makes a selection and the product offering is added to the cart, along with the MSISDN number selection. Customers also have the ability to change the selected MSISDN number to a new selection in the cart before placing the order.

## Frontend Requirements and Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce Cloud release 1905 (latest patch is recommended) 	|

## Configuring and Enabling MSISDN in TUA

The checklist policy for the MSISDN-Reference for a selected product offering is configured in the Backoffice by a Product Manager. For more information, see [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## Components

The following MSISDN components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Component Name                           | Description                                                                                                                                  |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| LogicalResourceComponent                 | Displays the logical resource details on   the order, order history, cart summary, and cart popup pages                                       |
| JourneyChecklistLogicalResourceComponent | Displays the available logical resource details to the customer.   Customers can select the desired logical resource from the available list |
| JourneyChecklistStepComponent            | Displays a stepper component that renders the checklist components   one-by-one                                                                       |

## TM Forum APIs

| API Name                       | API Endpoint                                        | Description                                                                                                  |
|--------------------------------------|-------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Tmf Resources#TMF-ChecklistActionAPI | /checklistAction                                | Shows applicable list of checklist policies for the product offerings                                        |
| TMF-685                              | POST /resourcePoolManagement/AvailabilityCheck  | Retrieves available resource entities (MSISDN)                                                               |
| TMF-685                              | POST /resourcePoolManagement/Reservation        | Creates a reservation instance                                                                               |
| TMF-685                              | PATCH /resourcePoolManagement/Reservation/{id}  | Updates a reservation instance                                                                               |
| TMF-685                              | GET /resourcePoolManagement/reservation/        | Retrieves a list of reservations. Additional filters can also be applied   to get the relevant search result |

For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).
