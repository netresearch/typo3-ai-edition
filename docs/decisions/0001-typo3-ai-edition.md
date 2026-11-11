---
type: decision
title: "ADR 0001: TYPO3 AI Edition as a tested Composer metapackage"
description: Package name and type, members, version policy, supported TYPO3 and PHP versions, and which curation criteria CI checks.
timestamp: 2026-11-11
tags: [edition, composer, curation]
---

# ADR 0001: TYPO3 AI Edition as a tested Composer metapackage

- Status: accepted
- Date: 2026-11-11
- Decision: product owner decision of 2026-11-11 to build and publish the edition now

## Context

Netresearch publishes several AI extensions for TYPO3 that depend on each other: nr-llm is the foundation, nr-vault stores the API keys, and the feature extensions require a specific minor range of nr-llm. A site that installs them one by one has to find a combination that resolves and works. An analysis of the extension portfolio named a curated, tested reference configuration as missing, with curation criteria: accessibility (BFSG), data processing agreements (AVV), EU AI Act, licenses, and functional tests per release. It rejected accessibility overlays.

## Decision

### Package

`netresearch/typo3-ai-edition`, Composer type `metapackage`, published on Packagist from `github.com/netresearch/typo3-ai-edition`.

A metapackage installs nothing of its own and only carries constraints, so it adds no code that needs maintaining or auditing. A TYPO3 distribution (a site package with configuration) was not chosen: it would impose a site structure on existing projects, and the members already ship their own setup.

`composer.json` carries no `version` field; Packagist reads versions from the tags.

### Members

Required, all public on Packagist under GPL-2.0-or-later or GPL-3.0-or-later:

| Package | Floor tested for 1.0.0 |
| --- | --- |
| netresearch/nr-llm | 0.43.23 |
| netresearch/nr-vault | 1.5.0 |
| netresearch/t3-cowriter | 3.27.0 |
| netresearch/nr-mcp-agent | 0.36.0 |
| netresearch/nr-landingpage | 0.3.26 |
| netresearch/nr-repurpose | 0.14.0 |

Suggested, tested in the same run, and fenced to the tested range through `conflict` so that a site installing them gets a tested version:

| Package | Floor tested for 1.0.0 | Why optional |
| --- | --- | --- |
| netresearch/nr-llm-compat | 0.5.0 | Useful only on sites that also run third-party AI extensions |
| netresearch/nr-browser-ai | 0.8.0 | Depends on a browser feature (Chrome built-in AI), not on the server |

Extensions that are not public on Packagist are not members.

nr-vault 1.5.0 was released on the day of this decision; the floor is 1.5.0, not the 1.4.2 an existing demo installation used, because 1.5.0 is the version the compatibility run installed.

### Version policy

- Each member is constrained with `~X.Y.Z`: the version the compatibility run installed, plus later patch releases of the same minor. A new minor of a member needs a new edition release.
- The compatibility run tests both ends of every range: "highest" resolves the newest patch inside each range, "lowest" pins every member to its floor. "Lowest" pins only the members; other libraries resolve as for a user. A trial with Composer's `--prefer-lowest` for everything resolved an old third-party library whose PHP deprecation notice turned every backend module into an error page in Development context, which no user install would get.
- Patch releases of members that appear after an edition release are covered by the weekly run, not by the release itself. A red weekly run is answered by an edition patch release that excludes the broken patch through `conflict` or raises the floor.
- The edition's own version follows SemVer: major when the supported TYPO3 LTS changes or a member is removed, minor when a member moves to a new minor or is added, patch when a floor rises within a minor or a `conflict` is added.

### Supported TYPO3 and PHP versions

The intersection of the members' constraints:

- TYPO3: nr-repurpose requires `^14.3`; every other member accepts `^13.4 || ^14.3`. The edition supports **TYPO3 14.3 LTS** only. Making nr-repurpose optional would have allowed 13.4 as well; it stays required because the edition is meant to represent the whole AI feature set on the current LTS.
- PHP: nr-repurpose requires `^8.3`, TYPO3 14.3 requires `^8.2`. The edition requires **PHP ^8.3** and tests 8.3, 8.4 and 8.5.

### Curation criteria

| Criterion | How it is checked |
| --- | --- |
| Functional tests per release | CI: `Build/Scripts/smoke-test.sh` in `.github/workflows/edition.yml` (install, `extension:setup`, nr-llm configuration records, every module-menu entry of every member; submodules below those entries are not opened). No step calls a language model. |
| License of members and their dependencies | CI: allowlist `Build/license-allowlist.txt` against `composer licenses`, plus the organisation's SSPL/BSL/BUSL deny check (`license-check.yml`) |
| Accessibility (BFSG) | Manual, `docs/release-checklist.md` |
| Data processing agreements (AVV) | Manual, `docs/release-checklist.md` |
| EU AI Act transparency and documentation duties | Manual, `docs/release-checklist.md` |
| No accessibility overlays | Membership rule: an overlay widget is never a member |

The manual items need judgement about a member's behaviour and about the providers a site connects; CI cannot decide them. The checklist records what was reviewed for a release and does not certify a site built with the edition.

### License

GPL-2.0-or-later, the license of TYPO3 and of most members. The repository holds no code; the license covers its scripts and documents.

## Consequences

- Sites get one constraint that resolves to a tested combination, and security patches of members within a minor arrive without an edition release.
- Every new minor of a member needs an edition release; the edition lags behind member minors by the time a release takes.
- TYPO3 13.4 sites cannot use the edition.
- The smoke test opens backend modules but does not exercise model calls; a defect that only shows with a live provider is not caught here.
