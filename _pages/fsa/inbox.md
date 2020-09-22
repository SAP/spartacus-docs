---
title: Inbox
---

## Overview
The Inbox feature enables your customers to see all notifications in one place, that is, on the Inbox page of the My Account area. All messages are grouped according to their content, sorted, and then displayed in different tabs.

More details regarding Inbox feature from Financial Services Accelerator could be found
 [here](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/abe842cac00a4f34a756cd720d4c2288.html).
In addition to that, messages in Inbox can have attachments. Customer can see the icon as an indicator of some attachments, and by clicking on the attachment link customer will be redirected to the attachment url. 

![inbox overview]({{ site.baseurl }}/assets/images/fsa/inbox_attachment.png)


![inbox message open]({{ site.baseurl }}/assets/images/fsa/inbox_attachment_open.png)

## Inbound API

Document inbound is enabled by default with **financialspastore** extension. FSDocumentPostPersistHook is responsible for creating message with attachment for certain user. Generated Inbox Message could have one document attached or bundle of documents. If documents are imported as a bundle, they should have the same **bundleId**. 
See  [Inbound API for Correspondence](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/cfe6ce0fba1e45b88db9e076ec801a61.html?q=fsDocumentPostPersistHook) for more details.

## SPA Components

Inbox feature consists of three components and it comes within inbox.module:
- inbox.component
- inbox-tab.component
- inbox-messages.component

Inbox component have inbox-tab at the top and inbox-messages at the bottom.
  ```html
  <li class="tab"
      *ngFor="let tab of tabs; let i = index"
      (click)="activeTabIndex = i" >
      <cx-fs-inbox-tab 
            [currentTab]="i === activeTabIndex" [tabId]="tab">
      </cx-fs-inbox-tab>
    </li>
  ```
In inbox tab we are setting current active tab index so we could render messages for current tab or navigate to other tabs. According to the selected tab(message group) messages are loaded:
  ```html
  <cx-fs-inbox-messages
    [mobileTabs]="tabs"
    [mobileInitialTab]="mobileGroupTitle"
    [initialGroup]="initialGroupName" >
  </cx-fs-inbox-messages>
  ```
InboxService is dedicated service for this feature, it has property `activeMessageGroupAndTitle` which is used to fetch active message group and set the title, also service provides following method for loading messages:
    ```typescript
    getMessages(messageGroup, searchConfig: SearchConfig): Observable<any> {
       return this.adapter.getSiteMessagesForUserAndGroup(
         this.inboxData.userId,
         messageGroup,
         searchConfig
       );
    }
    ```
