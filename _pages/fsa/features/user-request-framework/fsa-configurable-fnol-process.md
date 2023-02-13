---
title: FSA Configurable FNOL Process (Financial Services Accelerator Trail)
---

**Note**: This trail has been written for and tested on the 4.0 version of the FSA Spartacus libraries.

Financial Services Accelerator offers several trails to help you get more familiar with some of its features. 
The Customized FNOL Process Trail demonstrates how to create a new user request process in Financial Services Accelerator, using as an example the First Notice of Loss (FNOL) process for Travel Insurance.

Making a custom FNOL process is almost fully available from the Backoffice. 
The last step, however, in which you enable your Backoffice-configured process to be seen and tested on the storefront, needs to be done in the FSA Spartacus application itself. 

The purpose of this document is to provide those final instructions and show how the newly created FNOL process for Travel Insurance can look like on the storefront.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Introduction

The First Notice of Loss (FNOL) sample process has been implemented in the Financial Services Accelerator on the Auto Insurance product. 
However, the Financial Services Accelerator enables you to create a tailor-made FNOL process for your insurance products using the User Request Framework.

To create a tailor-made FNOL process for an insurance product:

- **Configure the process in the Backoffice**
  
  To do this, follow the instructions given in the [FSA Help Portal documentation](https://help.sap.com/docs/FINANCIAL_SERVICES_ACCELERATOR/087aa07411e34eb38c86d49ce2aaf73b/b940fe76a2eb47c1b84e02693074ca0a.html?version=2202). 
  The tutorial on the Help Portal uses the Travel Insurance FNOL process as an example.
  
- **Enable the FNOL process on the SPA side**
  
  After you complete all the steps from the tutorial, you need to expose the routes of your newly created FNOL process in your FSA Spartacus application. 
  For instructions on how to do that, see the steps in the next section.

- **Test your FNOL Process on the Storefront**
  
  Check if the process you created is visible on the Storefront and test it out.


## Enabling FNOL Process in your Custom Application

To complete the creation of your custom FNOL process, which you previously configured in the Backoffice, you need to expose the routes of your customized FNOL page to make it visible on the storefront.

To do that: 

1. Go to the `app.module.ts` file of your FSA Spartacus application (`[your-fsa-spa-root-folder]/src/app`). 
2. Enter the following code, having in mind that we used the Travel Insurance example in this tutorial: 

```typescript
const routes: Routes = [
  {
    path: null,
    canActivate: [AuthGuard, CmsPageGuard],
    data: {
      cxRoute: 'travelFnolFirstStepPage',
      pageLabel: 'travelFnolFirstStepPage',
    },
    component: PageLayoutComponent,
  },
];
   
export const storefrontRoutesConfig: RoutesConfig = {
  travelFnolFirstStepPage: { paths: ['travelFnolFirstStepPage'] },
};
    
export const routingConfig: RoutingConfig = {
  routing: {
    routes: storefrontRoutesConfig,
  },
};
  
@NgModule({
  imports: [
    ...
    RouterModule.forChild(routes),
    ConfigModule.withConfig(routingConfig),
  ],
```

## Test your FNOL Process on the Storefront

In order to test your FNOL process, perform the following steps:

1. On the storefront, create a travel policy and check if it is available in the **My Policies** section of the **My Account** area (screenshot).
2. Log into the Backoffice, then navigate to **Financial Services** > **Insurance** > **Policies** node.
3. Find the travel policy you created and then click on it to open the context menu.
4. Change the start date and the effective date of the policy to be in the past. This is necessary for the FNOL process to be visible on the storefront immediately.
5. Go back to the storefront and navigate to the **Policies** page in the **My Account** area. You should see the **Make a Claim** button on the travel policy.    
6. Click on the **Make a Claim** button to start the FNOL process.
7. Check if all the forms and steps are as you configured them in the Backoffice. 

    ![Travel FNOL Process - First Step]({{ site.baseurl }}/assets/images/fsa/travel-fnol-first-step.png)

    ![Travel FNOL Process - Second Step]({{ site.baseurl }}/assets/images/fsa/travel-fnol-second-step.png)

8. Fill out the forms and submit the claim. 

    ![Travel FNOL Process - Claim Created]({{ site.baseurl }}/assets/images/fsa/travel-fnol-claim-created.png)

Congratulations! You successfully created a custom FNOL process for your insurance website. 

    

