---
type: reference
title: Release checklist
description: Steps and manual curation checks for every edition release; copy the checklist into the release pull request.
---

# Release checklist

Copy the list below into the description of the release pull request (`release/vX.Y.Z`) and tick each item there. An item that was not reviewed stays unticked and is named in the release notes.

## Automated (must be green on the release commit)

- [ ] `Edition CI` is green on `main` for the commit being tagged: every PHP version, highest and floor versions, with and without suggested members.
- [ ] The installed versions in the job summary match the floors in `composer.json`.
- [ ] License allowlist and the organisation license check passed. Any new identifier on `Build/license-allowlist.txt` is explained in `docs/decisions/`.

## Manual curation

For every member whose version changed since the previous edition release:

### Accessibility (BFSG)

- [ ] New or changed backend modules and editor dialogs are operable by keyboard alone and have visible focus.
- [ ] Form fields and buttons in those views have accessible names.
- [ ] Content a member writes into pages (for example generated landing pages or texts) keeps a valid heading order and alt texts can be edited before publishing.
- [ ] No member adds an accessibility overlay or a script that changes the page for assistive technology at runtime.

### Data processing agreements (AVV)

- [ ] The list of external services a member can send data to is current in its documentation (model providers, search or speech services).
- [ ] No member sends content to an external service without a provider an administrator configured.
- [ ] Changes that add a new external service are named in the release notes, so sites can check their agreements.

### EU AI Act

- [ ] Generated content can be identified as generated where a member publishes it, or the member documents how editors mark it.
- [ ] Each member's documentation states which data it sends to a model and for what purpose.
- [ ] No member adds a use that the AI Act lists as prohibited or high-risk without a documented decision.

### Membership

- [ ] Every member is public on Packagist and its license is on the allowlist.
- [ ] Removed or added members are recorded in a decision document.

## Release steps

1. Bump floors in `composer.json` to the versions the green run installed, update the tables in `README.md`, and open `release/vX.Y.Z` as a draft pull request with this checklist.
2. After the merge, tag `main`: `git tag -s vX.Y.Z -m "vX.Y.Z"` and `git push origin vX.Y.Z`.
3. `.github/workflows/release.yml` builds and signs the source archive, creates the GitHub release and waits until Packagist lists the version.
4. Rewrite the release notes: members and versions, what changed, which checklist items were not reviewed.
