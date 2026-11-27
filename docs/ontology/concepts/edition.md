---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Edition"
description: "The Composer metapackage netresearch/typo3-ai-edition: member constraints that a compatibility run installed and tested together."
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
---

# Definition

The edition is the Composer metapackage `netresearch/typo3-ai-edition`. It contains no code; it carries the constraints of its members, so that one `composer require` resolves to a combination that a compatibility run installed and tested together. ADR 0001 records the decision.

# Not to be confused with

- A TYPO3 distribution or site package: the edition imposes no site structure.
- An installation that uses the extensions, for example the TYPO3 demo instance: such an installation can require the members individually, in versions the edition has not tested.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `uses` | [Supported platform](supported-platform.md) | `composer.json` | `"typo3/cms-core": "^14.3"` | asserted |
| `constrainedBy` | [Curation criterion](curation-criterion.md) | `docs/decisions/0001-typo3-ai-edition.md` | `### Curation criteria` | asserted |
| `implementedBy` | `composer.json` | `composer.json` | `"type": "metapackage"` | asserted |
| `verifiedBy` | `.github/workflows/edition.yml` | `.github/workflows/edition.yml` | `name: Edition CI` | asserted |
