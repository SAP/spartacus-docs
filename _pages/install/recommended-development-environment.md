---
title: Recommended Development Environment (DRAFT)
---

## CLI tools

There are a couple of necessary CLI tools that you need to have installed in order to work with Spartacus:

- Node - first and foremost you need Node installed. The recommended version is Node 11. To install it, refer to the [official site](https://nodejs.org). An alternative to installing a system-wide version of node is to use a Node version manager, such as [nvm](https://github.com/nvm-sh/nvm#installation-and-update). `nvm` also works on Windows via Windows Subsystem for Linux, a.k.a. `WSL`; if `WSL` is not available, [nvm-windows](https://github.com/coreybutler/nvm-windows) can be used. The advantage of installing a Node version manager is that it provides an ability to easily switch to a different version of Node.
- Package manager - Spartacus team prefers `yarn` over `npm`, as a package manager solution, for its speed. To install `yarn` see the official [guide](https://yarnpkg.com/en/docs/install). `npm` comes pre-installed with Node.
- Angular CLI - to install it, run `npm install -g @angular/cli`. To configure angular CLI to always use `yarn` over `npm` run `ng config -g cli.packageManager yarn`. This setting is stored in `<YOUR_HOMEDIR>/.angular-config.json`. For more, see [this article](https://medium.com/@beeman/using-yarn-with-angular-cli-v6-7f53a7678b93).

## Editor

Spartacus team recommends a highly extendable and open source editor - _VSCode_, which can be downloaded from [here](https://code.visualstudio.com/Download).

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
- chrome debugger
- TSLint
- prettier - code formatter

There's no need to manually install these extensions - just create `.vscode` folder in the root of your project, and inside of it create `extensions.json` with the following content:

```json
{
  "recommendations": [
    // Angular Language Service
    "Angular.ng-template",
    // Debugger for Chrome
    "msjsdiag.debugger-for-chrome",
    // The ng lint command uses TSLint under the hood.
    "ms-vscode.vscode-typescript-tslint-plugin",
    // Prettier - Code formatter
    "esbenp.prettier-vscode"
  ]
}
```

VSCode will automatically prompt you to install the recommended extensions with just one click. This is also a nice way to have a consistent environment across team members.

Some other notable extensions:

- Inline HTML and CSS highlighter - `natewallace.angular2-inline`
- A more richer git support than VS Code's default one - `eamodio.gitlens`
- AI assisted IntelliSense - `visualstudioexptteam.vscodeintellicode`
- Docker support - `peterjausovec.vscode-docker`
- Languages support for the SAP Hybris import/export language ImpEx (unofficial) - `simplyroba.impex-support`
- Markdown linting and style checking for Visual Studio Code - `davidanson.vscode-markdownlint`

## Project setup

After [creating a new project and pulling Spartacus libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}), it's time to set up the project.

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

To avoid collision between `tslint` and `prettier`, it's recommended to remove formatting rules from the `tslint.json` and leave the formatting to `prettier`. This is a diff version of rules that should be removed from the `tslint.json`:

```diff
{
  "rulesDirectory": [
    "node_modules/codelyzer"
  ],
  "rules": {
    "arrow-return-shorthand": true,
    "callable-types": true,
    "class-name": true,
--  "comment-format": [
--    true,
--    "check-space"
--   ],
--  "curly": true,
--  "eofline": true,
    "forin": true,
    "import-blacklist": [
      true,
      "rxjs",
      "rxjs/Rx"
    ],
--  "import-spacing": true,
--  "indent": [
--    true,
--    "spaces"
--  ],
    "interface-over-type-literal": true,
    "label-position": true,
--  "max-line-length": [
--    true,
--    140
--  ],
    "member-access": false,
    "member-ordering": [
      true,
      {
        "order": [
          "static-field",
          "instance-field",
          "static-method",
          "instance-method"
        ]
      }
    ],
    "no-arg": true,
    "no-bitwise": true,
    "no-console": [
      true,
      "debug",
      "info",
      "time",
      "timeEnd",
      "trace"
    ],
    "no-construct": true,
    "no-debugger": true,
    "no-duplicate-super": true,
    "no-empty": false,
    "no-empty-interface": true,
    "no-eval": true,
    "no-inferrable-types": [
      true,
      "ignore-params"
    ],
    "no-misused-new": true,
    "no-non-null-assertion": true,
    "no-shadowed-variable": true,
    "no-string-literal": false,
    "no-string-throw": true,
    "no-switch-case-fall-through": true,
--  "no-trailing-whitespace": true,
    "no-unnecessary-initializer": true,
    "no-unused-expression": true,
    "no-use-before-declare": true,
    "no-var-keyword": true,
    "object-literal-sort-keys": false,
--  "one-line": [
--    true,
--    "check-open-brace",
--    "check-catch",
--    "check-else",
--    "check-whitespace"
--  ],
    "prefer-const": true,
--  "quotemark": [
--    true,
--    "single"
--  ],
    "radix": true,
--  "semicolon": [
--    true,
--    "always"
--  ],
    "triple-equals": [
      true,
      "allow-null-check"
    ],
--  "typedef-whitespace": [
--    true,
--    {
--      "call-signature": "nospace",
--      "index-signature": "nospace",
--      "parameter": "nospace",
--      "property-declaration": "nospace",
--      "variable-declaration": "nospace"
--    }
--  ],
    "typeof-compare": true,
    "unified-signatures": true,
    "variable-name": false,
 -- "whitespace": [
 --   true,
 --   "check-branch",
 --   "check-decl",
 --   "check-operator",
 --   "check-separator",
 --   "check-type"
 -- ],
    "directive-selector": [
      true,
      "attribute",
      "app",
      "camelCase"
    ],
    "component-selector": [
      true,
      "element",
      "app",
      "kebab-case"
    ],
--  "angular-whitespace": [true, "check-interpolation"],
    "no-output-on-prefix": true,
    "use-input-property-decorator": true,
    "use-output-property-decorator": true,
    "use-host-property-decorator": true,
    "no-input-rename": true,
    "no-output-rename": true,
    "use-life-cycle-interface": true,
    "use-pipe-transform-interface": true,
    "component-class-suffix": true,
    "directive-class-suffix": true
  }
}
```

You can read more in [this article](https://medium.com/@victormejia/setting-up-prettier-in-an-angular-cli-project-2f50c3b9a537).

To run `prettier` you can add this script to `package.json` to `scripts` array: `"prettier": "prettier --config ./.prettierrc --list-different \"src/**/*{.ts,.js,.json,.scss,.html}\""`.

_Note_: you may have to change `src` to match the directory that you are using as a source directory.

To check for formatting violations run: `yarn prettier`.

### linting

To check for linting violations, run `ng lint`.

To improve linting, add the following to the `tsconfig.json` located in the project's root:

```json
  "noUnusedLocals": true,
  "noUnusedParameters": true,
```

## git ignore

If you switched from using `npm` to `yarn`, it's wise to delete `package-lock.json` file that `npm` generates, and add this file to `.gitignore`:

```git
package-lock.json
```

## Final Steps

Finally, you may need to run `yarn install` to install dependencies added to `package.json`.
