---
title: Debugging a Server–Side Rendered Storefront
---

If a runtime error occurs in your server-side rendered Spartacus storefront application, the application only outputs a stacktrace in the console of the Node.js process, not in the browser, and it can sometimes be difficult to determine the cause of the error. Fortunately, you can use Node.js debugging to take advantage of standard debugging techniques, such as inspecting variables in the code, inspecting breakpoints, and so on.

## Debugging Node.js in VS Code

The following steps describe how to use Node.js debugging in Visual Studio Code.

1. Build your Spartacus storefront app and start the Node server with it.
1. In Visual Studio Code, open the Run view.

   For more information, see [Run view](https://code.visualstudio.com/docs/editor/debugging#_run-view) in the VS Code documentation.

1. If you have not already done so, create a new `launch.json` file and select `Node.js` as the environment.

   For more information, see [Launch configurations](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations) in the VS Code documentation.

1. In the new `launch.json` file, click `Add Configuration` and select `Node.js: Attach to Process`.

   For more information, see [Add a new configuration](https://code.visualstudio.com/docs/editor/debugging#_add-a-new-configuration) and [Attaching to Node.js](https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_attaching-to-nodejs) in the VS Code documentation.

1. Run the debugger using the `Attach by Process ID` configuration, and when asked to `Pick the node.js process to attach to`, select the process with a path to your Spartacus storefront app, such as `/dist/ssr/server.js`.

For more information, see [Getting started with Node.js debugging in VS Code](https://www.youtube.com/watch?v=2oFKNL7vYV8&ab_channel=VisualStudioCode) on Visual Studio Code's official YouTube channel.

### Setting Breakpoints on Exceptions

1. At the bottom of the Run view, expand the **Breakpoints** section and select the `All exceptions` checkbox.
1. Open the storefront app in a browser (for example, `localhost:4200`) and VS Code should stop on a line that throws a runtime error.
