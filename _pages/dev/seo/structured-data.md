---
title: Structured Data
feature:
- name: Structured Data
  spa_version: 1.3
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Structured data is a standardized way of describing the page content of a website to make it easier for web crawlers and search engines to understand. For example, using HTML alone, an `img` element does not indicate whether the element represents a product or a person. When you use structured data, you provide various data sets to the page to make the content easier for web crawlers to classify. The data sets used in Spartacus are aligned with the standard schemas that are provided by the Schema.org community.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Tag Managers

It is possible to use structured data in combination with a tag management system (TMS), but you can also use structured data to add various schemas to your HTML without using a TMS. For example, tag managers have great advantages over tags implemented by a development team, but there can also be certain disadvantages regarding the runtime performance and the governance of tags. Of course, the use of structured data is also optional.

For more information, see [{% assign linkedpage = site.pages | where: "name", "tag-management-system.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system.md %}).

## Schema Types

There are various standard schemas for the web that are maintained by the Schema.org community. Common schemas that are used on e-commerce websites including: WebSite, Organization, BreadcrumbList, Product, Review, Offer, and Rating. Other, custom schemas may also be suggested by certain crawlers.

Spartacus has implemented standard schemas for the following:

- [BreadcrumbList](https://schema.org/BreadcrumbList)
- [Product](https://schema.org/Product)
- [Review](https://schema.org/Review)
- [Offer](https://schema.org/Offer)
- [Rating](https://schema.org/Rating)

You can further enhance the generated schemas or introduce new schemas to the application as well.

### Structured Data Vocabularies

There are three vocabularies that can be used to describe structured data on a web page: RDFa, Microdata, and JSON-LD.

Spartacus uses JSON-LD because it is an easier format to generate, and it is decoupled from the actual UI components. The other vocabularies are tightly coupled with the UI components, which has a number of disadvantages.

## Implementation of JSON-LD Schemas in Spartacus

The creation of the JSON-LD schemas is completely separated from the UI components, so that whenever you replace a UI component, you can still benefit from the generated structured data.

The schemas are only used by crawlers, so there is no need to build schemas for every page while end users are browsing the application. Therefore, the creation of schemas is limited to the Server-Side Rendering process. However, since developers are involved in evaluating and building the schemas, Spartacus also renders the schemas in development mode.

**Note:** To set up JSON-LD schemas in Spartacus, you need to import the `JsonLdBuilderModule` to your application.

## Schema Builders

The standard JSON-LD schemas are added to Spartacus during the initialization of the application. This is done in the `StructuredDataModule`, which is imported in the `SeoModule`.

The `JsonLdBuilderModule` provides the following standard schema builders to Spartacus using the `SCHEMA_BUILDER`:

- `ProductSchemaBuilder`
- `BreadcrumbSchemaBuilder`

You can extend the existing builders, or inject additional builders using the `SCHEMA_BUILDER` injection token.

### Breadcrumb Schema Builder

The `BreadcrumbSchemaBuilder` collects data from the `PageMetaService` and converts the data to the required schema model, as described in the [BreadcrumbList specification](https://schema.org/BreadcrumbList).

### Product Schema Builder

The product schema structure consists of various parts, including the base product data, the price and stock (Offer), the product ratings (Rating), and the product reviews (Review).

The product schema is added by the `ProductSchemaBuilder` class. The actual data collection for the product schema is delegated to `JsonLdBuilder` builders, which can be injected using the `JSONLD_PRODUCT_BUILDER` token. The various product parts are added by using a list of product builders. These builders are added using the `JSONLD_PRODUCT_BUILDER` injection token.

## JSON-LD Directive

The JSON-LD schemas require a script tag in the HTML. Spartacus use the `JsonLdDirective` (with the `[cxJsonLd]` selector) to add the data to the document body. The directive bypasses strict XSS security, because otherwise Spartacus is not able to append a script tag that contains JavaScript.

You can use the directive to add additional JSON-LD scripts if needed. For example, you could add product schema data for each product in a product list, such as the Product List Page, or a carousel.

The SCHEMA LD directives can be used with the following syntax:

```html
<span [cxJsonLd]="{foo: 'bar'}">hello</span>
```

This example JSON schema generates the following script tag:

```html
<script type="application/ld+json">
  {
    "foo": "bar"
  }
</script>
```

**Note:** Spartacus does not validate the JSON-LD schema that is generated inside the script tag.
