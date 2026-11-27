---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
type: Concept
title: "Supported platform"
description: "TYPO3 14.3 LTS and PHP 8.3 to 8.5: the intersection of the members constraints."
status: draft
timestamp: 2026-11-27
---

# Definition

The supported platform is the intersection of the constraints of all members: TYPO3 14.3 LTS and PHP `^8.3`, tested on 8.3, 8.4 and 8.5. TYPO3 13.4 is out, because Content Repurpose requires TYPO3 14.3.

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `composer.json` | `composer.json` | `"php": "^8.3"` | asserted |
