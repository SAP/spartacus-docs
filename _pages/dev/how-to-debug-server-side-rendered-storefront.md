---
title: How to Debug a Server–Side Rendered Storefront (DRAFT)
---

When a runtime error occurs in the server-side rendered Javascript application, it outputs only a stacktrace in the console of the Node.js process (not in the browser) and sometimes it can be difficult to deduce the cause cause of an error. But fortunately, you can use *Node.js debugging* to take advantage of standard debugging techniques like inspecting variables in code, breakpoints, etc.

## Node.js Debugging in VS Code

1. Build your Javascript Storefront and start the Node server with it
2. In VS Code, open the `Debug` panel (Ctrl+Shift+D)
3. Unless you have done it before, add a new configuration, as follows:
   1. from the dropdown choose option `Add configuration`
   2. then in the automatically-opened file `launch.json` choose the option `Node.js Attach to process` from the list of suggestions and save the file
4. Run debugging with above configuration. In opened popup in the center of the window choose the process with path to your Javascript Storefront (i.e. `/dist/ssr/server.js`)

### How to Set Breakpoint on Exceptions

5. In the bottom of the `Debug` panel, expand the section `Breakpoints` and select checkbox `All exceptions`.
6. Open the storefront in the browser (i.e. `localhost:4200`) and VS Code should stop in a line that throws a runtime error.

### References

- Docs: https://code.visualstudio.com/docs/nodejs/nodejs-debugging
- Video: https://www.youtube.com/watch?v=2oFKNL7vYV8

