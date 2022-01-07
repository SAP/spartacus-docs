---
title: Journey Management - Appointment Scheduling 
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

As a result of Journey Management configuration, a product offerings may be defined with the requirement of an appointment to be scheduled. This means that an appointment reservation is required before the order can be successfully placed. The Journey Management appointment feature enables customers to make this reservation during the "Add to Cart" process.

Appointment selection and reservation in a productive system requires third-party integration to the appropriate backend system. This feature can be adapted to work with a customer-specific business process flow.

This feature applies to product offerings or product specifications that have a checklist policy for Appointment Reference and/or Installation Address configured. It is applicable to product offerings sold as a simple product offering or bundled product offering through configurable guided selling. For more information, see [Configurable Guided Selling](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/fa22e16db2524c0bb9b12c6102ba1b5d.html) in the TUA Help portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisite

To test this feature using a mockup service, follow the instructions to set-up soapUI. Ensure that the Appointment system is always up and running.

**Note:** The mockup service is not recommended for the production environments as it is intended only for demonstration purpose.

1. Download [soapUI, version 5.6.0](https://www.soapui.org/downloads/latest-release/) as per your installed Operating System.
2. Navigate to the [TUA Spartacus git repository](https://github.com/SAP/spartacus-tua/releases/tag/1.1.0) and download the `mock_services.zip` file.
3. Extract the `mock_services.zip` file. The content of the ZIP when extracted is the `Resource_Pool_Management_API.xml` file.
4. Click the **Import** icon on the soapUI toolbar. The `Select soapUI Project` file dialog box opens. Import the  `Resource_Pool_Management_API.xml` file into the soapUI.
5. Right-click **Appointment** and then click **Start Minimized**. When the mock service is up, you can see that the Appointment mock service is also up and running.

## Business Use Cases

The following business use cases are covered for this feature:

1. A customer wants to purchase a product offering that requires an installation service at a preferred address specified by the customer.  During the "Add to “Cart" process, the customer is prompted to specify the address and/or make an appointment reservation.   If the product offering has only an installation address policy configured, the appointment selection screen will not display.

2. A customer enters [Configurable Guided Selling](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/464d4b03d91442e9ac95f69808895a39.html) and wants to purchase a product offering that requires an installation service at a preferred address specified by the customer. During the "Add to Cart" process, the customer is prompted to specify the address and/or make an appointment reservation. If multiple products requires installation, the end customer will only be prompted once to provide this information making the configurable guided selling journey seamless.  Behind the scenes, the installation address and appointment will be copied to all product offerings requiring this information.   If the product offering has only an installation address policy configured, the appointment selection screen will not display.

3.  A customer has the ability to change the installation address and/or appointment from within the cart.

4.  A customer may not immediately place the order but instead waits until the next day, or the customer completely abandons the cart. After a defined period of time, the cart times-out and the appointment is automatically cancelled, and the slot can be made available for another customer.



## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2007 or 2011 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce Cloud release 2005 (latest patch is recommended) 	|

## Configuring and Enabling Installation Address and Appointment in TUA

The `Installation address` and the `Appointment-Reference` checklist policy is configured in the Backoffice by the Product Manager. For more information, see [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## Components

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-pcvp{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"><span style="font-weight:bold">Component   Name</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Status</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Description</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-pcvp">JourneyChecklistStepComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component is updated to include:<br><br>1. JourneyChecklistInstallationAddressComponent.<br>2. The <span style="font-weight:bold">Next</span> button to save the address in the address book of the user and to navigate to the next step, which can be either "Add to Cart" or the "Installation address" selection.<br></td>
  </tr>
  <tr>
    <td class="tg-0pky">JourneyChecklistAppointmentComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component displays the available time slots for scheduling an appointment to the customer.<br><br><span style="font-weight:bold">Note:</span> The <span style="font-weight:bold">Please Call to Schedule</span> option shows selected by default. The other values are in the Month Date, Year, and Time (AM/PM) format. For Example: Sept 9, 2020 12:00 PM</td>
  </tr>
  <tr>
    <td class="tg-pcvp">JourneyChecklistInstallationAddressComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">This component wraps the <span style="font-weight:bold">TmaAddressFormComponent</span> for the checklist installation address. It is responsible for populating the installation address when the customer clicks the <span style="font-style:italic">Edit </span>pencil icon.</td>
  </tr>
  <tr>
    <td class="tg-0pky">AppointmentComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component displays the appointment details in the Order page, Order History page, the Cart summary, and the Add to Cart screen. <br><br>It is in the following format: Appointment: Month Date and Year Time (AM/PM). For example, Appointment: Sept 9,2020 12:00 PM or  Appointment: Please Call to Schedule.</td>
  </tr>
  <tr>
    <td class="tg-pcvp">InstallationAddressComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">This component displays the the details of the installation address in the Order page, Order History page, the Crart summary page, and Add to Cart pop-up.<br><br>It is in the following format: Installation Address : Building Number, Street Name, City, StateOrProvince(Optional), Country, and Postal Code</td>
  </tr>
  <tr>
    <td class="tg-0pky">AppointmentDetailsComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">This component is a wrapper for the <span style="font-style:italic">AppointmentComponent </span>and the <span style="font-style:italic">InstallationAddressComponent</span>. It enables editing of an appointment using the <span style="font-weight:bold">Edit </span>pencil icon. For more information, see <span style="font-style:italic">AppointmentComponent</span> and <span style="font-style:italic">InstallationAddressComponent</span>.</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaAddToCartComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component displays the enhanced<span style="font-weight:bold"> Add to Cart </span>button to call the checklist actions and open the checklist action stepper, if any checklist actions for Appointment or Installation address are present.</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaAddressFormComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">This component enables to input the following address details: House/Building Number, Street Apartment/Unit/Suite(Optional), City, Country, State/Province (appears only in case the country is US), Zip/Postal Code.<br></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaAddedToCartDialogComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component is updated to include the <span style="font-style:italic">AppointmentDetailsComponent</span> in the <span style="font-weight:bold">Add to Cart </span>screen<br></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaCartItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component is updated to include the <span style="font-style:italic">AppointmentDetailsComponent</span> on the Cart entry level. <br><br>For example:<br>for SPO, it displays at the Cart and the Order entry Level<br>for BPO, it displays at the BPO level</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaCartItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component has modified the display of the appointment details to move at the Cart entry level. For more information, see <span style="font-style:italic">TmaCartItemListComponent</span>.<br></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaGuidedSellingAddedToCartDialogComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component is updated to display the<span style="font-style:italic"> AppointmentDetailsComponent</span>. For more information, see <span style="font-style:italic">AppointmentDetailsComponent.</span><br></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaGuidedSellingCurrentSelectionComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component displays the<span style="font-weight:bold"> Add to Cart</span> button for a BPO that calls the checklist action and opens the checklist action stepper, if any checklist actions for an appointment or for the installation address are present.</td>
  </tr>
</tbody>
</table>

## TM Forum APIs

| End Points                      | TMF      | Description                                                                            |
|---------------------------------|----------|----------------------------------------------------------------------------------------|
| POST appointment/searchTimeSlot | TMF-646  | Displays the available list of time slots                                   |
| POST /appointment               | TMF-646  | Creates an appointment for the customer                                                 |
| GET /appointment/{id}           | TMF-646  | Retrieves the  appointment details of a customer                                       |
| PATCH /appointment/{id}         | TMF-646  | Updates the appointment details of a customer                                           |
| GET /checklistAction            | None     | Retrieves applicable list of checklist policies for product offerings |
| PATCH /shoppingCart/{id}        | TMF-633  | Updates an existing entry in the shopping cart                           |
| POST /geographicAddress     | TMF-673  | Creates an installation address                                                   |
| PATCH /geographicAddress/{id}   | TMF-673  | Edits an installation address                                                        |

For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/latest/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Configurable Guided Selling (CGS)](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/464d4b03d91442e9ac95f69808895a39.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).
