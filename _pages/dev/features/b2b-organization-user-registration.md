---
title: B2B Organization User Registration
feature:
  - name: B2B Organization User Registration
    spa_version: 6.0
    cx_version: 2205
---

{% capture version_note %}
{{ site.version_note_part1 }} 6.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

B2B Organization User Registration allows user to request a new account. Once registration is enabled and customers are able to provide their information in a form and send it through to create an account.

New registrations are approved or rejected by the Backoffice Administration Cockpit by a merchant user who belongs to the `b2bregistrationapprovergroup` group.

For in-depth information on this feature, see [New Account Requests](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/8ac2d88f86691014858efbd2faa52a92.html) on the SAP Help Portal.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling B2B Organization User Registration

B2B User registration is enabled by default and requires following things to work properly in Spartacus.

### Sample Data

To render registration form component and other related compontents ensure that following impex script has been imported properly to your backend:

```
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;register;Register Page;AccountPageTemplate;/login/register

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef)
;;BodyContentSlot-register;Body Content Slot for Register;true;OrganizationUserRegistrationComponent

INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;BodyContent-register;BodyContent;register;BodyContentSlot-register

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;OrganizationUserRegistrationComponent;Organization User Registration Component;OrganizationUserRegistrationComponent;OrganizationUserRegistrationComponent

INSERT_UPDATE CMSParagraphComponent;$contentCV[unique=true];uid[unique=true];name;content
;;NoAccountParagraphComponent;No Account Paragraph Component;"<p class='cx-section-title'>Don't have an account?</p>"

INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;styleClasses;&linkRef;&componentRef;target(code)[default='sameWindow'];
;;OrganizationUserRegistrationLink;Organization User Registration Link;/login/register;cx-organization-user-register-button;OrganizationUserRegistrationLink;OrganizationUserRegistrationLink;

UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];linkName[lang=en]
;;OrganizationUserRegistrationLink;"Register"

INSERT_UPDATE CMSParagraphComponent;$contentCV[unique=true];uid[unique=true];name;visible;content
;;DisabledRegistrationParagraphComponent;Disabled Registration Paragraph Component;false;"<p>You can request a login from your account representative. Send a message to <strong>email@domain.com</strong>.</p>"

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;LeftContentSlot-login;ReturningCustomerLoginComponent, NoAccountParagraphComponent, OrganizationUserRegistrationLink, DisabledRegistrationParagraphComponent
```

### Feature library

B2B Organization User Registration feature library can be installed by Schematics and is a part of Organization feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

## CMS Components

The organization user registration feature is CMS driven, and consists of the following:

- `OrganizationUserRegistrationComponent`
- `NoAccountParagraphComponent`
- `DisabledRegistrationParagraphComponent`
- `OrganizationUserRegistrationLink`

By default CMS related data is set to enable registration feature.

If you want to ensure that feature is enabled the following CMS components: `OrganizationUserRegistrationComponent`, `NoAccountParagraphComponent`, `OrganizationUserRegistrationLink` should have property `active` set to `true` whereas `DisabledRegistrationParagraphComponent` should has it set to `false`.

### Disabling the feature

You can disable the registration feature by using CMS.

There is possiblity to completely disable rendering registration form in Spartacus. To achieve this please deactivate `OrganizationUserRegistrationComponent` component.

However it is not enough, because on the login page the register link still will be visible to customer. For consistency the recommendation is to deactivate `OrganizationUserRegistrationLink` as well.

Instead of link there is also an option to display information for customer that registration is not available. It requires only to activate `DisabledRegistrationParagraphComponent` paragraph component.

As the result of those activities customer will see following text on login page:

<img src="{{ site.baseurl }}/assets/images/b2b-user-registration-disabled.png" alt="Disabled B2B User Registration" border="1px" />

## Limitations

Because `OrgUserRegistrationData` API model for B2B Registration exposes only "firstname", "lastname",
"email" and the "message" field to provide extra info for approver, the idea is to serialize all collected information in the form (like: address information, phone number etc.) to the "message" and send them in following format as part of the message:

```
`Phone number: {{phoneNumber}},
  Address: {{addresLine}} {{secondAddressLine}} {{city}} {{state}} {{postalCode}} {{country}},
  Message: {{message}}`
```

Additionaly this format can be easily replaced by overriding `messageToApproverTemplate` translation key. For more information please take a look into this [section](https://sap.github.io/spartacus-docs/i18n/#overwriting-individual-translations).
