---
title: FSA Policy Change
---

**Note**: Sample processes for changing mileage and adding additional coverages are introduced with version 1.0 of the FSA Spartacus libraries, while the processes for adding additional drivers and removing coverages were added in the 2.0 version.

The Policy Change feature enables insurance carriers to provide their customers with the possibility to change their policies online.


***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Initiating Policy Change Request 

Existing customers can enter the policy change process on the **Policy Details** page in the **My Account** area. After choosing what they wish to change on the first step, customers are presented with a preview of the new premium, which they can then compare with the existing one and if satisfied, submit the change request. The customer can cancel the policy change at any time during the change process, in which case the customer will be redirected to the 'Policy Details' page again.


## Policy Change Sample Requests

Financial Service Accelerator provides several sample policy change processes out of the box. Processes for changing mileage, adding or removing coverages, as well as adding additional drivers are made available, based on the sample Auto Insurance product. 

### Changing Mileage

The user who wishes to change the mileage enters the change process by clicking the **EDIT** button in the 'Who or What is Insured' accordion on the **Policy Details** page.

![Policy Details Page - Change Mileage]({{ site.baseurl }}/assets/images/fsa/policy-change/policy-details-change-mileage.png)

A two-step change process is initiated - in the first step, the user is presented with a form for entering a new mileage, while the second step is a summary step, where the user can preview and compare the new premium with the existing one. The new premium is calculated based on the exiting premium and the change the user just made.

![Change Mileage - Change Car Details]({{ site.baseurl }}/assets/images/fsa/policy-change/change-mileage-step1.png)

![Change Mileage - Change Preview]({{ site.baseurl }}/assets/images/fsa/policy-change/change-mileage-step2.png)

If satisfied with the new premium, the user applies the change by clicking the **SUBMIT** button. 
When the user submits the request, a confirmation page is displayed, indicating that the request has been submitted.

![Change Confirmation Page]({{ site.baseurl }}/assets/images/fsa/policy-change/cr_confirmation.png)

The new premium becomes effective immediately and can be seen on the **Policy Details** page.

### Adding and Removing Coverages

The user may wish to add additional coverage to the existing policy or remove coverage that is no longer wanted. The user can make one or both of these changes within the same change process.

This time the user initiates the change request process by clicking the **Edit** button in the ‘Optional Extras’ accordion.

![Policy Details Page - Edit Coverage Details]({{ site.baseurl }}/assets/images/fsa/policy-change/policy-details-add-or-remove_coverage.png)

In the first step, the user can now choose whether to add or remove coverages. Note that the **Continue** button stays disabled until the change is made. After applying the desired change and clicking Continue, the user can preview the changes made to the policy and compare them with the current situation. If satisfied, the user submits the changes, and they become effective immediately. Otherwise, the user discontinues the process by clicking the **CANCEL** button.

![Change Coverage Step]({{ site.baseurl }}/assets/images/fsa/policy-change/change_coverage.png)

In the final step, the user previews the changes made to the policy, and if satisfied, submits the change request.

Example of a Change Preview page when the user adds additional coverage: 

![Add Coverage Preview Step]({{ site.baseurl }}/assets/images/fsa/policy-change/add-coverage-step2.png)

Example of a Change Preview page when the user removes existing coverage:

![Remove Coverage Preview Step]({{ site.baseurl }}/assets/images/fsa/policy-change/remove-coverage-step2.png)

After submitting the request for coverage change, the user can see the changes on the **Policy Details** page.


### Adding Additional Drivers

By clicking  the **ADD** button in the Drivers section of the 'Who or What is Insured' accordion, the user initiates the policy change process for adding additional driver to the policy. The user is presented with the form requesting information about the additional driver. Note that 'Effective date' field is disabled and cannot be changed by the policyholder.

![Form for Adding Additional Driver]({{ site.baseurl }}/assets/images/fsa/policy-change/additional_driver_form.png)

After filling in all the required fields, the user can proceed to the Change Preview step.
On this step, the user is presented with an overview of the change applied to the current policy.

![Add Driver Change Preview Step]({{ site.baseurl }}/assets/images/fsa/policy-change/add-driver-step2.png)

The user can see the policy change by visiting the **Policy Details** page again. In the 'Who or What is Insured' accordion, the user can see a new section with the headline 'Driver 2', containing information about the added additional driver.

![Policy Details Page with Additional Driver Added]({{ site.baseurl }}/assets/images/fsa/policy-change/policy-details-driver-added.png)

The user can add up to three additional drivers. The change procedure in this case needs to be done for each additional driver separately.

## Implementation

The policy change process is based on the User Request Framework, a flexible, lightweight framework for implementing various types of user requests, originating from the customer towards the company. 

Although the current implementation of the Financial Services Accelerator uses this framework for changing policies and reporting claims, it can be extended and reused for other request types (contact request, service request, etc.). All user request processes are fully configurable in the Backoffice. 

For more information, see [User Request Framework](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/e565d508786748b2a752b4faccf860d2.html) documentation on the SAP Help Portal.