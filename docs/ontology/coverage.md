---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Reference
title: "Coverage"
description: "What the TYPO3 AI Edition ontology models, what it leaves out, and how to read its statuses."
status: draft
timestamp: 2026-11-27
---

# Scope

The bundle models the edition as a product: its members, their version ranges, the supported platform, the compatibility run, the license allowlist, the curation criteria and the edition release. The concepts inside each member (for example the providers and configurations of nr-llm) belong to the bundle of that member's repository; nr-llm has one in `docs/ontology/` (https://github.com/netresearch/t3x-nr-llm/tree/main/docs/ontology), added with netresearch/t3x-nr-llm#1480 (https://github.com/netresearch/t3x-nr-llm/pull/1480).

It describes the edition, not an installation. A site that requires the members individually, such as a demo instance, can run versions the edition has not tested.

# Not modelled

A missing relation means "not modelled", never "not related". Out of scope for now:

- The dependencies between members (for example that the feature extensions require a minor range of nr-llm). They are declared in each member's `composer.json`.
- The template drift check, the security and scorecard workflows, and Renovate.
- The individual items of the release checklist.

# Statuses

- `asserted`: the evidence text occurs exactly once in the evidence file; the check script confirms this on every run. It does not confirm that the evidence still means the relation: review a relation when its evidence file changes.
- `hypothesis`: plausible, without evidence in this repository.
- `status: draft` in the frontmatter marks every file as not yet reviewed by a person.
