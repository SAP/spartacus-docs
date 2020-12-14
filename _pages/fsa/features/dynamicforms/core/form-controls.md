---
title: Form Controls
---

## Overview
In this page you can read about:
- [Default form controls](#default-from-controls)
- [Overriding existing controls](#overriding-existing-controls)
- [Adding new form control](#adding-new-form-control) 

## Default from controls

Dynamic Forms library is shipped with following controls out of the box:
- button
- input
- select
- dynamicSelect (options can be fetched from external API)
- title
- datepicker
- radio
- textarea
- time
- checkbox
- separator (HTML element <hr/> used as visual separator)
- dataHolder (hidden input field, used for holding data, usually for "dependsOn" functionality)
- upload

Default Form Controls configuration looks like this:
```typescript
components: {
      button: {
        component: ButtonComponent,
      },
      input: {
        component: InputComponent,
      },
      select: {
        component: SelectComponent,
      },
      dynamicSelect: {
        component: DynamicSelectComponent,
      },
      title: {
        component: TitleComponent,
      },
      datepicker: {
        component: DatePickerComponent,
      },
      radio: {
        component: RadioComponent,
      },
      textarea: {
        component: TextAreaComponent,
      },
      time: {
        component: TimeComponent,
      },
      checkbox: {
        component: CheckboxComponent,
      },
      separator: {
        component: SeparatorComponent,
      },
      dataHolder: {
        component: DataHolderComponent,
      },
      upload: {
        component: UploadComponent,
      },
},
```

So in the above example we have a type **input**, which exists in JSON configuration for a certain form, and it is being mapped (by default) to the **InputComponent**. This means that all of the simple input fields in every form of DynamicForms, will have the look and logic of "InputComponent". 

## Overriding existing controls

To override the default component for an existing type, we will take "input" type as an example. As mentioned before "input" type is mapped to a "InputComponent". All that is needed is for user to have a custom component created and include it in some module. In this example we'll call it "CustomInputComponent". The configuration needed for this override must be done inside the module where "CustomInputComponent" resides, and it would look like this:

Example of custom input component
```typescript
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfigModule, I18nModule } from '@spartacus/core';
import { CustomInputComponent } from './custom-input-component';
import { ReactiveFormsModule } from '@angular/forms';
import { DynamicFormModule, DynamicFormsConfig } from '@fsa/dynamicforms';
 
@NgModule({
  imports: [
    CommonModule,
    I18nModule,
    DynamicFormModule,
    SpinnerModule,
    ConfigModule.withConfig(<DynamicFormsConfig>{ // Need to call Spartacus Factory function and pass it DynamicFormsConfig
      dynamicForms: {
        components: {
          input: { // The type we are mapping our component to
            component: CustomInputComponent, // Our custom component
          },
        }
      }
    }),
  ],
  declarations: [CustomInputComponent],
  exports: [],
  entryComponents: [CustomInputComponent],
})
export class CategoryFormsModule {}
```

In this "CustomInputComponent" it is also required to extend "AbstractFormComponent" which all existing form controls in DynamicForms are referencing:

custom-input.component.ts
```typescript
import { Component } from '@angular/core';
import { AbstractFormComponent } from '@fsa/dynamicforms';
 
@Component({
  selector: 'cx-fs-custom-input',
  templateUrl: './custom-input.component.html',
})
export class CustomInputComponent extends AbstractFormComponent {}
```

Having done that, it is possible now to use properties and functionalities from "AbstractFormComponent" in HTML:
```html
<div [formGroup]="group">
  <div [ngClass]="cssClass.inputWrapper">
    <label class="customInputLabelClass">
      <ng-container *ngIf="!config.required">
        {{ 'forms.optional' | cxTranslate }}
      </ng-container>
      {{ config.label }}
    </label>
    <input
      [ngClass]="cssClass.input"
      class="customInputClass"
      type="text"
      [formControlName]="config.name"
    />
  </div>
  <cx-error-notice
    [warn]="group.controls[config.name]"
    [parentConfig]="config"
  ></cx-error-notice>
</div>
```

Now every input field in DynamicForms will be replaced with "CustomInputComponent".

## Adding new form control

If custom form control is needed, custom type needs to be specified, and then custom component should be mapped to that type, as in following example:

Example of creating custom type for a custom control
```typescript
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfigModule, I18nModule } from '@spartacus/core';
import { CustomInputComponent } from './custom-input-component';
import { DynamicFormModule, DynamicFormsConfig } from '@fsa/dynamicforms';
 
@NgModule({
  imports: [
    CommonModule,
    I18nModule,
    DynamicFormModule,
    SpinnerModule,
    ConfigModule.withConfig(<DynamicFormsConfig>{ // Need to call Spartacus Factory function and pass it DynamicFormsConfig
      dynamicForms: {
        components: {
          customControl: { // NEW type we are declaring and mapping our custom component to
            component: CustomInputComponent, // Our custom component
          },
        }
      }
    }),
  ],
  declarations: [CustomInputComponent],
  exports: [],
  entryComponents: [CustomInputComponent],
})
export class CategoryFormsModule {}
```
Now the only thing needed is to invoke this new type inside JSON configuration for a certain form, like so:

FormSampleConfigurations
```typescript
{
  "formId": "customForm",
  "formGroups": [
    {
      "groupCode": "myFormGroup",
      "fieldConfigs": [
        {
          "type": "customControl", // NEW type we have already declared in our module in the example above
          "name": "testControl",
          "required": true,
          "label": "This is our custom control!",
          "validations": [
            {
              "name": "number"
            },
            {
              "name": "minValue",
              "arguments": [
                {
                  "value": 10000
                }
              ]
            },
            {
              "name": "maxValue",
              "arguments": [
                {
                  "value": 1000000
                }
              ]
            }
          ],
          "error": "forms.between10kAnd1M"
        },
...

```