---
title: Conflict Solver
---
The conflict solver as developed with MVP version is quite rudimentary with regards to user navigation.

In the MVP version the following user navigation is currently implemented:

- If the user is in a conflict group and changes a value there, after the update the UI displays the original group of the attribute for which she changed the value, i.e. the user is taken out of the conflict resolving context.
- This happens every time she is changing a value in a conflict group, even if the value-change did not solve the conflict or if there are still other conflicts to be resolved.
- If the user clicks on "Resolve Issues" link in overview/cart the user is taken to the first conflict group. But after changing a value in the conflict group the above behavior applies, i.e. there is currently no guided "resolve issue" mode where the user is taken from issue to issue until the configuration has no issues anymore.

<!-- For v2, we have created a BI to enhance the conflict solver: https://cxjira.sap.com/browse/TIGER-6778 -->