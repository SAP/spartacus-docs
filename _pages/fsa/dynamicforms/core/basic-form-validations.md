---
title: Basic Form Validations
---

## Overview
Dynamic Forms library provides some basic validator functions by default. This page will explain how to use, override or add validations in Dynamic Forms library for end customers. Following things should be covered:

- [How to invoke validation from JSON?](#how-to-invoke-validation-from-json)
- [Which validations exist out of the box?](#existing-validations) 
- [How all this works?](#how-all-this-works)
- [How to override existing validation in custom App?](#how-to-override-existing-validation-in-custom-app)
- [How to add new validation in custom App and invoke that from JSON?](#how-to-add-new-validation-in-custom-app-and-invoke-that-from-json) 

## How to invoke validation from JSON

In order to specify validations for certain field, JSON schema is enhanced by exposing property called "validations".  Property represents array of complex objects which are translated into dynamic forms validation functions and they consist of two properties:

- validation name - corresponds the name for validation function defined in  Form Config on SPA side (ex: compareToCurrentDate)
- validation input parameters - specify input parameter(s) which are acceptable by validation function (ex: shouldBeGreater, shouldBeLess)

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

## Existing validations

- **compareToCurrentDate** - accepts one argument from list:
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
- **dateOfBirth** - Accepts argument of type number. It will trigger validation if input date is less than argument provided.
- **compareDOBtoAge** - Compares date from other filed with input date. Accepts two arguments:
  - name of the field to compare (string)
  - operator (string) can be 'shouldBeGreater' or 'shouldBeLess'

JSON example, compare input to the value of the 'retirementAge' field:
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
- **maxValue**, **minValue**, **maxLength**, **minLength** - Default Angular validators
- **number** - Triggers error message if input type is not a number.
- **compareDates** - Compares input date to the value of other field. Accepts two arguments:
  - name of the field to compare (string)
  - operator (string) can be 'shouldBeGreater' or 'shouldBeLess'

JSON example, compare input to the value of the 'vehiclePurchaseDate' field:
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
- **checkValue** - Checks if input data matches any item from array of allowed values. Accepts one argument (array of strings)
JSON example, field is valid only in case string "no" is added to the input:
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
- **containsValue** - Checks if input value contains string form argument array. Accepts one argument (array of strings) 
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
- **compareNumbers** - Compares input value to other field. Accepts two arguments:
  - name of the field to compare (string)
  - operator (string) can be 'shouldBeGreater' or 'shouldBeLess' 
   
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
- **email** - Checks if input data is valid email
- **alphanumeric** - Allows only numbers and letters as input data 

## How all this works

Before Form gets rendered, all validations from JSON are processed and in case they have corresponding implementation defined  in config they are transferred to mapped **ValidationFn**. Name from validation object corresponds to the name defined in form configuration on SPA application. In this particular case it will be validation with name compareToCurrentDate :

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

All arguments defined in JSON file represent input parameters for compareToCurrentDate function from DefaultFormValidators and they are added to the function in run-time. In our example based on mapping defined in configuration we will find following validation function:

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
and assign that function with input parameter 'shouldBeGreater' (operator in this case) to the corresponding field. In the same way we can pass multiple input parameters via arguments attribute in case function requires more and add them to the validation function respectively.

## How to override existing validation in custom App

In order to override some predefined validation, customers should be able to do that in their modules by referencing their custom functions with the same name as existing ones. Let's try to override compareToCurrentDate function, so that it just logs customized message and returns always true for validation.  We will start in one of our modules by specifying following configuration:

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
From the code snippet above we can see that for validation with name compareToCurrentDate we have new a function defined in CategoryFormsModule. Function has the following implementation:

```typescript
static customFunction(regex) {
  return (control: AbstractControl): ValidationErrors | null => {
    console.log('Custom function works!');
    return null;
  };
}
```
As described in introduction, function has one console log and always returns true for validation. In this particular case, JSON file should not be edited since name of new function is the same as for old one.

## How to add new validation in custom App and invoke that from JSON

Adding new functions is similar to overriding them. First, we need to define a new function and then we have to expose it via configuration.

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
Lastly, since this function is completely new we have to invoke it from our JSON form definition:

```typescript

"validations": [{
    "name": "newValidation"
  }],

```
