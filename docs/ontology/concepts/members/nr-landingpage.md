---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "Landing Page Generator (netresearch/nr-landingpage)"
description: "Required member of the edition: Backend wizard that drafts landing pages."
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
---

# Definition

Landing Page Generator is the Composer package `netresearch/nr-landingpage`. Backend wizard that drafts landing pages. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-landingpage": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-landingpage": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `[netresearch/nr-landingpage]='nr_landingpage' [netresearch/nr-repurpose]='nr_repurpose'` | asserted |
