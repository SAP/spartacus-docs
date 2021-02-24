---
title: Document Upload
---

**Note**: This feature is introduced with version 2.0 of the FSA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Document Upload Usage](#document-upload-usage)
- [File Upload](#file-upload) 

## Overview

The Document Upload feature is one of the many components implemented in the Dynamicforms library and is used to enable the user to upload one or multiple images, documents, audio, video, and other file types to a server.

The Document Upload API creates a document that is assigned to a specified user. The API response is the newly created document. As the document is uploaded for a specific customer, the client needs to obtain an access token before the actual upload and gain access to the Upscale Service APIs. OAuth Client Security is implemented in order for a client application to securely access the Document Upload API. When using the OAuth 2.0 client, data will always be secure, because an HTTPS connection secures the communication between the OAuth 2.0 client and the server.

Financial Services Accelerator offers insurance customers the possibility to upload documents during the FNOL process. Once the documents are uploaded, the customer can download and check them, or delete them. Although the document upload is implemented in the FNOL process, it can be used in any other process (e.g. application/quotations, change request process).


## Document Upload Usage

Dynamic Forms is a library for creating forms, designed to work with Spartacus application. It allows customers to define forms metadata in JSON configuration and render them on the UI. 

The following example shows a JSON representation of the document upload form control:  

```json
{
    "label": {
        "en": "Please upload files relevant to the incident:",
        "de": "Bitte laden sie dateien hoch, die für den vorfall relevant sind:"
    },
    "name": "relevantFiles",
    "fieldType": "upload",
    "required": true,
    "multiple": true,
    "maxUploads": 4,
    "accept": [
        "application/pdf",
        "text/plain",
        "image/png",
        "image/jpeg",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ],
    "maxFileSize": 5242880
}
```


| Properties                   | Description                                                 	|
| :---                         | :---	|
| `label`                      | Represents a localizable caption for an item in a user interface.                         |
| `name`                       | Identification of upload form control.           	|
| `fieldType`                  | The upload fieldType is used to create interactive upload control for dynamic-based forms.|
| `required`                   | When present, it specifies that an input field must be filled out before submitting the form.
| `multiple`                   | Specifies that the user is allowed to enter/select more than one value. Should be set it to " true " if you wish to allow uploading multiple files at once and to " false " for a single file upload (i.e. one by one). |
| `maxUploads`                 | A maximum number of files that can be uploaded at one time.
| `accept`                     | Specifies a filter for what file types the user can pick from the file input dialogue box.
| `maxFileSize`                | Maximum size limit for files in bytes. |

## File Upload

The previous example demonstrates how to upload the files to the server. Users have the possibility to upload images, Microsoft Office, PDF, and plain text files that are up to 5.0 MB in size. This sample limits the maximum number of files that can be uploaded to 4. The cx-upload component allows you to validate the file type and limit the file size using the maxFileSize property.

![document upload]({{ site.baseurl }}/assets/images/fsa/document-upload.png)

The component displays a built-in progress bar (progress indicator) with the progress percentage during each file upload. Once the upload is finished, the user should be able to download the uploaded file, and the file will be marked with a check icon.

![progress bar during document upload]({{ site.baseurl }}/assets/images/fsa/document-upload-progress-bar.png)

When a user clicks the **UPLOAD** button, a new instance of DocumentModel is created in CommerceSuite. Relevant information during document upload is:

- content of the document
- document name
- document object identifier
- customer external id

In the Backoffice, the uploaded file can be found under Document itemtype.  

![uploaded document in backoffice]({{ site.baseurl }}/assets/images/fsa/document-upload-backoffice.png)