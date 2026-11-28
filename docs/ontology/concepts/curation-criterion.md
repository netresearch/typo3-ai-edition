---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Curation criterion"
description: "A condition every edition release must meet: functional tests, licenses, accessibility, data processing agreements, EU AI Act, no overlays."
status: draft
timestamp: 2026-11-27
---

# Definition

A curation criterion is a condition an edition release must meet. Two are checked by CI: the functional tests of the compatibility run and the licenses. The licenses are checked twice: by the license allowlist in every cell of the compatibility run, and by the organisation license check (job `licenses` in `.github/workflows/edition.yml`), which denies SSPL, BSL and BUSL. Three are reviewed by hand per release with the release checklist: accessibility (BFSG), data processing agreements (AVV) and the transparency duties of the EU AI Act. One is a membership rule: an accessibility overlay is never a member. The checklist records reviews; it certifies no site.

# Neighbours

Generated from the relation tables by `check-ontology.py --write-diagrams`. A solid arrow is an asserted relation, a dotted arrow a hypothesis; a slanted box is a file of the repository.

```mermaid
flowchart LR
  c["Curation criterion"]
  n1[/".github/workflows/edition.yml"/]
  n2[/"docs/release-checklist.md"/]
  n3["Edition"]
  n4["Edition release"]
  c -->|"verifiedBy"| n1
  c -.->|"verifiedBy (hypothesis)"| n2
  n3 -->|"constrainedBy"| c
  n4 -.->|"constrainedBy (hypothesis)"| c
  classDef focus fill:#2F99A4,stroke:#15585E,color:#ffffff
  class c focus
```

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `verifiedBy` | `docs/release-checklist.md` |  |  | hypothesis |
| `verifiedBy` | `.github/workflows/edition.yml` | `.github/workflows/edition.yml` | `run: bash Build/Scripts/smoke-test.sh "$RUNNER_TEMP/project"` | asserted |
| `verifiedBy` | `.github/workflows/edition.yml` | `.github/workflows/edition.yml` | `uses: netresearch/typo3-ci-workflows/.github/workflows/license-check.yml@main` | asserted |

# Notes

- `verifiedBy` `docs/release-checklist.md` is a hypothesis: the checklist is prose that a person ticks in the release pull request, and no code or configuration of this repository reads it, so no literal would disappear if the review stopped.
- The two rows for `.github/workflows/edition.yml` are the two CI-checked criteria: the smoke test step (functional tests and the license allowlist) and the job `licenses` (the organisation license check).
