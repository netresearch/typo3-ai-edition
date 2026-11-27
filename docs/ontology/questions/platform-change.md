---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Competency Question
title: "The supported platform changes"
description: "What is affected when the supported TYPO3 LTS or PHP version changes?"
x-nr-query: --impact concepts/supported-platform
status: draft
timestamp: 2026-11-27
---

# Question

A new TYPO3 LTS or a new PHP version is to be supported, or an old one dropped. What is affected?

# How to answer

Follow the relations backwards from the supported platform. Run:

```bash
python3 Build/Scripts/check-ontology.py docs/ontology --impact concepts/supported-platform
```

# Answer at the time of writing

```text
concepts/supported-platform
  test .github/workflows/edition.yml
concepts/edition
  via concepts/edition uses concepts/supported-platform
  test .github/workflows/edition.yml
concepts/compatibility-run
  via concepts/edition uses concepts/supported-platform
  via concepts/compatibility-run uses concepts/edition
concepts/edition-release
  via concepts/edition uses concepts/supported-platform
  via concepts/edition-release derivedFrom concepts/edition
Scope: only the relations this bundle models; coverage.md names what it leaves out.
```

# Limits

The platform is the intersection of the constraints of all members, so every member must support the new version first. A change of the supported TYPO3 LTS is a major release of the edition.
