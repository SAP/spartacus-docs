---
title: FSA Speak to an Agent
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries and enhanced with version 4.0.

The **Speak to an Agent** feature offers customers a possibility to easily start a live conversation with an insurance agent. 
It combines the advantages of an agent-driven approach (person-to-person interactions, flexibility in discussions, ability to explain and discuss complex matters) with the flexibility and cost advantages of online communication. 
This feature is available thanks to the integration of Financial Service Accelerator with SAP partner company SYNCPILOT and their solution Live Contract. 
Customers can enter a live conversation with an agent all the way through the quotation and application process, as well as from the Agent pages. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Integration

To integrate your project with Live Contract, you first need to set the syncpilot.integration.active property to true in your local.properties file.
The next step would be to create an instance of the *CMSConnectionComponent*, which will be used as an entry point to the partner solution. 
For easier integration, we recommend you use the existing instances of the CMSConnectionComponent, introduced for this occasion, and then just configure them to suit your needs. 
When configured, the components will are visible on the storefront to your customers when they're logged in.

## Components

The available components are:

- *CmsSyncPilotComponent* - a reusable component that can be easily configured through the Backoffice. 
When triggered, calls the first available agent. 
In the default implementation, used in the checkout process.
- *GenericSyncPilotComponent* - a more restricted components, meant to be used by developers, 

The *CmsSyncPilotComponent* can be configured from the Backoffice or by adding an ImpEx file through the Administration Console.
For information on how to configure the *CmsSyncPilotComponent*, refer to the [Speak to an Agent documentation on SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/LATEST/en-US/2b40d357decb414faee9e7da240bb5c9.html).
-------
With the following code snippet, you can add the component anywhere in your project:

```typescript
    <ng-container *ngIf="(user$ | async)?.uid">
        <cx-fs-sync-pilot-connection-component></cx-fs-sync-pilot-connection-component> 
    </ng-container>
```

The component is very simple. The target URL is configured on the back-end side of the component so when the user clicks on the link, a new window will open with passed parameters: channel and currently logged-in user details.

--------



The *GenericSyncPilotComponent* can be used for:
                              
- contacting the first available agent from the product comparison page, when the customer is in doubt about which product to choose, and therefore needs support
- contacting a specific agent on the Find an Agent page, provided that that agent is currently available. When used, the component is placed inside the agent information card, on both Map and List views.

Depending on the purpose, the *GenericSyncPilotComponent* has two designs. 
When it's placed on the comparison table, the component contains an icon, a title, and a link. 
When placed inside the agent card on the Find an Agent page, contains only an icon element. 
The component, in this case, needs to be passed the agent attribute and is connected to agent availability, which is a separate functionality.

## User Interface

Once configured, the SyncPilot CMS Component will be visible on all product comparison pages. 
Although the default location of this component is the comparison table, you can place it on another location in your custom project.

The customer must be logged in to be able to see the component.

![Speak to an Agent Component]({{ site.baseurl }}/assets/images/fsa/agents/speak_to_agent.png)

When the customer clicks the 'Speak to an Agent' link or the phone icon, they will be is redirected to the partner solution endpoint in the new tab. 

![Live Contract Login Page]({{ site.baseurl }}/assets/images/fsa/agents/sync_pilot_endpoint.png)
