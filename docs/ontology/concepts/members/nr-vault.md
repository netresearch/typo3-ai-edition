---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Edition Member
title: "Secrets Vault (netresearch/nr-vault)"
description: "Required member of the edition: Envelope-encrypted storage for API keys and credentials."
status: draft
timestamp: 2026-11-27
---

# Definition

Secrets Vault is the Composer package `netresearch/nr-vault`. Envelope-encrypted storage for API keys and credentials. It is a required member of the edition. Its version range in the edition admits patch releases of one minor version only.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["Secrets Vault (netresearch/nr-vault)"]
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
| `partOf` | [Edition](../edition.md) | `composer.json` | `"netresearch/nr-vault": "~` | asserted |
| `constrainedBy` | [Version range](../version-range.md) | `composer.json` | `"netresearch/nr-vault": "~` | asserted |
| `verifiedBy` | `Build/Scripts/smoke-test.sh` | `Build/Scripts/smoke-test.sh` | `declared=$(jq -r '.require \| keys[] \| select(startswith("netresearch/"))'` | asserted |
