# Writers: Contributing to Documentation

The [Spartacus documentation website](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/) is hosted in GitHub Pages and is powered by Jekyll.

All documentation for Spartacus resides in the `_pages` folder that is located in the root of this repository.

The following sections are intended to help you get up-and-running with everything you need to start contributing to the Spartacus documentation repository.

## Working with Visual Studio Code

Visual Studio Code (VS Code) is an open-source code editing tool that is highly recommended for anyone who wishes to contribute to the Spartacus project. You can download it for free here: https://code.visualstudio.com

VS Code has built-in interfaces for committing code and running commands, for navigating directories on your computer, and of course for editing text and previewing how your [Markdown](#working-with-markdown) pages will render.

To be able to make updates to the documentation repository, you first need to configure VS Code to communicate with Git, which is a separately installed component. The following page has information about commonly used components in VS Code: https://code.visualstudio.com/docs/setup/additional-components

And this page has information about how to install Git for your operating system: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

You may want to ask a developer on your team for help with configuring VS Code to work with Git.

[Making Updates to the Documentation Repository](#making-updates-to-the-documentation-repository) explains how to add and update documentation in the documentation repository using VS Code, but of course you can learn a lot more about working with VS Code by checking out the first few sections of the VS Code documentation: https://code.visualstudio.com/docs

## Working with Markdown

All documentation in the Spartacus documentation repository is written in Markdown. Files written in Markdown have a `.md` file extension.

Markdown does not use tags, but it does use a specific syntax to format text.

To get started with writing documentation in Markdown, check out the following guide: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet. And while this page explains most of the formatting and syntax you are likely to need, the following pages can be useful as well:

- https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf

- https://www.markdownguide.org/cheat-sheet/

## Working with Jekyll

Jekyll is the software we use for generating the Spartacus documentation site.

**Note:** Writers must install Jekyll on their local machines. With Jekyll installed, you can build the documentation website on your local machine, and this ensures that updates to the documentation are free from errors that could prevent the site from working properly.

To get up-and-running with Jekyll, read this [intro to Ruby](https://jekyllrb.com/docs/ruby-101/), and then install a full [Ruby development environment](https://jekyllrb.com/docs/installation/). The steps for installing Ruby also include steps for installing Jekyll.

### Useful Links

Although you don't need to become an expert in Jekyll to contribute to the Spartacus documentation, the following links may nonetheless be of interest:

- [Jekyll Quickstart](https://jekyllrb.com/docs/)
- [Step by Step Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/)

    **Note:** If you decide to follow the steps in the tutorial, be aware that this tutorial guides you through setting up your own (test) site. Accordingly, remember to create your own test folder for setting up the site and following the tutorial steps. Do not point to the `cloud-commerce-spartacus-storefront-docs` repository for any part of the tutorial! :smile:

## Working with GitHub

### Your GitHub ID and Obtaining Write-Access to the Spartacus Repositories

Before being able to contribute to the Spartacus documentation, you first need a GitHub ID, as well as write access to the Spartacus repositories. You cannot use your SAP Enterprise GitHub ID. You must either use a GitHub account that you have already created, or if you don't already have one, you must create a new GitHub account. Also be aware, your GitHub ID cannot include your SAP D-/I-/C-number, nor can it include "sap" as part of the ID. If you are creating a new GitHub account, you can associate it with any email address that you want: it can be your SAP email address, or it can be a personal email address. This is the email address where you will receive notifications about your activities related to GitHub.

Once you have a GitHub ID, you then need write-access to the Spartacus repositories. Send your request for access to the Scrum Master of team Gladiators, either through Slack or email.

### Cloning the Documentation Repository

When you clone a repository, you are making a copy of the repository (all the files and folders of the repository) on your local machine. You then make changes to the files locally, and upload them to the master repository hosted in GitHub. All the steps for working in GitHub (as relates to Spartacus documentation) are detailed further below.

The following steps describe how to clone the Spartacus documentation repository onto your local machine.

1. Open a shell app on your computer.

    For example, if you are on a Mac, you can use the `Terminal` application. On Windows, you can use the `Command Prompt`, for example. Or, on any computer, you can use the integrated terminal that is included in VS Code. For more information on using the VS Code terminal, see the relevant [VS Code documentation](https://code.visualstudio.com/docs/editor/integrated-terminal).

2. Within the shell app of your choice, navigate to the directory on your local machine where you would like to copy the repository.

    You do not need to create a new folder. The clone operation takes care of this.

3. In your shell app, enter the following command:

    ```bash
    git clone https://github.com/SAP/cloud-commerce-spartacus-storefront-docs.git
    ```

4. Press **Enter**.

    A new `cloud-commerce-spartacus-storefront-docs` directory is created, and a local clone of the Spartacus documentation repository is copied to this directory.

### Working with GitHub Issues

GitHub has its own issue tracking system, called GitHub Issues. GitHub Issues is open source, just like the Spartacus code. Anyone can see the issues we're working on, and anyone with a GitHub account can create a new issue. Note, the Spartacus tribe uses the terms "issue" and "ticket" interchangeably.

All open issues related to the Spartacus documentation repository can very viewed under the [Issues](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues) tab, which you can access at the top of any page in the repository.

You can create a new issue by clicking the green [New issue](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues/new) button on the upper-right side of the **Issues** page. Since creating issues is a frequent activity when working in GitHub, you may want to bookmark this page.

When you create a new issue, you also need to assign it to a project. The Spartacus tribe uses project boards for tracking work on a sprint-by-sprint basis, and should look familiar to you with its various columns, such as **To Do**, **In Progress**, and **Done**. At the moment,the Spartacus docs repo has only one project: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/projects/1. When you start to contribute documentation to Spartacus, it might make sense to create a project specific to the work for your team. **Note:** You can access all projects for a particular repo by clicking on the [Projects](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/projects) tab at the top of any page in GitHub.

#### Creating a New Issue

The following steps guide you through creating a new issue in GitHub:

1. Open the new issue page: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues/new

2. Provide a title in the **Title** field.

3. In the comment box below the **Title** field, add a description of the work to be done.

4. In the column on the right, click on **Projects** and assign the issue to a project.

    For now, the only project is the [Spartacus Documentation](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/projects/1) project.

5. If you know who will start work on this issue, click on **Assignees** (above **Projects**) and assign the issue to that person.

6. Click **Submit new issue**.


#### Further Links

The following are useful links from the GitHub Help documentation:

- [About issues](https://help.github.com/en/articles/about-issues)
- [Searching issues and pull requests](https://help.github.com/en/articles/searching-issues-and-pull-requests)
- [About project boards](https://help.github.com/en/articles/about-project-boards)

------------------

- Need to clone the docs repo
- Working with GitHub Issues
- Procedure for adding/updating content must include a step where the writer runs a Jekyll build in their branch (`bundle exec jekyll serve`), and verifies it locally (`http://localhost:4000/`) **before** merging to `develop` or `master`.
- Every merge to the `master` branch automatically triggers Jekyll to rebuilt the site. Note that, after merging to the `master` branch, it can sometimes take a few minutes for your changes to appear.
- Include this "Learn git concepts, not commands" resource https://dev.to/unseenwizzard/learn-git-concepts-not-commands-4gjc
- Mention GitHub Desktop and Sourcetree as other tools that may be of interest, but that are beyond the scope of this document (ask your team for recommendations, suggestions -- note that neither of these tools are necessary)
- If you want to know more about Git in general, this guide is very useful: https://git-scm.com/book/en/v2

## Making Updates to the Documentation Repository

Whether you are creating new documentation, or updating an existing topic, the steps are the same.

One important detail to keep in mind is that the `develop` branch is used for staging documentation updates that will be published with the next release of the Spartacus libraries, while the `master` branch contains the "live", published documentation.

**Note:** It is recommended to always create new `doc` branches from the `develop` branch. It is also recommended to always send your pull requests to the `develop` branch. The `master` branch should only be used for emergencies.

1. Create a new issue (ticket) in the documentation repository: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues/new

   **Tip:** If you have a related issue in the Spartacus repository, it is recommended that, in each ticket, you add a link to the other ticket. The normal GitHub shortcuts for linking to other tickets (#xx or GH-xx) do not work across different repositories, so use the full URL of the ticket. Even across different repositories, GitHub still tracks if the issue is open, merged, closed, etc.

2. Create a new branch in the documentation repo. The branch naming convention is `doc/GH-issue-number`, where `GH-issue-number` refers to the GitHub issue you have created in the documentation repository. So if your new issue number is #42, for example, then you would name your new branch `doc/GH-42`.

    Always create your new `doc` branch from the `develop` branch.
  
    The one exception is if you have an emergency update that needs to be published as soon as it is merged, in which case you can create your new `doc` branch from the `master` branch.

3. Create new documentation or update existing topics in the `_pages` folder.

   There are a number of conventions that need to be followed for your documentation to render properly in GitHub Pages. For more information, see the [Documentation Conventions](#documentation-conventions) section below.

4. Create a pull request.

   Always send your pull request to the `develop` branch.
  
   The one exception is if you have an emergency update that needs to be published as soon as it is merged, in which case you can send your pull request to the `master` branch.

   The PR requires a minimum of one approver. Always include a writer as one of the approvers.

5. Merge your pull request.

   If you merged your updates to the `develop` branch, the updates will be staged until the next release of the Spartacus libraries, at which point they will be published by the documentation release master.

   If you merged your updates to the `master` branch, the updates will automatically trigger Jekyll to rebuild the GitHub pages site. The changes will show up after a few minutes (you may need to empty your cache to see the updates).  

## Updating the Sidebar

New topics must be explicitly added to `_data/navigation.yml` for them to appear in the sidebar. Please consult with a writer or the product owner before modifying this file. Of course, your writer can always make updates to this file on your behalf.

## Documentation Conventions

Please adhere to the following conventions to ensure that your changes build successfully when they are merged:


- **Filenames:** Use lower-case names for all documentation files. 

    Avoid changing the filename where possible, because links and permalinks need to be udpated every time the filename is changed. Having said that, page titles are independent of filenames, and can be changed any time.

- **Page titles:** The page title is included at the top of your documentation file, and appears between two rows of three dashes, as follows:

    ```markdown
    ---
    title: Hello Spartacus!
    ---
    ```

    This section is referred to in Jekyll as the "front matter".
  
    The page title takes the place of the level-1 header that normally appears in a markdown file, so there is no need to include leve1-1 headers (denoted by the single hashtag #) at the top of the page.
  
    The page titles is independent of the filename. You can change the title any time, but avoid changing the filename as much as possible.

- **Links:** To link to another page within the Spartacus documentation, use the `link` tag, as follows:

    ```liquid
    [link text]({{ site.baseurl }}{% link path/from/root/to/filename.md %})
    ```

    The following is an example:

    ```liquid
    [Adding and Customizing Routes]({{ site.baseurl }}{% link _pages/dev/routes/adding-and-customizing-routes.md %})
    ```

    To quote from the Jekyll help: *"One major benefit of using the `link` tag is link validation. If the link doesn’t exist, Jekyll won’t build your site. This is a good thing, as it will alert you to a broken link so you can fix it (rather than allowing you to build and deploy a site with broken links)."*

    Note, there are a few types of links that are not handled by the `link` tag: links to external sites, and links to sections within a page.
  
    If you need to link to an external site, use the following format:

    ```markdown
    [link text](URL)
    ```

    If you want to link to another section on the same page within the documentation site, use the following format:

    ```markdown
    [link text](#title-of-section)
    ```

    The title of the section must be in lower-case, and connected by dashes.

    If you want to link to a section on another page within the documentation site, use the following format:

    ```markdown
    [link text]({{ site.baseurl }}/permalink/#title-of-section)
    ```

    The title of the section must be in lower-case, and connected by dashes. The following is an example:

    ```markdown
    [Controlling Server-Side Rendering]({{ site.baseurl }}/customizing-cms-components/#controlling-server-side-rendering-ssr)
    ``` 

- **Images:** Images reside in the `/assets/images/` folder. The format for including an image in your topic is the following:

    ```markdown
    ![alt text]({{ site.baseurl }}/path/to/image.png)
    ```

    The following is an example from the [Designing Action Buttons](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/designing-action-buttons/) page:

    ```markdown
    ![submit button]({{ site.baseurl }}/assets/images/ux/action_how/submit_button.png)
    ```

- **Curly Braces:** When a Jekyll build is run, double curly braces (such as `{{` and `}}` ) are interpreted as Liquid filters, with the result that the contents between the curly braces are either removed, or sometimes even processed!

    If your code example includes curly braces, you can escape it with the `{% raw %}` and `{% endraw %}` tags. 

    See [the source](https://raw.githubusercontent.com/SAP/cloud-commerce-spartacus-storefront-docs/master/_pages/dev/i18n.md?token=AKKGMXYMRJY6J7DB3QQ5J7K5CKPTW) of the "Internationalization (i18n)" topic for examples of the `raw` tag being used, both inline and to escape entire codeblocks.

- **Includes:** If a certain block of text occurs repeatedly in the documentation, we can use the `include` tag to reference a single source HTML file. For example, the front end requirements for Spartacus developers are documented in `_includes/docs/frontend_requirements.html`, and then are referenced where ever they are needed, as follows:

    ```markdown
    {% include docs/frontend_requirements.html %}
    ```

    If you have text that occurs more than once, you can create an include file and add it to `_includes/docs`. Note that include files are written in HTML, rather than markdown. To see an example, take a look at [frontend_requirements.html](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/master/_includes/docs/frontend_requirements.html).
    
    To see an example of an `include` tag in use, take a look at the [Front-End Development Requirements](https://raw.githubusercontent.com/SAP/cloud-commerce-spartacus-storefront-docs/master/_pages/install/building-the-spartacus-storefront-from-libraries.md?token=AKKGMX26EXQQJVG7GGGHUNC5CKRI4) section of "Building the Spartacus Storefront from Libraries".
