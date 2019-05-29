---
layout: home
title: Installing SAP Commerce Cloud
---

The Spartacus JavaScript Storefront uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator electronics storefront in particular.

Note: The latest release of SAP Commerce Cloud is recommended. These instructions are based on a setup with SAP Commerce Cloud Release 1811 as the back end.

Perform the following steps to set up your back end:

- Install a new instance of SAP Commerce Cloud using the `b2c_acc_plus` recipe, as follows:

  1.  In the `installer/recipes` folder of SAP Commerce Cloud, make a copy of `b2c_acc_plus` and call it `b2c_for_spartacus`.

  2.  Delete the existing `build.gradle` file in the `b2c_for_spartacus` recipe folder.

  3.  Add this [build.gradle](https://github.com/SAP/cloud-commerce-spartacus-storefront/blob/develop/docs/archived_installation_docs/back_end_installation/1811/build.gradle) file to your `b2c_for_spartacus` recipe folder.

  4.  Follow the instructions in https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html to install, initialize and start a new instance of SAP Commerce 1811, using `b2c_for_spartacus` as the recipe name.

- Import `spartacus_sample_data.impex`, which you can download here: https://github.com/SAP/cloud-commerce-spartacus-storefront/tree/develop/docs/archived_installation_docs/impex_sample_data

  For more information on importing ImpEx, see https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/2f095d195c0740aab4b0bbdf0f0a2d12.html.

- Configure your OCC client, as described here: https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html#loio4079b4327ac243b6b3bd507cda6d74ff

- Configure the `corsfilter` settings, as described here: https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c91f3a486691014b085fb11c44412ff.html