---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Competency Question
title: "A member releases a new minor version"
description: "What does a new minor version of a member, for example nr-llm, require of the edition?"
x-nr-query: --impact concepts/members/nr-llm
status: draft
timestamp: 2026-11-27
---

# Question

A member, for example nr-llm, releases a new minor version. What is affected, and what must happen before sites get it through the edition?

# How to answer

Follow the relations backwards from the member. Run:

```bash
python3 Build/Scripts/check-ontology.py docs/ontology --impact concepts/members/nr-llm
```

# Answer at the time of writing

```text
concepts/members/nr-llm
  test Build/Scripts/smoke-test.sh
concepts/compatibility-run
  via concepts/compatibility-run uses concepts/members/nr-llm
concepts/edition
  via concepts/members/nr-llm partOf concepts/edition
  test .github/workflows/edition.yml
concepts/edition-release
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/edition-release constrainedBy concepts/compatibility-run (hypothesis)
concepts/version-range
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
concepts/members/nr-browser-ai
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-browser-ai constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/nr-landingpage
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-landingpage constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/nr-llm-compat
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-llm-compat constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/nr-mcp-agent
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-mcp-agent constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/nr-repurpose
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-repurpose constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/nr-vault
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-vault constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/members/t3-cowriter
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/t3-cowriter constrainedBy concepts/version-range
  test Build/Scripts/smoke-test.sh
concepts/supported-platform
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/version-range derivedFrom concepts/compatibility-run (hypothesis)
  via concepts/members/nr-repurpose constrainedBy concepts/version-range
  via concepts/supported-platform derivedFrom concepts/members/nr-repurpose (hypothesis)
  test .github/workflows/edition.yml
Scope: only the relations this bundle models; coverage.md names what it leaves out.
A test line names a test file that covers the concept; it does not show that the test ran.
```

# Limits

The edition does not install the new minor: the version range admits patch releases only. A pull request raises the range in `composer.json` and in the README, the compatibility run must pass on it, and an edition release (a minor release of the edition) ships it after the manual curation review of `docs/release-checklist.md` (accessibility, data processing agreements, EU AI Act) for every member whose version changed; `--needs concepts/edition-release` lists those conditions. Sites that require the member directly, without the edition, get the new minor as their own constraints allow.
