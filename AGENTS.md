# AGENTS.md

Composer metapackage `netresearch/typo3-ai-edition`: constraints only, no PHP code. Read `README.md` for what it is and `docs/decisions/0001-typo3-ai-edition.md` for why it looks this way.

## Layout

| Path | Content |
| --- | --- |
| `composer.json` | The edition: `require` (members), `conflict` (tested range of suggested members), `suggest` |
| `Build/Scripts/smoke-test.sh` | Compatibility run: fresh TYPO3 project, install, setup, member checks |
| `Build/license-allowlist.txt` | SPDX identifiers an installed package may carry |
| `.github/workflows/edition.yml` | Runs the smoke test per PHP version and dependency set; `Edition CI` is the gate |
| `.github/workflows/release.yml` | Tag push: signed source archive, GitHub release, Packagist check |
| `docs/decisions/` | Decision records (OKF frontmatter) |
| `docs/release-checklist.md` | Steps and manual curation checks per release |

## Commands

```bash
bash -n Build/Scripts/smoke-test.sh          # syntax
composer validate --strict                   # manifest
Build/Scripts/smoke-test.sh /tmp/edition-smoke   # full run, needs an empty MariaDB (see CONTRIBUTING.md)
```

## Rules

- Member lists live in two places that must agree: `composer.json` and the arrays at the top of `smoke-test.sh`. The script fails when they differ.
- Member ranges are `~X.Y.Z`, where `X.Y.Z` is a version a green compatibility run installed. Never widen a range to a minor that has not run.
- `composer.json` has no `version` field; tags carry the version.
- No step may call a language model or need an API key.
- Organisation reusable workflows are called at `@main`; third-party actions are pinned to a full commit SHA.
- Commits: Conventional Commits, `git commit -S --signoff`, English.
- Do not state that the edition makes a site BFSG-, AVV- or AI-Act-compliant; the checklist records reviews, it certifies nothing.
