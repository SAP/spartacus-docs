---
title: Server-Side Rendering Coding Guidelines
---

The following guidelines are highly recommended when working with server-side rendering (SSR).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Working with Global Objects

Do not access global objects that are available in the browser. For example, do not use the `window`, `document`, `navigator`, and other browser types, because they do not exist on the server. If you try to use them, or any library that uses them, it will not work. For most cases, it is better to inject `WindowRef` and then do additional checks. For example, you can check if `WindowRef.nativeWindow` is defined.

## Working with Timeouts

Limit or avoid using `setTimeout`. It slows down the server-side rendering process and should be removed from the `ngOnDestroy` method of your components.

For RxJs timeouts, cancel their stream on success, because they can slow down rendering as well.

## Manipulating the nativeElement

Do not manipulate the `nativeElement` directly. Instead, use `Renderer2` and related methods. We do this to ensure that, in any environment, we are able to change our view. The following is an example:

```typescript
constructor(element: ElementRef, renderer: Renderer2) {
  renderer.setStyle(element.nativeElement, 'font-size', 'x-large');
}
```

## Using Transfer State Functionality

Using transfer state functionality is recommended. The application runs XHR requests on the server, and then again on the client-side, when the application bootstraps.

Use a cache that is transferred from the server to the client.

For more information, see [{% assign linkedpage = site.pages | where: "name", "ssr-transfer-state.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/ssr-transfer-state.md %}).

## Getting the Request URL and Origin

In CCv2, or any other setup that uses proxy servers, the request origin may be modified on the fly to something else, such as `localhost` or `127.0.0.1`. Also, the `document.location` behaves differently in the browser as compared to SSR, where Angular Universal creates a DOM that is more limited in functionality.

When working with SSR, to get the request URL or the origin, you should use the Spartacus `WindowRef.location.href` or `WindowRef.location.origin` properties. This works with CSR as well.

**Note:** The `WindowRef.location` property in SSR is able to mimic only some properties of the [Location](https://developer.mozilla.org/en-US/docs/Web/API/Location) interface, such as `href` and `origin`. However, when used with CSR, the `WindowRef.location` property exposes all of the properties of the `Location` interface because it points to the original `document.location` object.

## Avoiding Memory Leaks in SSR

In the SSR server, there is one long-living Node.js process that handles all HTTP requests. On each request, this process bootstraps the Angular application, returns the HTML to the client, and cleans up the application's resources. If any subscription that was created in any Angular (singleton) service is not disposed of on app destroy, this subscription remains pending, even after the app is destroyed, and this causes a memory leak. In SSR, Angular calls `ngOnDestroy` for services, so it is a good place to unsubscribe any pending RxJs subscriptions at the end of life of the service.

## Workaround for Known Issue in Spartacus 3.0.2 and Earlier

In Spartacus 3.0.2 and earlier, when using CCv2 or any other setup that uses proxy servers, the `SERVER_REQUEST_URL` and `SERVER_REQUEST_ORIGIN` tokens return the `localhost` request origin instead of the real website domain. This has been fixed in Spartacus 3.0.3.

If you are using Spartacus 3.0.2 or earlier, and you are unable to upgrade to the latest version of Spartacus, you can fix this issue with the workaround described in a comment in [GitHub issue 11016](https://github.com/SAP/spartacus/issues/11016#issuecomment-775245885).
