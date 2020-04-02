# Cross-Origin Resource Sharing (CORS)

While CORS is a standard mechanism on the web, it's considered rather complicated and blocks new Spartacus developer often during their first setup. This is why we spend an article on explaing _how_ CORS affects Spartacus, and _what_ is required to enable the right CORS setup.

## What is CORS?

CORS is a standard mechanism on the web to enable cross-domain requests from a web application to a server on a different domain. Browsers block Cross-Origin requests (or simply put: _cross-domain requests_), whenever the required HTTP headers are not available on the response.

The response headers are dictated by the server, which is why the server must be setup to generate the right headers. In the SAP commerce backend, those headers are configurable in a generic fashion, using a CorsFilter. Project properties can be used to configure this for each node, or an installation script (ImpEx) can be used to install to each node. See for more information on the setup in the section below.

## CORS Headers

There are various CORS headers that come into play to specify whether the origin is allowed with or without certain methods, headers, cookies, etc. Each of the configurations and it's use in spartacus is discussed in the following sections.

### allowedOrigins

In development the allowed origins are often configured with a `*`, which basically whitelists all clients regardless of their domain. In a production environment, this should contain the different domains are allowed to interact with the backend API.

### allowedMethods

The allowed headers must include all the HTTP methods that can be used. For Spartacus, the following headers should be configured:

`GET HEAD OPTIONS PATCH PUT POST DELETE`

If you use custom methods in your project, you should add the methods to this list.

### allowedHeaders

The allowed headers describe the HTTP headers that are allowed for cross-origin requests. If these header are not allowed cross-origin, Spartacus will not get a response for a specific request. Most of the headers are standard headers, but there are a few feature specific headers that you might need. The list below provides an overview of all the headers that could be used.

| Header                   | description                                                                                                                                                                                                                                                                                                                                             |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `origin`                 | The Origin request header indicates where a request originates from. This is send with each cross-orinin request by the browser and must therefor be configured for all requests.                                                                                                                                                                       |
| `content-type`           | The Content-Type header is used to indicate the media type of the resource. It is not requried for all APIs but is often used regardless.                                                                                                                                                                                                               |
| `accept`                 | The accept request header indicates the formats that can be read by the browser. It is send in a few occassions in Spartacus.                                                                                                                                                                                                                           |
| authorization            | The authorization request header is used during authentication. Unless there's no login process, this must be configured.                                                                                                                                                                                                                               |
| cache-control            | cache-control headers are used for various API requests.                                                                                                                                                                                                                                                                                                |
| x-anonymous-consents     | The `x-anonymous-consents` is required by the anonymous consent feature. If anonymous consent is not used, this configuration can be omitted.                                                                                                                                                                                                           |
| occ-personalization-id   | The `occ-personalization-id` is required by the anonymous consent feature. If you don't use personalisation the personalisation feature it's fine to leave this one out. See [the personalisation documentation](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1905/en-US/e970070f997041c7b3f3e77fcb762744.html) for more information.   |
| occ-personalization-time | The `occ-personalization-time` is required by the anonymous consent feature. If you don't use personalisation the personalisation feature it's fine to leave this one out. See [the personalisation documentation](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1905/en-US/e970070f997041c7b3f3e77fcb762744.html) for more information. |
| x-profile-tag-debug      | The `x-profile-tag-debug` header is required by CDS. It is used to instruct CDS to produce a trace through. If you don't use CDS, it's fine to leave this one out.                                                                                                                                                                                      |
| x-consent-reference      | The `x-consent-reference` header is required by CDS. If you don't use CDS, it's fine to leave this one out.                                                                                                                                                                                                                                             |

### exposedHeaders

Only CDS requires to expose a custom header, namely the `x-anonymous-consents` header.

### allowCredentials

Request credentials are concerned with cookies, authorization headers or TLS client certificates. These are not allowed in cross-origin requests by default, which is why a request is blocked when the configuration isn't applied.

Spartacus has not been sending cookies in version 1, but since version 2, cookies will be send for each and every occ request. This has also been patched to 1.4 and 1.5.

Sending cookies is required to gain _session infinity_, also know as sticky sessions. Session infinity means that the same server behind an API endpoint is used for all sub-sequential request for the same session. Although the Commerce API is stateless, there are occassions where multiple parallel calls could fail (i.e. add to cart vs get cart). Moreover, the backend will gain performance improvements if requests for the same session aer served by the same server.

To this reason, CCv2, exposes a response cookie (`ROUTE`), that indicates the processing server that was used to process the API request. Whenever the client will add this cookie into the next request, the request will be handled by the same server.

## Setup

The various CORS configurations that are required for the backend can be installed in various ways:

- use configuration properties to install them during a deployment
- use the Commerce Cloud manifest file to install them during a deployment
- use ImpEx script to install them at runtime
- use backoffice to configure them manually at runtime

For each installation, the following is important:

- OCC is installed by a template extension with the name `ycommercewebservices`, you can however rename thie exentension web applicaton path, or generate a custom extension out of this. In the below exampes we assume the name is `ycommercewebservices`, but you should replace this if you have a custom name.
- Most configurations apply to OCC only, but in case you use other APIs (i.e. Assisted Service Module), you also need to configure CORS for these APIs as well.

###

```json
{
	"key": "corsfilter.ycommercewebservices.allowedOrigins",
	"value": "*"
},
{
	"key": "corsfilter.ycommercewebservices.allowedMethods",
	"value": "GET HEAD OPTIONS PATCH PUT POST DELETE"
},
{
	"key": "corsfilter.ycommercewebservices.allowedHeaders",
	"value": "origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time"
},
{
	"key": "corsfilter.ycommercewebservices.exposedHeaders",
	"value": "x-anonymous-consents"
}
{
	"key": "corsfilter.ycommercewebservices.allowCredentials",
	"value": "true"
}
```

In case you use the Assisted Service Module(AMS), you must add the same headers:

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
	"value": "x-anonymous-consents"
}
{
	"key": "corsfilter.assistedservicewebservices.allowCredentials",
	"value": "true"
}
```

### Project Properties file

If you install the cors filter configuration by properties, the following properties must be added:

```
corsfilter.ycommercewebservices.allowedOrigins=*
corsfilter.ycommercewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.ycommercewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.ycommercewebservices.exposedHeaders=x-anonymous-consents
corsfilter.ycommercewebservices.allowCredentials=true
```

In case you use the Assisted Service Module(AMS), you must add the same headers:

```
corsfilter.assistedservicewebservices.allowedOrigins=*
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.assistedservicewebservices.exposedHeaders=x-anonymous-consents
corsfilter.assistedservicewebservices.allowCredentials=true
```

### Impex

You can use the following ImpEx script if you want to install the cors filter configuration during initialisation, update or manually using the hac.

```impex
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=ycommercewebservices,unique=true]
;allowedOrigins;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents
```

In case you use the Assisted Service Module(AMS), you must run a similar installation:

```impex
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=assistedservicewebservices,unique=true]
;allowedOrigins;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents
```
