# Developers: Contributing to Documentation

All documentation for Spartacus resides in the `_pages` folder that is located in the root of this repository.

The [Spartacus documentation website](https://sap.github.io/spartacus-docs/) is hosted in GitHub Pages and is powered by Jekyll. Every merge to the `master` branch automatically triggers Jekyll to rebuild the site.

Note that, after merging to the `master` branch, it can sometimes take a few minutes for changes to appear on the site.

## Making Updates to the Documentation Repository

Whether you are creating new documentation, or updating an existing topic, the steps are the same.

One important detail to keep in mind is that the `develop` branch is used for staging documentation updates that will be published with the next release of the Spartacus libraries, while the `master` branch contains the "live", published documentation.

**Note:** It is recommended to always create new `doc` branches from the `develop` branch. It is also recommended to always send your pull requests to the `develop` branch. The `master` branch should only be used for emergencies.

1. Create a new issue (ticket) in the documentation repository: https://github.com/SAP/spartacus-docs/issues/new

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
