## Table configuration

```ts
export abstract class TableConfig {
  table?: {
    [tableType: string]: ResponsiveTableConfiguration;
  };
  tableOptions?: {
    /**
     * Global component to render table header _content_ (`<th>...</th>`). A specific component
     * can be configured alternatively per table or table field.
     */
    headerComponent?: Type<any>;

    /**
     * Global component to render table cell _content_ (`<td>...</td>`). A specific component per
     * field can be configured alternatively.
     *
     * If no component is available, the table content will render as-is.
     */
    dataComponent?: Type<any>;
  };
}
```
