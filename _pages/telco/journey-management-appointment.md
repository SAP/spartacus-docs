---
title: Journey Management - Appointment Reference
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Key Personas](#key-personas)
- [Business Use Case](#business-use-case)
- [Navigation Flow](#navigation-flow)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling New Appointment](#configuring-and-enabling-new-appointment)
- [Further Reading](#further-reading)

## Overview

The `Journey Management - Appointment Reference` feature enables the customers browsing the TUA for SPA Storefront to browse the content of a product offering, and select a suitable appointment for arranging onsite service support, before purchasing the product offering.

**Note:** The `Journey Management - Appointment Reference` feature applies to only those product or service offerings for which a checklist policy is configured at the backend by the Product Manager.

## Key Personas

- Customers
- Product Managers

## Business Use Case

A customer wants to purchase a product offering. Before adding the product offering to the cart, the `Select a suitable time for an appointment` screen is displayed, based on the checklist policy configured at the backend by the Product Manager. The customer is required to select a `call to schedule` option, or a suitable appointment from the available appointments.

The business use case includes the following steps:

1. The customer searches and selects a product offering; for example, Fiberlink 100, and clicks **Add to Cart** to add the product offering to the cart.
2. The `Select a suitable time for an appointment` screen is displayed, based on the checklist actions configured at the backend by Product Manager. The `Select a suitable time for an appointment` screen displays:
    - **Call to Schedule:** The customer can select this option if a call back is required to schedule an appointment.
    - **Select a Suitable Appointment:** The customer can select a suitable appointment from the available appointments.
3. The selected product offering with the appointment is added to the cart.
4. The customer can edit the appointment before proceeding to checkout the product offering. 
5. The customer can view view the appointment and the order details from the `Order Details` page or the `Order History` page.

## Navigation Flow

- Search and select a product offering, for example, Fiber Link at 100 mbps.

<p align="center"><img src="/assets/images/telco/1Product_Offering.png"></p>

- Click **Add to Cart**. The `Select a suitable time for an appointment` screen is displayed, based on the checklist policy configured at the backend by the Product Manager.

    **Note:** The `Please Call to Schedule` option is preselected.

- Click a suitable appointment from the available appointments.

<p align="center"><img src="/assets/images/telco/2Select_Suitable_Appointment.png"></p>

- Click **CONTINUE**. The appointment is displayed in the `Item(s) added to your cart` screen.

<p align="center"><img src="/assets/images/telco/3Add_to_Cart.png"></p>

- Click **View Cart**. The cart displays all relevant details of the product offering (Fiber Link) with the appointment.

<p align="center"><img src="/assets/images/telco/4View_Cart.png"></p>

- Click the pencil icon to edit the appointment. The `Select a suitable time for an appointment` screen is displayed. 
- Select a suitable appointment and click **Update**. The cart page displays the new appointment.
- Click **Proceed to Checkout** to buy the product offering.

## Requirements and Dependencies

### Frontend Requirements and Dependencies

In progress.

### Backend Requirements and Dependencies

In progress.

### Supported Backed Functionality

- [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Data Model for entities exposed Via TMF and OCC APIs](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).

| Entity   Exposed 	| TMF & OCC APIs 	| Remark 	| Request or Response 	|
|-	|-	|-	|-	|
| Tmf   Resources#TMF-ChecklistActionAPI 	| /checklistAction 	| To show   applicable list of checklist policies for product offering 	| None 	|
| TMF-646 	| GET   appointment/searchTimeSlot  	| To show available list of time slots from Technician 	| **Response (200 OK):**<br>     [<br>     {<br>     ""id"":   ""a9d239bb-dc21-4f98-a519-4a3f9aa4d2b5"",<br>     ""href"":   ""https://api-appointment-v4-0-0.mybluemix.net/tmf-api/appointment/v4/searchTimeSlot/a9d239bb-dc21-4f98-a519-4a3f9aa4d2b5"",<br>     ""@schemaLocation"":   ""https://api-appointment-v4-0-0.mybluemix.net/docs/#/"",<br>     ""@type"": ""SearchTimeSlot"",<br>     ""@baseType"":   ""SearchTimeSlot"",<br>     ""creationDate"":   ""2020-03-12T14:07:01.889Z"",<br>     ""status"": ""initialized"",<br>     ""availableTimeSlot"": [<br>     {<br>     ""id"": ""365"",<br>     ""href"":   ""https://host:port/appointment/searchtimeslot/99/availableTimeSlot/365"",<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-28T14:00:00.000Z"",<br>     ""endDateTime"":   ""2020-08-28T16:00:00.000Z""<br>     },<br>     ""relatedParty"": {<br>     ""id"": ""56"",<br>     ""href"":   ""https://host:port/partyManagement/individual/56"",<br>     ""name"": ""John Doe"",<br>     ""role"": ""technician"",<br>     ""@referredType"":   ""Individual""<br>     }<br>     },<br>     {<br>     ""id"": ""921"",<br>     ""href"":   ""https://host:port/appointment/searchtimeslot/99/availableTimeSlot/921"",<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-28T16:30:00.000Z"",<br>     ""endDateTime"":   ""2018-08-28T18:00:00.000Z""<br>     },<br>     ""relatedParty"": {<br>     ""id"": ""56"",<br>     ""href"":   ""https://host:port/partyManagement/individual/56"",<br>     ""name"": ""John Doe"",<br>     ""role"": ""technician"",<br>     ""@referredType"":   ""Individual""<br>     }<br>     },<br>     {<br>     ""id"": ""325"",<br>     ""href"": ""https://host:port/appointment/searchtimeslot/99/availableTimeSlot/325"",<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-28T18:30:00.000Z"",<br>     ""endDateTime"":   ""2020-08-28T19:00:00.000Z""<br>     },<br>     ""relatedParty"": {<br>     ""id"": ""58"",<br>     ""href"": ""https://host:port/partyManagement/individual/58"",<br>     ""name"": ""Adam Smith"",<br>     ""role"": ""technician"",<br>     ""@referredType"": ""Individual""<br>     }<br>     }<br>     ]<br>     },<br>     {<br>     ""id"":   ""a9d239bb-dc21-4f98-a519-4a3f9aa4d2b5"",<br>     ""href"":   ""https://api-appointment-v4-0-0.mybluemix.net/tmf-api/appointment/v4/searchTimeSlot/a9d239bb-dc21-4f98-a519-4a3f9aa4d2b5"",<br>     ""@schemaLocation"":   ""https://api-appointment-v4-0-0.mybluemix.net/docs/#/"",<br>     ""@type"": ""SearchTimeSlot"",<br>     ""@baseType"":   ""SearchTimeSlot"",<br>     ""creationDate"":   ""2020-03-12T14:07:01.889Z"",<br>     ""status"": ""initialized"",<br>     ""availableTimeSlot"": [<br>     {<br>     ""id"": ""365"",<br>     ""href"":   ""https://host:port/appointment/searchtimeslot/99/availableTimeSlot/365"",<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-29T14:00:00.000Z"",<br>     ""endDateTime"": ""2020-08-29T16:00:00.000Z""<br>     },<br>     ""relatedParty"": {<br>     ""id"": ""56"",<br>     ""href"":   ""https://host:port/partyManagement/individual/56"",<br>     ""name"": ""John Doe"",<br>     ""role"": ""technician"",<br>     ""@referredType"":   ""Individual""<br>     }<br>     },<br>     {<br>     ""id"": ""921"",<br>     ""href"":   ""https://host:port/appointment/searchtimeslot/99/availableTimeSlot/921"",<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-29T16:30:00.000Z"",<br>     ""endDateTime"":   ""2020-08-29T18:00:00.000Z""<br>     },<br>     ""relatedParty"": {<br>     ""id"": ""56"",<br>     ""href"":   ""https://host:port/partyManagement/individual/56"",<br>     ""name"": ""John Doe"",<br>     ""role"": ""technician"",<br>     ""@referredType"":   ""Individual""<br>     }<br>     }<br>     ]<br>     }<br>     ]" 	|
| TMF-646 	| POST /appointment 	| To create an   appointment for the customer 	| **Request:**<br>     {<br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-28T14:00:00.000Z"",<br>     ""endDateTime"":   ""2020-08-28T16:00:00.000Z""<br>     }<br>     <br>     }<br>     <br>     **Response (201 Created):**<br>     <br>     ""validFor"": {<br>     ""startDateTime"":   ""2020-08-28T14:00:00.000Z"",<br>     ""endDateTime"":   ""2020-08-28T16:00:00.000Z""<br>     },<br>     ""id"":   ""appointment-test-1"",<br>     ""href"":   ""https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1"",<br>     ""lastUpdate"":   ""2020-08-06T11:41:59.054Z"",<br>     ""@schemaLocation"":   ""https://localhost:8080/docs/#/"",<br>     ""@type"": ""Appointment"",<br>     ""@baseType"":   ""Appointment"",<br>     ""creationDate"":   ""2020-08-06T11:41:59.054Z"",<br>     ""status"": ""initialized""<br>     }" 	|
| TMF-646 	| GET /appointment/{id} 	| To fetch the appointment details of a   customer 	| Response : (200 OK)<br>     <br>     {<br>     "validFor": {<br>     "startDateTime": "2020-08-28T14:00:00.000Z",<br>     "endDateTime": "2020-08-28T16:00:00.000Z"<br>     },<br>     "id": "appointment-test-1",<br>     "href":   "https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1",<br>     "lastUpdate": "2019-08-21T12:11:13.683Z",<br>     "@schemaLocation": "https://api-appointment-v4-0-0.mybluemix.net/docs/#/",<br>     "@type": "Appointment",<br>     "@baseType": "Appointment",<br>     "creationDate": "2019-08-21T12:11:13.683Z",<br>     "status": "initialized"<br>     } 	|
| TMF-646 	| PATCH   /appointment/{id} 	| Update the   appointment details of a customer 	| **Request:**<br>     {<br>     """"validFor"""": {<br>     """"startDateTime"""":   """"2020-08-28T16:00:00.000Z"""",<br>     """"endDateTime"""":   """"2020-08-28T18:00:00.000Z""""<br>     }<br>     }<br>     <br>     **Response (200 OK):**<br>     {<br>     """"validFor"""": {<br>     """"startDateTime"""":   """"2020-08-28T16:00:00.000Z"""",<br>     """"endDateTime"""":   """"2020-08-28T18:00:00.000Z""""<br>     },<br>     """"id"""":   """"appointment-test-1"""",<br>     """"href"""":   """"https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1"""",<br>     """"lastUpdate"""":   """"2020-08-06T11:41:59.054Z"""",<br>     """"@schemaLocation"""":   """"https://localhost:8080/docs/#/"""",<br>     """"@type"""":   """"Appointment"""",<br>     """"@baseType"""":   """"Appointment"""",<br>     """"creationDate"""":   """"2020-08-06T11:41:59.054Z"""",<br>     """"status"""":   """"initialized""""<br>     }""" 	|

## Configuring and Enabling the Appointment Reference

In progress.

### Components

| Component Name                          | Status | Description                                                                                     |
| --------------------------------------- | ------ | ----------------------------------------------------------------------------------------------- |
| TmaAppointmentDisplayComponent          | New    | the component displays the appointment details of an order, order-history, cart summary, and cart popup |  |  |
| TmaJourneyChecklistAppointmentComponent | New    | the component displays the available time slots to the customer                               |
| TmaJourneyChecklistStepComponent        | New    | A stepper component that renders the checklist components                                        |

### Sample Data

In progress.

## Further Reading

Consult the TUA Help Portal for more information on the following topics:

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Customer Inventory and Cart](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/6d4fed0352f04fb8ba10846024854ea6.html).
