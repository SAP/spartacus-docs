# Contributing to the Spartacus Storefront Documentation

Thank you for your interest in the Spartacus storefront documentation! We welcome contributions in all forms.

Here are some of the ways you can contribute to the Spartacus documentation:

Note: This is a living document. Like the Spartacus documentation, this document will be improved over time with the help of our community. Feedback welcome.

----

## Helping Others

An easy way to start is by helping others who may have questions or need support. Look for such requests here:

* Spartacus [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU)
* [Stack Overflow posts tagged with 'spartacus-storefront'](https://stackoverflow.com/questions/tagged/spartacus-storefront)

----

## Reporting Issues

Bug reports welcome! We are using [GitHub issue tracking](https://github.com/SAP/spartacus-docs/issues) for tracking user stories and bugs.

### How We Process Issues

New issues are reviewed regularly for validity and prioritization. Confirmed issues are given the "Approved" label, and the rest are either sent back to the reporter with a request for more details, or closed with an explanation.

Validated issues are then moved into one of these buckets:

* Priority issues will be assigned to one of our writers
* Issues that are less urgent will be left open as "contribution welcome"

Issues are closed when the fix is merged to develop.

### Issue Reporting Disclaimer

Feedback, especially bug reports, are always welcome. However, our capacity as a team is limited -- we cannot answer specific project or consultation requests, nor can we invest time in fleshing out what might be a bug. Because of this, we reserve the right to close or not process issue reports that do not contain enough information. We also do not guarantee that every well-documented issue will be fixed.

That being said, we will try our very best to ensure the Spartacus documentation is of high quality.

----

## Analyzing Issues

You don't have to be a programmer to help us determine the specifics of a bug. Any help here is welcome!

----

## Contributing Documentation

We welcome contributions to the Spartacus documentation. Before you start your first contribution, here are some things you should know:

1. You must be aware of the Apache License (which describes contributions), and you must agree to the [Developer Certificate of Origin](LICENSE.md). This is common practice for most open source projects.

    Note: You do not need to sign the CLA until you submit your first pull request. If you have not signed the CLA before, a link to the CLA assistant is provided on the PR status page.

    * To make this process as simple as possible, we use the *[CLA assistant](https://cla-assistant.io/)* for individual contributions. CLA assistant is an open source tool that integrates with GitHub very well and enables a one-click-experience for accepting the CLA.
    * For company contributors, special rules apply. See the respective section below for details.

1. Contributions must be compliant with the project code style, quality, and standards. We also follow them :-) 

    The `Contribution Content Guidelines` section below gives more details on the content guidelines.

1. Not all contributions will be accepted.
    * The documentation you are submitting must fit the overall vision and direction of Spartacus and really improve it.
    * Major feature implementations should be discussed with the owner [Bill Marcotte](https://github.com/Xymmer). You can also float ideas in our Slack channel, and we'll connect you to the appropriate person for further discussion.

## Developer Certificate of Origin (DCO)

Due to legal reasons, contributors will be asked to accept a DCO before they submit the first pull request to this projects. This happens in an automated fashion during the submission process. SAP uses [the standard DCO text of the Linux Foundation](https://developercertificate.org/).

### Contribution Content Guidelines

A contribution will be considered for inclusion in the Spartacus documentation if it meets the following criteria:

* The contribution fits the overall vision and direction of Spartacus
* The contribution truly improves the documentation
* The contribution follows the applicable guidelines and standards.

The "guidelines and standards" requirement could fill entire books and still lack a 100% clear definition, but rest assured that you will receive feedback if something is not right. That being said, please consult the [Contributing to Documentation guides](https://github.com/SAP/spartacus-docs/tree/master/contributing_to_docs).

### Contribution Process

1. Make sure the change would be welcome, as described above.

1. Create a fork of the Spartacus documentation sources. 

1. Build and run the documentation from the documentation development workspace. 

    For more information, see the [Contributing to Documentation guides](https://github.com/SAP/spartacus-docs/tree/master/contributing_to_docs).

1. Work on the change in your fork (either on the `develop` branch or on a `doc` branch).

1. Commit and push your changes using the [squash and merge](https://help.github.com/articles/about-pull-request-merges/) feature in GitHub.

    You should also use the squash and merge feature when additional changes are required after code review.

1. If your change fixes an issue reported in GitHub, add the following line to the commit message:

     ```Fixes https://github.com/SAP/spartacus/issues/(issueNumber)```

    * Do not add a colon after "Fixes", as this prevents automatic closing.
    * When your pull request number is known (for example, because you enhanced a pull request after a code review), you can also add the following line:

        ```Closes https://github.com/SAP/spartacus/pull/(pullRequestNumber)```

1. Create a pull request so that we can review your change.
1. Follow the link posted by the CLA assistant to your pull request and accept it, as described above.
1. Wait for our review and approval, possibly enhancing your change on request.
    
    Note: This may take time, depending on the required effort for reviewing, testing, and clarification. Spartacus writers are also working their regular duties.

1. After the change has been approved, we will inform you in a comment.

1. Due to internal SAP processes, your pull request cannot be merged directly into the branch. It will be merged internally, and will also immediately appear in the public repository.
1. We will close the pull request. At that point, you can delete your branch.

We look forward to hearing from you!
