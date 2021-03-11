---
title: Html Tags
feature:
  - name: Html Tags
    spa_version: 1.0
    cx_version: n/a
---

HTML tags, and meta tags in particular, are used by search engines, social platforms, and bots to display page meta data on their platforms. By carefully preparing the meta tags, and evaluating their values on a regular basis, you can improve the page ranking, click-through-rate and usability of a page. All of this can affect SEO and the user experience.

Page meta tags are written into the head of the HTML. HTML5 supports a variety of meta tag properties, such as `description`. These meta tags are used by search engines, social platforms and crawlers. Some social platforms have introduced their own sets of properties that are specific to their platforms. For example, Facebook uses the Open Graph protocol that enables any web page to become a rich object in a social graph. Specific meta tags can be used to articulate the experience on the social platform. The code snippet below shows a custom page description for Facebook:

```html
<meta property="og:title" content="Custom title for Facebook" />
<meta property="og:description" content="Custom description for Facebook" />
```

## Structured Data (schema.org)

While page meta tags can be of great help to articulate the page content, crawlers have started to leverage an alternative technique to better understand the content. This technique is called _structured data_, which is supported in Spartacus as well. This is [documented as a separate topic]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %}). You can use structured data and meta tags together on a page. Each techniques has it's own specific purpose and use with a fair amount of overlap. Crawlers use both techniques when they evaluate the page content.

## Supported Meta Tags

Spartacus supports a certain amount of meta tags, which can be further customized to your needs.

| content      | (meta) tag                                                                       |
| ------------ | -------------------------------------------------------------------------------- | --- |
| page title   | The page title is written in `<title>` element in the head of the page.          |
| page heading | The page heading is added to the `<h1>` element inside the breadcrumb component. |
| description  | The page description is added to the `description` meta tag.                     |
| image        | The (product) image is added to the `og:image` meta tag.                         |
| robot        | The robot values are written to the `robots` meta tag.                           |     |
| canonicalUrl | The canonical url is added to a link with the `rel="canonical"` attribute.       |

The actual creation and values of the tags differ per page. For example, the image tag is only added for product detail pages.

More information on the specific tags and how the data is resolved can be found below in this page.

## Customize Meta Tags

The content that is used for the meta tags is driven by backend (runtime) data wherever possible. The image tag for the product detail page, for example, uses the main product image. Another example is the title for the product detail page, which is constructed from the product title, (first) category and brand.

If you like to further customize the creation of meta tas, you can implement custom `PageMetaResolvers`. Page resolvers generate the content for the meta data for a specific page. The list of standard page resolvers can be further adjusted to your needs.

From version 3.1 onwards, page resolvers are configurable so that you can extend resolvers more easily to your needs. The resolvers are taken into account by the `PageMetaService` to construct the `PageMeta` object. The `PageMeta` object is primarily used by the `SeoMetaService` for the creating of the actual tags.

Most of the page meta data is used by crawlers and is therefor not of interest while the user is navigating the application. Each meta data tag can therefor be configured to be created on the server (SSR) only. This will simplify building the page and therefor improves performance. If you want to debug the meta tags in development you can however use the `pageMeta.enableInDevMode` configuration flag.

### Title Resolver

Adding an HTML `title` tag to your page has the following advantages:

- the page can be uniquely addressed in the browser (that is, through the browser history, bookmarks, tabs, and so on)
- the page title increases the ranking of the page in search engines
- the page title identifies content in search engines

Spartacus provides a special resolver for pages that require a specific heading. The page title for a search engine result page (SERP) is not necessarily the same as the page heading shown in the UI. Let's look at the product title as an example. To achieve good results in the SERP, a product details page would typically disclose the product title, category, and brand, as follows:

`Product Title | Main category | Brand`

However, such a title does not look good in the UI, so a different title is used for that. To support flexibility, Spartacus uses a specific `PageHeadingResolver` that can be implemented in the page resolving logic.

### Description Resolver

Each page on the storefront can contain a `description` tag. The description tag is used in the search engine result page to improve the click-through-rate (CTR). It is not used to improve the page ranking. It is generally considered best practice to create a description tag for each page, although there are occasions when the search engine is more capable of generating the description based on the context.

### Image Resolver

To share pages with social media, such as Facebook, Twitter, Pinterest, and so on, it is important to provide the correct image in the meta tags. The Open Graph standard from Facebook is widely adopted for this purpose. The following tag can be used to tell social media to use a specific image:

```html
<meta name="og:image" value="https:storefont.com/myimage" />
```

While it is possible to provide multiple images by replicating the tag with different values (for a gallery of images, for example), Spartacus only provides a solution for a single image. This is considered best practice for commerce storefronts.

You can implement the `PageImageResolver` to resolve a specific image for a specific page. The `ProductPageMetaResolver` demonstrates an implementation of the `PageImageResolver` by providing the main product image URL for the product details page.

### Robots Tag

You can use the `robots` meta tag to control whether or not a page is indexed. The following is an example:

```html
<meta name="robots" value="FOLLOW, NOINDEX" />
```

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

This feature is introduced in version 3.2. Since introducing canonical URLs can be a breaking change for those who have already a custom canonical URL in place, this feature will be part of the default configuration in version 4. You can however use this feature in 3.2 and above, by adding the following resolver configuration:

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

A canonical URL is used by crawlers to optimize the search index by providing the single URL to a page and avoid the notion of so-called duplicated content. Without a canonical URL, subtle differences in (generated) URLs variations are considered duplicates, which might impact the ranking of the page.

URL variations might be introduced by external systems (such as social platforms) or caused by the internal mechanism of the web application. Common examples of URL variations are:

- links to pages with query parameters from social platforms; the query parameters differ from user to user, but the actual page is the same.
- product variations that only differ in the selected size or colour; the URL is different, but the content is 99,99% similar.
- filtering product listing pages by using query or route parameters; the actual page content might be the same using various filters.

There are a few common techniques to normalize the URL:

- always add `https://`, avoid `http://`
- always add `www.`
- remove (certain) query parameters
- add a trailing slash to all URLs, except in case of remaining query parameters

The `PageMetaConfig` configuration allows to configure these aspects of the canonical url creation. The default configuration for Spartacus adds https, the trailing slash and removes the query parameters:

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

The `www` subdomain is not added since you might use a subdomain for your storefront that we're not able to detect in an efficient way.

The canonical resolver for the product detail page is using the product data to indicate whether the canonical url should be created for the current product or - in case of a variant product - should use the baseProduct for the creation of the canonical url. Most likely, variations of the same products are very similar in terms of product detail page and should be exposed as the base product to avoid duplicated content.
