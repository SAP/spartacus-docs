---
title: FSA Agent Availability
---

**Note**: This feature is introduced with version 3.0 of and enhanced in version 4.0 of the FSA Spartacus libraries.

The integration with Live Contract enables another enhancement of the insurance agent capabilities - besides agent data, customers can also see if a certain agent is currently available. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

To enable this feature, you need to integrate your project with Live Contract. For more information, see [Speak to an Agent]({{ site.baseurl }}{% link _pages/fsa/features/agents/fsa-speak-to-agent.md %}).

## Integration

To enable this particular functionality of the integration with Live Contract, add the following ImpEx file through the Administration Console:

```sql

INSERT_UPDATE Endpoint; id[unique = true]; version[unique = true]; name; specUrl
; syncPilot-agent-request ; unknown ; syncPilot-agent-request ; "https://sync-pilot-integration-server-url"
INSERT_UPDATE DestinationTarget; id[unique = true]
; syncpilot-agent-destination
INSERT_UPDATE ConsumedDestination[impex.legacy.mode = true]; id[unique = true]; url; endpoint(id, version); destinationTarget(id);
; FS-SyncPilot-Agent-Request ; "https://sync-pilot-integration-server-url" ; syncPilot-agent-request:unknown ; syncpilot-agent-destination ;

```
Note that the integration server link is specific for each integration. In the ImpEx, enter the one created for your project.

## User Interface

With this functionality enabled, logged-in customers can see the agent availability on both the Map and the List View of the **Find an Agent** page. 
Based on this, customers will know which agent they can contact.

![Agent Availability on the Map View]({{ site.baseurl }}/assets/images/fsa/agents/find-agent-map-view-agent-availability-2202.png) 

When the agent is online, on the Map view, their profile image is circled with a blue line with a green dot. 
Also, the phone icon indicates that the agent is available for a call.

![Online Agent on Map View]({{ site.baseurl }}/assets/images/fsa/agents/online-agent-card-map-2202.png) 

On the List view, the phone icon inside the agent card shows that the agent is online.

![Online Agent on the List View]({{ site.baseurl }}/assets/images/fsa/agents/online-agent-list-view-2202.png)  
 
