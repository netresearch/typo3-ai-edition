# Security Policy

The organisation-wide policy applies: [netresearch/.github SECURITY.md](https://github.com/netresearch/.github/blob/main/SECURITY.md). Do not open a public issue for a vulnerability.

## Where to report

- A vulnerability in one of the extensions the edition installs: report it privately in that extension's repository (Security tab, "Report a vulnerability"). Its Packagist page links the repository.
- A problem of the edition itself, for example a range that admits a version with a known vulnerability: report it privately here.

## Supported versions

The latest edition release. When a member publishes a security fix, a new edition release raises that member's floor or excludes the affected versions through `conflict`. Within a member's minor, `composer update` already installs a patch release without a new edition release.
