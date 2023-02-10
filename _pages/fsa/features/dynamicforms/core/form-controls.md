---
title: Form Controls
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Default from controls

Dynamicforms library is shipped with the following controls out of the box:

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
- separator (HTML element `<hr/>` used as visual separator)
- dataHolder (hidden input field, used for holding data, usually for "dependsOn" functionality)
- upload

The default form controls configuration looks like this:

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

In the example above example, you can see the control of a type **input**, which exists in the JSON configuration for a certain form, and it is being mapped (by default) to the **InputComponent**. This means that all simple input fields in every form of dynamicforms will have the look and the logic of the "InputComponent".

## Overriding existing controls

To show you how to override the default component for an existing type, we will take the "input" type as an example. 
As mentioned before, "input" type is mapped to a "InputComponent". To override this component, you have to create a custom component and include it in some module. In this example, we call it "CustomInputComponent". 
The configuration needed for this override must be done inside the module where "CustomInputComponent" resides.

Example of custom input component

```typescript
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfigModule, I18nModule } from '@spartacus/core';
import { CustomInputComponent } from './custom-input-component';
import { ReactiveFormsModule } from '@angular/forms';
import { DynamicFormModule, DynamicFormsConfig } from '@spartacus/dynamicforms';
 
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

In this `CustomInputComponent`, it is also required to extend `AbstractFormComponent` which all existing form controls in dynamic forms are referencing to:

custom-input.component.ts

```typescript
import { Component } from '@angular/core';
import { AbstractFormComponent } from '@spartacus/dynamicforms';
 
@Component({
  selector: 'cx-fs-custom-input',
  templateUrl: './custom-input.component.html',
})
export class CustomInputComponent extends AbstractFormComponent {}
```

Having done that, it is now possible to use properties and functionalities from `AbstractFormComponent` in HTML:

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

Now every input field in dynamic forms will be replaced with `CustomInputComponent`.

## Adding new form control

If you need a custom form control, you need to specify a custom type, and then map the custom component to that type. The example below illustrates this.

Example of creating custom type for a custom control

```typescript
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfigModule, I18nModule } from '@spartacus/core';
import { CustomInputComponent } from './custom-input-component';
import { DynamicFormModule, DynamicFormsConfig } from '@spartacus/dynamicforms';
 
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
Now all you need to do is to invoke this new type inside the JSON configuration of a certain form:

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
