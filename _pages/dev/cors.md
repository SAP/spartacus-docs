---
title: Cross-Origin Resource Sharing (CORS)
---

CORS is a standard mechanism on the web that enables cross-domain requests from web applications to reach servers on different domains. Cross-origin requests could also be thought of as "cross-domain requests". Browsers block cross-origin requests whenever the required HTTP headers are not available in the response.

The response headers are dictated by the server, which is why the server must be set up to generate the correct headers. In the SAP Commerce Cloud back end, these headers can be [configured in a generic fashion](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/b27d995150a74be08869e60e3fbc7395.html?q=authorization%20CORS) by using a CorsFilter. Project properties can be used to configure this for each node, or an ImpEx installation script can be used to install to each node.

## CORS Headers

You can use various CORS headers to specify whether the origin is allowed, with or without certain methods, headers, cookies, and so on. The following sections describe each of the configurations as they are related to Spartacus.

### allowedOrigins

In development, the allowed origins are often configured with an asterisk (`*`), which whitelists all clients, regardless of their domain. In a production environment, this should contain the different domains that are allowed to interact with the back end API.

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
| occ-personalization-id | The `occ-personalization-id` header is required by the personalization feature. If you do not use the personalization feature, this header can be omitted. For more information, see [Configure Personalization for Commerce Web Services](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/latest/en-US/e970070f997041c7b3f3e77fcb762744.html) on the SAP Help Portal. |
| occ-personalization-time | The `occ-personalization-time` header is required by the personalization feature. If you do not use the personalization feature, this header can be omitted. For more information, see [Configure Personalization for Commerce Web Services](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/latest/en-US/e970070f997041c7b3f3e77fcb762744.html) on the SAP Help Portal. |
| x-profile-tag-debug | The `x-profile-tag-debug` header is required by Context-Driven Services. It is used to instruct Context-Driven Services to produce a trace. If you do not use Context-Driven Services, this header can be omitted. For more information, see [SAP Commerce Cloud, Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US?task=discover_task) on the SAP Help Portal. |
| x-consent-reference | The `x-consent-reference` header is required by Context-Driven Services. If you do not use Context-Driven Services, this header can be omitted. For more information, see [SAP Commerce Cloud, Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US?task=discover_task) on the SAP Help Portal. |

### exposedHeaders

Context-Driven Services requires a custom header to be exposed, which is the `x-anonymous-consents` header.

Personalization requires the `occ-personalization-id` and the `occ-personalization-time` headers to be exposed.

### allowCredentials

Request credentials are concerned with cookies, authorization headers, or TLS client certificates. These are not allowed in cross-origin requests by default, which is why a request is blocked when the configuration is not applied.

Spartacus did not send cookies in version 1.x of the Spartacus libraries, but since version 2.0, cookies will be sent for each and every OCC request. This has also been patched to versions 1.4 and 1.5 of the Spartacus libraries.

Sending cookies is required to gain "session infinity", which is also know as "sticky sessions". Session infinity means that the same server behind an API endpoint is used for all subsequent requests for the same session. Although the Commerce API is stateless, there are occasions when multiple parallel or sequential calls could fail. For example, an “add to cart” request followed by a “load cart” request could fail, because the first request could end up at server 1, whereas the second request, immediately following after, could end up at server 2. The servers might not be fast enough to send around cache invalidation, which is why the second response might fail to catch the added item. 

An added advantage of session infinity is that the back end will gain performance improvements if requests for the same session are served by the same server.

For this reason, CCv2 exposes a response cookie (`ROUTE`) that indicates the processing server that was used to process the API request. Whenever the client adds this cookie into the next request, the request is handled by the same server.

## Setting Up CORS

The various CORS configurations that are required by the back end can be installed in the following ways:

- using configuration properties to install them during a deployment
- using the Commerce Cloud manifest file to install them during a deployment
- using an ImpEx script to install them at runtime
- using Backoffice to configure them manually at runtime

For each installation, it is important to note the following:

- OCC is installed by a template extension with the name `commercewebservices`. However, you can rename the extension web application path, or generate a custom extension out of this. In the examples in the next sections, we assume the name is `commercewebservices`, but you should replace this if you have a custom name.
- Most configurations apply to OCC only, but in case you use other APIs (such as the Assisted Service Module), you also need to configure CORS for these APIs as well.

**Note:** If you are using SAP Commerce Cloud version 1905 or older, you must use `ycommercewebservices` (or your custom extension name) and not `commercewebservices`. If you are using SAP Commerce Cloud version 2005 or newer, you can choose to use `commercewebservices` or `ycommercewebservices`, but the default is `commercewebservices`, which is defined by the cx recipe.

### Project Properties File

If you install the CORS filter configuration by properties, the following properties must be added:

```plaintext
corsfilter.commercewebservices.allowedOrigins=*
corsfilter.commercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.commercewebservices.exposedHeaders=x-anonymous-consents occ-personalization-id occ-personalization-time
corsfilter.commercewebservices.allowCredentials=true
```

If you are using the Assisted Service Module (ASM), you must also add the same headers to the `corsfilter.assistedservicewebservices` settings, as follows:

```plaintext
corsfilter.assistedservicewebservices.allowedOrigins=*
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.assistedservicewebservices.exposedHeaders=x-anonymous-consents occ-personalization-id occ-personalization-time
corsfilter.assistedservicewebservices.allowCredentials=true
```

### Commerce Cloud Manifest Configuration

If you install the CORS filter configuration using the Commerce Cloud manifest file, add the following headers to the manifest file:

```json
{
	"key": "corsfilter.commercewebservices.allowedOrigins",
	"value": "*"
},
{
	"key": "corsfilter.commercewebservices.allowedMethods",
	"value": "GET HEAD OPTIONS PATCH PUT POST DELETE"
},
{
	"key": "corsfilter.commercewebservices.allowedHeaders",
	"value": "origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time"
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

If you use the Assisted Service Module (ASM), you must also add the same headers to the `corsfilter.assistedservicewebservices` settings, as follows:

```json
{
	"key": "corsfilter.assistedservicewebservices.allowedOrigins",
	"value": "*"
},
{
	"key": "corsfilter.assistedservicewebservices.allowedMethods",
	"value": "GET HEAD OPTIONS PATCH PUT POST DELETE"
},
{
	"key": "corsfilter.assistedservicewebservices.allowedHeaders",
	"value": "origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time"
},
{
	"key": "corsfilter.assistedservicewebservices.exposedHeaders",
	"value": "x-anonymous-consents occ-personalization-id occ-personalization-time"
}
{
	"key": "corsfilter.assistedservicewebservices.allowCredentials",
	"value": "true"
}
```

### Impex

You can use the following ImpEx script if you want to install the CORS filter configuration during initialization, during an update, or manually with the Hybris Admin Console.

```plaintext
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=commercewebservices,unique=true]
;allowedOrigins;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents occ-personalization-id occ-personalization-time
```

If you are using the Assisted Service Module (ASM), you must also run the following script:

```plaintext
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=assistedservicewebservices,unique=true]
;allowedOrigins;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents occ-personalization-id occ-personalization-time
```
