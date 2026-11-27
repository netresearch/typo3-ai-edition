---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Competency Question
title: "What an edition release needs"
description: "Which conditions must hold before an edition release is tagged?"
x-nr-query: --needs concepts/edition-release
status: draft
generated: {by: claude-code/2.1.332, at: 2026-11-27T21:06:57Z}
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
  via concepts/edition-release constrainedBy concepts/compatibility-run
concepts/curation-criterion
  via concepts/edition-release constrainedBy concepts/curation-criterion
  test docs/release-checklist.md
  test .github/workflows/edition.yml
concepts/supported-platform
  via concepts/edition-release derivedFrom concepts/edition
  via concepts/edition uses concepts/supported-platform
concepts/license-allowlist
  via concepts/edition-release constrainedBy concepts/compatibility-run
  via concepts/compatibility-run constrainedBy concepts/license-allowlist
concepts/members/nr-llm
  via concepts/edition-release constrainedBy concepts/compatibility-run
  via concepts/compatibility-run uses concepts/members/nr-llm
  test Build/Scripts/smoke-test.sh
concepts/version-range
  via concepts/edition-release constrainedBy concepts/compatibility-run
  via concepts/compatibility-run uses concepts/members/nr-llm
  via concepts/members/nr-llm constrainedBy concepts/version-range
Scope: only the relations this bundle models; coverage.md names what it leaves out.
```

# Limits

The manual curation items in `docs/release-checklist.md` are reviews by a person; an item that was not reviewed stays unticked and is named in the release notes.
