---
title: FSA Find an Agent
---

**Note**: This feature is introduced with version 1.0 of the FSA Spartacus libraries.

The **Find an Agent** feature allows customers to locate points of service and agents on the map, or select agents from the product category list. 
Customers can also fill in a contact form and submit it to the agent, requesting a contact.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The Find an Agent feature consists of three separate views:

- a Google map with all points of service listed, together with related agents (a map view: Agent Locator)
- a list of insurance categories with agents related to them (a list view: Find an Agent)
- a Contact Expert page to get in contact with an agent

For more details on implementation of each of these views, see the [Find an Agent documentation on SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/LATEST/en-US/38f6a987f43f4be0b7e0cd7d6d660f19.html).


## User Interface

### Map View

This view opens by default when the user clicks the **Find an Agent** link in the header. 
Full map view is available if the customer enables current location in the browser. 
In such case, the search is refined and the customer can see which agents are closest to them. 
Otherwise, they can search for an agent by typing their name or an insurance type they need. 
In the current implementation, up to 10 agents are displayed per page, but this can be changed through the Administration Console.

![Map View]({{ site.baseurl }}/assets/images/fsa/agents/find_agent_map_view_2202.png)

### List View

By going to the list view, you can see a list of agents grouped by their respective areas of expertise. 
When the user clicks the + button on the selected insurance type accordion, agents who are experts in that area are displayed in form of cards.

![List View]({{ site.baseurl }}/assets/images/fsa/agents/find_agent_list_view_2202.png)

Click on the email icon below agent image opens the Contact Agent form (see the section below), while the location icon opens map view for the selected agent only.
If you are integrated with Live Contract application, and the agent is currently online, a phone icon will be displayed, too, allowing the customer to start a video call with the agent.
For more information, see [Agent Availability]({{ site.baseurl }}{% link _pages/fsa/features/agents/fsa-agent-availability.md %}).


### Contact Expert

This view includes a contact form, displayed in a separate page for each agent. Customers can access the page by clicking the Contact button displayed under each agent on the Map view, or the email icon displayed under each agent in the List view.

Through this page, customers can provide the relevant details regarding their policy, or a quote, and request a contact with a specific insurance agent, in charge of a specific insurance category. 
As a result of this action, the contacted agent receives an email together with relevant contact details. Upon receiving the request, the agent can assist the customer by accessing their account through Assisted Service Mode.

![Contact Agent Page]({{ site.baseurl }}/assets/images/fsa/agents/contact_agent_form.png)
