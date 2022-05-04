## Screen Reader accessibility

Starting with version 5.0, Spartacus features will comply with the following success criteria of the Web Content Accessibility Guidelines (WCAG) 2.1. When combined all together, these criteria provide Spartacus with Screen Reader accessibility.

- 1.1.1, Level A, Non-Text Content
- 1.3.1, Level A, Info and Relationships
- 2.4.2, Level A, Page Titled
- 2.4.4, Level A, Link Purpose
- 2.4.6, Level AA, Headings and Labels
- 2.5.3, Level A, Label in Name
- 3.3.2, Level A, Labels or Instructions
- 3.1.1, Level A, Language of Page
- 3.2.1, Level A, On Focus
- 3.2.2, Level A, On Input
- 3.3.1, Level A, Error Identification
- 3.3.3, Level AA, Error Suggestion
- 3.3.4, Level AA, Error Prevention
- 4.1.1, Level A, Parsing
- 4.1.2, Level A, Name, Role, Value
- 4.1.3, Level AA, Status Messages

### Testing wih Screen Reader

- For Desktop: JAWS, NVDA, VoiceOver
- For Mobile: Talkback for Android and VoiceOver for iPhone.

Although most features work across screen reader vendors, there are some small differences in what one vendor supports and others won't. JAWS and NVDA are known to be very strict in their code interpretation, as opposed to VoiceOVer being very flexible and forgiving with code mistakes. E.g., An event vocalization works on VoiceOver and NVDA, but not on JAWS. Then it's major bug and must be fixed. But, if an event vocalization works on JAWS and NVDA, but not on VoiceOver, then it's considered a minor bug.

When this happens, JAWS should always be prioritized. This due to Accessibility audits being performed by our Test Labs using JAWS.

The developer and tester will need a license in order to test features with JAWS, or use the trial version (40 minutes then reboots). If not available, we recommend testing with NVDA for Windows and VoiceOver for Mac, and contact a team member with a JAWS license to confirm support.

Note to Matt: These are ALL internal tips, not sure if we can put them here, please delete if we can't:
https://wiki.wdf.sap.corp/wiki/display/spar/Running+JAWS+on+Mac

## Accessibility Management Platform (AMP)

In order to avoid code mistakes and properly validate it for Accessibility audits, SAP developers use AMP before manually testing with JAWS, and before merging fixes or new features. The result of the APM test must be 0 (zero) violations.

Spartacus should preserve its Audit-Ready Accessibility status. Audits are performed on every major version. AMP Testing avoids regressions on existing features and validates new ones. Concerning Screen Readers, it easly detects things like headings'order, and missing labels for buttons and landmarks. It also detects common Accessibility issues, other than Screen Readers, such as colour contrast.

### How to Test with AMP

An SAP sanctioned AMP account is needed. However, most common issues are detected with AMP's free version.

Note to Matt: These are ALL internal resources, not sure if we can put it here, please delete if we can't:
https://wiki.wdf.sap.corp/wiki/display/spar/UI+Styling+and+Accessibility+Onboarding

## E2E Tests

Note to Matt: I don't have infirmation if e2e tests are needed for aria-label and all the things developers did for the Screen Reader milestone.
