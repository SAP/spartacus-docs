# Writers: Contributing to Documentation

The [Spartacus documentation website](https://sap.github.io/spartacus-docs/) is hosted in GitHub Pages and is powered by Jekyll.

All documentation for Spartacus resides in the `_pages` folder that is located in the root of this repository.

The following sections are intended to help you get up and running with everything you need to start contributing to the Spartacus documentation repository.

## Working with Markdown

All documentation in the Spartacus documentation repository is written in Markdown. Files written in Markdown have a `.md` file extension.

Markdown does not use tags, but it does use a specific syntax to format text.

To get started with writing documentation in Markdown, check out the following guide: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet. And while this page explains most of the formatting and syntax you are likely to need, the following pages can be useful as well:

- https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf

- https://www.markdownguide.org/cheat-sheet/

## Working with Visual Studio Code

Visual Studio Code (VS Code) is an open-source code editing tool that is highly recommended for anyone who wishes to contribute to the Spartacus project. You can download it for free here: https://code.visualstudio.com

VS Code has built-in interfaces for committing code and running commands, for navigating directories on your computer, and of course for editing text and previewing how your [Markdown](#working-with-markdown) pages will render.

To be able to make updates to the documentation repository, you first need to configure VS Code to communicate with Git, which is a separately installed component. The following page has information about commonly used components in VS Code: https://code.visualstudio.com/docs/setup/additional-components

And this page has information about how to install Git for your operating system: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

You may want to ask a developer on your team for help with configuring VS Code to work with Git.

[Making Updates to the Documentation Repository](#making-updates-to-the-documentation-repository) explains how to add and update documentation in the documentation repository using VS Code, but of course you can learn a lot more about working with VS Code by checking out the first few sections of the VS Code documentation: https://code.visualstudio.com/docs

## Working with Jekyll

Jekyll is the software we use for generating the Spartacus documentation site.

**Note:** Writers must install Jekyll on their local machines. With Jekyll installed, you can build the documentation website on your local machine, and this ensures that updates to the documentation are free from errors that could prevent the site from working properly.

To get up and running with Jekyll, read this [intro to Ruby](https://jekyllrb.com/docs/ruby-101/), and then install a full [Ruby development environment](https://jekyllrb.com/docs/installation/). The steps for installing Ruby also include steps for installing Jekyll. 

If you are on a Mac, run all the necessary commands for installing Ruby and Jekyll from the home directory (`~`) in Terminal. By default, this is the directory that Terminal opens in (unless you have changed the default).

If you are on Windows, run all the necessary commands for installing Ruby and Jekyll from your user directory in a command prompt (for example, `Users\your_username`). By default, when you open a command prompt from the Start menu, this is the directory that the command prompt opens in (unless you have changed the default).

### Useful Links

Although you don't need to become an expert in Jekyll to contribute to the Spartacus documentation, the following links may nonetheless be of interest:

- [Jekyll Quickstart](https://jekyllrb.com/docs/)
- [Step by Step Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/)

    **Note:** If you decide to follow the steps in the tutorial, be aware that this tutorial guides you through setting up your own (test) site. Accordingly, remember to create your own test folder for setting up the site and following the tutorial steps. Do not point to the `spartacus-docs` repository for any part of the tutorial! :wink:

## Working with GitHub

If you are new to GitHub, have a look at Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/). Without following the tutorials, you can learn a lot by simply reading the introductions to each section.

The following sections are intended to help you get up and running with those aspects of GitHub that you need to contribute to the Spartacus project:

- [Your GitHub ID and Obtaining Write-Access to the Spartacus Repositories](#your-github-id-and-obtaining-write-access-to-the-spartacus-repositories)
- [Cloning the Documentation Repository](#cloning-the-documentation-repository)
- [Working with GitHub Issues](#working-with-github-issues)
- [Working with Branches](#working-with-branches)
- [Further Reading About Git](#further-reading-about-git)

### Your GitHub ID and Obtaining Write-Access to the Spartacus Repositories

Before being able to contribute to the Spartacus documentation, you first need a GitHub ID, as well as write-access to the Spartacus repositories.

The GitHub ID is the username of your GitHub account. If you already have a personal GitHub account, you can use this to contribute to the Spartacus project. If not, you must create a new, personal GitHub account. Note that you cannot use your SAP Enterprise GitHub ID for working with Spartacus. Also be aware, your personal GitHub ID cannot include your SAP D-/I-/C-number, nor can it include "sap" as part of the ID.

If you are creating a new GitHub account, you can associate it with any email address that you want: it can be your SAP email address, or it can be a personal email address. This is the email address where you will receive notifications about your activities related to GitHub.

When you have finished setting up a personal GitHub account, you must then join the SAP GitHub Organization and link your GitHub account to your SAP-internal account. You must also set up your GitHub account to use two-factor authentication. All the steps for this are described in [Self-Service for Joining an SAP GitHub Organization](https://github.wdf.sap.corp/OSPO/guidelines/blob/master/publishing/github-self-registration.md). Note, VPN is required to access this link if you are outside of the `SAP Corporate` network.

Once you have joined the SAP GitHub Organization and linked your GitHub account to your SAP-internal account, you can then request write access to the Spartacus documentation repository. To do so, send your GitHub ID to one of the Spartacus administrators, either through Slack or email, and you will be contacted as soon as write access has been granted.

### Cloning the Documentation Repository

**Note:** Do not begin this step until you have installed Jekyll and have verified that it is running. To do so, please ensure that you have successfully completed all the steps in the [Jekyll Quickstart Guide](https://jekyllrb.com/docs/) before cloning the Spartacus documentation repository.

Before you can contribute to Spartacus documentation, you must clone the Spartacus documentation repository.

When you clone a repository, you are making a copy of the repository (that is, all the files and folders of the repository) on your local machine. You then make changes to the files locally, and upload them to the master repository hosted in GitHub. All the steps for working in GitHub (as relates to Spartacus documentation) are detailed further below.

The following steps describe how to clone the Spartacus documentation repository onto your local machine.

1. Open a shell app on your computer.

    For example, if you are on a Mac, you can use the **Terminal** application. On Windows, you can use the **Command Prompt**, for example. Or, on any computer, you can use the integrated terminal that is included in VS Code. For more information on using the VS Code integrated terminal, see the [VS Code documentation](https://code.visualstudio.com/docs/editor/integrated-terminal).

2. Within the shell app of your choice, navigate to the directory on your local machine where you would like to copy the repository.

    You do not need to create a new folder. The clone operation takes care of this.

3. In your shell app, enter the following command:

    ```bash
    git clone https://github.com/SAP/spartacus-docs.git
    ```

4. Press **Enter**.

    A new `spartacus-docs` directory is created, and a local clone of the Spartacus documentation repository is copied to this directory.

### Working with GitHub Issues

GitHub has its own issue tracking system, called GitHub Issues. GitHub Issues is open source, just like the Spartacus code. Anyone can see the issues we're working on, and anyone with a GitHub account can create a new issue. Note, the Spartacus tribe uses the terms "issue" and "ticket" interchangeably.

All open issues related to the Spartacus documentation repository can be viewed under the [Issues](https://github.com/SAP/spartacus-docs/issues) tab, which you can access at the top of any page in the repository, including the page you are currently reading.

You can create a new issue by clicking the green **New issue** button on the upper-right side of the **Issues** page. Since creating issues is a frequent activity when working in GitHub, you may want to bookmark the [New issue](https://github.com/SAP/spartacus-docs/issues/new) page.

When you create a new issue, you also need to assign it to a project. The Spartacus tribe uses project boards for tracking work on a sprint-by-sprint basis, and should look familiar to you with its various columns, such as **To Do**, **In Progress**, and **Done**. At the moment,the Spartacus docs repo has only one project: the [Spartacus Documentation project](https://github.com/SAP/spartacus-docs/projects/1). When you start to contribute documentation to Spartacus, it might make sense to create a project specific to the work for your team. **Note:** You can access all projects for a particular repo by clicking on the [Projects](https://github.com/SAP/spartacus-docs/projects) tab at the top of any page in GitHub.

#### Creating a New Issue

The following steps guide you through creating a new issue in GitHub:

1. Open the new issue page: https://github.com/SAP/spartacus-docs/issues/new

2. Provide a title in the **Title** field.

3. In the comment box below the **Title** field, add a description of the work to be done.

4. In the column on the right, click on **Projects** and assign the issue to a project.

    For now, the only project is the [Spartacus Documentation](https://github.com/SAP/spartacus-docs/projects/1) project.

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

As mentioned earlier, you create a new branch when you want to create a new topic, update an existing topic, or even just fix a typo. Of course, you can combine work in a single branch, such as fixing a typo in one topic while making updates to a different topic, but generally speaking, it is better to create separate branches for taking taking care of different kinds of work. To give an example, your team might be working on Feature A and Feature B at the same time, but Feature A will be released before Feature B. In this case, you need one branch for the documentation for Feature A, and another branch for the documentation for Feature B. This way, when Feature A is ready to be released, you can release the Feature A documentation at the same time. Later, when it is time for Feature B to be released, you can also release the Feature B documentation. If you were to put the documentation for both features in a single branch, you would not be able to separate what gets merged from your branch and what doesn't, because all the work on Feature A docs and Feature B docs would be mixed in together. So if you tried to merge your work for Feature A, you would end up merging (and releasing!) your work for Feature B as well, even though Feature B is not ready to be released.

In general, and especially if you are working on several tasks at the same time, the easiest way to manage your work is to dedicate each task to its own branch.

### Further Reading About Git

Although this writers' guide tries to introduce some Git concepts, the following resources are highly recommended:

- [Learn git concepts, not commands](https://dev.to/unseenwizzard/learn-git-concepts-not-commands-4gjc)
- [Pro Git](https://git-scm.com/book/en/v2)

## Making Updates to the Documentation Repository

Whether you are creating new documentation or updating an existing topic, the steps are the same.

The following workflow describes how to make updates to the documentation repository using Git commands and various features of VS Code. You are free to choose different tools, but your workflow should generally follow the approach described here.

1. Create a new GitHub issue in the documentation repository that describes the work you plan to do.

    For more information, see [Working with GitHub Issues](#working-with-gitHub-issues).

1. In VS Code, open your local copy of the Spartacus documentation repository as follows:

    1. In the menu, click **File —> New Window**.
    1. In the **Activity Bar**, in the upper-left of the app window, click the **Explorer** button (just above the **Search** button), then click **Open Folder** in the **Explorer** panel that appears.
    1. Navigate to your `spartacus-docs` folder and click **Open**.
    
        The `spartacus-docs` folder is the folder that contains your clone of the Spartacus documentation repository. For more information, see [Cloning the Documentation Repository](#cloning-the-documentation-repository).

    For a general overview of the VS Code user interface, see the [VS Code documentation](https://code.visualstudio.com/docs/getstarted/userinterface).

1. If you don't already have a terminal window open in VS Code, in the menu, click **Terminal —> New Terminal**.

    **Note:** The terminal should open at the root of your repository, but if for some reason the directory that is shown in your terminal prompt is not `spartacus-docs`, then switch to this directory before continuing.

1. In the terminal, switch to the `develop` branch with the following command:

    ```bash
    git checkout develop
    ```

    When you want to create a new branch, you always start by switching to the branch that you want to use as your starting point. Aside from emergency fixes, you always start from the `develop` branch.

    In Git terminology, you "check out" a branch when you want to switch from one branch to another. So no matter which branch you are currently on, you can switch to (that is, check out) a different branch with the command `git checkout [branch name]`.

1. Get the latest updates from the `develop` branch with the following command:

    ```bash
    git pull
    ```

    When you check out the `develop` branch, you are switching to the local copy of the branch that is on your computer. However, there is also a remote version of the same branch, which is the online version that everyone sees and sends their updates to. If other people have made changes to the remote version of the `develop` branch since the last time you updated your copy, you won't have those updates until you download them. For any branch, you can update it at any time with the `git pull` command.

1. Create a new branch and switch to it with the following command:

    ```bash
    git checkout -b [branch-name]
    ```

    The branch naming convention is `doc/GH-issue-number`, where `GH-issue-number` refers to the GitHub issue you have created in the first step of this workflow. For example, if your new GitHub issue number is `#42`, then you would name your new branch `doc/GH-42`. The command for creating a branch for issue `#42` and switching to it is the following:

    ```bash
    git checkout -b doc/GH-42
    ```

    Your new branch starts off as a copy of the `develop` branch, with the only difference being that you give it a different name, based on the relevant GitHub ticket. You can create a branch from any other branch by switching to the branch you want to copy, and then creating a new branch from there. But unless you have a special reason to do otherwise, it is recommended to always create new branches from the `develop` branch.

1. Create new documentation or update existing topics in the `_pages` folder, which you can navigate to in the **Explore** panel.

   There are a number of conventions that need to be followed for your documentation to render properly in GitHub Pages. For more information, see the [Documentation Conventions](#documentation-conventions) section below.

1. When you have finished making your updates, run the Jekyll build from the terminal with the following command:

    ```bash
    bundle exec jekyll serve
    ```

    This command builds the entire documentation site from your local branch. Also, while this command is running, it rebuilds the site every time you save your work. Running the build is very important because you can find out if there are any build errors in your branch (and then fix them) before you merge your work back to the `develop` branch. You can also preview your work at `http://localhost:4000/`. This site runs from your current branch and updates automatically every time you save your work — as long as this command is running. Note that if `bundle exec jekyll serve` is running and you decide to switch to a different branch, the site automatically updates to display the contents of the branch you switched to.

    **Note:** You do not have to wait until you are finished making your updates to run this command. In fact, you can leave it running all the time.

    **Tip:** You can have multiple terminal windows open simultaneously. This lets you leave the `bundle exec jekyll serve` command running in one window, while allowing you to input Git commands in another. To open an additional terminal window, click the **Split Terminal** button that is in the top-right of the terminal window, in between the `+` button and the trash can button (that is, between the **New Terminal** and **Kill Terminal** buttons). To close additional terminal windows, use the **Kill Terminal** button.

    **Note:** When you save your changes, you must also commit them before switching to a different branch. If you happen to switch branches without committing your work, all updates since your last commit will be lost. How to commit your changes is explained later in this workflow.

1. Stage your work.

    This step is a precursor to committing your work. Often it can be done right before you are ready to commit. Staging your commit allows you to formally decide which work is actually included in the commit. For example, if you have worked on multiple files, and if you do not wish to commit the work you have done in all of the files, you can choose to stage only certain files. You can also stage work progressively as you go within a single file. At any time before you commit, you can also unstage your work, and none of your edits are undone if you do so. You must stage your work before you commit it, though if you attempt to commit unstaged work, editors such as VS Code offer options to "automatically stage all your changes and commit them directly", to which you can answer "Yes", "Cancel", "Never", and "Always". If you choose "Always", you are essentially choosing to stage and commit in a single step every time your commit, and there is nothing wrong with that.

    The following steps describe how to stage your work:

    1. In the **Activity Bar**, click the **Source Control** button.

       If you have saved any changes, this button displays a badge with the number of files that can be potentially staged for your commit.

    1. In the **Source Control** panel, next to each file that is listed under **Changes**, click the **Stage Changes** button, which appears as a `+` symbol. Alternatively, next to the **Changes** label, you can click the **Stage All Changes** button, which also appears as a `+` symbol. Note, these buttons only show up when you hover over a file, or over the **Changes** label itself.

    At this point, your changes are staged and you are ready to commit your work.

1. Write a commit message and commit your work.

    The more meaningful your commit message, the easier it is to track down a commit later on. For example, if you want to undo a commit, or see when a certain change was introduced, a meaningful commit message makes this much easier. There is a 50 character limit to the message, so it needs to be brief, but the message can be as simple as referring to the section you have updated, or that you fixed a broken link, or even just a typo. Despite the 50 character limit on commit messages, try to be specific when possible.

    When you commit your work, it is "saved" in the local copy of your branch, and it is then safe to switch to other branches. You can make commits to your branch as often as you like. At this point, other people still can't see the work you have done. For that, you need to push your work, which is described in the next step of this workflow.

    **Note:** If you need to switch branches but you are not ready to commit your work, you also have the option to stash your work. For more information, see the [Stashing changes](https://dev.to/unseenwizzard/learn-git-concepts-not-commands-4gjc#stashing-changes) section of *Learn git concepts, not commands*.

    The following steps describe how to commit your work:

    1. In the **Activity Bar**, click the **Source Control** button.

    1. In the **Message** text field at the top of the **Source Control** panel, enter a commit message.

    1. Above the **Message** text field, click the **Commit** button, which appears as a ✓ checkmark symbol.

        You have now committed your work and are ready to push it.

1. In the terminal, push your work with the following command:

    ```bash
    git push
    ```

    The first time you push your work with this command, Git returns an error similar to the following:

    ```bash
    fatal: The current branch doc/GH-42 has no upstream branch.
    To push the current branch and set the remote as upstream, use

    git push --set-upstream origin doc/GH-42
    ```

    In your shell app, copy-paste the `git push --set-upstream origin [branch-name]` command from the error message and hit **Enter**. This command pushes your work, and simultaneously sets up the remote copy of your branch that you are pushing to. You only have to do this the first time you push a commit. After that, you only ever need the `git push` command to push your updates.

    When you push your commit, the work on your local branch is uploaded (pushed) to the remote branch. Now, anyone who tries to access this branch can see the work you have done (that is, they can see all the work that you have pushed to the remote branch so far).

1. Create a pull request.

    The first time that you successfully push a commit, Git returns a response in the terminal that includes a link to create a pull request (PR). Open this link and create a pull request. The steps are quite similar to creating a GitHub issue.

    Until your pull request is merged, you can continue pushing updates to it, so it is a good idea to create a PR when you push your first commit.
  
    **Note:** The pull request requires a minimum of one approver. Always include a senior writer as one of the approvers.

1. Merge your pull request.

   When your pull request has been approved, and all checks are green on the pull request page in GitHub, click the **Squash and merge** button. The page refreshes to display a header field with a proposed merge message, and a body field that includes a list of your commit messages. Edit these fields if you wish, then click the **Confirm squash and merge** button.
  
   Your work is now merged... Congratulations!
  
   **Tip:** After you click **Squash and merge**, if you add a line at the bottom of the body, such as "Closes GH-xxx" or "Fixes GH-xxx", where `xxx` is the number of your GitHub issue, when your PR is merged, the GitHub issue #xxx is closed automatically. You can use this to close the ticket that you opened in the first step of this workflow. If you don't add this line, you can always close your issue manually, later on.

1. Delete your branch.

    On the pull request page in GitHub, as soon as your PR is merged, you see the option to delete the original branch. To avoid the repository getting cluttered with branches that are no longer needed, it is a good idea to delete your branch after your work has been merged. If you have not deleted your branch from the PR page after you merged your pull request, you can always delete your branch with the following command:
  
    ```bash
    git branch -D [branch_name] && git push --delete origin [branch_name]
    ```
  
    For example, if you just merged work from branch `doc/GH-42`, then the command to delete the branch is the following: 
  
    ```bash
    git branch -D doc/GH-42 && git push --delete origin doc/GH-42
    ```

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

    The following is an example from the [Designing Action Buttons](https://sap.github.io/spartacus-docs/designing-action-buttons/) page:

    ```markdown
    ![submit button]({{ site.baseurl }}/assets/images/ux/action_how/submit_button.png)
    ```

- **Curly Braces:** When a Jekyll build is run, double curly braces `{{` and `}}` are interpreted as Liquid filters, with the result that the contents between the curly braces are either removed, or sometimes even processed!

    If your code example includes curly braces, you can escape it with the `{% raw %}` and `{% endraw %}` tags.

    See [the source](https://raw.githubusercontent.com/SAP/spartacus-docs/master/_pages/dev/i18n.md?token=AKKGMXYMRJY6J7DB3QQ5J7K5CKPTW) of the "Internationalization (i18n)" topic for examples of the `raw` tag being used, both inline and to escape entire codeblocks.

- **Includes:** If a certain block of text occurs repeatedly in the documentation, we can use the `include` tag to reference a single source HTML file. For example, the front end requirements for Spartacus developers are documented in `_includes/docs/frontend_requirements.html`, and then are referenced where ever they are needed, as follows:

    ```markdown
    {% include docs/frontend_requirements.html %}
    ```

    If you have text that occurs more than once, you can create an include file and add it to `_includes/docs`. Note that include files are written in HTML, rather than markdown. To see an example, take a look at [frontend_requirements.html](https://github.com/SAP/spartacus-docs/blob/master/_includes/docs/frontend_requirements.html).

    To see an example of an `include` tag in use, take a look at the [Front-End Development Requirements](https://raw.githubusercontent.com/SAP/spartacus-docs/master/_pages/install/building-the-spartacus-storefront-from-libraries.md?token=AKKGMX26EXQQJVG7GGGHUNC5CKRI4) section of "Building the Spartacus Storefront from Libraries".
