---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Compatibility run"
description: "The CI run that installs the edition into a new TYPO3 project per PHP version and member set and checks every member."
status: draft
timestamp: 2026-11-27
---

# Definition

The compatibility run installs the edition into a new TYPO3 project with MariaDB, in five cells: PHP 8.3, 8.4 and 8.5 with the newest members in range, PHP 8.5 with the suggested members, and PHP 8.3 with every member at the floor of its range. It checks the member lists, the licenses, the setup, the nr-llm configuration records and every backend module entry of every member. It runs on every pull request, on `main` and every Monday. No step calls a language model.

# Not to be confused with

- A test of what a model answers: no step calls a model, so a defect that shows only with a live provider is not caught.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `uses` | [Edition](edition.md) | `Build/Scripts/smoke-test.sh` | `# Installs the edition into a fresh TYPO3 project and checks every member.` | asserted |
| `constrainedBy` | [License allowlist](license-allowlist.md) | `Build/Scripts/smoke-test.sh` | `step "License check (allowlist, Build/license-allowlist.txt)"` | asserted |
| `uses` | [LLM Foundation (netresearch/nr-llm)](members/nr-llm.md) | `Build/Scripts/smoke-test.sh` | `vendor/bin/typo3 nrllm:demo:seed --days=0 --no-interaction` | asserted |
| `implementedBy` | `.github/workflows/edition.yml` | `.github/workflows/edition.yml` | `- { php: '8.3', deps: lowest, suggested: '1' }` | asserted |
| `implementedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `step "Member lists of composer.json and this script agree"` | asserted |
