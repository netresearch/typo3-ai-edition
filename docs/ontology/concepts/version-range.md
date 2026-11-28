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

# Relations

| Relation | Target | Evidence file | Evidence text | Status |
|---|---|---|---|---|
| `implementedBy` | `composer.json` | `composer.json` | `"netresearch/nr-llm": "~` | asserted |
