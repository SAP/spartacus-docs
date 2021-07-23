---
title: Guest Checkout
feature:
- name: Guest Checkout
  spa_version: 1.2
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Spartacus supports guest checkout, which is a feature that allows users to check out without creating an account. After making a purchase, a guest user has the option to create an account with the email address they provided during checkout. If an account is created at this point, the account retains the order history of the user, as well as the personal details that were entered during the guest checkout process.

## Enabling Guest Checkout

Guest checkout is disabled by default, but can be enabled in `spartacus-configuration.module.ts` by setting the `guest` flag to `true` in the `checkout` configuration. You can enable guest checkout, as shown in the following example:

```ts
provideConfig({
  checkout: {
    guest: true
  }
})
```

## Using Guest Checkout With Express Checkout

Spartacus allows you to enable guest checkout and express checkout at the same time. When both features are enabled, guest checkout is not affected by any configurations for express checkout because express checkout is only available to registered users who are signed in.

For more information on express checkout, see [{% assign linkedpage = site.pages | where: "name", "express-checkout.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/express-checkout.md %}).

## Extending Guest Checkout

Guest checkout leverages the existing pages and components from the standard checkout, so you can extend guest checkout in the same way that you can extend the standard checkout feature. For more information, see [{% assign linkedpage = site.pages | where: "name", "extending-checkout.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/extending-checkout.md %}).
