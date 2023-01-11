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

B2B Organization User Registration allows users to request a new account. Once registration is enabled, users can use a form to provide their information and submit their request for a new account.

New registrations are approved or rejected through the Backoffice Administration Cockpit by a merchant user who belongs to the `b2bregistrationapprovergroup` group.

For more information, see [B2B Early Login User Experience](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/8ac2d88f86691014858efbd2faa52a92.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling B2B Organization User Registration

You can enable B2B organization user registration by installing the `@spartacus/organization` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

B2B organization user registration is CMS driven, and consists of the following CMS components:

- `OrganizationUserRegistrationComponent`
- `NoAccountParagraphComponent`
- `DisabledRegistrationParagraphComponent`
- `OrganizationUserRegistrationLink`

If you are using the [spartacussampledata extension]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the B2B organization user registration components are already enabled in Spartacus. However, if you decide not to use the extension, you can enable them through ImpEx.

Whether you use the sample data extension or the ImpEx examples provided below, the following CMS components have the `visible` property set to `true` by default:

- `OrganizationUserRegistrationComponent`
- `NoAccountParagraphComponent`
- `OrganizationUserRegistrationLink`

And by default, the `DisabledRegistrationParagraphComponent` has the `visible` property set to `false`.

You can change the status of the `visibility` property for any of these components in Backoffice.

### Adding CMS Components Using ImpEx

This section describes how to add the various B2B organization user registration components to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

You can enable the **B2B Organization User Registration** page and add the required content slot with the following ImpEx:

```text
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;register;Register Page;AccountPageTemplate;/login/register

INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;BodyContent-register;BodyContent;register;BodyContentSlot-register
```

You can enable the `Organization User Registration Component` with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;OrganizationUserRegistrationComponent;Organization User Registration Component;OrganizationUserRegistrationComponent;OrganizationUserRegistrationComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef)
;;BodyContentSlot-register;Body Content Slot for Register;true;OrganizationUserRegistrationComponent
```

You can enable the `No Account Paragraph Component` with the following ImpEx:

```text
INSERT_UPDATE CMSParagraphComponent;$contentCV[unique=true];uid[unique=true];name;content
;;NoAccountParagraphComponent;No Account Paragraph Component;"<p class='cx-section-title'>Don't have an account?</p>"
```

You can create the `Organization User Registration Link` component with the following ImpEx:

```text
INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;styleClasses;&linkRef;&componentRef;target(code)[default='sameWindow'];
;;OrganizationUserRegistrationLink;Organization User Registration Link;/login/register;cx-organization-user-register-button;OrganizationUserRegistrationLink;OrganizationUserRegistrationLink;
```

You can add the `Disabled Registration Paragraph Component` (which is inactive by default) with the following ImpEx:

```text
INSERT_UPDATE CMSParagraphComponent;$contentCV[unique=true];uid[unique=true];name;visible;content
;;DisabledRegistrationParagraphComponent;Disabled Registration Paragraph Component;false;"<p>You can request a login from your account representative. Send a message to <strong>email@domain.com</strong>.</p>"
```

You add the `ReturningCustomerLoginComponent`, `NoAccountParagraphComponent`, `OrganizationUserRegistrationLink`, and `DisabledRegistrationParagraphComponent` to the **Login** page content slot with the following ImpEx:

```text
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;LeftContentSlot-login;ReturningCustomerLoginComponent, NoAccountParagraphComponent, OrganizationUserRegistrationLink, DisabledRegistrationParagraphComponent
```

### Disabling B2B Organization User Registration

You can completely disable the user registration feature through Backoffice. You must disable the rendering of the registration form by setting the visibility to `false` for the `OrganizationUserRegistrationComponent` component, and you also need to set the visibility to `false` for the `OrganizationUserRegistrationLink` so that the register link is not visible to users.

There is also the option of displaying information to users that registration is not available. You can do this by setting the visibility to `true` for the `DisabledRegistrationParagraphComponent` paragraph component.

The following is an example of what users see on the **Login** page when `OrganizationUserRegistrationComponent` and `OrganizationUserRegistrationLink` have visibility set to `false`, and the visibility for `DisabledRegistrationParagraphComponent` is set to `true`:

<img src="{{ site.baseurl }}/assets/images/b2b-user-registration-disabled.png" alt="Disabled B2B User Registration" width="500" border="1px" />

## Limitations

The `OrgUserRegistrationData` API model for B2B registration only exposes the `firstname`, `lastname`, `email` and `message` fields. To be able to provide additional information to the approver, you can serialize all of the collected information in the form to the `Message` field (such as `Address` and `Phone number`) and send this information as part of the message in the following format: {% raw %}

```text
`Phone number: {{phoneNumber}},
  Address: {{addressLine}} {{secondAddressLine}} {{city}} {{state}} {{postalCode}} {{country}},
  Message: {{message}}`
```

Furthermore, this format can be easily replaced by overriding the `messageToApproverTemplate` translation key. For more information, see [Overwriting Individual Translations](https://sap.github.io/spartacus-docs/i18n/#overwriting-individual-translations).{% endraw %}
