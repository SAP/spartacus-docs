---
title: Markdown Rendering via Content Negotiation
feature:
- name: Markdown Rendering via Content Negotiation
  spa_version: TBD
  cx_version: TBD
---

## Overview

Spartacus SSR server can return **Markdown** version of storefront page instead of HTML. Client asks for it via HTTP `Accept` header. Same URL, two representations:

- Browser sends `Accept: text/html` → normal HTML page (unchanged).
- Client sends `Accept: text/markdown` → clean Markdown of same page.

Markdown is stripped-down, content-only view: main content, headings, links, page metadata. Interactive UI noise (buttons, sorting dropdowns, facet-removal links, images) removed.

Runs as Express middleware in SSR server. Feature reuses existing Angular Universal render, then converts rendered HTML to Markdown on the fly.

## Why it matters / use cases

Non-browser clients want page *content*, not UI:

- LLMs / AI agents / chat assistants consuming storefront pages.
- Crawlers, indexers, RAG pipelines.
- Any tool that wants lightweight text over full HTML+JS+CSS.

Markdown = smaller payload, no interactive cruft, easy to parse. Content negotiation = same canonical URL serves both, no separate `.md` route to maintain.

## Requirements / pre-reqs

- Spartacus SSR (Angular Universal) enabled. Feature is server-only — no effect on browser build.
- Package: `@spartacus/setup` (SSR entry point `@spartacus/setup/ssr/markdown`).
- Access to SSR `server.ts` to register middleware.

## How to enable

Register handler in SSR `server.ts`. Middleware must sit **before** `express.static()` and Angular catch-all render.

```typescript
import { createMarkdownPageHandler } from '@spartacus/setup/ssr/markdown';

// ...inside server() setup, after origin validation, before static + render:
server.use(createMarkdownPageHandler());
```

## How it works (good to know)

Per request handler decides. `Vary: Accept` is always set first (so caches key HTML vs Markdown separately), then:

1. **URL in `skipUrls`** (excluded from SSR — no Markdown representation):
   - client accepts HTML → `next()`, serve HTML as usual.
   - client does not accept HTML → respond **`406 Not Acceptable`** (empty). Honest signal: server will not render Markdown for that URL, does not silently return HTML client never asked for.
2. **URL not skipped** — `req.accepts(['text/html', 'text/markdown'])`:
   - result not `text/markdown` → `next()`, serve HTML as usual.
   - result `text/markdown` → patches `res.send`, lets Angular render page HTML, then converts HTML → Markdown before sending.

Timeout guard: whole convert pipeline capped (default 3000ms). On timeout or error → graceful fallback to original HTML. Markdown never blocks/breaks normal response.

Output Markdown structure:

- Page metadata header — site name, title, canonical URL, breadcrumb, description.
- JSON-LD block (structured data) if present — `image`/`logo` fields stripped (media URLs, noise for agents).
- Body Markdown from page `<main>` landmark (`extractMainContent`; falls back to `<body>`, then whole document if `<main>` absent).

Noise removed during HTML → Markdown (Turndown custom rules):

- `<img>` → alt text only (no image markup).
- Empty links dropped; image-only links kept as plain alt text (no `href`); headings hoisted out of links.
- `role="img"` (e.g. `cx-star-rating`) → aria-label text.
- Pagination → `[aria-label](href)`; disabled/current dropped.
- `cx-active-facets` → plain text list (filter-removal hrefs dropped).
- `cx-banner` → block; `[label](href)` if link, else text.
- `cx-sorting` combobox removed (plus its `label.cx-sort-dropdown`; pagination in the same row kept).
- All `<button>` removed (interactive, no href).

## How to configure

`createMarkdownPageHandler(options?)` takes `MarkdownPageHandlerOptions`:

| Option | Type | Default | Purpose |
|---|---|---|---|
| `skipUrls` | `string[]` | `['checkout', 'my-account', 'punchout', 'opf']` | URL substrings excluded from Markdown (case-sensitive substring match on `req.url`). Default inherited from SSR excluded URLs (`defaultRenderingStrategyResolverOptions.excludedUrls`). Pass `[]` to disable filtering. |
| `timeout` | `number` | `3000` | Max ms for convert pipeline. Exceed → fallback to HTML. |
| `logger` | `Pick<Console, 'error'> \| null` | `console` | Error logger. Pass `null` to silence. |
| `parser` | `HtmlToPageParser` | `createDefaultParser()` | HTML → `ParsedPage` (metadata + main content). |
| `converter` | `ParsedPageConverter` | `defaultConverter` | `ParsedPage` → Markdown string. |

Example — custom skipUrls + longer timeout:

```typescript
server.use(
  createMarkdownPageHandler({
    skipUrls: ['checkout', 'my-account', 'payment'],
    timeout: 5000,
  })
);
```

## How to customize

Two seams: parsing (HTML → structured `ParsedPage`) and conversion (`ParsedPage` → Markdown).

- **Tune Markdown conversion rules** — build a Turndown service on top of `createDefaultTurndownService()` (add/override rules, e.g. keep images or buttons), then pass it via `createDefaultParser({ createTurndownService })` as the `parser` option. Turndown rules live in the parser seam, not the converter.
- **Custom converter** — supply `converter: (page: ParsedPage) => string` to change output layout (e.g. drop JSON-LD block, reorder metadata).
- **Custom parser** — supply `parser: (html: string) => ParsedPage` to change what counts as main content or which metadata is extracted.

Exposed helpers (`@spartacus/setup/ssr/markdown`) for reuse:

- `htmlToMarkdown` — convert arbitrary HTML fragment.
- `extractMainContent` — pull Spartacus `<main>` landmark.
- `extractPageContext` — page metadata (siteName, title, canonicalUrl, breadcrumb, description, jsonLd).
- `createDefaultTurndownService`, `defaultConverter`, `renderPageBlock`, `renderJsonLdBlock`, `renderBody`.

## How to extend

- Add Markdown support for currently-skipped areas by narrowing `skipUrls` + supplying a parser that handles that page type.
- Emit extra structured blocks (e.g. product schema) by extending the converter.
- Reuse `htmlToMarkdown` in other server tooling (sitemaps, previews) — it is a standalone export.

## Notes / gotchas

- Server-side only. No browser bundle impact.
- Middleware order matters: register before `express.static()` and Angular render.
- `Vary: Accept` set so CDNs/proxies cache HTML and Markdown separately — verify CDN honors `Vary`.
- `406` is intentional for excluded URLs when the client does not accept HTML — not a bug.
- No feature toggle: enabling = registering the middleware; disabling = removing it.
- Markdown output tuned for content consumption (LLMs/agents), not a pixel-faithful page mirror.
