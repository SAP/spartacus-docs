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

    **Note:** If you decide to follow the steps in the tutorial, be aware that this tutorial guides you through setting up your own (test) site. Accordingly, remember to create your own test folder for setting up the site and following the tutorial steps. Do not point to the `cloud-commerce-spartacus-storefront-docs` repository for any part of the tutorial! :wink:

## Working with GitHub

If you are new to GitHub, I recommend having a look at Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/). Without following the tutorials, you can learn a lot by simply reading the introductions to each section.

The following sections are intended to help you get up-and-running with those aspects of GitHub that you need to contribute to the Spartacus project:

- [Your GitHub ID and Obtaining Write-Access to the Spartacus Repositories](#your-github-id-and-obtaining-write-access-to-the-spartacus-repositories)
- [Cloning the Documentation Repository](#cloning-the-documentation-repository)
- [Working with GitHub Issues](#working-with-github-issues)

### Your GitHub ID and Obtaining Write-Access to the Spartacus Repositories

Before being able to contribute to the Spartacus documentation, you first need a GitHub ID, as well as write-access to the Spartacus repositories.

The GitHub ID is the username of your GitHub account. If you already have a personal GitHub account, you can use this to contributing to the Spartacus project. If not, you must create a new GitHub account. Note that you cannot use your SAP Enterprise GitHub ID for working with Spartacus. Also be aware, your GitHub ID cannot include your SAP D-/I-/C-number, nor can it include "sap" as part of the ID.

If you are creating a new GitHub account, you can associate it with any email address that you want: it can be your SAP email address, or it can be a personal email address. This is the email address where you will receive notifications about your activities related to GitHub.

Once you have a GitHub ID, you then need write-access to the Spartacus repositories. Send your request for access to the Scrum Master of team Gladiators, either through Slack or email.

### Cloning the Documentation Repository

When you clone a repository, you are making a copy of the repository (that is, all the files and folders of the repository) on your local machine. You then make changes to the files locally, and upload them to the master repository hosted in GitHub. All the steps for working in GitHub (as relates to Spartacus documentation) are detailed further below.

The following steps describe how to clone the Spartacus documentation repository onto your local machine.

1. Open a shell app on your computer.

    For example, if you are on a Mac, you can use the `Terminal` application. On Windows, you can use the `Command Prompt`, for example. Or, on any computer, you can use the integrated terminal that is included in VS Code. For more information on using the VS Code integrated terminal, see the [VS Code documentation](https://code.visualstudio.com/docs/editor/integrated-terminal).

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

All open issues related to the Spartacus documentation repository can very viewed under the [Issues](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues) tab, which you can access at the top of any page in the repository, including the page you are currently reading.

You can create a new issue by clicking the green **New issue** button on the upper-right side of the **Issues** page. Since creating issues is a frequent activity when working in GitHub, you may want to bookmark the [New issue](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues/new) page.

When you create a new issue, you also need to assign it to a project. The Spartacus tribe uses project boards for tracking work on a sprint-by-sprint basis, and should look familiar to you with its various columns, such as **To Do**, **In Progress**, and **Done**. At the moment,the Spartacus docs repo has only one project: the [Spartacus Documentation project](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/projects/1). When you start to contribute documentation to Spartacus, it might make sense to create a project specific to the work for your team. **Note:** You can access all projects for a particular repo by clicking on the [Projects](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/projects) tab at the top of any page in GitHub.

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

To learn more about GitHub Issues, check out the following links from the GitHub Help documentation:

- [About issues](https://help.github.com/en/articles/about-issues)
- [Searching issues and pull requests](https://help.github.com/en/articles/searching-issues-and-pull-requests)
- [About project boards](https://help.github.com/en/articles/about-project-boards)

### Working with Branches

Everything in GitHub lives in a branch. The documentation that is published on the Spartacus help site resides in the `master` branch. At any given time, the work that is waiting to be published with the next release of the Spartacus libraries is staged in the `develop` branch. And any work that is done to update the documentation (such as creating a new topic, updating an existing topic, or just fixing a typo) is done on an individual branch that is named according to the relevant ticket (that is, the relevant GitHub issue).

When you create a branch, it is like you are making your own personal copy of the entire project, where you can experiment and make changes as much as you like, without risk of affecting the main `master` and `develop` branches. And when your work is complete, and has been tested by running a Jekyll build from your branch, you can then merge your work back into one of the main branches. Aside from emergency fixes, you always create new branches off the `develop` branch, and you always merge back to the `develop` branch. The `develop` branch is the pre-publishing or staging branch. When updates to the Spartacus libraries are released (which happens more or less every sprint), the documentation release master merges the `develop` branch into the `master` branch, at which point the Spartacus help site is automatically updated with all the changes that were staged in the `develop` branch.

As mentioned earlier, you create a new branch when you want to create a new topic, update an existing topic, or even just fix a typo. Of course, you can combine work in a single branch, such as fixing a typo in one topic while making updates to a different topic, but you should always create separate branches for work that will be released at different times. To give an example, your team might be working on Feature A and Feature B at the same time, but Feature A will be released before Feature B. In this case, you need separate branches for the documentation for Feature A and for Feature B, so that you can release Feature A documentation at the same time that Feature A is released, and later, you can release Feature B documentation along with the release of Feature B. If you were to put the documentation for both features in a single branch, when it comes time to release Feature A, you would be forced to publish the documentation for Feature B as well the documentation for Feature A, even though Feature B is not ready for release. If you are in doubt about whether you should combine your work in one branch, or create separate branches for different tasks, it is safer to dedicate specific tasks to specific branches.

When you are working with branches, the workflow proceeds as follows:

1. Go to the branch that you want to use as your starting point. Aside from emergency fixes, you always start from the `develop` branch.

    In Git terminology, you "check out" a branch when you want to switch from one branch to another. So in this case, no matter which branch you are currently on, you can check out the `develop` branch with the following command: `git checkout develop`.

1. Make sure you have all the latest updates on the `develop` branch by "pulling the latest changes".

    When you check out the `develop` branch, you are switching to the "local" copy of the branch that is on your computer. However, there is also a "remote" version of the same branch, which is the online version that everyone sees and sends their updates to. If other people have made changes to the remote version of the `develop` branch since the last time you updated it, you won't have those updates until you download them. You update the branch with following command: `git pull`.

1. Create a new branch.

    Your new branch starts off as a copy of the `develop` branch, with the only difference being that you give it a different name, based on the relevant GitHub ticket. If the relevant ticket number is `GH-123` (often also displayed as `#123`), then you would name your new branch `doc/GH-123`. You can create a new branch and switch to it in a single command: `git checkout -b doc/GH-xxx`. For example, if your GitHub issue number is `#123`, then the command would be: `git checkout -b doc/GH-123`

1. Save your work.

    When you save your work, you are ready for the next step in the workflow, which is to stage your work. At this point, although the work you have done is saved in your editor, if you happen to switch branches, any work that you have not committed is lost.

1. Stage your work.

    This step allows you to more formally decide which work will actually be included in your commit. If you have worked on multiple files, you can choose to stage only certain files, if you do not wish to commit the work you have done in the other files. Or you can stage work progressively as you go within a single file. At any time, you can also unstage your work, and nothing is "undone" if you do so. You must stage your work before you commit it, though if you attempt to commit unstaged work, editors such as VS Code offer options to "automatically stage all your changes and commit them directly", to which you can answer "Yes", "Cancel", "Never", and "Always".

1. Write a commit message and commit your work.

    The more meaningful your commit message, the easier it is to track down a commit later on, if you want to undo a commit, or see when a certain change was introduced. There is a 50 character limit to the message, so it needs to be brief, but it can be as simple as referring to the section you have updated, or that you fixed a broken link, or a typo. So try to be specific when possible.

    When you commit your work, it is "saved" in the local copy of your branch, and it is then safe to switch to other branches. You can make commits to your branch as often as you like. At this point, other people still can't see the work you have done. For that, you need to `push` your work, which is the next step.

1. Push your work with the command `git push`.

    The work on your local branch is uploaded (pushed) to the remote branch. Now, anyone who tries to access this branch can see the work you have done (that is, all the work that you have pushed so far). The first time that you push your updates, Git also offers to create a pull request (which you can do by clicking the provided link). Until your pull request is merged, you can continue pushing updates to it.

1. Merge your work.

    This is done with a pull request to the `develop` branch. Normally, you will have set up a pull request (PR) the first time that you pushed work from your branch. Someone needs to review your work and approve it. When the work is approved, you will be able to merge your work. When your work is merged, GitHub's web interface often offers the option to delete your branch. To avoid the repository getting cluttered with branches that are no longer needed, it is a good idea to delete your branch after your work has been merged.

------------------

- Procedure for adding/updating content must include a step where the writer runs a Jekyll build in their branch (`bundle exec jekyll serve`), and verifies it locally (`http://localhost:4000/`) **before** merging to `develop` or `master`.
- Every merge to the `master` branch automatically triggers Jekyll to rebuilt the site. Note that, after merging to the `master` branch, it can sometimes take a few minutes for your changes to appear.
- Include this "Learn git concepts, not commands" resource https://dev.to/unseenwizzard/learn-git-concepts-not-commands-4gjc
- Mention GitHub Desktop and Sourcetree as other tools that may be of interest, but that are beyond the scope of this document (ask your team for recommendations, suggestions -- note that neither of these tools are necessary)
- If you want to know more about Git in general, this guide is very useful: https://git-scm.com/book/en/v2

## Making Updates to the Documentation Repository

Whether you are creating new documentation, or updating an existing topic, the steps are the same.

One important detail to keep in mind is that the `develop` branch is used for staging documentation updates that will be published with the next release of the Spartacus libraries, while the `master` branch contains the "live", published documentation.

**Note:** It is recommended to always create new `doc` branches from the `develop` branch. It is also recommended to always send your pull requests to the `develop` branch. The `master` branch should only be used for emergencies.

There are various (free) tools that you can use to update the documentation, such as GitHub Desktop and Sourcetree. However, I found the simplest way of working with GitHub was to use Git commands in the terminal of VS Code. Accordingly, the following steps describe how to update the documentation in Spartacus using the integrated terminal in VS Code.

1. Create a new issue (ticket) in the documentation repository: https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/issues/new

1. Checkout the `develop` branch. [command]

1. Pull the latest from the `develop` branch [command]

1. Create a new branch in the documentation repo. The branch naming convention is `doc/GH-issue-number`, where `GH-issue-number` refers to the GitHub issue you have created in the documentation repository. So if your new issue number is #42, for example, then you would name your new branch `doc/GH-42`.

    Always create your new `doc` branch from the `develop` branch.
  
    The one exception is if you have an emergency update that needs to be published as soon as it is merged, in which case you can create your new `doc` branch from the `master` branch.

1. Create new documentation or update existing topics in the `_pages` folder.

   There are a number of conventions that need to be followed for your documentation to render properly in GitHub Pages. For more information, see the [Documentation Conventions](#documentation-conventions) section below.

1. Push your work with the command `git push`.

    The first time you push your work with this command, Git returns an error similar to the following:
    
    ```bash
    fatal: The current branch doc/GH-123 has no upstream branch.
    To push the current branch and set the remote as upstream, use

    git push --set-upstream origin doc/GH-123
    ```

    In your shell app, copy-paste the command from the error message and hit **Enter**. This command pushes your work, and simultaneously sets up the remote copy of your branch that you are pushing to

1. Create a pull request.

   Always send your pull request to the `develop` branch.
  
   The one exception is if you have an emergency update that needs to be published as soon as it is merged, in which case you can send your pull request to the `master` branch.

   The PR requires a minimum of one approver. Always include a writer as one of the approvers.

1. Merge your pull request.

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
