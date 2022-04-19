## Screen Reader support

For Desktop: JAWS, NVDA, VoiceOver
For Mobile: Talkback for Android and VoiceOver for iPhone.

### Testing wih Screen Reader

Although most features work across screen reader brands, there are some small differences in what one vendor supports and others won't. JAWS and NVDA are know to be very strict in their code interpretation, as opposed to VoiceOVer being very flexible and forgiving with code mistakes. E.g., If an event vocalization works on VoiceOver and NVDA, but not on JAWS. Then it's major bug and must be fixed. But, if an event vocalization works on JAWS and NVDA, but not on VoiceOver, then it's considered a minor bug.

When this happens, JAWS should always be prioritized. This due to Accessibility audits being performed by our Test Labs using JAWS.

Starting with version 2.0, Spartacus features comply with the following success criteria of the Web Content Accessibility Guidelines (WCAG) 2.1:

- 1.1.1, Level A, Non-Text Content
- 1.3.1, Level A, Info and Relationships
- 2.4.2, Level A, Page Titled
- 2.4.4, Level A, Link Purpose
- 2.4.6, Level AA, Headings and Labels
- 3.3.2, Level A, Labels or Instructions
- 3.1.1, Level A, Language of Page
- 3.1.2, Level AA, Language of Parts
- 3.2.1, Level A, On Focus
- 3.2.2, Level A, On Input
- 3.3.1, Level A, Error Identification
- 3.3.3, Level AA, Error Suggestion
- 3.3.4, Level AA, Error Prevention
- 4.1.1, Level A, Parsing
- 4.1.2, Level A, Name, Role, Value

## Accessibility Management Platform

This is what we know as AMP testing and it should be performed before merging a new feature or fix. The result of the test should be 0 (zero) violations.

Spartacus should preserve its Audit Ready status regarding Accessibility. AMP Testing avoids regressions on existing features and validates new features for common Accessibility issues.

Some Screen Reader support issues are easily detected with AMP.

- Headings'order
- Missing Labels for buttons, landmarks.

### How to Test with AMP
