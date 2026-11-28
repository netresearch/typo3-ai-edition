---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Edition"
description: "The Composer metapackage netresearch/typo3-ai-edition: member constraints that a compatibility run installed and tested together."
status: draft
timestamp: 2026-11-27
---

# Definition

The edition is the Composer metapackage `netresearch/typo3-ai-edition`. It contains no code; it carries the version ranges of its members. The compatibility run tests the lowest and the highest combination those ranges admit; a member patch published after the last run can be resolved by `composer require` before a run has tested it. ADR 0001 records the decision.

# Not to be confused with

- A TYPO3 distribution or site package: the edition imposes no site structure.
- An installation that uses the extensions, for example the TYPO3 demo instance: such an installation can require the members individually, in versions the edition has not tested.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["Edition"]
  n1["Curation criterion"]
  n2[/"composer.json"/]
  n3["Supported platform"]
  n4[/".github/workflows/edition.yml"/]
  n5["Edition release"]
  n6["Browser AI (netresearch/nr-browser-ai)"]
  n7["Landing Page Generator (netresearch/nr-landingpage)"]
  n8["LLM Foundation (netresearch/nr-llm)"]
  n9["LLM Compatibility Layer (netresearch/nr-llm-compat)"]
  n10["AI Chat (netresearch/nr-mcp-agent)"]
  n11["Content Repurpose (netresearch/nr-repurpose)"]
  n12["Secrets Vault (netresearch/nr-vault)"]
  n13["AI Cowriter (netresearch/t3-cowriter)"]
  n14["Compatibility run"]
  c -->|"constrainedBy"| n1
  c -->|"implementedBy"| n2
  c -->|"uses"| n3
  c -->|"verifiedBy"| n4
  n5 -->|"derivedFrom"| c
  n6 -->|"partOf"| c
  n7 -->|"partOf"| c
  n8 -->|"partOf"| c
  n9 -->|"partOf"| c
  n10 -->|"partOf"| c
  n11 -->|"partOf"| c
  n12 -->|"partOf"| c
  n13 -->|"partOf"| c
  n14 -->|"uses"| c
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `uses` | [Supported platform](supported-platform.md) | `composer.json` | `"typo3/cms-core": "^14.3"` | asserted |
| `constrainedBy` | [Curation criterion](curation-criterion.md) | `docs/decisions/0001-typo3-ai-edition.md` | `### Curation criteria` | asserted |
| `implementedBy` | `composer.json` | `composer.json` | `"type": "metapackage"` | asserted |
| `verifiedBy` | `.github/workflows/edition.yml` | `.github/workflows/edition.yml` | `name: Edition CI` | asserted |
