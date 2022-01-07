---
title: FSA Speak to an Agent
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries.

The **Speak to an Agent** feature offers customers a possibility to easily start a live conversation with an insurance agent. It combines the advantages of an agent-driven approach (person-to-person interactions, no artificial dialogs via chatbot, flexibility in discussions, ability to explain and discuss complex matters) with the flexibility and cost advantages of online communication. This feature is available thanks to the integration of Financial Service Accelerator with SAP partner company SYNCPILOT and their solution Live Contract. Customers can enter the process of starting a live call with an agent by clicking the Speak to an Agent link on a product comparison table. This further leads them to the partner solution login page where they can continue with the process.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

To integrate your project with Live Contract, you first need to set the syncpilot.integration.active property to true in your local.properties file.

## Components

To enable the **Speak to an Agent** feature, and the integration with Live Contract, a new CMS component has been introduced. The CMSConnectionComponent has the following attributes:

- **targetUrl** - The partner solution endpoint.
- **channel** - The channel of the partner solution endpoint.
- **action** - The action executed in the channel.

The next step would be to create an instance of the CMSConnectionComponent, which will be used as an entry point to the partner solution. However, the easiest way to integrate with a partner solution is to use the existing instance created for this occasion - SyncPilotConnectionComponent - and configure it to suit your needs. 

The SyncPilotConnectionComponent can be configured from the Backoffice or by adding an ImpEx file through the Administration Console.

For information on how to configure the SyncPilotConnectionComponent, refer to the [Speak to an Agent documentation on SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/LATEST/en-US/2b40d357decb414faee9e7da240bb5c9.html).

With the following code snippet, you can add the component anywhere in your project:

```typescript
    <ng-container *ngIf="(user$ | async)?.uid">
        <cx-fs-sync-pilot-connection-component></cx-fs-sync-pilot-connection-component> 
    </ng-container>
```

The component is very simple. The target URL is configured on the back-end side of the component so when the user clicks on the link, a new window will open with passed parameters: channel and currently logged-in user details.

## User Interface

Once configured, the SyncPilot CMS Component will be visible on all product comparison pages. Although the default location of this component is the comparison table, you can place it on another location in your custom project.

The customer must be logged in to be able to see the component.

![Speak to an Agent Component]({{ site.baseurl }}/assets/images/fsa/agents/speak_to_agent.png)

When the customer clicks the 'Speak to an Agent' link, they will be is redirected to the partner solution endpoint in the new tab. 

![Live Contract Login Page]({{ site.baseurl }}/assets/images/fsa/agents/sync_pilot_endpoint.png)
