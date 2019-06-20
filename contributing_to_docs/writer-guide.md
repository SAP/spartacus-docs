# Writers: Contributing to Documentation

The [Spartacus documentation website](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/) is hosted in GitHub Pages and is powered by Jekyll.

All documentation for Spartacus resides in the `_pages` folder that is located in the root of this repository.

The following sections are intended to help you get up-and-running with everything you need to start contributing to the Spartacus documentation repository.

## Working with Visual Studio Code

Visual Studio Code (VS Code) is an open-source code editing tool that is highly recommended for anyone who wishes to contribute to the Spartacus project. You can download it for free here: https://code.visualstudio.com

VS Code has built-in interfaces for committing code and running commands, for navigating directories on your computer, and of course for editing text previewing how your [markdown](#working-with-markdown) pages will render.

VS Code is the same tool your developers are using to contribute code to the Spartacus project, and you can use VS Code to build and try out your own Spartacus application, when it comes to testing the docs you are writing ;-)

To be able to make updates to the documentation repository, you first need to configure VS Code to communicate with Git, which is a separately installed component. The following page has information about commonly used components in VS Code: https://code.visualstudio.com/docs/setup/additional-components

This page has information about how to install Git for your operating system: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

And in general, if you want to know more about Git, this guide is very useful: https://git-scm.com/book/en/v2

Feel free to ask a developer on your team for help with configuring VS Code to work with Git.

## Working with Markdown


## Working with Jekyll


**Note:** You must always run the Jekyll build in your branch before you merge


## Working with GitHub

- Need GitHub ID
- Need to be get write access to repos
- Need to clone the docs repo
- Working with GitHub Issues
- Procedure for adding/updating content must include a step where the writer runs a Jekyll build in their branch, and verifies it locally (http://localhost:4000/) **before** merging to `develop` or `master`.
- Every merge to the `master` branch automatically triggers Jekyll to rebuilt the site. Note that, after merging to the `master` branch, it can sometimes take a few minutes for your changes to appear.
