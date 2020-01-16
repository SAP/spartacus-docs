---
title: Connecting to Other Systems
---

The system landscape of a Commerce Cloud solution is made up of various systems, which are typically orchestrated on various application layers, including the front end. Spartacus connects to SAP Commerce Cloud APIs by default, but the underlying framework can be used to work with other systems as well. This is done by so-called "connectors", which can be added to connect to other systems.

## Component Data Binding

Spartacus delivers view logic that binds to (complex) commerce data and logic in the Commerce Cloud back end. Angular provides standards for data binding, and relies on reactive programming as the best-practice, standard pattern for data binding. The following best practices are used for data binding in Spartacus:

- UI components bind to observable data from the back end, using the standard Angular `async` pipe.
- UI components do not store response data from observables locally, which means destroy logic can be avoided. RxJS pipeable logic can be applied to implement any logic when data is observed.
- Back-end data is stored in a central data store, provided by a state management system. Spartacus uses NgRx.
- The complexity of the state management system is hidden by a facade layer to provide a simple API to component developers.
- You can configure the back-end system by using connector, adapter, and convertor logic. Customers can provide alternative implementations to work with a specific back end.

This data binding design involves multiple layers, as follows:

- **UI components:** The UI layer is only concerned with the view logic of the UI. The UI components observe data provided by the facade layer.
- **Facade layer:** The facade layer hides the complexity of the in-memory data store (NgRx). This layer is designed to simplify your development, and let you focus on custom view logic.
- **In-memory store:** Spartacus uses NgRx Store for state management. NgRx is considered complex, and it is recommended that you use the facade layer.
- **Back-end connector:** The back-end connector is called by NgRx effects, and returns the response from the back end in the required UI model. The connector delegates to an adapter, which interacts with a back-end system.

![component data binding]({{ site.baseurl }}/assets/images/data-binding-architecture.png)

Although this is a fairly complex setup, you do not need to worry about most layers. When you want to connect a UI component to an alternative data source, you can customize some low-level layers without being concerned with the facade layer or the data store. Only if alternative client-side business logic is required would you then provide additional logic (most likely, close to the UI layer).

## Connector Logic

The connector logic sits between the in-memory data store and the back end. A specific connector is used for each domain to offload the connection to a back-end system. For example, the product connector takes care of loading the product details.

To provide optimal flexibility, there are three entities involved in connecting to a back-end system: a connector, an adapter, and a converter. Note, however, that not all entities are necessarily involved when you work with a third-party system.

This is a common pattern across different frameworks and technology stacks, although different names are used (for example, populator or serializer instead of convertor).

A fine-grained setup helps to separate concerns, and simplifies further customization. That being said, when you bind to an alternative data source, nothing stops you from further simplifying your setup.

### Connector

The connector orchestrates the connection to a source system. The connector layer could be considered over-engineered, because there are occasions where standard data is provided, even in the case of switching to an alternative system. A real example use-case of the connector is when structured CMS data is loaded: Spartacus can be set up to add static CMS data without relying on a back end at all, or as a fall-back in case the CMS does not provide sufficient data.

The main task of the connector is to delegate the loading and conversion of back-end data to the adapter.

### Adapter

The adapter layer is responsible for loading and submitting data to a source system. By default, Spartacus works with OCC, the standard REST API of SAP Commerce Cloud. The adapters (and convertors) are shipped and provided in separate modules, so that they become optional in the final build, in case you wish to work with an alternative system.

The endpoints used in OCC adapters can be configured, so that the customization of Spartacus can be very light-weight. Only if you work with another system might it be necessary to provide a custom adapter. 

For more information on OCC endpoint configuration, see [Configuring Endpoints](#configuring-endpoints), below.

### Convertor

Convertors are used to convert data from the back end to the UI, and vice versa. Spartacus uses the following to distinguish the two flows:

- **Normalize** is the conversion from back-end models to UI models
- **Serialize** is the conversion of UI models to back-end models, in the case of submitting data to the back end.

To provide optional conversion, the convertors are so-called "multi-providers", which allows Spartacus to provide specific convertors. A good example of an optional normalizer is the one that is used for the additional data required by SmartEdit integrations. This integration requires some additional attributes on the final DOM. Spartacus provides an optional convertor that normalizes additional data from the back-end source to the UI model.

Convertors are optional: when no convertor is found for the given domain, the source data is returned. Furthermore, whenever the back-end model is equal to the UI model, or in the case of a simple conversion, the adapter can easily take care of this.

### Providing Custom Converters

Converters in Spartacus use specific injector tokens that can also be used to provide custom converters.

For example, the product normalizer uses the `PRODUCT_NORMALIZER` token, and can be used as follows:

```ts
  providers: [
    {
      provide: PRODUCT_NORMALIZER,
      useClass: CustomProductNormalizer,
      multi: true
    }
  ]
```

## Extending the UI Model

When using a custom converter, it is possible to extend the UI model to provide type safety in the UI layer.

Out-of-the-box, Spartacus includes a set of types that are used to provide type safety in the UI layer, and these types can be extended to add new fields provided by a custom system.

The following example demonstrates how to add the extra `target` field to the `Product` model.

```ts
import { Product } from '@spartacus/core';

export interface CustomProduct extends Product {
  target?: string;
}
```

This type can be used in custom converters and also in a custom product. The following is an example:

```ts
import { Injectable } from '@angular/core';
import { Converter, Occ } from '@spartacus/core';

@Injectable()
export class CustomProductNormalizer implements Converter<Occ.Product, CustomProduct> {
  convert(source: any, target: any): CustomProduct {
    /*...*/
  }
}
```

## Configuring Endpoints

You can often configure the REST endpoints that are provided by OCC. For example, all endpoints have an optional field parameter that determines the response data that is returned. While this configuration can also be driven by a (JAVA Spring) back-end configuration, doing this at runtime in the front end gives more flexibility, and limits customizations in the back end. Accordingly, you can configure the endpoints of OCC modules in Spartacus.

The following code snippet shows a custom configuration for the product details endpoint:

```typescript
backend: {
  occ: {
    baseUrl: environment.occBaseUrl,
    endpoints: {
    product:
        'products/${productCode}?fields=DEFAULT,customAttribute',
    }
  }
}
```

The OCC configuration is used in the `OccEndpointsService`. The service looks up the configuration, and applies parameters to the endpoint, if needed.

**Note:** The endpoints are type safe. As a result, the list of available endpoints is visible when adding the configuration.

**Note:** This feature requires a feature level of 1.1 or higher. The following configuration is required to enable it:

```typescript
features: {
  level: 1.1
}
```
