<!-- ---
title: Table Component
feature:
- name: Table Component
  spa_version: 3.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %} -->

# Table Component

The table component is a low-level component for rendering tabular data, using the standard HTML `<table>` element. While HTML tables can have very complex structures, the table component implementation is fairly limited.

The main purpose for using the table components is the ability to generate tables by header configuration and provide a mechanism to customize the rendering of table cells.

The table component supports various layout orientations as well as responsive configurations for table definition.

## Table Cell Configuration

Tables configurations are defined by a table type. The type is a unique key that is used to identify the table configuration from the `TableConfig`.

The `TableConfig` contains a global configuration for all tables as well as _type_ specific configurations. The global configuration defines the default components to render the header and data cells. These components can be overridden in type specific configurations.

A basic example of a table configuration is shown below, which provides the cell definition for the "budget" table.

```ts
provideConfig({
  table: {
    'my-table': {
      cells: ['name', 'active', 'amount', 'dateRange', 'unit'],
    },
  },
} as TableConfig);
```

## Table Layout Configuration

The table can be rendered in different layout orientations:

- **vertical** - renders the table vertically, with a heading on top of the table
- **vertical stacked** - horizontal oriented table layout renders the table headers in the first column of the table
- **horizontal** – the header is rendered at the start (i.e. left side) of the table

The vertical layout is the default layout.

The layout configuration can be provided for each table type:

```ts
provideConfig({
  table: {
    'my-table': {
      cells: ['first', 'second', 'third'],
      options: {
        layout: TableLayout.VERTICAL,
      },
    },
  },
} as TableConfig);
```

## Responsive Table Configuration

The table configurations can also be further configured per breakpoint to differ the table per screen size. The mobile first approach is used, and cascades to larger screen size(s) to keep the configuration as simple as possible.

The configuration below demonstrates builds on top of the configuration above. The table is redefined for medium sized screens (tablet).

```ts
provideConfig({
  table: {
    'my-table': {
      cells: ['name', 'active', 'amount', 'dateRange', 'unit']
      options: {
        layout: TableLayout.VERTICAL
      },
      md: {
      cells: ['name', 'unit']
        options: {
          layout: TableLayout.HORIZONTAL
        }
      }
    }
  }
} as TableConfig);
```

## Cell Renderers

One of the key features of the table component is the ability to provide (custom) cell components for the cell rendering. While a default component is provided for both header and data cells, custom component can be configured to change the rendering. You can configure the rendering of headers and data cell separately.

The example below demonstrates how the cell rendering can be configured.

```ts
provideConfig({
  table: {
    'my-table': {
      cells: ['name', 'active', 'amount', 'dateRange', 'unit']
      options: {
        headerComponent: CustomHeaderCellComponent,
        cells: {
          name: {
            dataComponent: NameDataCellComponent,
          },
          active: {
            headerComponent: ActiveHeaderComponent,
          },
        },
      },
    },
  },
} as TableConfig),
```

## Cell Outlets

Besides configuration, the table component can be customized with [outlets](({{ site.baseurl }}{% link _pages/dev/outlets.md %})). Outlets are used to customize existing UI without change existing component logic or templates.

The Table component generates an outlet for each cell, so that customizations
can be done by both outlet templates and components. The outlet references are concatenated from the table `type` and header `key`. The following snippet shows an outlet generated for the table header name of the budget table.

```html
<th>
  <template cxOutlet="table.budget.header.name"> </template>
</th>
```

Similarly, the data cells (`<td>`) are generated with the outlet template reference
`table.budget.data.name`.

The cell context is injected to the outlets, so that template or component logic can pick up the provided cell data. The outlet is typed with either `TableHeaderOutletContext` or `TableDataOutletContext`, which are exported in the public API.

## Localized table headers

Table headers are rendered by default with the `TableHeaderCellComponent`. This component renders - if available - the field label from the configuration. If there's no field label provided, an i18n label is expected. The i18n label is taken from `fieldOptions.i18nKey`, but if this is also not provided, it will fallback to a concatenated label: `[i18nRoot].[cell-name]`.
