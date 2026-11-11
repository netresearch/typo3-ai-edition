#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# SPDX-FileCopyrightText: Netresearch DTT GmbH
#
# Installs the edition into a fresh TYPO3 project and checks every member.
#
#   Build/Scripts/smoke-test.sh <work-dir>
#
# Environment:
#   EDITION_DIR     checkout of this repository (default: the script's repository)
#   EDITION_VERSION version the path repository reports for the checkout (default 1.0.0)
#   DEPS            highest | lowest  (lowest = every member at its floor)
#   WITH_SUGGESTED  1 = also install the suggested members
#   DB_HOST DB_PORT DB_NAME DB_USER DB_PASSWORD   MariaDB/MySQL to install into
#   HTTP_PORT       port of the built-in PHP server (default 8080)
#   REPORT_DIR      where versions.json and licenses.json are written (default <work-dir>/report)
#
# No step calls an LLM: the checks need no API key and make no paid request.
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
EDITION_DIR=${EDITION_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}
EDITION_VERSION=${EDITION_VERSION:-1.0.0}
DEPS=${DEPS:-highest}
WITH_SUGGESTED=${WITH_SUGGESTED:-0}
DB_HOST=${DB_HOST:-127.0.0.1}
DB_PORT=${DB_PORT:-3306}
DB_NAME=${DB_NAME:-typo3}
DB_USER=${DB_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-root}
HTTP_PORT=${HTTP_PORT:-8080}
ADMIN_USER='admin'
ADMIN_PASSWORD='Edition-Smoke-1!'

WORK_DIR=${1:?usage: smoke-test.sh <work-dir>}
mkdir -p "$WORK_DIR"
WORK_DIR=$(cd "$WORK_DIR" && pwd)
REPORT_DIR=${REPORT_DIR:-$WORK_DIR/report}
mkdir -p "$REPORT_DIR"
BASE_URL="http://127.0.0.1:${HTTP_PORT}"

failures=0
fail() { echo "::error::$*"; failures=$((failures + 1)); }
step() { echo; echo "=== $*"; }

# Members and the backend module identifier prefix each one registers. A member
# without a prefix registers no backend module; its check is the extension list.
# Keep in step with composer.json "require" (Build/Scripts/check-members.sh).
declare -A MODULE_PREFIX=(
    [netresearch/nr-llm]='nrllm_'
    [netresearch/nr-vault]='admin_vault'
    [netresearch/t3-cowriter]='cowriter_'
    [netresearch/nr-mcp-agent]='nr_mcp_agent_'
    [netresearch/nr-landingpage]='nr_landingpage'
    [netresearch/nr-repurpose]='web_nrrepurpose'
)
declare -A EXTENSION_KEY=(
    [netresearch/nr-llm]='nr_llm'
    [netresearch/nr-vault]='nr_vault'
    [netresearch/t3-cowriter]='t3_cowriter'
    [netresearch/nr-mcp-agent]='nr_mcp_agent'
    [netresearch/nr-landingpage]='nr_landingpage'
    [netresearch/nr-repurpose]='nr_repurpose'
    [netresearch/nr-llm-compat]='nr_llm_compat'
    [netresearch/nr-browser-ai]='nr_browser_ai'
)
SUGGESTED=(netresearch/nr-llm-compat netresearch/nr-browser-ai)

# --------------------------------------------------------------------------
step "Member lists of composer.json and this script agree"
# A member added to composer.json without a check here would be "tested" by
# nothing; a member removed there but still listed here would fail every run.
declared=$(jq -r '.require | keys[] | select(startswith("netresearch/"))' "$EDITION_DIR/composer.json" | sort)
checked=$(printf '%s\n' "${!MODULE_PREFIX[@]}" | sort)
if [ "$declared" != "$checked" ]; then
    diff <(echo "$declared") <(echo "$checked") || true
    fail "composer.json require (left) and MODULE_PREFIX in this script (right) differ"
fi
declared=$(jq -r '.suggest | keys[]' "$EDITION_DIR/composer.json" | sort)
checked=$(printf '%s\n' "${SUGGESTED[@]}" | sort)
if [ "$declared" != "$checked" ]; then
    fail "composer.json suggest and SUGGESTED in this script must list the same packages"
fi
# Every suggested member needs a conflict entry "<floor || >=next-minor" that
# fences it to its tested range. conflict may also hold entries for required
# members (a broken patch release excluded); those are not checked here.
for p in "${SUGGESTED[@]}"; do
    jq -e --arg p "$p" '.conflict[$p] // "" | test("^<[0-9]+\\.[0-9]+\\.[0-9]+ \\|\\| >=[0-9]+\\.[0-9]+\\.0$")' \
        "$EDITION_DIR/composer.json" > /dev/null \
        || fail "$p: composer.json conflict needs \"<X.Y.Z || >=X.(Y+1).0\" for the tested range"
done
[ "$failures" -eq 0 ] || exit 1

cd "$WORK_DIR"

# --------------------------------------------------------------------------
step "Create the project (deps=$DEPS, suggested=$WITH_SUGGESTED)"
require_extra=''
if [ "$WITH_SUGGESTED" = 1 ]; then
    # The edition's "conflict" section holds the tested range of each
    # suggested member; "*" lets Composer pick within it.
    for p in "${SUGGESTED[@]}"; do require_extra+=", \"$p\": \"*\""; done
fi
cat > composer.json <<JSON
{
    "name": "netresearch/typo3-ai-edition-smoke",
    "description": "Throw-away project for the edition smoke test",
    "type": "project",
    "license": "GPL-2.0-or-later",
    "repositories": [
        {
            "type": "path",
            "url": "${EDITION_DIR}",
            "options": {"symlink": false, "versions": {"netresearch/typo3-ai-edition": "${EDITION_VERSION}"}}
        }
    ],
    "require": {
        "netresearch/typo3-ai-edition": "${EDITION_VERSION}",
        "typo3/cms-backend": "*",
        "typo3/cms-extbase": "*",
        "typo3/cms-fluid": "*",
        "typo3/cms-frontend": "*",
        "typo3/cms-install": "*",
        "typo3/cms-rte-ckeditor": "*"${require_extra}
    },
    "config": {
        "allow-plugins": {
            "typo3/class-alias-loader": true,
            "typo3/cms-composer-installers": true,
            "php-http/discovery": true
        },
        "sort-packages": true
    },
    "minimum-stability": "stable",
    "prefer-stable": true
}
JSON
if [ "$DEPS" = lowest ]; then
    # Every member at the floor of its range ("~0.43.23" -> 0.43.23, the
    # suggested ones from "<0.8.0 || >=0.9.0" -> 0.8.0). Everything else
    # resolves as for a user: Composer's --prefer-lowest would also drag
    # third-party libraries to floors no real install gets, and those fail
    # for reasons unrelated to the edition.
    mapfile -t floors < <(jq -r '. as $c |
        (.require | to_entries[] | select(.key | startswith("netresearch/")) | "\(.key):\(.value | ltrimstr("~"))"),
        (.suggest | keys[] as $k | "\($k):\($c.conflict[$k] | capture("^<(?<v>[0-9.]+)").v)")' "$EDITION_DIR/composer.json")
    pins=()
    for f in "${floors[@]}"; do
        if [ "$WITH_SUGGESTED" != 1 ] && grep -q -x -F -- "${f%%:*}" <<<"$(printf '%s\n' "${SUGGESTED[@]}")"; then continue; fi
        echo "  floor $f"
        pins+=("$f")
    done
    composer require --no-update --no-interaction "${pins[@]}"
fi
composer update --no-interaction --no-progress --prefer-dist

# --------------------------------------------------------------------------
step "Installed member versions"
members=("${!MODULE_PREFIX[@]}")
if [ "$WITH_SUGGESTED" = 1 ]; then members+=("${SUGGESTED[@]}"); fi
composer show --format=json > "$REPORT_DIR/installed.json"
jq --argjson m "$(printf '%s\n' "${members[@]}" typo3/cms-core | jq -R . | jq -s .)" \
    '[.installed[] | select(.name as $n | $m | index($n)) | {name, version}] | sort_by(.name)' \
    "$REPORT_DIR/installed.json" > "$REPORT_DIR/versions.json"
jq -r '.[] | "  \(.name) \(.version)"' "$REPORT_DIR/versions.json"
for p in "${members[@]}"; do
    jq -e --arg p "$p" 'any(.[]; .name == $p)' "$REPORT_DIR/versions.json" > /dev/null \
        || fail "$p is not installed"
done

# --------------------------------------------------------------------------
step "License check (allowlist, Build/license-allowlist.txt)"
composer licenses --format=json > "$REPORT_DIR/licenses.json"
allow=$(grep -v -E '^\s*(#|$)' "$EDITION_DIR/Build/license-allowlist.txt" | jq -R . | jq -s .)
# A package passes when at least one of its licenses is allowed (a disjunctive
# expression offers a choice). A package with no license at all fails.
bad=$(jq -r --argjson allow "$allow" '
    .dependencies | to_entries[]
    | select((.value.license | length) == 0 or ([.value.license[] | select(. as $l | $allow | index($l))] | length) == 0)
    | "\(.key) \(.value.version) \(.value.license | join(" OR "))"' "$REPORT_DIR/licenses.json")
if [ -n "$bad" ]; then
    while IFS= read -r line; do fail "license not on the allowlist: $line"; done <<<"$bad"
else
    echo "  $(jq '.dependencies | length' "$REPORT_DIR/licenses.json") packages, every one on the allowlist"
fi

# --------------------------------------------------------------------------
step "TYPO3 setup and extension:setup"
# typo3 setup needs a DB connection array while it builds the container
# (same workaround as typo3-ci-workflows e2e.yml); --force overwrites it.
mkdir -p config/system
cat > config/system/settings.php <<PHP
<?php
return ['DB' => ['Connections' => ['Default' => ['driver' => 'mysqli', 'host' => '${DB_HOST}', 'port' => ${DB_PORT}, 'dbname' => '${DB_NAME}', 'user' => '${DB_USER}', 'password' => '${DB_PASSWORD}', 'charset' => 'utf8mb4']]], 'SYS' => ['encryptionKey' => 'placeholder-overwritten-by-typo3-setup']];
PHP
export TYPO3_CONTEXT=Development
vendor/bin/typo3 setup --driver=mysqli --host="$DB_HOST" --port="$DB_PORT" --dbname="$DB_NAME" \
    --username="$DB_USER" --password="$DB_PASSWORD" \
    --admin-username="$ADMIN_USER" --admin-user-password="$ADMIN_PASSWORD" --admin-email=admin@example.com \
    --project-name='TYPO3 AI Edition smoke test' --server-type=other --no-interaction --force
vendor/bin/typo3 extension:setup --no-interaction

step "Members are active extensions"
vendor/bin/typo3 extension:list --raw > "$REPORT_DIR/extensions.txt" 2>/dev/null \
    || vendor/bin/typo3 extension:list > "$REPORT_DIR/extensions.txt"
for p in "${members[@]}"; do
    key=${EXTENSION_KEY[$p]}
    if grep -q -w -- "$key" "$REPORT_DIR/extensions.txt"; then echo "  $key active"; else fail "$p ($key) is not an active extension"; fi
done

# --------------------------------------------------------------------------
step "nr-llm: a provider, model and configuration can be created"
vendor/bin/typo3 nrllm:demo:seed --days=0 --no-interaction
db() { php -r '
    $c = require "config/system/settings.php"; $d = $c["DB"]["Connections"]["Default"];
    $m = new mysqli($d["host"], $d["user"], $d["password"], $d["dbname"], (int)$d["port"]);
    echo $m->query($argv[1])->fetch_row()[0];' -- "$1"; }
for t in tx_nrllm_provider tx_nrllm_model tx_nrllm_configuration; do
    n=$(db "SELECT COUNT(*) FROM $t WHERE deleted = 0")
    if [ "$n" -gt 0 ]; then echo "  $t: $n row(s)"; else fail "$t is empty after nrllm:demo:seed"; fi
done

# --------------------------------------------------------------------------
step "Backend: log in and open every module of every member"
cat > "$WORK_DIR/router.php" <<'PHP'
<?php
$uri = urldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
$path = $_SERVER['DOCUMENT_ROOT'] . $uri;
if ($uri !== '/' && is_file($path)) {
    return false;
}
$_SERVER['SCRIPT_NAME'] = '/index.php';
require $_SERVER['DOCUMENT_ROOT'] . '/index.php';
PHP
cat > config/system/additional.php <<PHP
<?php
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = '.*';
\$GLOBALS['TYPO3_CONF_VARS']['BE']['cookieSecure'] = 0;
PHP
php -d opcache.jit=disable -S "127.0.0.1:${HTTP_PORT}" -t public "$WORK_DIR/router.php" > "$REPORT_DIR/php-server.log" 2>&1 &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true' EXIT
for _ in $(seq 1 30); do curl -sf -o /dev/null "$BASE_URL/typo3/login" && break; sleep 1; done

jar="$WORK_DIR/cookies.txt"
rm -f "$jar"
# TYPO3 answers a backend request without a same-origin Referer with an
# interstitial page that reloads itself, so every request below sends one.
curl -sS -c "$jar" -b "$jar" -o "$WORK_DIR/login.html" "$BASE_URL/typo3/login"
token=$(php -r 'preg_match("/name=\"__RequestToken\"\\s+value=\"([^\"]+)\"/", file_get_contents($argv[1]), $m); echo $m[1] ?? "";' -- "$WORK_DIR/login.html")
[ -n "$token" ] || { fail "login form carries no __RequestToken"; exit 1; }
# A successful login redirects to /typo3/main?token=...; -L follows it, so
# main.html is the backend main page with its module menu.
curl -sS -L -c "$jar" -b "$jar" -e "$BASE_URL/typo3/login" -o "$WORK_DIR/main.html" \
    --data-urlencode "login_status=login" --data-urlencode "username=$ADMIN_USER" \
    --data-urlencode "userident=$ADMIN_PASSWORD" --data-urlencode "__RequestToken=$token" \
    "$BASE_URL/typo3/login"
if grep -q 'typo3-login-form' "$WORK_DIR/main.html"; then
    fail "backend login failed"; exit 1
fi

# The module menu lists every module the user may open, with its URL. A member
# whose prefix matches nothing there has not registered its module, which
# fails on its own.
php -r '
    $html = file_get_contents($argv[1]);
    preg_match_all("/<a\\s[^>]*>/s", $html, $tags);
    foreach ($tags[0] as $tag) {
        if (preg_match("/data-modulemenu-identifier=\"([^\"]+)\"/", $tag, $id) && preg_match("/href=\"([^\"]+)\"/", $tag, $href)) {
            echo $id[1], " ", html_entity_decode($href[1]), "\n";
        }
    }
' -- "$WORK_DIR/main.html" | sort -u > "$REPORT_DIR/modules.txt"
echo "  $(wc -l < "$REPORT_DIR/modules.txt") module(s) in the menu"
# Control: a core module must be found the same way, or the parser is broken
# and every "no module" verdict below would be meaningless.
grep -q '^web_layout ' "$REPORT_DIR/modules.txt" || { fail "menu parser found no core module (web_layout)"; exit 1; }

# The marker each module page must contain. TYPO3's ModuleTemplate writes
# data-module-name="<identifier>" into the body; a module rendering its own
# page without ModuleTemplate gets an explicit marker here.
declare -A MODULE_MARKER=(
    [nr_landingpage]='<h1 class="mb-2">Landing Pages'
)

for p in "${!MODULE_PREFIX[@]}"; do
    prefix=${MODULE_PREFIX[$p]}
    mapfile -t mods < <(awk -v pre="$prefix" 'index($1, pre) == 1' "$REPORT_DIR/modules.txt")
    if [ "${#mods[@]}" -eq 0 ]; then fail "$p: no backend module with prefix '$prefix' in the menu"; continue; fi
    for line in "${mods[@]}"; do
        id=${line%% *}; href=${line#* }
        case "$href" in http*) url=$href ;; *) url="$BASE_URL$href" ;; esac
        out="$WORK_DIR/module-$id.html"
        code=$(curl -sS -L -b "$jar" -e "$BASE_URL/typo3/main" -o "$out" -w '%{http_code}' "$url")
        if [ "$code" != 200 ]; then fail "$p: module $id answered HTTP $code"; continue; fi
        if grep -q 'typo3-login-form' "$out"; then fail "$p: module $id showed the login form"; continue; fi
        if grep -q -E 'Oops, an error occurred|<title>TYPO3 Exception' "$out"; then
            fail "$p: module $id rendered an error page"; continue
        fi
        marker=${MODULE_MARKER[$id]:-data-module-name=\"$id\"}
        if ! grep -q -F -- "$marker" "$out"; then
            fail "$p: module $id returned a page without its marker ($marker)"; continue
        fi
        echo "  $p: $id OK"
    done
done

if grep -q -E 'PHP (Fatal|Warning)' "$REPORT_DIR/php-server.log"; then
    grep -E 'PHP (Fatal|Warning)' "$REPORT_DIR/php-server.log" | head -20
    fail "the PHP server logged fatal errors or warnings"
fi

echo
if [ "$failures" -gt 0 ]; then
    echo "$failures check(s) failed"
    exit 1
fi
echo "All checks passed"
