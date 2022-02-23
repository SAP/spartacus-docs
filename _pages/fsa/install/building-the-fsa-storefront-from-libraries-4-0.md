---
title: Building the FSA Spartacus Storefront using 4.0 Libraries
---

The following instructions describe how to build an FSA storefront application using published FSA Spartacus 4.x libraries. 
If you are building Spartacus from the source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before carrying out the procedures below, ensure the following front-end and back-end requirements are in place.

### Front-End Development Requirements

Your Angular development environment should include the following:

- **Angular CLI**: Version 12.0.5 or later.
- **node.js**: Version 14.x is recommended.
- **yarn**: Version 1.22.x or later.

### Back-End Server Requirements

FSA Spartacus uses SAP Commerce and Financial Services Accelerator back end and makes use of the sample data.

- **SAP Commerce version**: Release **2105** (the latest patch is recommended).
- **Financial Services Accelerator version**: Release **2202** is required.

For more information, see [Installing SAP Commerce Cloud FSA for use with FSA Spartacus]({{ site.baseurl }}{% link _pages/fsa/install/installing-sap-commerce-with-fsa-spartacus.md %}).

### Windows Setup

To successfully install the project in the Windows environment, first make sure that you have installed GitBash.

Next, create the .npmrc file at the root of your Angular project.
The .npmrc file should contain the following:

```shell
shell = "{instalation directory}\\Git\\bin\\bash.exe" 
script-shell = "{instalation directory}\\Git\\bin\\bash.exe" 


Example:
shell = "C:\\Program Files\\Git\\bin\\bash.exe"
script-shell = "C:\\Program Files\\Git\\bin\\bash.exe"
```

Once you have configured this, you should execute all the commands in the procedures that follow from the GitBash console.

## Creating a New Angular App

The following procedure describes how to create a new Angular application with the name `mystore`.

1. Open a terminal or command prompt window at the location of your choice.
2. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

   When prompted for Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

3. Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## FSA Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to set up your application quickly.

You can add FSA Spartacus libraries to your Spartacus Angular project by running the following command from your project root:

```shell
ng add @spartacus/fsa-schematics --baseSite=sample-financial-site --currency=usd,eur --language=en,de,fr
```

For a detailed explanation, see [FSA Schematics]({{ site.baseurl }}{% link _pages/fsa/install/fsa-schematics.md %}).

For a full list of available parameters, see Spartacus schematics [documentation](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

**NOTE**: After you finish this step, you need to upgrade your FSA Spartacus application to version 4.0. 
For instructions, see ???

### Installing Dependencies

**NOTE**: If you installed dependencies during upgrade to version 4.0, you can skip this step.

Install dependencies needed by your FSA Spartacus app with the following command:

```bash
yarn install
```

### Starting your Spartacus App

**NOTE**: If you started the app during upgrade to version 4.0, you can skip this step.

Start your app with the following command:

```bash
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming you installed everything locally, browse to `http://localhost:4200`. 
If you installed the Financial SPA Sample Data with the *financialprocess* extension, the FSA Spartacus storefront for financial services should appear.

**Note:** If your storefront doesn't appear, you probably have to accept a privacy certificate. 
To do so, browse to `https://localhost:9002/occ/v2/financial/cms/pages`, and then accept the privacy certificate. 
This step is necessary because your browser will block calls to the app which makes calls to `localhost:9002`, due to security settings. 
To see the browser message, right-click in your browser, select **Inspect**, then click **Console**.


Congratulations! You've built your first FSA Spartacus storefront.
