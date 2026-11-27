---
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
okf_version: "0.3"
title: TYPO3 AI Edition ontology
description: The concepts of the TYPO3 AI Edition and their typed relations, each checked against this repository, for questions such as what a new member minor version requires.
license: GPL-2.0-or-later
---

# TYPO3 AI Edition ontology

This bundle defines the concepts of the TYPO3 AI Edition (the edition, its members, version ranges, the compatibility run, curation criteria, releases) and states how they relate. Every relation names the file in this repository that shows it, so the bundle can answer questions such as "a member releases a new minor version: what must happen before sites get it?".

This bundle follows the Open Knowledge Format 0.3 (https://okf.md): one Markdown file per concept, with a YAML frontmatter block that names its `type`.

# Use it

Run the check from the repository root. The job `ontology` in `.github/workflows/edition.yml` runs the first command, and the gate `Edition CI` requires it.

```bash
python3 Build/Scripts/check-ontology.py docs/ontology                                  # check the bundle against the code
python3 Build/Scripts/check-ontology.py docs/ontology --impact concepts/members/nr-llm     # what a change to it can affect
python3 Build/Scripts/check-ontology.py docs/ontology --needs concepts/edition-release       # what it depends on
```

The check fails when an asserted relation loses its evidence in the code. Fix the relation in the same change as the code.

# Contents

* [Concepts](concepts/index.md) - The concepts of the edition and its members, one file each
* [Relations](relations/index.md) - The relation vocabulary: what each relation means and in which direction a change propagates
* [Competency questions](questions/index.md) - The questions this bundle is built to answer, with the answer at the time of writing
* [Coverage](coverage.md) - What this bundle models, what it leaves out, and how to read its statuses

# Format of a concept

Every concept file has the sections `# Definition`, an optional `# Not to be confused with`, `# Relations` and optional `# Notes`. The relations table has five columns:

| Column | Content |
|---|---|
| Relation | A relation of the vocabulary in `relations/` |
| Target | A link to a concept, a path in this repository in backticks, or an external URL |
| Evidence file | The file, relative to the repository root, that shows the relation |
| Evidence text | A literal from one line of that file; the check requires it to be present |
| Status | `asserted`: read in the code and checked by the script. `hypothesis`: not yet backed by evidence |

The relation vocabulary is the same in every Netresearch bundle. Netresearch keeps the canonical copy of the vocabulary and of this script, and the relations between repositories, in an internal repository.
