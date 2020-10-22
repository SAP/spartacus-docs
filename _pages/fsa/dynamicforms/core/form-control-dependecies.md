---
title: Form controls dependencies
---

## Overview
This page will explain how to show/hide form controls that have a dependency on different form fields and how changes on "parent" fields will affect their visibility.

In order to specify dependencies for a certain field, JSON schema is enhanced by exposing the property called "**dependsOn**".  The property represents array of complex objects  and it consists of two properties:

- controlName - reflects the name of **parent** form field
- conditions - The conditions of parent control that need to be fulfilled. Conditions are validation functions of the parent field. If conditions are met then form control will be visible

Parent control - form control from which the specific abstract control (with defined dependsOn property) is dependant.

This logic can be applied to both single form control or form group.

```typescript
Interface representation
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

It is necessary to constantly track value and validity of parent form controls and based on it, show/hide some form controls (group or specific field). For tracking validity, dynamic forms uses already defined validator functions. See [this page]({{ site.baseurl }}{% link _pages/fsa/dynamicforms/core/basic-form-validations.md %}) for more info.

## Example and Explanation

- Form field with name "dependantField" is dependant on form control with name "controlField" and condition for its visibility is that minimum value of "controlField" is 1.
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
- FormGroup with name "dependantGroup" and all form fields that are defined in that group wont be visible if form control with name "controlField" is not equal or higher than 2.
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
- FormGroup with name "dependantGroup" and all form fields that are defined in that group wont be visible if form control with name "controlField" doesn't match values "test" or "test2"
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

If hiding dependant filed is not desired, it can only disabled using this functionality by setting "**hide**" property to false.