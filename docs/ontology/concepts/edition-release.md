---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Edition release"
description: "A tagged version of the edition; its SemVer level follows what changed in the members."
status: draft
timestamp: 2026-11-27
---

# Definition

An edition release is a tag `vX.Y.Z` of this repository; a workflow builds a signed source archive and the GitHub release, and Packagist reads the version from the tag. The edition follows SemVer: major when the supported TYPO3 LTS changes or a member is removed, minor when a member moves to a new minor or is added, patch when a floor rises within a minor or a `conflict` is added.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `derivedFrom` | [Edition](edition.md) | `.github/workflows/release.yml` | `tags: ['v*']` | asserted |
| `constrainedBy` | [Compatibility run](compatibility-run.md) | `docs/release-checklist.md` | `for the commit being tagged` | asserted |
| `constrainedBy` | [Curation criterion](curation-criterion.md) | `docs/release-checklist.md` | `Copy the list below into the description of the release pull request` | asserted |
| `implementedBy` | `.github/workflows/release.yml` | `.github/workflows/release.yml` | `tags: ['v*']` | asserted |
