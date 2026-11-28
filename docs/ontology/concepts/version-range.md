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
  n1[/"composer.json"/]
  n2["Browser AI (netresearch/nr-browser-ai)"]
  n3["Landing Page Generator (netresearch/nr-landingpage)"]
  n4["LLM Foundation (netresearch/nr-llm)"]
  n5["LLM Compatibility Layer (netresearch/nr-llm-compat)"]
  n6["AI Chat (netresearch/nr-mcp-agent)"]
  n7["Content Repurpose (netresearch/nr-repurpose)"]
  n8["Secrets Vault (netresearch/nr-vault)"]
  n9["AI Cowriter (netresearch/t3-cowriter)"]
  c -->|"implementedBy"| n1
  n2 -->|"constrainedBy"| c
  n3 -->|"constrainedBy"| c
  n4 -->|"constrainedBy"| c
  n5 -->|"constrainedBy"| c
  n6 -->|"constrainedBy"| c
  n7 -->|"constrainedBy"| c
  n8 -->|"constrainedBy"| c
  n9 -->|"constrainedBy"| c
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `composer.json` | `composer.json` | `"netresearch/nr-llm": "~` | asserted |
