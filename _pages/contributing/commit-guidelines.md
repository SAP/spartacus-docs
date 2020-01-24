---
title: Committing Code to Spartacus
---

## Settings

If you are on Windows, set the Git `core.autocrlf` configuration property to "false", and make sure to use Unix-style linebreaks (LF-only).

## Merging

When you are ready to merge your pull request, select GitHub's `Squash and merge` option, as shown in the following image:

![Squash and Merge Button]({{ site.baseurl }}/assets/images/Squash_and_merge_button.png)

For information on `Squash and merge`, see [GitHub Help](https://help.github.com/articles/about-pull-request-merges/).

# Commit Message Guidelines

We use git commit messages to generate the framework changelog. To that end, we have specific rules for how to format git commit messages. These rules are also intended to make the commit messages easier to read.

## Commit Message Format

The commit message consists of a header, a body, and optionally, a footer. Each line in the commit message has a maximum length of 100 characters.

When you click `Squash and merge`, two text fields appear. The first is for entering the header, and the second is for entering the body and footer, as shown in the following screenshot:

![Text fields for entering commit message]({{ site.baseurl }}/assets/images/Squash_merge_header_body_footer.png)

The following is an example of a header you might enter:

```
feat: introduce new facade signature and generic ngrx store state for fine-grained control of loading state (GH-123)
```

The following is an example of the corresponding body and footer. The footer begins with `BREAKING CHANGE`. Note that the body and footer are separated by a blank line:

```
The product, language and currency facades have been refactored. A generic reducer has been introduced for all entities that require fine-grained load, success and error state.

BREAKING CHANGE:

Product, language and currency facades have a new public interface.

Closes GH-123
```

### Header

The commit header is a brief summary of the work done.

When you click `Squash and merge`, the header field is automatically populated. However, it does not match our commit guidelines format precisely. Please modify it to fit the following format:

```
 <type>: <subject><issue number>
```

#### Type

The `type` is mandatory, and must be one of the following:

- `build`: for changes that affect the build system or external dependencies.

- `ci`: for changes to our CI configuration files and scripts.

- `docs`: for changes to documentation only

- `feat`: for new feature work

- `fix`: for a bug fix

- `perf`: for a code change that improves performance

- `refactor`: for a code change that neither fixes a bug nor adds a feature

- `style`: for changes that do not affect the meaning of the code, such as white-space, formatting, missing semi-colons, and so on

- `test`: for adding missing tests or to correct existing tests.

In the changelog, we only include commits that are of type `feat` or `fix`.

#### Subject

The subject contains a succinct description of the change, and adheres to the following rules:

- The subject is written in the present, imperative tense. For example, "add facades", rather than "adds facades" or "added facades".
- The first letter of the subject message is in lower-case.
- There is no period at the end of the subject message.

#### Issue Number

At the end of the header, include the GitHub issue number in parentheses, as follows: `(GH-123)`.

By default, GitHub includes the pull request number here, so be sure to change it to the issue number. After your commit message is submitted, GitHub converts the issue number into a link to the original issue, which can be convenient for anyone who is reading the changelog.

### Body

The body is entered in the text field below the header field.

The following are some guidelines for writing the body:

- Describe the problem you are fixing. Whether your patch is a one-line bug fix, or is 5000 lines of new code, there must be an underlying problem that motivated you to do this work. Make the necessity of the fix clear to the reviewers, so they will continue reading.

- Describe the effect that this change has from a user's point of view. App crashes and lockups are pretty convincing, but not all bugs are that obvious; this information should be mentioned in the text. Even if the problem was spotted during code review, describe the impact you think it can have on users.

- Describe the technical details of what you changed. It is important to describe the change as clearly as possible. This will help the reviewer to verify that the code is behaving as you intend it to.

### Footer

If your issue contains a breaking change, start the footer with `BREAKING CHANGE:` followed by a space or an empty line, and then a description of the breaking change. You can indicate one or more breaking changes in the footer with the following keywords:

- `BREAKING CHANGE`
- `BREAKING CHANGES`

If your issue contains a deprecation, you use a similar approach to breaking changes, with the following keywords:

- `DEPRECATION`
- `DEPRECATED`
- `DEPRECATIONS`

The footer is also where you can automatically close your issue with a keyword (such as `closes` or `fixes`). For information on the format, and a list of the available keywords, see [GitHub Help](https://help.github.com/articles/closing-issues-using-keywords/).

### Reverting a Commit

If your commit reverts a previous commit, begin the header with `revert:` and then include the header of the reverted commit. In the body, write "This reverts commit _hash_", where _hash_ is the SHA of the commit you are reverting.
