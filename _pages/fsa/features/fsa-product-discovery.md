---
title: FSA Product Discovery
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries.

This page clarifies the technical implementation of the product discovery feature in the FSA SPA application.

Customers are guided through a structured process to identify the best suitable product for their needs. The main purpose of this feature is to help customers decide whether to choose Life or Savings Insurance but can be applied to other insurance or banking categories and products. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Configuration

The following route configuration defines the semantic link on which product discovery feature is available:
questionnaire: { paths: ['questionnaire'] }

## Components

The structured process that helps customers choose the right product has been implemented in a form of a carousel component. **QuestionnaireCarouselModule** is declaring and exporting **QuestionnaireCarouselComponent** which holds the logic responsible for the rendering of product results, facets (that carry questions), and applied filters.


![product finder carousel]({{ site.baseurl }}/assets/images/fsa/product-discovery/fsa-product-discovery
.png)


The component will initialize product results based on desired facets and create breadcrumbs that provide customers with a preview of products that correspond to the choices they made in the questionnaire. 
When the customer decides to purchase one of the offered products, they can start the checkout by clicking the **SELECT** button on the chosen product. The selected product is defined as the **recommended product** and that information is kept in the local storage. The value of the recommended-product key will be used in the comparison table to separate the chosen product from other available products. The selected product will be highlighted on the UI, together with the corresponding message (This is your recommended product.).




