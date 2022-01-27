---
title: FSA Chatbot
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

The Chatbot feature in Financial Services Accelerator helps customers create support tickets.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The chatbot functionality in Financial Services Accelerator is implemented using SAP Conversational AI.
To implement this functionality into your custom application, you can use the existing Financial Services Accelerator bot as a starting point and then customize it for your particular use cases.
To use our chatbot, you need to integrate with SAP Conversatonal AI and obtain necessary permissions.
The Financial Services Accelerator bot can be found on SAP Conversational AI platform with the name *enterprise-chatbot-fsa-dev*.   
For more details on how to implement the chatbot, see our documentation on the [SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/c106e07964894603ad84d68c2673e9f9.html).   

## Accessing the Chatbot

The customer can access the chatbot from any page on the portal at any time, even during the checkout. 
In the default implementation, the customer starts the conversation with the chatbot by clicking the dialog box positioned in the bottom left corner. 

![Accessing Chatbot from the Homepage]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_homepage.png)

When the customer opens the dialog box, the bot greets him with a welcome message. 

![Chatbot Welcome Message]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_welcome_message.png)

The customer can expand the dialog box for a better preview of the conversation by clicking the first icon in the header.
The "X" icon closes the dialog.

![Chatbot Header]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_header.png)

The look and feel of the dialog box, as well as all the text (call to action, header message, welcome message, etc.) can be customized on the [SAP Conversational AI platform](https://cai.tools.sap/). 
For more information, see Bot Builder documentation on the [SAP Help Portal](https://help.sap.com/viewer/a4522a393d2b4643812b7caadfe90c18/latest/en-US/1d5bf8925496462aad1a181c7e25755a.html).

## Customer Ticket Creation Flow

The Financial Services Accelerator bot guides the customer through the ticket creation procedure with a set of open and multiple-choice questions.
The bot created for this purpose has a set of skills and intents defined, and is trained to recognize expressions related to ticket creation.

When the customer types in that she would like to create a ticket, the bot recognizes her intent, and responds with an adequate message, according to the defined conversation flow.
In this case, the bot first asks the customer to provide her e-mail address, and then prompts her to choose one of the offered subjects for her ticket.  

![Beginning of the Customer Ticket Creation Flow]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_create_customer_ticket_flow.png)

After selecting the subject title, the customer can describe her request. Each time she enters a part of the message, the bot asks her if she's finished writing.
When the customer answers affirmatively, the bot presents the whole content for the customer to review it and submit the request. 

![Customer Writing Flow in Chatbot]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_customer_ticket_flow_claim_information.png)

Customer can also choose to edit the message or the subject of the ticket.

![Editing Ticket Content in Chatbot]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_customer_ticket_flow_edit.png)

When the customer submits the ticket, the bot ask for the medium of communication she wishes to be contacted with. 
If the customer chooses phone over e-mail, she needs to enter the phone number.
Finally, the bot send the request to the back end where the customer ticket is then created.

The customer can submit another request. Otherwise, the conversation ends with the closing thank you note from the bot. 

![End of Conversation in Chatbot]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_customer_ticket_flow_end.png)

## Other Chatbot Functionalities

Besides helping customer create support ticker, the Financial Services Accelerator bot can also perform other actions, such as provide basic information about products, direct customers to Product Discovery questionairre, or to the Contact an Agent page.
In your custom implementation, you can add other skills and intents and train your bot to recognize it. 

![Chatbot Product Info]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_product_info.png)










