---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "Browser AI (netresearch/nr-browser-ai)"
description: "Suggested member of the edition: On-device assistant for the current page in Chrome's built-in AI."
status: draft
timestamp: 2026-11-27
---

# Definition

Browser AI is the Composer package `netresearch/nr-browser-ai`. On-device assistant for the current page in Chrome's built-in AI. It is a suggested member of the edition: a site installs it only on request, and the edition fences it to the tested range through `conflict`. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-browser-ai": "On-device` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-browser-ai": "<` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `SUGGESTED=(netresearch/nr-llm-compat netresearch/nr-browser-ai)` | asserted |
