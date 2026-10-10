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

**Note:** The agent skills are for building a custom Spartacus storefront (that is, the consumer
codebases). They are not intended for developing the Spartacus framework itself.

The agent skill is packaged as follows:

```text
skills/spartacus-developer/
  SKILL.md             # entry point with front matter (auto-discovered by agents)
  references/
    <topic>.md         # one file per topic, linked from SKILL.md
    ...                # plus deep-dive material linked from the topic files
```

## Installing the Agent Skill

1. To install the Spartacus agent skill, run the following command:

   ```bash
   npm install --save-dev @spartacus/skills
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

## Upgrading the Agent Skill

To keep your skill current with the latest updates, carry out the following steps.

1. Update the package by running the following command:

   ```bash
   npm update @spartacus/skills
   ```

2. Copy the agent skill into your project (as described in [Installing the Agent Skill](#installing-the-agent-skill), above) so that your project reflects the latest guidance.
