---
title: Form Controls Dependencies
---

This page explains how to show/hide form controls that have a dependency on different form fields and how changes on the "parent" fields affect their visibility.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Introduction

In order to specify dependencies for a certain field, JSON schema is enhanced by exposing the property called **dependsOn**. This property represents an array of complex objects, and it consists of two properties:

- controlName - Reflects the name of **parent** form field.
- conditions - The conditions of parent control that need to be fulfilled. Conditions are validation functions of the parent field. If conditions are met, the form control will be visible.

**Note:** The parent control is the form control on which the specific abstract control (with defined *dependsOn* property) is dependant.

This logic can be applied to both single form control or form group.

Interface representation

```typescript
export interface DynamicFormGroup {
  ...;
  dependsOn?: ControlDependency[];
}
 
export interface FieldConfig {
  ...;
  dependsOn?: ControlDependency[];
}
 
export interface ControlDependency {
  controlName?: string;
  conditions?: ValidatorFunction[];
}
```

It is necessary to constantly track value and validity of parent form controls and based on it, show/hide some form controls (group or specific field). For tracking validity, dynamicforms library uses already defined validator functions. For more information, see [Basic Form Validations]({{ site.baseurl }}{% link _pages/fsa/features/dynamicforms/core/basic-form-validations.md%}).

## Examples

- Form field with the name "dependantField" is dependant on the form control with the name "controlField", and the condition for its visibility is that minimum value of the "controlField" is 1.

```typescript
{
    "type": "input",
    "name": "dependantField",
    "required": true,
    "dependsOn": [
        {
        "controlName": "controlField",
        "conditions": [
            {
            "name": "minValue",
            "arguments": [
                {
                "value": [1]
                }
            ]
            }
        ]
        }
    ]
}
```

- FormGroup with the name "dependantGroup" and all form fields that are defined in that group will not be visible if the form control with the name "controlField" is not equal or higher than 2.

```typescript
{
   "groupCode": "dependantGroup",
   "dependsOn": [
     {
       "controlName": "controlField",
       "conditions": [
         {
           "name": "minValue",
           "arguments": [
             {
               "value": [2]
             }
           ]
         }
       ]
     }
   ],
  "formFields": [........]
}
```

- FormGroup with the name "dependantGroup" and all form fields that are defined in that group will not be visible if form control with the name "controlField" doesn't match values "test" or "test2"

```typescript
{
"groupCode": "dependantGroup",
"dependsOn": {
  "hide": true,
  "controls": [
    {
      "controlName": "controlField",
      "conditions": [
        {
          "name": "checkValue",
          "arguments": [
            {
              "value": [
                "test",
                "test2"
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

If you do not want to hide the dependant field, you can only disable it by setting the **hide** property to false.
