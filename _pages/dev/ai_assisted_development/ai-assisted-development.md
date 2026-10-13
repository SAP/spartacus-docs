---
title: AI-Assisted Development in Spartacus
---

Starting with release 221121.20, Spartacus provides agent skills that you can use for guiding AI coding harnesses to generate custom storefront code that follows Spartacus conventions.

## Overview

The agent skills provided with Spartacus offer the following:

- Packaged development guidance delivered as agent skills for widely used AI coding harnesses, such as Claude Code, Codex, and Cursor
- Automatic activation whenever an AI coding agent works on Spartacus code, with no manual prompting required
- Coverage of Spartacus core building patterns for creating and customizing components, pages, and back-end data flows
- Direction to extend existing Spartacus elements rather than rebuilding them from scratch
- Guidance to reuse standard Spartacus capabilities before implementing new ones
- Built-in debugging steps that reveal the live configuration and page structure of a running storefront
- One-step setup that adds the agent skills to a project and targets the developer's chosen AI coding harness
- Automatic alignment of the guidance with the installed Spartacus version on every update
- Availability for new projects and existing Spartacus implementations through standard install and update flows.

Working with Spartacus agent skills allows you to do the following:

- Reduce rework by generating correct code on the first attempt
- Accelerate developer onboarding by embedding framework conventions into everyday tooling
- Improve upgrade resilience by favoring supported extension patterns over ad hoc code
- Lower total cost of ownership by reusing standard capabilities instead of rebuilding them
- Shorten troubleshooting cycles by giving agents visibility into real application state
- Increase consistency across teams and projects by making correct patterns the default.

The `@spartacus/skills` package ships a single skill, `spartacus-developer`,
that captures the Spartacus-specific rules an AI assistant should follow when
generating or changing storefront code, such as back-end communication, CMS wiring,
routing, configuration, state, i18n, styling, SSR, and more.

The agent skill is packaged as follows:

```text
skills/spartacus-developer/
  SKILL.md             # entry point with front matter (auto-discovered by agents)
  references/
    <topic>.md         # one file per topic, linked from SKILL.md
    ...                # plus deep-dive material linked from the topic files
```

## Installing the Agent Skill

It is recommended to set up the agent skill through the standard Spartacus installation or update flow. The schematics install the `@spartacus/skills` development dependency and copy the skill into the project folders used by your chosen AI tools. However, it is also possible to add the skill to an existing project without running a full Spartacus installation or update. Both approaches are described in the following sections.

### Recommended Agent Skill Installation

Install Spartacus with the following command, and select the AI tool folders when prompted:

```bash
ng add @spartacus/schematics
```

The available folders are `.agents/skills/spartacus-developer/` and `.claude/skills/spartacus-developer/`. You can select one or both. The schematic installs the package and copies the skill for you, so no separate package installation or manual copying is required. To skip skill setup, leave both folders unselected.

For an existing project, skill setup is also offered during the standard Spartacus update flow, as described in [Updating the Agent Skill](#updating-the-agent-skill).

### Adding the Skill Without Running a Full Spartacus Installation or Update

To add the skill to an existing project without running a full Spartacus installation or update, carry out the following steps.

1. Install the skill package. Replace `<version>` with the version that matches the Spartacus libraries in your project.

   ```bash
   npm install --save-dev @spartacus/skills@<version>
   ```

2. Copy the skill into your project.

   AI assistants discover skills from your project, not from `node_modules`. Copy the skill into the locations your tools expect.

3. Place the files.

   1. If `@spartacus/schematics` is installed, it is recommended to let it place the files for you by running the following command:

      ```bash
      ng generate @spartacus/schematics:ai-context
      # or target specific tools (repeat the flag once per tool):
      ng generate @spartacus/schematics:ai-context --ai-tools=claude --ai-tools=agents
      ```

      This is also offered as a prompt during `ng add @spartacus/schematics`.

   2. If you do not use the schematic, manually copy the skill folder, as shown in the following example:

      ```bash
      # Claude Code
      mkdir -p .claude/skills
      cp -r node_modules/@spartacus/skills/skills/spartacus-developer .claude/skills/

      # Other agents (cross-tool location read by Codex, Gemini CLI, and others)
      mkdir -p .agents/skills
      cp -r node_modules/@spartacus/skills/skills/spartacus-developer .agents/skills/
      ```

## Updating the Agent Skill

When updating Spartacus through the standard schematic flow, you are prompted to install or update the skill when you run the following command:

```bash
ng update @spartacus/schematics
```

Accept the prompt to install or update `@spartacus/skills` to a version aligned with the schematics and refresh the skill files. If the skill is already configured, the update reuses the existing tool folders and replaces their skill files. Otherwise, you are prompted to choose the folders to configure. You can decline the prompt to skip configuring or refreshing the skill files.

### Updating the Skill Without Schematics

If you manage the package without schematics, install a version of `@spartacus/skills` that matches your Spartacus libraries and copy the updated skill into your project, as described in [Adding the Skill Without Running a Full Spartacus Installation or Update](#adding-the-skill-without-running-a-full-spartacus-installation-or-update). Replace the previously copied `spartacus-developer` folders before copying the updated skill so that files removed from the package are not retained. Updating the npm package alone does not refresh the copies used by your AI tools.
