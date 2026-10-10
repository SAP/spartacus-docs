---
title: AI-Assisted Development in Spartacus
---

Starting with release 221121.20, Spartacus provides agent skills that guide AI coding harnesses to generate storefront code that follows Spartacus conventions.

## Scope Overview

- Packaged development guidance delivered as Agent Skills for widely used AI coding harnesses, for example Claude Code, Codex, and Cursor
- Automatic activation whenever an AI coding agent works on Composable Storefront code, with no manual prompting required
- Coverage of Composable Storefront core building patterns for creating and customizing components, pages, and back-end data flows
- Direction to extend existing Composable Storefront elements rather than rebuild them from scratch
- Guidance to reuse standard Composable Storefront capabilities before implementing new ones
- Built-in debugging steps that reveal the live configuration and page structure of a running storefront
- One-step setup that adds the Agent Skills to a project and targets the developer's chosen AI coding harness
- Automatic alignment of the guidance with the installed Composable Storefront version on every update
- Availability for new projects and existing Composable Storefront implementations through standard install and update flows

## Benefits

- Reduce rework by generating correct code on the first attempt
- Accelerate developer onboarding by embedding framework conventions into everyday tooling
- Improve upgrade resilience by favoring supported extension patterns over ad hoc code
- Lower total cost of ownership by reusing standard capabilities instead of rebuilding them
- Shorten troubleshooting cycles by giving agents visibility into real application state
- Increase consistency across teams and projects by making correct patterns the default

## @spartacus/skills

AI **Agent Skills** for building custom [SAP Spartacus](https://github.com/SAP/spartacus)
storefront applications. The package ships a single skill, `spartacus-developer`,
that captures the Spartacus-specific rules an AI assistant should follow when
generating or changing storefront code (backend communication, CMS wiring,
routing, configuration, state, i18n, styling, SSR, and more).

## Scope

This guidance is for **building a custom Spartacus storefront** (consumer
codebases). It is **not** guidance for developing the Spartacus framework
itself.

## Install

```bash
npm install --save-dev @spartacus/skills
```

## Copy the skill into your project

AI assistants discover skills from your project, not from `node_modules`. Copy
the skill into the locations your tools expect.

### Recommended: the schematic

If `@spartacus/schematics` is installed, let it place the files for you:

```bash
ng generate @spartacus/schematics:ai-context
# or target specific tools (repeat the flag once per tool):
ng generate @spartacus/schematics:ai-context --ai-tools=claude --ai-tools=agents
```

This is also offered as a prompt during `ng add @spartacus/schematics`.

### Manual copy

If you don't use the schematic, copy the skill folder yourself:

```bash
# Claude Code
mkdir -p .claude/skills
cp -r node_modules/@spartacus/skills/skills/spartacus-developer .claude/skills/

# Other agents (cross-tool location read by Codex, Gemini CLI, and others)
mkdir -p .agents/skills
cp -r node_modules/@spartacus/skills/skills/spartacus-developer .agents/skills/
```

## Keeping it up to date

After updating the package (`npm update @spartacus/skills`), re-run the copy step
above so your project reflects the latest guidance.

## What's inside

```text
skills/spartacus-developer/
  SKILL.md             # entry point with frontmatter (auto-discovered by agents)
  references/
    <topic>.md         # one file per topic, linked from SKILL.md
    ...                # plus deep-dive material linked from the topic files
```
