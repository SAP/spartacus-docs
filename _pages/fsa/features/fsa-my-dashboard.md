---
title: FSA My Dashboard
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Financial Services Accelerator introduces a single information place for customers called My Dashboard. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

## User Journey 

After logging in, customers can access the Dashboard by clicking the **Dashboard** link in the upper right corner, next to **My Account**. 

![Accessing My Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/my-dashboard-access-link.png)

After they land on the Dashboard, customers can see their personal details on the right, while in the Dashboard Options section on the left, they can see number of existing insurance objects, such as quotes and applications, policies, and claims. 

![My Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/my-dashboard-policies.png)


## Components

Dashboard is a content page (ID *my-dashboard*), which consists of two content slots. 
The first content slot contains `DashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `DashboardFlexComponent`, which maps to the FSA Spartacus `DashboardComponent`, responsible for rendering the dashboard details. 
`DashboardComponent` displays customer's photo, name and other personal details, such as e-mail and date of birth. 




