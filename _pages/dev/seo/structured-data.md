---
title: Structured Dta
---

Structured Data provides a data structure for the web that makes the web content more understandable for web crawlers. With only HTML structure, a web page provides insufficient understanding of the content itself. An `img` element, for example, doesn't provide information whether it represents a product or person. Without more detail, crawlers like Google, Pinterest, Twitter, etc. have a hard time to understand the content. This is where _Structured Data_ kicks in. With structured data you povide various data sets to the page to make the content better understandable by web crawlers. The dta sets should be aligned with standard schema's, which are provided by the schema.org community.

Structured Data has been introduced in Spartacus with version 1.3.

**Tag Managers**

The Structured Data let you add various schema's to the HTML, without using a tag manager solution. While tag managers have great advantages over tags implemented by a development team, there are also certain disadvantages regarding the runtime performance and the covernance of tags.
Structured Data is optional for your project, you could even consider a combination of a tag management solution and the structured data generated in Spartacus.

## Schema types

There are various schema's for the web, and schema's can be extended as well. The schema's are maintained by the schema.org community. Common schema's for commerce are;

-   [WebSite](https://schema.org/WebSite)
-   [Organization](https://schema.org/Organization)
-   [BreadcrumbList](https://schema.org/BreadcrumbList)
-   [Product](https://schema.org/Product)
-   [Reviews](https://schema.org/Reviews)
-   [Offer](https://schema.org/Offer)
-   [Rating](https://schema.org/Rating)

Spartacus has imlemented standard schema's for BreadcrumbList, Product, Review, Rating and Offer. You can further enhance the generated schema's or introduce new schena's to the application as well.

The schema's offer the flexiblity to add different schema's in a script tag, or wrap multiple schema's in an overarching schema. In the standard schema build for product data, the product reviews, offers and rating are part the the product schema.

An alternative or additional approach to add schema's to the website is using a tag management solution. As long as we do not provide a _datalayer_ to GTM, customers will not be able to easily integrate content related data.

### Structured Data Vocabularies

There are three vocabularies that can be used to describe Structured Data on a web page:

-   RDFa
-   Microdata
-   JSON-LD

Spartacus is using JSON-LD. Not only is JSON-LD the recommended format according to Google, it's also an easier format to generate and is decoupeled from the actual UI compnents. The other vocabularies are tightly coupled with UI components, which has a number of disadvantages.

# Implementation details

The creation of the JSON-LD schema's is completely separated from the UI components, so that whenever you replace UI components, you would still benefit from the generated Structured Data.

Since the schema's are only used by crawlers, there's no need to build schema's for every page while end users browse the application. The creation of schema's is therefor limited to the Server Side Rendering process. However, since developers would be involved in evaluating or building the schema's, the schema's are also rendered in development mode.

## Schema Builders

The standard JSON-LD schema's are added to Spartacus during the initialisation of the application.
This is done in the `StructuredDataModule`, which is imported in the `SeoModule`. While the `StructuredDataModule` is added in the 1.3 release, the actual builders are not implicitely added; you need to import the actual _builders_, which are provided by the `JsonLdBuilderModule`. In version 2, the `JsonLdBuilderModule` are likeley to become a standard module of Spartacus.

The `JsonLdBuilderModule` provides two standard schema builders to Spartacus, using the `SCHEMA_BUILDER`.

-   `ProductSchemaBuilder`
-   `BreadcrumbSchemaBuilder`

You can extend the existing builders, or inject additional builders using the `SCHEMA_BUILDER` injection token.

### Breadcrumb schema builder

The `BreadcrumbSchemaBuilder` implementation is relativaly straightforward. The builder collects data from the `PageMetaService` and converts the data to the required schema model, given by [the specifications](https://schema.org/BreadcrumbList).

### Product Schema Buidler

The product schema strucure is more complicated to build. It exists of various parts, inluding the base product data, price and stock (Offer), product ratings (Ratting) and product reviews (Reviews).

The product schema is added by the `ProductSchemaBuilder` class. The actual data collection for the product schema is delegated to `JsonLdBuilder`'s, which can be injected using the `JSONLD_PRODUCT_BUILDER` token. The various product parts are added by using a list of product builders. These builders are added using the `JSONLD_PRODUCT_BUILDER` injection token.

## Json Ld Directive

The JSON-LD schema's require a script tag in the HTML. The `JsonLdDirective` (with selector `cxJsonLd]`) is used by Spartacus to add the data to the document body. The directive bypasses strict XSS security, as otherwise we're not able to append a script tag with JS inside.

You can use the directive to add additional json-ld scripts if needed. You could for example add product schema data for each product in a product list, such as the Product List Page or a carousel.

The SCHEMA LD directives can be used with the following syntax:

```html
<span [cxJsonLd]="{foo: 'bar'}">hello</span>
```

The given json schema will generate the following script tag:

```html
<script type="application/ld+json">
    {
        "foo": "bar"
    }
</script>
```

Note: Spartacus doesn't validate the given json ld schema.
