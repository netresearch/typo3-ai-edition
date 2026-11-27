---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "AI Cowriter (netresearch/t3-cowriter)"
description: "Required member of the edition: Writing assistant in CKEditor."
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
---

# Definition

AI Cowriter is the Composer package `netresearch/t3-cowriter`. Writing assistant in CKEditor. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/t3-cowriter": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/t3-cowriter": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `[netresearch/t3-cowriter]='t3_cowriter'` | asserted |
