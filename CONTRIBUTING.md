# Contributing

The organisation-wide rules apply: [netresearch/.github CONTRIBUTING.md](https://github.com/netresearch/.github/blob/main/CONTRIBUTING.md) (Conventional Commits, signed commits with DCO sign-off, pull requests against `main`).

## What belongs here

This repository holds the edition's constraints, the compatibility run and the curation documents. A bug in one extension belongs in that extension's repository; open an issue here when a combination of members fails, or when the edition should take a new member version.

## Raising a member to a new version

1. Change the member's range in `composer.json` (`~X.Y.Z`, the version you want to test) and its row in `README.md`.
2. Open a draft pull request. `Edition CI` installs the new combination on every supported PHP version.
3. When it is green, the change goes out with the next edition release; see `docs/release-checklist.md`.

## Adding or removing a member

Membership is a curation decision. Write it down in `docs/decisions/` first, then change `composer.json` and the member lists in `Build/Scripts/smoke-test.sh` together: the script fails when the two disagree. A new member needs a check in the script, at least its backend module prefix.

## Running the compatibility run locally

The script needs PHP with `mysqli`, `intl`, `gd`, `zip`, `sodium` and `curl`, Composer, `jq`, `curl` and a MariaDB or MySQL server:

```bash
DB_HOST=127.0.0.1 DB_PORT=3306 DB_USER=root DB_PASSWORD=root DB_NAME=typo3 \
    Build/Scripts/smoke-test.sh /tmp/edition-smoke
```

`DEPS=lowest` pins every member to its floor; `WITH_SUGGESTED=1` also installs the suggested members. The database must be empty.
