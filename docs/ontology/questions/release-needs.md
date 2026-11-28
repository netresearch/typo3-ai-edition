---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Competency Question
title: "What an edition release needs"
description: "Which conditions must hold before an edition release is tagged?"
x-nr-query: --needs concepts/edition-release
status: draft
timestamp: 2026-11-27
---

# Question

Which conditions must hold before an edition release is tagged?

# How to answer

Follow the relations forwards from the edition release. Run:

```bash
python3 Build/Scripts/check-ontology.py docs/ontology --needs concepts/edition-release
```

# Answer at the time of writing

```text
concepts/edition-release
concepts/edition
  via concepts/edition-release derivedFrom concepts/edition
  test .github/workflows/edition.yml
concepts/compatibility-run
  via concepts/edition-release constrainedBy concepts/compatibility-run (hypothesis)
concepts/curation-criterion
  via concepts/edition-release constrainedBy concepts/curation-criterion (hypothesis)
  test docs/release-checklist.md (hypothesis)
  test .github/workflows/edition.yml
concepts/supported-platform
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/edition uses concepts/supported-platform
  test .github/workflows/edition.yml
concepts/members/nr-browser-ai
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-browser-ai partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-landingpage
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-landingpage partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-llm-compat
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-llm-compat partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-llm
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-llm partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-mcp-agent
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-mcp-agent partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-repurpose
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-repurpose partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/nr-vault
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-vault partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/members/t3-cowriter
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/t3-cowriter partOf concepts/edition
  test Build/Scripts/smoke-test.sh
concepts/license-allowlist
  via concepts/edition-release constrainedBy concepts/compatibility-run (hypothesis)
  via concepts/compatibility-run constrainedBy concepts/license-allowlist
concepts/version-range
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/members/nr-browser-ai partOf concepts/edition
  via concepts/members/nr-browser-ai constrainedBy concepts/version-range
Scope: only the relations this bundle models; coverage.md names what it leaves out.
A test line names a test file that covers the concept; it does not show that the test ran.
```

# Limits

The manual curation items in `docs/release-checklist.md` are reviews by a person; an item that was not reviewed stays unticked and is named in the release notes.
