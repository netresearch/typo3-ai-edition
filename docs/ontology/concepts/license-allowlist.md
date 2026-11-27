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

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `Build/license-allowlist.txt` | `Build/license-allowlist.txt` | `# SPDX identifiers a package installed by the edition may carry.` | asserted |
