---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "LLM Compatibility Layer (netresearch/nr-llm-compat)"
description: "Suggested member of the edition: Routes the LLM calls of third-party AI extensions through nr-llm."
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
---

# Definition

LLM Compatibility Layer is the Composer package `netresearch/nr-llm-compat`. Routes the LLM calls of third-party AI extensions through nr-llm. It is a suggested member of the edition: a site installs it only on request, and the edition fences it to the tested range through `conflict`. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-llm-compat": "Routes` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-llm-compat": "<` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `[netresearch/nr-llm-compat]='nr_llm_compat'` | asserted |
