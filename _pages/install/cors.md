---
title: Cross-Origin Resource Sharing (CORS)
---

CORS is a standard mechanism on the web that enables cross-domain requests from web applications to reach servers on different domains. Cross-origin requests could also be thought of as "cross-domain requests". Browsers block cross-origin requests whenever the required HTTP headers are not available in the response.

The response headers are dictated by the server, which is why the server must be set up to generate the correct headers. In the SAP Commerce Cloud back end, these headers can be [configured in a generic fashion](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/b27d995150a74be08869e60e3fbc7395.html?q=authorization%20CORS) by using a CorsFilter. Project properties can be used to configure this for each node, or an ImpEx installation script can be used to install to each node.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## CORS Headers

You can use various CORS headers to specify whether the origin is allowed, with or without certain methods, headers, cookies, and so on. The following sections describe each of the configurations as they are related to Spartacus.

### allowedOrigins

In development, the allowed origins are often configured with an asterisk (`*`), which allowlists all clients, regardless of their domain. In a production environment, this should contain the different domains that are allowed to interact with the back end API.

### allowedMethods

The allowed headers must include all the HTTP methods that are allowed to be used. For Spartacus, the following methods should be configured:

```plaintext
GET HEAD OPTIONS PATCH PUT POST DELETE
```

If you use custom methods in your project, you should add these methods to this list.

### allowedHeaders

The allowed headers setting indicates the HTTP headers that are allowed for cross-origin requests. If these header are not allowed cross-origin, Spartacus will not get a response for a specific request. Most of the headers are standard headers, but there are a few headers that you might need that are feature specific. The following list provides an overview of all the headers that can be used.

| Header | Description |
| - |  |
| origin | The `origin` request header indicates where a request originates from. This is sent by the browser with each cross-origin request, and must therefore be configured for all requests. |
| content-type | The `content-type` header is used to indicate the media type of the resource. It is not required for all APIs, but it is often used nonetheless. |
| accept | The `accept` request header indicates the formats that can be read by the browser. It is sent pn a few occasions in Spartacus. |
| authorization | The `authorization` request header is used during authentication. Unless there is no login process, this must be configured. |
| cache-control | The `cache-control` headers are used for various API requests. |
| x-anonymous-consents | The `x-anonymous-consents` header is required by the anonymous consent feature. If anonymous consent is not used, this configuration can be omitted. However, it is important to note that if you do not include this header, you must disable the anonymous consent feature. Otherwise, you might encounter problems with your storefront not displaying properly. |
| occ-personalization-id | The `occ-personalization-id` header is required by the personalization feature. If you do not use the personalization feature, this header can be omitted. For more information, see [Configure Personalization for Commerce Web Services](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/e970070f997041c7b3f3e77fcb762744.html) on the SAP Help Portal. |
| occ-personalization-time | The `occ-personalization-time` header is required by the personalization feature. If you do not use the personalization feature, this header can be omitted. For more information, see [Configure Personalization for Commerce Web Services](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/e970070f997041c7b3f3e77fcb762744.html) on the SAP Help Portal. |
| x-profile-tag-debug | The `x-profile-tag-debug` header is required by Intelligent Selling Services for SAP Commerce Cloud. It is used to instruct Intelligent Selling Services to produce a trace. If you do not use Intelligent Selling Services for SAP Commerce Cloud, this header can be omitted. For more information, see [Intelligent Selling Services for SAP Commerce Cloud](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US?task=discover_task) on the SAP Help Portal. |
| x-consent-reference | The `x-consent-reference` header is required by Intelligent Selling Services for SAP Commerce Cloud. If you do not use Intelligent Selling Services for SAP Commerce Cloud, this header can be omitted. For more information, see [Intelligent Selling Services for SAP Commerce Cloud](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US?task=discover_task) on the SAP Help Portal. |

### exposedHeaders

Intelligent Selling Services for SAP Commerce Cloud requires a custom header to be exposed, which is the `x-anonymous-consents` header.

Personalization requires the `occ-personalization-id` and the `occ-personalization-time` headers to be exposed.

### allowCredentials

Request credentials are concerned with cookies, authorization headers, or TLS client certificates. These are not allowed in cross-origin requests by default, which is why a request is blocked when the configuration is not applied.

Spartacus did not send cookies in version 1.x of the Spartacus libraries, but since version 2.0, cookies will be sent for each and every OCC request. This has also been patched to versions 1.4 and 1.5 of the Spartacus libraries.

Sending cookies is required to gain "session affinity", which is also know as "sticky sessions". Session affinity means that the same server behind an API endpoint is used for all subsequent requests for the same session. Although the Commerce API is stateless, there are occasions when multiple parallel or sequential calls could fail. For example, an “add to cart” request followed by a “load cart” request could fail, because the first request could end up at server 1, whereas the second request, immediately following after, could end up at server 2. The servers might not be fast enough to send around cache invalidation, which is why the second response might fail to catch the added item.

An added advantage of session affinity is that the back end will gain performance improvements if requests for the same session are served by the same server.

For this reason, CCv2 exposes a response cookie (`ROUTE`) that indicates the processing server that was used to process the API request. Whenever the client adds this cookie into the next request, the request is handled by the same server.

## Setting Up CORS

The various CORS configurations that are required by the back end can be installed in the following ways:

- using configuration properties to install them during a deployment
- using the Commerce Cloud manifest file to install them during a deployment
- using an ImpEx script to install them at runtime
- using Backoffice to configure them manually at runtime

For each installation, it is important to note the following:

- OCC is installed by a template extension with the name `commercewebservices`. However, you can rename the extension web application path, or generate a custom extension out of this. In the examples in the next sections, we assume the name is `commercewebservices`, but you should replace this if you have a custom name.
- Most configurations apply to OCC only, but in case you use other APIs (such as the Assisted Service Module), you also need to configure CORS for these APIs as well. For more information, see [{% assign linkedpage = site.pages | where: "name", "asm.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/asm.md %})

### Local Properties File

If you install the CORS filter configuration by properties, the following properties must be added:

```plaintext
corsfilter.commercewebservices.allowedOriginPatterns=*
corsfilter.commercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.commercewebservices.exposedHeaders=x-anonymous-consents occ-personalization-id occ-personalization-time
corsfilter.commercewebservices.allowCredentials=true
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

### Commerce Cloud Manifest Configuration

If you install the CORS filter configuration using the Commerce Cloud manifest file, add the following headers to the manifest file:

```json
{
	"key": "corsfilter.commercewebservices.allowedOriginPatterns",
	"value": "*"
},
{
	"key": "corsfilter.commercewebservices.allowedMethods",
	"value": "GET HEAD OPTIONS PATCH PUT POST DELETE"
},
{
	"key": "corsfilter.commercewebservices.allowedHeaders",
	"value": "origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time"
},
{
	"key": "corsfilter.commercewebservices.exposedHeaders",
	"value": "x-anonymous-consents occ-personalization-id occ-personalization-time"
}
{
	"key": "corsfilter.commercewebservices.allowCredentials",
	"value": "true"
}
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

### ImpEx

You can use the following ImpEx script if you want to install the CORS filter configuration during initialization, during an update, or manually with the Hybris Admin Console.

```plaintext
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=commercewebservices,unique=true]
;allowedOriginPatterns;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents occ-personalization-id occ-personalization-time
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

## Troubleshooting

When troubleshooting a possible CORS issue, the first step is to determine if a CORS error is the source of the problem. If it is, you can determine what is causing the CORS error, and then resolve it.

### Determining If a Problem Is Caused by a CORS Issue

To determine if a problem is caused by a CORS issue, you can open the **Network** tab in your browser's development tools and try to reproduce the problem with the **Network** tab open. In the following example, there are two requests that are highlighted in red, and in the **Status** column, one of the requests is listed as having a `CORS error`:

<img src="{{ site.baseurl }}/assets/images/cors/cors-error-01.png" alt="Network tab: request with cors error" width="950" border="1px" />

### Determining the Cause of a CORS Error

To support CORS, your browser makes a preflight request to the server to verify that the server will allow the real request to go through. It is often the case that the CORS issue is the result of an error with the preflight request. The preflight request has the same URL as the real request, but the HTTP method is `OPTIONS`. Google Chrome offers a convenient **Preflight** link in the **Method** column of the **Network** tab. When you click on the **Preflight** link of a request, the associated preflight request is highlighted, as show in the following example:

<img src="{{ site.baseurl }}/assets/images/cors/cors-error-02.png" alt="Network tab: request with cors error" width="950" border="1px" />

When you select the preflight request, you can see detailed information about the headers. In the request header info, look for headers that start with `Access-Control-Request-*`, such as in the following example:

<img src="{{ site.baseurl }}/assets/images/cors/cors-error-03.png" alt="Network tab: request with cors error" width="950" border="1px" />

The error is often caused by the back end server not being configured to allow one of the elements that is listed in one of the `Access-Control-Request-*` headers.

### Resolving the CORS Error

If you see that a legitimate header or HTTP method is being used, you should be able to resolve the issue by adding the header or HTTP method to the server's CORS configuration.

HTTP headers need to be added to at least one of the `corsfilter.*.allowedHeaders` properties (that is, the one related to the back end extension that serves the request.)

HTTP methods are allowed by adding them to the `corsfilter.*.allowedMethods`. Again, which property you need to add depends on which back end extension serves the request.

To resolve the error in the above examples, you add the `authorization` header in the `corsfilter.assistedservicewebservices.allowedHeaders` back end configuration property.

To know which extension serves which URL, you can use the following table of URLS and their corresponding extensions for an out-of-the-box Commerce Cloud deployment:

| Webservice URL      | Back End Extension Name |
| --- | --- |
| /authentication/*      | oauth2       |
| /occ/v2/*   | commercewebservices        |
| /assistedservicewebservices/*   | assistedservicewebservices        |

For more information about preflight requests, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Glossary/Preflight_request).
