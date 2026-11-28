---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "License allowlist"
description: "The SPDX identifiers an installed package may carry; the compatibility run fails on any other."
status: draft
timestamp: 2026-11-27
---

# Definition

The license allowlist lists the SPDX license identifiers that an installed package may carry. The compatibility run compares every installed package against it. A new identifier on the list is explained in a decision record.

# Not to be confused with

- The organisation license check: the job `licenses` in `.github/workflows/edition.yml` calls the shared `license-check.yml` workflow, which denies a few licenses (SSPL, BSL, BUSL) on the edition's own resolve. The allowlist is stricter: it admits only the identifiers it lists, and it runs in every cell of the compatibility run. `Edition CI` requires both.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["License allowlist"]
  n1[/"Build/license-allowlist.txt"/]
  n2["Compatibility run"]
  c -->|"implementedBy"| n1
  n2 -->|"constrainedBy"| c
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `Build/license-allowlist.txt` | `Build/Scripts/smoke-test.sh` | `"$EDITION_DIR/Build/license-allowlist.txt"` | asserted |
