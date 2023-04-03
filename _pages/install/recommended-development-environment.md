---
title: Recommended Development Environment
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## CLI tools

There are a number of necessary CLI tools that you need to have installed in order to work with Spartacus, as follows:

- Node - first and foremost you need Node installed. To install it, refer to the [official site](https://nodejs.org). An alternative to installing a system-wide version of node is to use a Node version manager, such as [nvm](https://github.com/nvm-sh/nvm#installation-and-update). `nvm` also works on Windows via Windows Subsystem for Linux, a.k.a. `WSL`; if `WSL` is not available, [nvm-windows](https://github.com/coreybutler/nvm-windows) can be used. The advantage of installing a Node version manager is that it provides an ability to easily switch to a different version of Node.
- Package manager - the Spartacus team uses `npm`, as a package manager solution. `npm` comes pre-installed with Node.
- Angular CLI - to install it, run `npm install -g @angular/cli`. 

### Versions

{% include docs/frontend_requirements.html %}

## Editor

Spartacus team recommends a highly extensible and open source editor - *VSCode*, which can be downloaded from [here](https://code.visualstudio.com/Download).

### VSCode settings

To share some common settings across team members, create `.vscode` folder in the root of your project, and inside of it create `settings.json` file. Settings added here are known as `workspace` settings.

Here are some recommended workspace settings that also help to avoid collision with the recommended code-formatter:

```json
{
  // Prettier uses single quotes.
  "prettier.singleQuote": true,
  // Prettify on save
  "editor.formatOnSave": true,
  // prettier uses 2 spaces instead of 4
  "editor.tabSize": 2,
  // organize imports on save
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  },
  // Uses the project specific typescript version.
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

### VSCode extensions

Here is a list of recommended extensions when working with Spartacus:

- angular language services
- prettier - code formatter
- ESLint
- Stylelint

There's no need to manually install these extensions - just create `.vscode` folder in the root of your project, and inside of it create `extensions.json` with the following content:

```json
{
  "recommendations": [
    // Angular Language Service
    "Angular.ng-template",
    // Prettier - Code formatter
    "esbenp.prettier-vscode",
    // The ng lint command uses ESLint under the hood.
    "dbaeumer.vscode-eslint",
    // Modern CSS/SCSS/Less linter
    "stylelint.vscode-stylelint"
  ]
}
```

VSCode will automatically prompt you to install the recommended extensions with just one click. This is also a nice way to have a consistent environment across team members.

Some other notable extensions:

- Inline HTML and CSS highlighter - `natewallace.angular2-inline`
- A more richer git support than VS Code's default one - `eamodio.gitlens`
- AI assisted IntelliSense - `visualstudioexptteam.vscodeintellicode`
- Languages support for the SAP Hybris import/export language ImpEx (unofficial) - `simplyroba.impex-support`
- Markdown linting and style checking for Visual Studio Code - `davidanson.vscode-markdownlint`

## Project setup

After following the steps in [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}), it's time to set up the project.

### Code formatting

As a code formatter, Spartacus team prefers [prettier](https://prettier.io/). To install it as a dependency, run `yarn add prettier --dev`. To share prettier settings with all team members, create `.prettierrc` file in the root of your project and paste the following:

```json
{
  "printWidth": 120,
  "singleQuote": true,
  "useTabs": false,
  "tabWidth": 2,
  "semi": true,
  "bracketSpacing": true,
  "trailingComma": "es5"
}
```

Most of these options are prettier's defaults, but it's a good practice to have them explicitly defined.

To ignore some files from being formatted, create `.prettierignore` in the project's root, and ignore your files like so:

```json
**/*.md
```

To avoid collision between `eslint` and `prettier`, it's recommended to disable formatting rules from eslint.  You can find information on how to integrate Prettier and linters in Prettier's documentation: https://prettier.io/docs/en/integrating-with-linters.html

To run `prettier` you can add this script to `package.json` to `scripts` array: `"prettier": "prettier --config ./.prettierrc --list-different \"src/**/*{.ts,.js,.json,.scss,.html}\""`.

_Note_: you may have to change `src` to match the directory that you are using as a source directory.

To check for formatting violations run: `npm run prettier`.

### linting

To check for linting violations, run `ng lint`.

## Final Steps

Finally, you may need to run `npm install` to install dependencies added to `package.json`.
