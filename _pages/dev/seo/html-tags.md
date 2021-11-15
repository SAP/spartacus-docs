---
title: HTML Tags
feature:
- name: HTML Tags
  spa_version: 1.0
  cx_version: n/a
---

HTML tags, and meta tags in particular, allow search engines, social platforms, and bots to use page meta data in their platforms. By carefully preparing meta tags, and evaluating their values on a regular basis, you can improve the page ranking, click-through-rate, and usability of a page. All of this can affect SEO and the user experience.

Page meta tags are written into the head of the HTML. In HTML5, you can use a variety of meta tag properties, such as `title` and `description`. These meta tags are used by search engines, social platforms and crawlers. Some social platforms have introduced their own sets of properties that are specific to their platforms. For example, Facebook uses the Open Graph protocol, which enables any web page to become a rich object in a social graph. Specific meta tags can be used to describe the experience on the social platform. The code snippet below shows a custom page description for Facebook:

```html
<meta property="og:title" content="Custom title for Facebook" />
<meta property="og:description" content="Custom description for Facebook" />
```

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Structured Data (schema.org)

While page meta tags can be of great help to describe the page content, crawlers have started to leverage an alternative technique to better understand the content. This technique is called "structured data", and is also supported in Spartacus. You can use structured data and meta tags together on the same page. Each technique has its own specific purpose and use, with a fair amount of overlap. Crawlers use both techniques when they evaluate the page content.

For more information on structured data in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "structured-data.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %}).

## Supported Meta Tags

Spartacus supports the following meta tags, which can be further customized to meet your needs:

| content      | (meta) tag                                                                       |
| ------------ | -------------------------------------------------------------------------------- |
| page title   | The page title is written in the `<title>` element in the head of the page.      |
| page heading | The page heading is added to the `<h1>` element inside the breadcrumb component. |
| description  | The page description is added to the `description` meta tag.                     |
| image        | The (product) image is added to the `og:image` meta tag.                         |
| robot        | The robot values are written to the `robots` meta tag.                           |
| canonicalUrl | The canonical URL is added to a link with the `rel="canonical"` attribute.       |

The actual creation of a tag, along with its value, depends on the page type. For example, the image tag is only added to the product details pages.

For more information on the tags supported by Spartacus, including how data is resolved for each tag, see the related sections below.

## Customizing Meta Tags

The content that is used for meta tags is driven by back end (runtime) data wherever possible. The image tag for the product details page, for example, uses the main product image. Another example is the title for the product details page, which is constructed from the product title, the (first) category, and the brand.

If you want to further customize the creation of meta tags, you can implement a custom `PageMetaResolver` and add it into your module's providers. The following is an example:

```ts
    {
      provide: PageMetaResolver,
      useExisting: YourCustomPageMetaResolver,
      multi: true,
    },
```

Page resolvers generate the content for the meta data for a specific page. The list of standard page resolvers can be further adjusted to meet your needs.

From version 3.1 onwards, page resolvers are configurable, and this allows you to extend resolvers more easily to meet your needs. The resolvers are taken into account by the `PageMetaService` to construct the `PageMeta` object. The `PageMeta` object is primarily used by the `SeoMetaService` for the creation of the actual tags.

Most of the page meta data is used by crawlers and is therefore not of interest while a user is navigating your application. Accordingly, each meta data tag can be configured so that it is only created on the server (SSR). This simplifies building the page, and therefore improves performance. However, if you want to debug the meta tags in development, you can use the `pageMeta.enableInDevMode` configuration flag.

### Title Resolver

Adding an HTML `title` tag to your page has the following advantages:

- the page can be uniquely addressed in the browser (that is, through the browser history, bookmarks, tabs, and so on)
- the page title increases the ranking of the page in search engines
- the page title identifies content in search engines

Spartacus provides a special resolver for pages that require a specific heading. The page title for a search engine result page (SERP) is not necessarily the same as the page heading shown in the UI. Let's look at the product title as an example. To achieve good results in the SERP, a product details page would typically disclose the product title, category, and brand, as follows:

`Product Title | Main category | Brand`

However, such a title does not look good in the UI, so a different title is used for that. To support flexibility, Spartacus uses a specific `PageHeadingResolver` that can be implemented in the page resolving logic.

### Description Resolver

Each page in the storefront can contain a `description` tag. The description tag is used in the search engine result page to improve the click-through-rate (CTR). It is not used to improve the page ranking. It is generally considered best practice to create a description tag for each page, although there are occasions when the search engine is more capable of generating the description based on the context.

### Image Resolver

To share pages with social media, such as Facebook, Twitter, Pinterest, and so on, it is important to provide the correct image in the meta tags. The Open Graph standard from Facebook is widely adopted for this purpose. The following tag can be used to tell social media to use a specific image:

```html
<meta name="og:image" value="https:storefont.com/myimage" />
```

While it is possible to provide multiple images by replicating the tag with different values (for a gallery of images, for example), Spartacus only provides a solution for a single image. This is considered best practice for commerce storefronts.

You can implement the `PageImageResolver` to resolve a specific image for a specific page. The `ProductPageMetaResolver` demonstrates an implementation of the `PageImageResolver` by providing the main product image URL for the product details page.

### Robots Tag

You can use the `robots` meta tag to control whether or not a page is indexed by a search index. The robot information can guide the search index to indicate whether the page should be indexed and whether the links on the page should be followed.

Most of the pages should be indexed and followed. However, some pages contain private information, or irrelevant content that should not be indexed. While the robot information can be resolved by page resolvers, Spartacus 3.1 introduces a standard page resolver that populates the page robot information provided by the CMS page data. If you are using SAP Commerce Cloud 2005 or newer, you can maintain robot information in the CMS.

The following table lists the values that can be used to guide search engines:

| Value    | Description                                                                              |
| -------- | ---------------------------------------------------------------------------------------- |
| INDEX    | Instructs the search engine to index the page                                            |
| NOINDEX  | Instructs the search engine to **not** index the page                                    |
| FOLLOW   | Instructs the search engine to follow the links on the page for further indexing         |
| NOFOLLOW | Instructs the search engine to **not** follow the links on the page for further indexing |

Spartacus provides a separate `PageRobotsResolver` interface that you can use to control the `robots` meta tag. The `PageMetaService` uses `FOLLOW, NOINDEX` whenever no value is provided by the `PageMeta`.

The `CheckoutPageMetaResolver` demonstrates the usage of the `PageRobotsResolver` and instructs search engines to not index the page nor follow any links on the page.

### Canonical URLs

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Using the Spartacus canonical URLs feature could result in a breaking change if you already have a custom canonical URL in place. Accordingly, this feature will only be part of the default configuration starting from Spartacus 4.0. However, you can use this feature in 3.2 (or newer) by adding the following resolver configuration:

```ts
pageMeta: {
  resolvers: [
    {
      property: 'canonicalUrl',
      method: 'resolveCanonicalUrl',
      disabledInCsr: true,
    },
  ];
}
```

A canonical URL provides a single URL to a page, and this URL is used by crawlers to optimize the search index. When a page has a canonical URL, it help crawlers to avoid identifying the page as duplicated content. Without a canonical URL, subtle differences in (generated) URLs are considered duplicates, and this could impact the ranking of the page.

URL variations might be introduced by external systems (such as social platforms), or they may be caused by the internal mechanism of the web application. The following are common examples of URL variations:

- links to pages with query parameters from social platforms: the query parameters are different from user to user, but the actual page is the same.
- product variations that only differ in the selected size or colour: the URL is different, but the content is 99.99% similar.
- filtering product listing pages by using query or route parameters: the actual page content might be the same using various filters.

The following are a few common techniques for normalizing the URL:

- always add `https://`, and avoid `http://`
- always add `www.`
- remove (certain) query parameters
- add a trailing slash to all URLs, except in the case of remaining query parameters

The `PageMetaConfig` configuration allows you to configure these aspects of the canonical URL creation. The default configuration for Spartacus adds `https`, as well as the trailing slash, and removes the query parameters, as shown in the following example:

```ts
pageMeta: {
    canonicalUrl: {
      forceHttps: true,
      forceWww: false,
      removeQueryParams: true,
      forceTrailingSlash: true
    }
}
```

The `www` subdomain is not added because you might use a subdomain for your storefront that Spartacus cannot detect in an efficient way.

The canonical resolver for the product details page uses the product data to indicate whether the canonical URL should be created for the current product or, in the case of a variant product, whether it should use the `baseProduct` for the creation of the canonical URL. Most likely, variations of the same products are very similar in terms of the product details page, and should be exposed as the base product to avoid duplicated content.
