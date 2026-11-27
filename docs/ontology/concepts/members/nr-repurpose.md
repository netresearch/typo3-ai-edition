---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "Content Repurpose (netresearch/nr-repurpose)"
description: "Required member of the edition: Turns a page or PDF into a podcast, diagram, story or text variants."
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
---

# Definition

Content Repurpose is the Composer package `netresearch/nr-repurpose`. Turns a page or PDF into a podcast, diagram, story or text variants. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-repurpose": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-repurpose": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `[netresearch/nr-repurpose]='nr_repurpose'` | asserted |
