---
title: Basic Form Validations
---

Dynamicforms library provides some basic form validation functions out of the box. This page explains how to use, override or add validations in dynamicforms library for end customers.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Invoking Validations from JSON

In order to specify validations for a certain field, the JSON schema is enhanced by exposing property called `validations`. This property represents an array of complex objects which are translated into dynamicforms validation functions, and they consist of two properties:

- `name`- corresponds to the name of the validation function defined in the form configuration on the SPA side (e.g., `compareToCurrentDate`)
- `arguments` - specifies input parameter(s) which are acceptable by the validation function (e.g., `shouldBeGreater`, `shouldBeLess`)

Example of the field with multiple validations:

- input data must be of type number
- input data max value must be 100
- input value should be less than 'otherField' value

```typescript
{
    "fieldType": "input",
    "valueType": "number",
    "name": "testInput",
    "required": true,
    "label": {
    "en": "Test input",
    "de": "Testeingang"
    },
    "validations": [
        {
            "name": "number"
        },
        {
            "name": "minValue",
            "arguments": [
              {
                  "value": 1
              }
            ]
        },
        {
            "name": "maxValue",
            "arguments": [
              {
                  "value": 100
              }
            ]
        },
        {
            "name": "compareAgeToDOB",
            "arguments": [
              {
                  "value": "otherField"
              },
              {
                  "value": "shouldBeLess"
              }
            ]
        }
    ],
},
```

## Existing Validations

The following validations come with the dynamicforms library out of the box:

- `compareToCurrentDate` - Accepts one argument from the following list:
  - shouldBeEqual
  - shouldBeGreater
  - shouldBeLess
  - shouldBeGreaterOrEqual
  - shouldBeLessOrEqual

JSON example:

```typescript
"validations": [
    {
        "name": "compareToCurrentDate",
        "arguments": [
          {
              "value": "shouldBeLessOrEqual"
          }
        ]
    }
],
```

- `dateOfBirth` - Accepts argument of type number. Triggers validation if the input date is less than the provided argument.
- `compareDOBtoAge` - Compares date from another field with the input date. Accepts two arguments:
  - Name of the field to compare (string). 
  - Operator which can be 'shouldBeGreater' or 'shouldBeLess' (string). 

The following JSON example compares input to the value of the `retirementAge` field:

```typescript
"validations": [
    {
        "name": "compareDOBtoAge",
        "arguments": [
          {
              "value": "retirementAge"
          },
          {
              "value": "shouldBeGreater"
          }
        ]
    }
],
```

- `maxValue`, `minValue`, `maxLength`, `minLength` - Default Angular validators.
- `number` - Triggers error message if the input type is not a number.
- `compareDates` - Compares input date with the value of another field. Accepts two arguments:
  - Name of the field to compare (string). 
  - Operator which can be 'shouldBeGreater' or 'shouldBeLess' (string). 

The following JSON example compares input to the value of the `vehiclePurchaseDate` field:

```typescript
"validations": [
    {
        "name": "compareDates",
        "arguments": [
          {
              "value": "vehiclePurchaseDate"
          },
          {
              "value": "shouldBeGreater"
          }
        ]
    }
],
```

- `checkValue` - Checks if input data matches any item from an array of allowed values. Accepts one argument (an array of strings).

In the following JSON example, the field is valid only if the string `no` is added to the input:

```typescript
"validations": [
    {
    "name": "checkValue",
    "arguments": [
        {
          "value": [
              "no"
          ]
        }
    ]
    }
]
```

- `containsValue` - Checks if the input value contains string form argument array. Accepts one argument (an array of strings).

JSON example:

```typescript
"validations": [
    {
    "name": "containsValue",
    "arguments": [
        {
          "value": ["test string"]
        }
    ]
    }
]       
```

- `compareNumbers` - Compares input value with another field. Accepts two arguments:
  - Name of the field to compare (string). 
  - Operator which can be 'shouldBeGreater' or 'shouldBeLess' (string). 

JSON example:

```typescript
"validations": [
    {
        "name": "compareNumbers",
        "arguments": [
        {
            "value": "propertyValue"
        },
        {
            "value": "shouldBeLess"
        }
        ]
    }
],
```

- `email` - Checks if the input data is a valid email.
- `alphanumeric` - Allows only numbers and letters as input data. 

## How Validations Work

Before the form is rendered, all validations from the JSON are processed and, in case they have a corresponding implementation defined in the configuration, they are transferred to the mapped **`ValidationFn`**. Name from the validation object corresponds to the name defined in the form configuration on the SPA application. 
In this particular case, it will be the validation with the name `compareToCurrentDate`:

```typescript
DynamicFormsConfig
validators: {
  ....
  compareToCurrentDate: {
    validator:  DefaultFormValidators.compareToCurrentDate
  },
  ....
}
```

All arguments defined in the JSON file represent input parameters for `compareToCurrentDate` function from `DefaultFormValidators`, and they are added to the function in run-time. 
In our example, based on the mapping defined in the configuration, we will find the following validation function:

```typescript
static compareToCurrentDate(operator) {
   return (control: AbstractControl): ValidationErrors | null => {
     const inputVal = new Date(control.value as string);
     const today = new Date();
     switch (operator) {
       case 'shouldBeGreater':
         return inputVal.getTime() > today.getTime()
           ? null
           : { InvalidDate: true };
       case 'shouldBeLess':
         return inputVal.getTime() < today.getTime()
           ? null
           : { InvalidDate: true };
     }
   };
 }
```

and assign that function with the input parameter `shouldBeGreater` (operator in this case) to the corresponding field. In the same way, we can pass multiple input parameters via arguments attribute, in case the function requires more, and add them to the validation function respectively.

## Overriding Existing Validation in Custom Application

To override a predefined validation, in your modules you need to reference your custom functions with the same name as the existing ones. 

Let's try to override `compareToCurrentDate` function, so that it just logs a customized message and returns always `true` for validation.  We will start in one of our modules by specifying the following configuration:

X-module.ts

```typescript
@NgModule({
  imports: [
    CommonModule,
    I18nModule,
    DynamicFormModule,
    SpinnerModule,
    ConfigModule.withConfig(<DynamicFormsConfig>{ // Need to call Spartacus Factory function and pass it DynamicFormsConfig
      dynamicForms: {
        validators: {
          compareToCurrentDate: {
            validator: CategoryFormsModule.customFunction
          }
        }
      }
    }),
  ],
  declarations: [CustomInputComponent],
  exports: [],
  entryComponents: [CustomInputComponent],
})
```

From the code snippet above, you can see that for a validation with the name `compareToCurrentDate` there is a new function defined in `CategoryFormsModule`. Function has the following implementation:

```typescript
static customFunction(regex) {
  return (control: AbstractControl): ValidationErrors | null => {
    console.log('Custom function works!');
    return null;
  };
}
```

As described in introduction, the function has one console log and always returns `true` for validation. In this particular case, JSON file should not be edited since the name of the new function is the same as the one of the default function.

## Adding a New Validation

This section describes how to add a new validation in your custom application and invoke it from your JSON form definition.

Adding new functions is similar to overriding them. First, you need to define a new function and then you have to expose it via configuration.

New validation function

```typescript
static customNewFunction(regex) {
    return (control: AbstractControl): ValidationErrors | null => {
      console.log('New function works!');
        return null;
    };
  }
```

Mapping new validation function

```typescript
@NgModule({
  imports: [
    CommonModule,
    I18nModule,
    DynamicFormModule,
    SpinnerModule,
    ConfigModule.withConfig(<DynamicFormsConfig>{ // Need to call Spartacus Factory function and pass it DynamicFormsConfig
      dynamicForms: {
        validators: {
          newValidation: {
            validator: CategoryFormsModule.customNewFunction
          }
        }
      }
    }),
  ],
  declarations: [CustomInputComponent],
  exports: [],
  entryComponents: [CustomInputComponent],
})
```

Lastly, since this function is completely new, you have to invoke it from your JSON form definition:

```typescript

"validations": [{
    "name": "newValidation"
  }],

```
