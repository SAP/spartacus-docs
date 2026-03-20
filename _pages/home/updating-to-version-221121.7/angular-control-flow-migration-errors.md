---
title: Troubleshooting the Angular Control Flow Migration
---

If you encounter errors during the Angular control flow migration, consult the sections below to see examples of common errors that could occur, as well as solutions to resolve those errors.

After fixing all errors, re-run the migration command and complete the migration process by running the following command:

```text
ng generate @angular/core:control-flow
```

It is recommended that you run the migration in `dry-run` mode first, which allows you to see what changes will be made, without actually modifying any files. The following is an example of running the migration command in `dry-run` mode:

```text
ng generate @angular/core:control-flow --dry-run
```

If you want to run the migration on a specific path (for example, if you want to run the migration on a specific component), you can use the `--path` option to specify the path to the file or directory you want to migrate. This is useful if you want to migrate one component at a time.

The following is an example of running the migration on a specific path:

```text
ng generate @angular/core:control-flow --path=src/app/my-component
```

## Duplicate ng-template Names Error

If you have duplicate `ng-template` names in your code, you may encounter an error during the migration. The following is an example:

```text
A duplicate ng-template name "#loading" was found. The control flow migration requires unique ng-template names within a component.
```

**Source:** `types.ts:492-495`

The cause of this error message is that two or more `<ng-template>` elements have the same `#name` reference within the same component.

The following is an example of problematic code that could cause this type of error to occur:

```html
<ng-template #loading>Loading data...</ng-template>
<ng-template #loading>Please wait...</ng-template>  <!-- DUPLICATE! -->

<div *ngIf="data; else loading">{{ data }}</div>
<div *ngIf="otherData; else loading">{{ otherData }}</div>
```

The migration eliminates the need for named templates in simple cases, so you can fix the issue by adjusting your code, as shown in the following example:

```html
@if (data) {
  <div>{{ data }}</div>
} @else {
  Loading data...
}

@if (otherData) {
  <div>{{ otherData }}</div>
} @else {
  Please wait...
}
```

If you still need to use templates, you can resolve the issue by using unique names, as shown in the following example:

```html
<ng-template #loadingData>Loading data...</ng-template>
<ng-template #loadingOther>Please wait...</ng-template>

<div *ngIf="data; else loadingData">{{ data }}</div>
<div *ngIf="otherData; else loadingOther">{{ otherData }}</div>
```

## Multiple Aliases on ngIf Error

If you have more than one alias on the same `*ngIf` directive in your code, you may encounter an error such as the following during the migration:

```text
Found more than one alias on your ngIf. Remove one of them and re-run the migration.
```

This issue arises when using multiple `let` or `as` aliases in the same `*ngIf` directive. This commonly occurs in the following scenarios:

- You have extended the `ng-template` syntax with both `as` and `let-*` attributes
- You have combined `as` with `let` in `*ngIf`

The following is an example of problematic code that could cause this type of error to occur:

```html
<!-- Using ng-template with both 'as' and 'let' declarations -->
<ng-template
  ngIf*="user$ | async as user"
  let-first
  let-index="index"
>
  <div>
    Name: {{ user.name }}
    First: {{ first }}
    Index: {{ index }}
  </div>
</ng-template>

<!-- Or in simpler form with dual alias -->
<div *ngIf="user$ | async as user; let myUser">
  {{ user.name }}
</div>
```

You can fix the issue by using only one alias. In many cases, the `as` form works best. The following is an example:

```html
@if (user$ | async; as user) {
  <div>
    Name: {{ user.name }}
    Email: {{ user.email }}
  </div>
}
```

## Collection Aliasing on ngFor Error

If you are using `as` to alias an entire collection in `*ngFor`, you may encounter an error such as the following during the migration:

```text
Found an aliased collection on an ngFor: "item of items$ | async as items". Collection aliasing is not supported with @for. Refactor the code to remove the `as` alias and re-run the migration.
```

The `@for` block does not support collection aliasing because you iterate over items, not the collection itself.

The following is an example of problematic code that could cause this type of error to occur:

```html
<div *ngFor="let item of items$ | async as items">
  {{ item.name }} (Total: {{ items.length }})
</div>
```

One possible solution to this issue is to use the `@if` wrapper, which is recommended for migration. The following is an example:

```html
@if (items$ | async; as items) {
  @for (item of items; track item.id) {
    <div>
      {{ item.name }} (Total: {{ items.length }})
    </div>
  }
}
```

Another option that can resolve the issue is to use a `@let` declaration, as shown in the following example:

```html
@let items = items$ | async;
@if (items) {
  @for (item of items; track item.id) {
    {{ item.name }} (Total: {{ items.length }})
  }
}
```

**Note:** Do not forget to add the `track` expression. It is required for `@for`.

## Invalid @switch Block Structure - Text Node Error

If you have direct text content inside an `[ngSwitch]` container that is not within a case or default block, you may encounter an error such as the following during the migration:

```text
Text node: "Status indicator:" would result in invalid migrated @switch block structure. @switch can only have @case or @default as children.
```

In the new `@switch` syntax, only `@case` and `@default` blocks are allowed as direct children.

The following is an example of problematic code that could cause this type of error to occur:

```html
<div [ngSwitch]="status">
  Status indicator:  <!-- TEXT NODE OUTSIDE CASE! -->
  <span *ngSwitchCase="'active'">Active</span>
  <span *ngSwitchCase="'inactive'">Inactive</span>
  <span *ngSwitchCase="'pending'">Pending</span>
  <span *ngSwitchDefault>Unknown</span>
</div>
```

One solution to this issue is to move the text outside the switch, as shown in the following example:

```html
<div>
  Status indicator:
  <span>
    @switch (status) {
      @case ('active') {
        <span>Active</span>
      }
      @case ('inactive') {
        <span>Inactive</span>
      }
      @case ('pending') {
        <span>Pending</span>
      }
      @default {
        <span>Unknown</span>
      }
    }
  </span>
</div>
```

Another option is to include the text in each case, as shown in the following example:

```html
@switch (status) {
  @case ('active') {
    <span>Status indicator: Active</span>
  }
  @case ('inactive') {
    <span>Status indicator: Inactive</span>
  }
  @case ('pending') {
    <span>Status indicator: Pending</span>
  }
  @default {
    <span>Status indicator: Unknown</span>
  }
}
```

## Invalid @switch Block Structure - Element Without Case Error

If you have an HTML element inside `[ngSwitch]` and that HTML element does not have an `*ngSwitchCase` or `*ngSwitchDefault` directive, you may encounter an error such as the following during the migration:

```text
Element node: "div" would result in invalid migrated @switch block structure. @switch can only have @case or @default as children.
```

The following is an example of problematic code that could cause this type of error to occur:

```html
<div [ngSwitch]="status">
  <div class="header">Status Header</div>  <!-- ELEMENT WITHOUT CASE! -->
  <span *ngSwitchCase="'active'">Active</span>
  <span *ngSwitchCase="'inactive'">Inactive</span>
  <span *ngSwitchDefault>Unknown</span>
</div>
```

The solution is to separate the non-case element from the switch container, as shown in the following example:

```html
<div>
  <div class="header">Status Header</div>
  @switch (status) {
    @case ('active') {
      <span>Active</span>
    }
    @case ('inactive') {
      <span>Inactive</span>
    }
    @default {
      <span>Unknown</span>
    }
  }
</div>
```

## i18n Nesting Error

After migration, if an element with the `i18n` attribute ends up containing another element with an `i18n` attribute, this is invalid in Angular and will result in an error. The following is an example of the error message you could receive:

```text
i18n Nesting error: The migration would result in invalid i18n nesting for /path/to/component.html. Element with i18n attribute "div" would result in having a child of element with i18n attribute "span". Please fix and re-run the migration.
```

This error occurs when `*ngIf` or similar structural directives create implicit containers that get removed during migration.

The following is an example of problematic code that could cause this type of error to occur:

```html
<div i18n="@@parentMessage">
  Parent content
  <ng-container *ngIf="condition">
    <span i18n="@@childMessage">Child text that needs translation</span>
  </ng-container>
</div>
```

After migration, the `ng-container` is removed, making the `span` with `i18n` a direct child of the `div` with `i18n`, which is invalid.

One solution to this issue is to restructure your code to avoid nesting, as shown in the following example:

```html
<div i18n="@@parentMessage">Parent content only</div>
@if (condition) {
  <span i18n="@@childMessage">Child text that needs translation</span>
}
```

Another option is to remove the inner i18n attribute. For example, the child text can be part of the parent translation, as shown in the following example:

```html
<div i18n="@@parentMessage">
  Parent content
  @if (condition) {
    <span>Child text included in parent translation</span>
  }
</div>
```

## Invalid HTML Structure After Migration

If the migration produces HTML that cannot be parsed due to malformed tags, unclosed elements, or improper nesting, you may encounter an error such as the following:

```text
The migration resulted in invalid HTML for /path/to/component.html. Please check the template for valid HTML structures and run the migration again.
```

The following is an example of code with unclosed tags that could cause this type of error to occur, as well as the solution to resolve the issue:

```html
<!-- Before (Problematic) -->
<div *ngIf="showRow">
  <span>Unclosed span without closing tag

<!-- After (Solution) -->
@if (showRow) {
  <div>
    <span>Properly closed span</span>
  </div>
}
```

The following is an example of code with improper table structure that could cause this type of error to occur, as well as the solution to resolve the issue:

```html
<!-- Before (Problematic) -->
<table>
  <tr *ngIf="showRow">
    <td>Data without tbody</td>
  </tr>
</table>

<!-- After (Solution) - Use proper table structure with tbody -->
<table>
  <tbody>
    @if (showRow) {
      <tr>
        <td>Data with proper tbody</td>
      </tr>
    }
    @for (item of items; track item) {
      <tr>
        <td>{{ item }}</td>
      </tr>
    }
  </tbody>
</table>
```

## Template Processing Error

An error may occur during `ng-template` placeholder replacement, typically when a referenced template does not exist. In this case, you may encounter an error such as the following:

```text
{type: 'template', error: Error: ...}
```

**Source:** `migration.ts:47-48`

The following is an example of problematic code that could cause this type of error to occur:

```html
<div *ngIf="condition; else nonExistentTemplate">
  Main content when condition is true
</div>
<!-- No #nonExistentTemplate exists! -->
```

To resolve this issue, you can either add the missing template, or use the new control flow syntax, as shown in the following example:

```html
@if (condition) {
  <div>
    Main content when condition is true
  </div>
} @else {
  Fallback content when condition is false
}
```

## Parse Errors

If a template has syntax errors that prevent parsing, you may encounter an error such as the following:

```text
{type: 'parse', error: Error: The migration resulted in invalid HTML for /path/to/component.html. Please check the template for valid HTML structures and run the migration again.}
```

The following is an example of code with invalid Angular binding syntax that could cause a parse error to occur, as well as the solution to resolve the issue:

```html
<!-- Before (Problematic) - Special characters in binding names -->
<div [invalid@binding]="value">Content</div>

<!-- After (Solution) -->
<div [attr.data-value]="value">Content with valid binding</div>
```

The following is an example of code with unclosed interpolation that could cause a parse error to occur, as well as the solution to resolve the issue:

```html
<!-- Before (Problematic) -->
<div>{{ name </div>

<!-- After (Solution) -->
<div>{{ name }}</div>
```

The following is an example of code with invalid attribute syntax that could cause a parse error to occur, as well as the solution to resolve the issue:

```html
<!-- Before (Problematic) - Missing closing parenthesis -->
<input [value]="name" (change)="update($event">

<!-- After (Solution) -->
<input [value]="name" (change)="update($event)" />
```

## ViewChild/ViewChildren Reference Conflict

The migration might try to remove an `ng-template` that is referenced by `@ViewChild` or `@ViewChildren` in the component class.

The good news is that the migration handles this automatically by preserving templates that are referenced by `ViewChild` or `ViewChildren`.

The following is an example of templates that are referenced by `@Viewchild`:

```typescript
// component.ts
@ViewChild('myTemplate') myTemplate: TemplateRef<any>;
@ViewChild('contentTemplate') contentTemplate: TemplateRef<any>;
```

And the following is an example of the corresponding migrated code, where templates referenced by `@ViewChild` are preserved:

```html
<!-- Templates referenced by @ViewChild are preserved -->
<ng-template #myTemplate>
  @if (show) {
    <div>Content inside template</div>
  }
</ng-template>

<ng-template #contentTemplate>
  <ul>
    @for (i of [1, 2, 3]; track i) {
      <li>Item {{ i }}</li>
    }
  </ul>
</ng-template>

<!-- Using the templates -->
<ng-container *ngTemplateOutlet="myTemplate"></ng-container>
<ng-container *ngTemplateOutlet="contentTemplate"></ng-container>
```

In this scenario, the migration preserves the `ng-template` wrapper, because it is referenced by `@ViewChild`, and it migrates the internal control flow syntax. For example, `*ngIf` is migrated to `@if`, and `*ngFor` is migrated to `@for`.
