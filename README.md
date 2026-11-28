# TYPO3 AI Edition

[![Edition](https://github.com/netresearch/typo3-ai-edition/actions/workflows/edition.yml/badge.svg)](https://github.com/netresearch/typo3-ai-edition/actions/workflows/edition.yml)
[![Packagist](https://img.shields.io/packagist/v/netresearch/typo3-ai-edition)](https://packagist.org/packages/netresearch/typo3-ai-edition)
[![License](https://img.shields.io/packagist/l/netresearch/typo3-ai-edition)](LICENSE)

One Composer package that installs the Netresearch AI extensions for TYPO3 in versions that were installed and tested together. It contains no code: it is a Composer [metapackage](https://getcomposer.org/doc/04-schema.md#type) whose constraints pin each extension to the range a compatibility run proved.

```bash
composer require netresearch/typo3-ai-edition
vendor/bin/typo3 extension:setup
```

## What it installs

| Extension | Package | Range | Purpose |
| --- | --- | --- | --- |
| LLM Foundation | [`netresearch/nr-llm`](https://packagist.org/packages/netresearch/nr-llm) | `~0.52.1` | Provider configuration, encrypted API keys, chat, translation, vision and embedding services for every other extension |
| Secrets Vault | [`netresearch/nr-vault`](https://packagist.org/packages/netresearch/nr-vault) | `~1.10.0` | Envelope-encrypted storage for API keys and credentials |
| AI Cowriter | [`netresearch/t3-cowriter`](https://packagist.org/packages/netresearch/t3-cowriter) | `~3.28.9` | Writing assistant in CKEditor |
| AI Chat | [`netresearch/nr-mcp-agent`](https://packagist.org/packages/netresearch/nr-mcp-agent) | `~0.39.4` | Chat assistant in the TYPO3 backend with tool calling |
| Landing Page Generator | [`netresearch/nr-landingpage`](https://packagist.org/packages/netresearch/nr-landingpage) | `~0.8.3` | Backend wizard that drafts landing pages |
| Content Repurpose | [`netresearch/nr-repurpose`](https://packagist.org/packages/netresearch/nr-repurpose) | `~0.15.9` | Turns a page or PDF into a podcast, diagram, story or text variants |

Optional, tested in the same run and fenced to the tested range through `conflict`:

| Extension | Package | Range |
| --- | --- | --- |
| LLM Compatibility Layer | [`netresearch/nr-llm-compat`](https://packagist.org/packages/netresearch/nr-llm-compat) | `~0.5.9` |
| Browser AI | [`netresearch/nr-browser-ai`](https://packagist.org/packages/netresearch/nr-browser-ai) | `~0.9.0` |

`~0.52.1` means 0.52.1 or a later 0.52.x patch release; the edition never pulls in a new minor version of a member. A new minor arrives with a new edition release after the compatibility run has passed for it.

## Requirements

- TYPO3 14.3 LTS
- PHP 8.3, 8.4 or 8.5
- The PHP extensions the members need: `sodium`, `curl`, `json` (see each member's `composer.json`)

TYPO3 13.4 is not supported: Content Repurpose requires TYPO3 14.3. [ADR 0001](docs/decisions/0001-typo3-ai-edition.md) explains the choice.

## What the compatibility run checks

[`.github/workflows/edition.yml`](.github/workflows/edition.yml) runs [`Build/Scripts/smoke-test.sh`](Build/Scripts/smoke-test.sh) on every pull request, on `main`, and every Monday. Each cell installs the edition into a new TYPO3 project with the MariaDB image that `edition.yml` names:

| PHP | Member versions | Suggested members |
| --- | --- | --- |
| 8.3 | newest in range | no |
| 8.4 | newest in range | no |
| 8.5 | newest in range | no |
| 8.5 | newest in range | yes |
| 8.3 | floor of each range | yes |

In every cell the script:

1. checks that `composer.json` and the script list the same members;
2. checks the license of every installed package against [`Build/license-allowlist.txt`](Build/license-allowlist.txt);
3. runs `typo3 setup` and `typo3 extension:setup`, then checks every member is an active extension;
4. creates nr-llm provider, model and configuration records with `nrllm:demo:seed --days=0` and checks they exist;
5. logs in to the backend and opens every entry the module menu lists for each member, failing on an HTTP error, an exception page, or a page without the module's own marker. These are the menu entry points (for 1.1.0: seven for nr-llm, two for nr-landingpage, one each for the others); submodules reached from inside a module, such as nr-llm's provider or model lists, are not opened separately.

No step calls a language model, so the run needs no API key and makes no paid request. The run does not test what a model answers.

The organisation's `license-check.yml` additionally refuses SSPL, BSL and BUSL.

## Manual review status

The [release checklist](docs/release-checklist.md) lists the manual reviews for backend and frontend accessibility, provider data processing agreements and AI Act transparency. The [release notes](https://github.com/netresearch/typo3-ai-edition/releases) record which reviews were completed or skipped for each version.

For [1.0.0](https://github.com/netresearch/typo3-ai-edition/releases/tag/v1.0.0) and [1.1.0](https://github.com/netresearch/typo3-ai-edition/releases/tag/v1.1.0), the compatibility run passed. The accessibility, provider agreement and AI Act items were all unreviewed in both releases. A site operator still needs to assess the chosen providers, site configuration and editorial workflow.

The edition contains no accessibility overlay, by design: accessibility belongs in the source and the editorial process.

## Versioning

The edition follows [Semantic Versioning](https://semver.org/) on its own version number:

- **Major**: the supported TYPO3 LTS changes, or a member is removed.
- **Minor**: a member moves to a new minor version, or a member is added.
- **Patch**: a member's floor is raised within its minor (for example to require a security fix), or a `conflict` excludes a broken patch release.

## Contributing and security

See [CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md). A defect in one extension belongs in that extension's repository; this repository takes reports about the combination.

## License

GPL-2.0-or-later, see [LICENSE](LICENSE). Each member carries its own license, listed on its Packagist page.
