---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "LLM Foundation (netresearch/nr-llm)"
description: "Required member of the edition: Provider configuration, encrypted API keys, chat, translation, vision and embedding services for the members that build on it: t3-cowriter, nr-mcp-agent, nr-landingpage, nr-repurpose and nr-llm-compat."
status: draft
timestamp: 2026-11-27
---

# Definition

LLM Foundation is the Composer package `netresearch/nr-llm`. Provider configuration, encrypted API keys, chat, translation, vision and embedding services for the members that build on it: t3-cowriter, nr-mcp-agent, nr-landingpage, nr-repurpose and nr-llm-compat. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-llm": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-llm": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `declared=$(jq -r '.require \| keys[] \| select(startswith("netresearch/"))'` | asserted |
