# Developers: Contributing to Documentation

All documentation for Spartacus resides in the `_pages` folder of this repository. The [Spartacus documentation website](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/) is hosted in GitHub Pages and is powered by Jekyll. Every merge to the `master` branch triggers Jekyll to rebuilt the site. Note that, after merging to the `master` branch, it can sometimes take a few minutes for your changes to appear.

## Making Updates to the Documentation Repository

Whether you are creating new documentation, or updating an existing topic, the steps are the same.

1. Create a new issue (ticket) in the documentation repo: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues

   **Tip:** If you have a related issue in the Spartacus repository, it is recommended that, in each ticket, you add a link to the other ticket. The normal GitHub shortcuts for linking to other tickets (#xx or GH-xx) do not work across different repositories, so use the full URL of the ticket. Even across different repositories, GitHub still tracks if the issue is open, merged, closed, etc.

2. Create a new branch in the documentation repo. The branch naming convention is `doc/GH-issue-number`, where `GH-issue-number` refers to the GitHub issue you have created in the documentation repository. So if your new issue number is #42, for example, then you would name your new branch `doc/GH-42`.

3. Create new documentation or update existing topics in the `_pages` folder.

   There are a number of conventions that need to be followed for your documentation to render properly in GitHub Pages. For more information, see the [Documentation Conventions](#documentation-conventions) section below.

4. Create a pull request.

   If your doc update should be published with the next release of the Spartacus libraries, send your pull request to the `develop` branch. If, on the other hand, you want your doc update to be published as soon as it is merged, then send your pull request to the `master` branch.

   The PR requires a minimum of one approver. It is always a good idea to let the writer check the PR, whenever possible.

5. Merge your pull request.

   If you merged your updates to the `develop` branch, they will be merged to the `master` branch (by the writer) on the next lib release day.
   If you merged your updates to the `master` branch, they will trigger Jekyll to rebuild the GitHub pages site. Your changes will show up after a few minutes (you may need to empty your cache to see the updates).  

## Updating the Sidebar



## Documentation Conventions

Please adhere to the following conventions to ensure your changes will build successfully when they are merged:


- File names: 

- Page titles: ... therefore, no need to add a heading 1 (single #) at the top of the page

- Links: 

- Curly Braces: ... include link/example of source to i18n.md

- Includes: 


