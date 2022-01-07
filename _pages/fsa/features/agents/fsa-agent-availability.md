---
title: FSA Agent Availability
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries.

The integration with Live Contract enabled another enhancement of the insurance agent capabilities - besides agent data, customers can also see if a certain agent is currently available. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

To enable this feature, you need to integrate your project with Live Contract. For more information, see [Speak to an Agent]({{ site.baseurl }}{% link _pages/fsa/features/agents/fsa-speak-to-agent.md %}).

## Integration

To enable this particular functionality of the integration with Live Contract, add the following ImPex file through the Administration Console:

```ts

INSERT_UPDATE Endpoint; id[unique = true]; version[unique = true]; name; specUrl
; syncPilot-agent-request ; unknown ; syncPilot-agent-request ; "https://<URL_AGENT_SERVER>/beraterpoolServer/beraterpool/server/v1/owner/1/consultants-active"
INSERT_UPDATE DestinationTarget; id[unique = true]
; syncpilot-agent-destination
INSERT_UPDATE ConsumedDestination[impex.legacy.mode = true]; id[unique = true]; url; endpoint(id, version); destinationTarget(id);
; FS-SyncPilot-Agent-Request ; "https://<URL_AGENT_SERVER>/beraterpoolServer/beraterpool/server/v1/owner/1/consultants-active" ; syncPilot-agent-request:unknown ; syncpilot-agent-destination ;
```
Note that the integration server link is specific for each integration and in the ImpEx, you need to enter the one created specifically for your project.

## User Interface

Once enabled, customers are able to see the agent availability on the Map View of the **Find an Agent** page. Below the agent profile image, the availability will be displayed as online or offline. Based on this, customers will know which agent they can contact.

![Agent Availability on the Find an Agent Page]({{ site.baseurl }}/assets/images/fsa/agents/map_view_agent_availability.png)  
