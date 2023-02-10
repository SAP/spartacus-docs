---
title: Configurable prefillValue Form Field 
---

This page explains how to use the configurable *prefillValue* form field in the dynamicforms library. 


***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Using the *prefillValue* Form Field

The *prefillValue* form field allows you to:

- Prepopulate form field on the SPA side.
- Populate the field with any available SPA asset which is exposed for that purpose (user, cart, claim, etc.)
- Adjust/override an already provided mechanism and add new logic on top of that.

Let's assume you want to prepopulate the "Title" field on the Personal Details form. You want to use the existing user data, located in the "User" state in FSA SPA. 

First, you need to adjust the Personal Details form, and add JSON configuration to the "Title" field. The following JSON example illustrates this:

```json
{
    "label": {
        "en": "First name",
    },
    "prefillValue": {
        "targetObject": "user",
        "targetValue": "firstName"
 
    },
    "name": "firstName",
    "type": "input",
    "required": true
}
```

In the example above, the `targetObject` signalizes that the asset from the SPA which is accessed is the `user`, and the value should be taken from the `firstName` field. In the same way you can specify a more nested structure, for example, on `cart` object:

```typescript
"fieldConfigs": [
   {
     "prefillValue": {
       "targetObject": "cart",
       "targetValue": "insuranceQuote.quoteDetails.Travellers"
     },
     "name": "noOfTravellers",
     "type": "input",
     "hidden": true
   },
```

For every object that you want to offer for the prepopulate functionality, you need to define one service that will take the field name from the JSON definition and return the field value from the state object. 
All services will implement the same interface with the dedicated method for value extraction, so they can be invoked in a generic way.

User resolver

```typescript
@Injectable({
  providedIn: 'root',
})
export class UserPrefillResolver implements PrefillResolver {
  constructor(protected userService: UserService) {}
 
  getFieldValue(fieldPath: string) {
    const attributes = fieldPath.split('.');
    let currentValue;
    return this.userService.get().pipe(
      map(user => {
        currentValue = user;
        attributes.forEach(attribute => {
          currentValue = currentValue[attribute];
        });
        return currentValue;
      })
    );
  }
}
```

As displayed above, `UserPrefillResolver` implements the given interface and the dedicated method, so it can take the `user` object from the state and find value by the key defined as input parameter. All these resolver classes are defined in the dynamicforms configuration, so they can be easily extended and overridden.

prefill-resolver.interface.ts

```typescript
/**
 * An interface representing prefill resolver used for getting data from application state.
 */
export interface PrefillResolver {
  /**
   * Method used to get state object property
   *
   * @param fieldPath  Path to the property
   */
  getFieldValue(fieldPath: string);
}
```

## Overriding the Resolver 

With this approach, you can redefine some of the prefill resolvers by specifying a new service instance for the same key. Also, in case you decide you need to access some other object, you can easily inject that in the configuration. 

config.ts

```typescript
@NgModule({
  imports: [
    CommonModule,
    I18nModule,
    DynamicFormModule,
    SpinnerModule,
    ConfigModule.withConfig(<DynamicFormsConfig>{ 
      dynamicForms: {
        prefill: {
          user: {
            prefillResolver: UserPrefillResolver,
          },
          cart: {
            prefillResolver: CartPrefillResolver,
          },
        },
      }
    }),
  ],
  declarations: [CustomInputComponent],
  exports: [],
  entryComponents: [CustomInputComponent],
})
```

Every field that has the *prefill* attribute defined in the JSON form definition will first find the given resolver in the configuration and then subscribe to the method in order to get the value.