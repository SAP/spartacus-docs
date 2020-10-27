---
title: Configurable Form Field Pre-populate
---

This page will explain how to use configurable form field pre-populate in Dynamic forms library. Feature allows user to :

- Pre-populate form field on SPA side.
- Populate field with any available SPA asset which is exposed for that purpose (user, cart, claim etc..)
- Adjust/override already provided mechanism and add new logic on top of that.

## How to use: 

Let's say we want to pre-populate "Title" field on personal details form. We want to use existing user data, located in "User" state in our SPA. First we need to adjust out personal details form, and add JSON configuration to the title field.

Looking from JSON perspective it should look similar to this:

```typescript
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

In given example targetObject - user signalizes that asset from SPA, which is accessed, is user and value should be taken from firstName field. Also, in the same way we can specify some more nested structure for example on cart object:

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

## How does this work?

For every object that we want to offer for pre-populate functionality,  we will define one service that will take field name from JSON definition and return field value from state object. All services will implement same interface with dedicated method for value extraction, so they can be invoked in generic way.

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

As displayed above, UserPrefillResolver implements given interface and implements dedicated method, so it can take user object from state and find value by key defined as input parameter. All these resolver classes will be defined in dynamic forms configuration, so they can be easily extended and overridden:

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

## How to override resolver ? 

With such approach customer can redefine some of the prefill resolvers by specifying new service instance for same key. Also, in case customer decides they need to access some other object they can easily inject that into configuration. 

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

Every field which has prefill attribute defined in JSON form definition will first find given resolver from configuration and then subscribe to method in order to get value.