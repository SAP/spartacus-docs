# Developers: Contributing to Documentation

All documentation for Spartacus resides in the `_pages` folder of this repository.

If probably goes without saying that you need to clone this repo before continuing with the steps below.

## Making Updates to the Documentation Repository

Whether you are creating a new doc, or updating an existing doc, the steps are the same.

1. Create a new issue in the documentation repo: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues

   **Tip:** If you have a related issue in the Spartacus repository, it is a good idea to add a comment in that issue with the link to this new issue (and vice versa). The normal GitHub shortcuts (# or GH-xx) won't work, so use the full URL. GitHub can still track if the issue is open, merged, closed, etc.

2. Create a new branch in the documentation repo. The branch naming convention is `doc/GH-issue-number`, where `GH-issue-number` refers to the GitHub issue you created in the doc repo. So if your new issue number is #42, for example, then you would name your new branch `doc/GH-42`.

3. Update existing documentation or create new topics, as required.

   See the [Documentation Conventions](#documentation-conventions) section below for important details that can help you provide error-free documentation.

    
4. Create a pull request.

    **Note:** If your doc update is meant to be published with the next release of Spartacus libraries, send your pull request to the `develop` branch (by default, PRs are sent to the `develop` branch). If you want your doc update to be published as soon as it is merged, then send your pull request to the `master` branch.

## Updating the Sidebar



## Documentation Conventions

Please adhere to the following conventions to ensure your changes will build successfully when they are merged:


- File names: 

- Page titles: ... therefore, no need to add a heading 1 (single #) at the top of the page

- Links: 

- Curly Braces: ... include link/example of source to i18n.md

- Includes: 


