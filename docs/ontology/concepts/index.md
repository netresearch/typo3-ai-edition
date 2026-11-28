<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
<!-- SPDX-FileCopyrightText: Netresearch DTT GmbH -->

# Concepts

* [Edition](edition.md) - The Composer metapackage netresearch/typo3-ai-edition: member constraints that a compatibility run installed and tested together.
* [Version range](version-range.md) - The constraint ~X.Y.Z of a member: the version a green compatibility run installed, plus later patch releases of that minor.
* [Compatibility run](compatibility-run.md) - The CI run that installs the edition into a new TYPO3 project per PHP version and member set and checks every member.
* [License allowlist](license-allowlist.md) - The SPDX identifiers an installed package may carry; the compatibility run fails on any other.
* [Curation criterion](curation-criterion.md) - A condition every edition release must meet: functional tests, licenses, accessibility, data processing agreements, EU AI Act, no overlays.
* [Supported platform](supported-platform.md) - TYPO3 14.3 LTS and PHP 8.3 to 8.5: the intersection of the members constraints.
* [Edition release](edition-release.md) - A tagged version of the edition; its SemVer level follows what changed in the members.

# Members

* [Members](members/index.md) - The packages the edition requires or suggests, one file each
