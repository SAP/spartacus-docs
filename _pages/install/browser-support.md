---
title: Web Browser Support
---

Ideally, your storefront will render uniformly in any browser that is used by your customers. However, web browsers do not all support the same web standards, nor do they handle these standards in the same way. For example, there are different ways of interpreting a standard's specifications, deliberate design decisions that result in different outcomes, as well as bugs that are unique to each browser. And for each browser that is supported, there is a resulting implementation effort that includes QA, architectural decisions, and technical decisions. In the end, a balance has to be struck between providing an excellent storefront experience, and supporting (as much as possible) the different web browsers that are out there.

Spartacus is designed to take advantage of the latest web platform standards, while also allowing you to run your Spartacus storefront in as many different web browsers as possible. However, some older browsers do not support the latest standards, and as a result, these browsers are not supported by Spartacus. Spartacus actively supports "evergreen browsers", which means there are end-to-end tests and manual QA done for evergreen browsers (though other browsers that are not evergreen may be supported "by accident" - for example, if they support the latest web platform standards). Evergreen browsers are web browsers that are automatically upgraded to future versions, rather than being updated by distribution of a new version (for example, in an OS update). Spartacus actively supports only evergreen browsers because Spartacus follows standard Angular, the Spartacus libraries are kept as clean as possible by intentionally avoiding "browser quirks" in the library code, and there is no planned investment in automated tests of very old browsers.

Although Spartacus might not support older browsers, there are some common techniques that make it possible to support these browsers. The following are some of the steps you can take to get an older browser to work with Spartacus:

- Configure the TypeScript compiler to transpile to the appropriate version of JavaScript.
- Add JavaScript polyfills to provide some web features that are not included in older browsers.
- Leverage PostCSS to (automatically) add vendor prefix style rules where browsers have not incorporated CSS standard syntax.

## Working with IE11

IE11 is not supported by Spartacus.

If your Spartacus storefront needs to support IE11, consider the following:

- Use JavaScript polyfills to add missing browser capabilities. The polyfills are prepared in a newly-rendered Angular CLI application, so it is typically only a matter of "uncommenting" some of these polyfills. For more information, see [Browser support](https://angular.io/guide/browser-support) in the official Angular documentation.
- Customize the Spartacus styles, or bring in a custom style layer.

**Note:** Depending on your customizations, there might be other things to consider, such as third-party libraries that you may be leveraging, but that are not guaranteed to fully work with IE11.

The default Spartacus style library is not prepared for IE11. Since most customers will not use the Spartacus styles in the first place, it is a typical custom effort to build your styles in such a way that they support the required browsers.

The following are some of the standard CSS features that are used in Spartacus styles, and that will not work for IE11:

- Custom properties, which are used in Spartacus themes, and which are not supported in IE11. For more information, see the browser support tables for custom properties on the [Can I Use?](https://caniuse.com/?search=custom%20properties) website.
- Logical properties, which are used for bidirectional text and layout, and which are not supported in IE11. For more information, see the browser support tables for logical properties on the [Can I Use?](https://caniuse.com/?search=logical%20properties) website.

**Note:** The Angular framework that underlies Spartacus *does* support IE11. As a result, it is very likely that the application logic works flawlessly with IE11, and the limitations for IE11 are only related to the Spartacus styles. That being said, Spartacus is not actively tested with IE11.

### Known Issues with Supporting IE11

In terms of Spartacus supporting IE11, the following are known issues at the time of writing:

- [GH-7220](https://github.com/SAP/spartacus/issues/7220) has been resolved, but the fix requires version 2.0 or newer of the Spartacus libraries.
- [GH-8925](https://github.com/SAP/spartacus/issues/8925) is open, but is currently not resolved.

## Mobile and Tablet Support

Spartacus supports evergreen web browsers on mobile and tablet platforms.

### iOS Browsers

On iOS-based devices, Spartacus supports Safari, Chrome, and other browsers. Although not every browser is tested, Spartacus should work with any iOS browser because all iOS browsers use the Webkit-based iOS browser engine.

### Android Browsers

On Android-based devices, Spartacus is tested on Chrome, which is based on Chromium and the Blink layout engine. Any Android browser that uses the same engine will likely work with Spartacus. Other browsers using different browser engines are not tested, but those browsers that use Webkit should work as well.
