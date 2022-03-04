---
title: FSA Inbox
---

**Note**: This feature is introduced with version 1.0 of the FSA Spartacus libraries.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The Inbox feature enables your customers to see all notifications in one place, that is, on the Inbox page of the My Account area. All messages are grouped according to their content, sorted, and then displayed in different tabs.

In addition to that, messages in Inbox can have attachments. The customer will see the paper-clip icon in the message preview as an indicator that the message contains attachments. By clicking on the attachment link, the customer will be redirected to the attachment's URL.

![inbox overview]({{ site.baseurl }}/assets/images/fsa/inbox_attachment.png)

![inbox message open]({{ site.baseurl }}/assets/images/fsa/inbox_attachment_open.png)

More details regarding the Inbox feature from Financial Services Accelerator can be found on the
 [SAP Help Portal](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/abe842cac00a4f34a756cd720d4c2288.html).

## Inbound API

Document inbound is enabled by default with the **financialspastore** extension. FSDocumentPostPersistHook is responsible for creating a message with an attachment for a certain user. Generated Inbox Message can have one document attached or a bundle of documents. If documents are imported as a bundle, they should have the same **bundleId**.

For more information, see  [Inbound API for Correspondence](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/cfe6ce0fba1e45b88db9e076ec801a61.html?q=fsDocumentPostPersistHook).

## Components

The Inbox feature consists of three components, and it comes within inbox.module:

- inbox.component
- inbox-tab.component
- inbox-messages.component

The inbox component has inbox-tab at the top and inbox-messages at the bottom.

```html
<li class="tab"
    *ngFor="let tab of tabs; let i = index"
    (click)="activeTabIndex = i" >
    <cx-fs-inbox-tab 
          [currentTab]="i === activeTabIndex" [tabId]="tab">
    </cx-fs-inbox-tab>
</li>
```

In inbox-tab we are setting the current active tab index so we could render messages for the current tab or navigate to other tabs. According to the selected tab (message group), messages are loaded:

```html
<cx-fs-inbox-messages
  [mobileTabs]="tabs"
  [mobileInitialTab]="mobileGroupTitle"
  [initialGroup]="initialGroupName" >
</cx-fs-inbox-messages>
```

InboxService is the dedicated service for this feature. It has property `activeMessageGroupAndTitle`, which is used to fetch active message group and set the title. The service also provides the following method for loading messages:

```typescript
getMessages(messageGroup, searchConfig: SearchConfig): Observable<any> {
    return this.adapter.getSiteMessagesForUserAndGroup(
      this.inboxData.userId,
      messageGroup,
      searchConfig
    );
}
```
