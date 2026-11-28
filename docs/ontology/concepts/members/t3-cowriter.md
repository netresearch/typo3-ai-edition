---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "AI Cowriter (netresearch/t3-cowriter)"
description: "Required member of the edition: Writing assistant in CKEditor."
status: draft
timestamp: 2026-11-27
---

# Definition

AI Cowriter is the Composer package `netresearch/t3-cowriter`. Writing assistant in CKEditor. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["AI Cowriter (netresearch/t3-cowriter)"]
  n1["Version range"]
  n2["Edition"]
  n3[/"Build/Scripts/smoke-test.sh"/]
  c -->|"constrainedBy"| n1
  c -->|"partOf"| n2
  c -->|"verifiedBy"| n3
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/t3-cowriter": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/t3-cowriter": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `declared=$(jq -r '.require \| keys[] \| select(startswith("netresearch/"))'` | asserted |
