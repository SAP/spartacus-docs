# Angular Control Flow Migration - Possible Errors & Solutions

Angular control flow migration (`@angular/core:control-flow`) is optional for Angular 20 upgrade, but mandatory during Angular 21 upgrade. This document describes common errors that may occur during the migration and provides solutions with example code snippets.

***NOTE:*** If any errors occur during the migration, they will be displayed in the terminal with details about the error type and location. The migration process will continue to run and attempt to migrate as much code as possible. It is recommended to review the error messages and fix the issues and re-run the migration for remaining files.

There are two places during Angular migration that may trigger the control flow migration:
1. You can select the optional migration when you update to Angular 20.
```bash  
 Select the migrations that you'd like to run  
   ❯◯ [control-flow-migration] Converts the entire application to block control flow syntax.  
```
1. During Angular 21 upgrade the migration runs automatically.

To re-run the migration command to complete the migration process, use the following command:

```bash
ng generate @angular/core:control-flow
```

## Helpful Tips
- Run the migration in **dry-run mode** first to see what changes will be made without actually modifying files:

```bash
# Run migration in dry-run mode first (recommended)
ng generate @angular/core:control-flow --dry-run
```
- if you want to run the migration on a specific path (e.g. a specific component), you can use the `--path` option to specify the path to the file or directory you want to migrate. This is useful if you want to migrate one component at a time:

```bash
# Run migration on specific path
ng generate @angular/core:control-flow --path=src/app/my-component
```

## Table of Contents

1. [Duplicate ng-template Names Error](#1-duplicate-ng-template-names-error)
2. [Multiple Aliases on ngIf Error](#2-multiple-aliases-on-ngif-error)
3. [Collection Aliasing on ngFor Error](#3-collection-aliasing-on-ngfor-error)
4. [Invalid @switch Block Structure - Text Node Error](#4-invalid-switch-block-structure---text-node-error)
5. [Invalid @switch Block Structure - Element Without Case Error](#5-invalid-switch-block-structure---element-without-case-error)
6. [i18n Nesting Error](#6-i18n-nesting-error)
7. [Invalid HTML Structure After Migration](#7-invalid-html-structure-after-migration)
8. [Template Processing Error](#8-template-processing-error)
9. [Parse Errors](#9-parse-errors)
10. [ViewChild/ViewChildren Reference Conflict](#10-viewchildviewchildren-reference-conflict)

---

## 1. Duplicate ng-template Names Error

### Error Message

```
A duplicate ng-template name "#loading" was found. The control flow migration requires unique ng-template names within a component.
```

**Source:** `types.ts:492-495`

### Cause

Two or more `<ng-template>` elements have the same `#name` reference within the same component.

### Before (Problematic)

```html
<ng-template #loading>Loading data...</ng-template>
<ng-template #loading>Please wait...</ng-template>  <!-- DUPLICATE! -->

<div *ngIf="data; else loading">{{ data }}</div>
<div *ngIf="otherData; else loading">{{ otherData }}</div>
```

### After (Solution)

The migration eliminates the need for named templates in simple cases:

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

**Alternative:** If you need to keep templates, use unique names:

```html
<ng-template #loadingData>Loading data...</ng-template>
<ng-template #loadingOther>Please wait...</ng-template>

<div *ngIf="data; else loadingData">{{ data }}</div>
<div *ngIf="otherData; else loadingOther">{{ otherData }}</div>
```

---

## 2. Multiple Aliases on ngIf Error

### Error Message

```
Found more than one alias on your ngIf. Remove one of them and re-run the migration.
```

### Cause

Using multiple `let` or `as` aliases in the same `*ngIf` directive. This commonly happens with:
- Extended `ng-template` syntax with both `as` and `let-*` attributes
- Combining `as` with `let` in `*ngIf`

### Before (Problematic)

```html
<!-- Using ng-template with both 'as' and 'let' declarations -->
<ng-template
  [ngIf]="user$ | async as user"
  let-first
  let-index="index"
>
  <div>
    Name: {{ user.name }}
    First: {{ first }}
    Index: {{ index }}
  </div>
</ng-template>

<!-- Or simpler form with dual alias -->
<div *ngIf="user$ | async as user; let myUser">
  {{ user.name }}
</div>
```

### After (Solution)

Use only one alias - typically the `as` form works best:

```html
@if (user$ | async; as user) {
  <div>
    Name: {{ user.name }}
    Email: {{ user.email }}
  </div>
}
```

---

## 3. Collection Aliasing on ngFor Error

### Error Message

```
Found an aliased collection on an ngFor: "item of items$ | async as items". Collection aliasing is not supported with @for. Refactor the code to remove the `as` alias and re-run the migration.
```

### Cause

Using `as` to alias the entire collection in `*ngFor`. The `@for` block doesn't support collection aliasing because you iterate over items, not the collection itself.

### Before (Problematic)

```html
<div *ngFor="let item of items$ | async as items">
  {{ item.name }} (Total: {{ items.length }})
</div>
```

### After (Solution)

**Option 1: Use `@if` wrapper** (recommended for migration)

```html
@if (items$ | async; as items) {
  @for (item of items; track item.id) {
    <div>
      {{ item.name }} (Total: {{ items.length }})
    </div>
  }
}
```

**Option 2: Use `@let` declaration** (Angular 18.1+)

```html
@let items = items$ | async;
@if (items) {
  @for (item of items; track item.id) {
    {{ item.name }} (Total: {{ items.length }})
  }
}
```

> **Note:** Don't forget to add `track` expression - it's required for `@for`.

---

## 4. Invalid @switch Block Structure - Text Node Error

### Error Message

```
Text node: "Status indicator:" would result in invalid migrated @switch block structure. @switch can only have @case or @default as children.
```

### Cause

Direct text content inside an `[ngSwitch]` container that is not within a case or default block. In the new `@switch` syntax, only `@case` and `@default` blocks are allowed as direct children.

### Before (Problematic)

```html
<div [ngSwitch]="status">
  Status indicator:  <!-- TEXT NODE OUTSIDE CASE! -->
  <span *ngSwitchCase="'active'">Active</span>
  <span *ngSwitchCase="'inactive'">Inactive</span>
  <span *ngSwitchCase="'pending'">Pending</span>
  <span *ngSwitchDefault>Unknown</span>
</div>
```

### After (Solution)

**Option 1: Move text outside the switch**

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

**Option 2: Include text in each case**

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

---

## 5. Invalid @switch Block Structure - Element Without Case Error

### Error Message

```
Element node: "div" would result in invalid migrated @switch block structure. @switch can only have @case or @default as children.
```

### Cause

An HTML element inside `[ngSwitch]` that doesn't have `*ngSwitchCase` or `*ngSwitchDefault` directive.

### Before (Problematic)

```html
<div [ngSwitch]="status">
  <div class="header">Status Header</div>  <!-- ELEMENT WITHOUT CASE! -->
  <span *ngSwitchCase="'active'">Active</span>
  <span *ngSwitchCase="'inactive'">Inactive</span>
  <span *ngSwitchDefault>Unknown</span>
</div>
```

### After (Solution)

Separate the non-case element from the switch container:

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

---

## 6. i18n Nesting Error

### Error Message

```
i18n Nesting error: The migration would result in invalid i18n nesting for /path/to/component.html. Element with i18n attribute "div" would result having a child of element with i18n attribute "span". Please fix and re-run the migration.
```

### Cause

After migration, an element with `i18n` attribute would contain another element with `i18n` attribute, which is invalid in Angular. This happens when `*ngIf` or similar structural directives create implicit containers that get removed during migration.

### Before (Problematic)

```html
<div i18n="@@parentMessage">
  Parent content
  <ng-container *ngIf="condition">
    <span i18n="@@childMessage">Child text that needs translation</span>
  </ng-container>
</div>
```

After migration, the `ng-container` is removed, making the `span` with `i18n` a direct child of the `div` with `i18n` - which is invalid.

### After (Solution)

**Option 1: Restructure to avoid nesting**

```html
<div i18n="@@parentMessage">Parent content only</div>
@if (condition) {
  <span i18n="@@childMessage">Child text that needs translation</span>
}
```

**Option 2: Remove inner i18n attribute**

If the child text can be part of the parent translation:

```html
<div i18n="@@parentMessage">
  Parent content
  @if (condition) {
    <span>Child text included in parent translation</span>
  }
</div>
```

---

## 7. Invalid HTML Structure After Migration

### Error Message

```
The migration resulted in invalid HTML for /path/to/component.html. Please check the template for valid HTML structures and run the migration again.
```

### Cause

The migration produces HTML that cannot be parsed due to malformed tags, unclosed elements, or improper nesting.

### Common Issues and Solutions

**A) Unclosed tags**

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

**B) Improper table structure**

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

---

## 8. Template Processing Error

### Error Message

```
{type: 'template', error: Error: ...}
```

**Source:** `migration.ts:47-48`

### Cause

Error during ng-template placeholder replacement, typically when a referenced template doesn't exist.

### Before (Problematic)

```html
<div *ngIf="condition; else nonExistentTemplate">
  Main content when condition is true
</div>
<!-- No #nonExistentTemplate exists! -->
```

### After (Solution)

Either add the missing template or use the new control flow syntax:

```html
@if (condition) {
  <div>
    Main content when condition is true
  </div>
} @else {
  Fallback content when condition is false
}
```

---

## 9. Parse Errors

### Error Message

```
{type: 'parse', error: Error: The migration resulted in invalid HTML for /path/to/component.html. Please check the template for valid HTML structures and run the migration again.}
```

### Cause

Template has syntax errors that prevent parsing.

### Common Issues and Solutions

**A) Invalid Angular binding syntax**

```html
<!-- Before (Problematic) - Special characters in binding names -->
<div [invalid@binding]="value">Content</div>

<!-- After (Solution) -->
<div [attr.data-value]="value">Content with valid binding</div>
```

**B) Unclosed interpolation**

```html
<!-- Before (Problematic) -->
<div>{{ name </div>

<!-- After (Solution) -->
<div>{{ name }}</div>
```

**C) Invalid attribute syntax**

```html
<!-- Before (Problematic) - Missing closing parenthesis -->
<input [value]="name" (change)="update($event">

<!-- After (Solution) -->
<input [value]="name" (change)="update($event)" />
```

---

## 10. ViewChild/ViewChildren Reference Conflict

### Cause

The migration might try to remove an `ng-template` that's referenced by `@ViewChild` or `@ViewChildren` in the component class.

> **Good news:** The migration handles this automatically by preserving templates that are referenced by `ViewChild`/`ViewChildren`.

### Example

```typescript
// component.ts
@ViewChild('myTemplate') myTemplate: TemplateRef<any>;
@ViewChild('contentTemplate') contentTemplate: TemplateRef<any>;
```

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

The migration will:
1. **Preserve** the `ng-template` wrapper (because it's referenced by `@ViewChild`)
2. **Migrate** the internal control flow syntax (`*ngIf` → `@if`, `*ngFor` → `@for`)

