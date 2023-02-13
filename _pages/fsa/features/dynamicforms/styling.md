---
title: Dynamic forms Styling
---
Dynamic forms library is shipped with default Bootstrap 4 CSS classes. These classes can be overridden with the custom JSON configuration through the Backoffice.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Adding Custom CSS Classes

Dynamic forms library uses Bootstrap 4 classes for styling. A custom CSS class can be defined for:

- [Form tag]({{ site.baseurl }}/json-structure/#formdefinition) - By default empty. This class can be used for specific styling of each form. It can be added by defining **"cssClass"** property in the JSON configuration.

Example:

```json
{
  "cssClass": "customFormClass", // This can be used to add custom styling class on the form tag
  "formGroups": [
    {
      "groupCode": "firstFormSection",
      "fieldConfigs": [
          // controls defined here...
```

- [Form group]({{ site.baseurl }}/json-structure/#dynamicformgroup) (section) - By default, dynamic forms library renders "row" Bootstrap class here. Defining cssClass in "formGroups" section of the JSON configuration will add class to the default class. It can be added by defining **"cssClass"** property in the JSON.

Example:

```json
{
  "cssClass": "customFormClass",
  "formGroups": [
    {
      "groupCode": "firstFormSection",
      "cssClass": "customSectionClass",  // This can be used to add custom styling class to the section (Form Group),
                                         // it will be added to the existing bootstrap's "row" class,
                                         // in this case each section would have "row customSectionClass".
      "fieldConfigs": [
          // controls defined here...
```

- [Individual control]({{ site.baseurl }}/json-structure/#fieldconfig) - By default, dynamic forms library renders "col-12" Bootstrap class here, which results in one-column design. Defining a **"cssClass"** property in the control section of the JSON will add the default class.
You can also override the default Bootstrap "col-12" class by defining a **"gridClass"** property in the same section of the JSON definition.

Example:

```json
{
    "fieldConfigs": [
        {
            "type": "input",
            "name": "firstFormSection",
            "gridClass": "col-6",            // This can be used to override the default FSA (col-12) 1-column layout

            "cssClass": "customControlClass" // This can be used to add custom styling class to control,
                                             // it will be added to the existing bootstrap's "col-6" class,
                                             // so in this case each control would have "col-6 customControlClass"
            "required": true,
            "label": "How much life insurance coverage do you require?",
            "validations": [
```

### HTML

If we consider a form with two sections and one control per section, a default HTML structure would consist of:

```html
<form class=""> // Form class, empty by default
    <div class="row"> // Form Group class, "row" by default
        <cx-input class="col-12"> // Control wrapper class, "col-12" by default  
            // Input control-1
        <cx-input>
    </div>
   <div class="row">
        <cx-input class="col-12">   
            // Input control-2
        <cx-input>
    </div>
</form>
```

Adding our classes from examples above would result in the following HTML:

```html
<form class="customFormClass">  // Custom class is added.
    <div class="row customSectionClass"> // Custom class is added to default class.
        <cx-input class="col-6 customControlClass"> // Custom class is added to default class, and grid class is REPLACED
            // Input control-1
        <cx-input>
    </div>
   <div class="row">
        <cx-input class="col-6 customControlClass">   
            // Input control-2
        <cx-input>
    </div>
</form>
```

### User Interface

Default look of the example form with two sections:

![default form look]({{ site.baseurl }}/assets/images/fsa/dynamicforms_default_look.png)

Form look when the default "col-12" class is overridden with "col-6" on each form control, to create a two-column design:

![two column design]({{ site.baseurl }}/assets/images/fsa/dynamicforms_two_column_layout.png)
