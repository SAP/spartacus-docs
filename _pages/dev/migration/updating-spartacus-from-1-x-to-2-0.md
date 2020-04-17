# Updating Spartacus from 1.x to 2.0

The version 2.0 of Spartacus arrives with many new features and fixes. At the same time, as it's a major release, **some changes can be potentially breaking to your application**.
So some additional work on your side may be required to fix the issues that come up after you upgrade the version of Spartacus from 1.x to 2.0.

However we did our best to minimize the amount of time you spend on it, by providing automated script. We've prepared schematics that we believe will make your upgrade process smoother. Just run the following command in the workspace of your Angular application and observe the results:
```shell
$ ng update @spartacus/schematics
```

The results should be:
- Heads-up code comments `// TODO:Spartacus - ...` will be injected in your codebase whenever you are using a reference to Spartacus' item (i.e. class or function) that has changed its behavior in 2.0 or changed its the API (i.e. added a required parameter or removed one), or was replaced with a different class or function. If you need more information for that item, please search for it in our technical documentation page that describes all breaking changes (TODO: link to technical docs)
- All calls of `super(...)` in constructors of classes extending from Spartacus' ones will be automatically fixed (new required parameters added; removed parameters dropped)

If something is not working or not clear regarding some class, search for it in our technical documentation of breaking changes. If you can't find something there, please reach us out in the public Spartacus slack channel (TODO: add a link) (you can help us improve our docs, if you find anything missing).

For upgrading manually CSS styles to the latest official _Calydon_ theme of Spartacus, please see the https://sap.github.io/spartacus-docs/updating-to-version-2/css
