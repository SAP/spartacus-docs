---
title: FSA My Dashboard
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Customers can now see an overview of the most important information from the *My Account* area on a separate summary page called **Dashboard**.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

Logged-in customers can access the Dashboard page to see an overview of their profile and their activities on the portal.
Beside personal details, such as name, e-mail address and date of birth, customers can preview their quotes and applications, policies and claims.

## User Journey 

When customers log into the portal, they can access the Dashboard by clicking the link in the upper right corner, next to **My Account**. 

![Accessing My Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/my-dashboard-access-link.png)

After they land on the Dashboard, customers can see their photo and personal details in the *Your Profile* section on the right, while on the left, in the *Dashboard Options* section, they can see number of their insurance objects: claims, policies, and quotes and applications. 
For each of these objects, the customer can open a list to see the details of each object item, such as ID number, payment frequency and status.
To open a list for the desired object, the customer clicks on the corresponding card. 
The list opens in a separate section below the previously mentioned sections.   

![My Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/my-dashboard-policies.png)


## Components

My Dashboard is a content page with ID `user-profile`. 
This content page consists of a content slot that contains `UserProfileFlexComponent` which is mapped to Spartacus `UserProfileComponent`, responsible for rendering the customer's details.  
The `UserProfileComponent` displays customer's personal details (name, e-mail, date of birth, and avatar), and the paginated list of customer's insurance objects (claims, quotes and applications, policies). 

`UserProfileComponent` is declared and exported in `UserProfileModule`.

The page route is */user-profile/*.

The following guards, provided by Spartacus, are used to protect the Dashboard page:
 - `AuthGuard` 
 - `CmsPageGuard` 

These guards prevent users who are not logged in to see the Dashboard page.


