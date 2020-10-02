---
title: Web Browser Support
---

Ideally, your Spartacus storefront application will render uniformly in any browser that is supported by Spartacus. However, web browsers do not all support the same web standards, nor do they support the same standards in the same way. For example, there are different ways of interpreting a standard's specifications, deliberate design decisions that result in different outcomes, as well as bugs that are unique to each browser. And for each browser that is supported, there is a resulting implementation effort that includes QA, architectural decisions, and technical decisions. In the end, a balance has to be struck between providing an excellent storefront experience, and supporting all the different web browsers that are out there.

Spartacus libraries are designed to take advantage of the latest web platform standards, while also allowing you to run your Spartacus storefront in as many different web browsers as possible. However, some older browsers do not support the latest standards, and as a result, these browsers are not supported by Spartacus. Officially, Spartacus only supports evergreen browsers. This is because Spartacus follows standard Angular, the libraries are kept as clean as possible by intentionally avoiding "browser quirks" in the library code, and there is no planned investment in automated tests of very old browsers.

The approach to browser support in Spartacus is as follows:

- Angular is trusted to be compatible with evergreen browsers.
- Other standards are trusted to be compatible with evergreen browsers (the [Can I Use?](http://caniuse.com/) website is a good example).
- Spartacus has many automated quality checks that align the code with those standards (such as the TypeScript standard, and [Can I Use?](http://caniuse.com/)).
- Spartacus end-to-end tests explicitly test only the Chrome browser.

Nonetheless, with a bit of effort, it is still possible to get Spartacus to work with older browsers. The following are some of the steps you can take to get an older browsers to work with Spartacus:

- Transpile the TypeScript into older versions of JavaScript.
- Use polyfills to add JavaScript files that can provide some of the standard web features that are missing in some older browsers.
- Use PostCSS to automatically add vendor prefix style rules when needed in an after process.

## Working with IE11

If your Spartacus storefront needs to support IE11, you must do the following:

- Use JavaScript polyfills to add missing browser capabilities. The polyfills are prepared in a newly-rendered Angular CLI application, so it is typically only a matter of "uncommenting" some of these polyfills. For more information, see [Browser support](https://angular.io/guide/browser-support) in the official Angular documentation.
- Customize the Spartacus styles, or bring in a custom style layer.

The default Spartacus style library is not prepared for IE11. Since most customers will not use the Spartacus styles in the first place, it is a typical custom effort to build your styles in such a way that they support the required browsers.

The following are some of the standard CSS features that are used in Spartacus styles, and that will not work for IE11:

- Custom properties, which are used in Spartacus themes, and which are not supported in IE11. For more information, see the browser support tables for custom properties on the [Can I Use?](https://caniuse.com/?search=custom%20properties) website.
- Logical properties, which are used for bidirectional text and layout, and which are not supported in IE11. For more information, see the browser support tables for logical properties on the [Can I Use?](https://caniuse.com/?search=logical%20properties) website.

**Note:** The Angular framework that underlies Spartacus *does* support IE11. As a result, it is very likely that the application logic works flawlessly with IE11, and the limitations for IE11 are only related to the Spartacus styles. That being said, Spartacus is not actively tested with IE11.

### Known Issues with Supporting IE11

In terms of Spartacus supporting IE11, the following are known issues at the time of writing:

- [GH-7220](https://github.com/SAP/spartacus/issues/7220) has been resolved, but the fix requires version 2.0 or newer of the Spartacus libraries.
- [GH-8925](https://github.com/SAP/spartacus/issues/8925) is being addressed, but is currently not resolved.

## Mobile and Tablet Support

Spartacus supports evergreen web browsers on mobile and tablet platforms.

### iOS Browsers

On iOS-based devices, Spartacus is automatically tested on Safari and Chrome through end-to-end tests. Although other browsers are not tested, Spartacus should work with any iOS browser, because all iOS browsers use the Webkit-based iOS browser engine.

### Android Browsers

On Android-based devices, Spartacus is automatically tested on Chrome through end-to-end tests. Chrome is based on Chromium and the Blink layout engine. Any Android browser that uses the same engine will likely work with Spartacus. Other browsers using different browser engines are not tested, but those browsers that use Webkit should work as well.
