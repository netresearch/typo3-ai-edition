---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Version range"
description: "The constraint ~X.Y.Z of a member: the version a green compatibility run installed, plus later patch releases of that minor."
status: draft
timestamp: 2026-11-27
---

# Definition

The version range of a required member has the form `~X.Y.Z`: X.Y.Z is a version a green compatibility run installed, and later patch releases of the same minor are admitted. The edition never pulls in a new minor version of a member; a new minor arrives with a new edition release after the compatibility run passed for it. A suggested member is fenced the same way through `conflict`.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["Version range"]
  n1["Compatibility run"]
  n2[/"composer.json"/]
  n3["Browser AI (netresearch/nr-browser-ai)"]
  n4["Landing Page Generator (netresearch/nr-landingpage)"]
  n5["LLM Foundation (netresearch/nr-llm)"]
  n6["LLM Compatibility Layer (netresearch/nr-llm-compat)"]
  n7["AI Chat (netresearch/nr-mcp-agent)"]
  n8["Content Repurpose (netresearch/nr-repurpose)"]
  n9["Secrets Vault (netresearch/nr-vault)"]
  n10["AI Cowriter (netresearch/t3-cowriter)"]
  c -.->|"derivedFrom (hypothesis)"| n1
  c -->|"implementedBy"| n2
  n3 -->|"constrainedBy"| c
  n4 -->|"constrainedBy"| c
  n5 -->|"constrainedBy"| c
  n6 -->|"constrainedBy"| c
  n7 -->|"constrainedBy"| c
  n8 -->|"constrainedBy"| c
  n9 -->|"constrainedBy"| c
  n10 -->|"constrainedBy"| c
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `composer.json` | `composer.json` | `"netresearch/nr-llm": "~` | asserted |
| `derivedFrom` | [Compatibility run](compatibility-run.md) |  |  | hypothesis |

# Notes

- `derivedFrom` Compatibility run is a hypothesis: a person bumps the floors in `composer.json` to the versions a green run installed (step 1 of the release steps in `docs/release-checklist.md`). No code of this repository writes the ranges from a run; `Build/Scripts/smoke-test.sh` reads the floors out of `composer.json`, the opposite direction.
