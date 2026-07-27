#!/usr/bin/env bash
set -euo pipefail

base_url="${1:?usage: tests/smoke.sh https://your-buzz-domain}"
base_url="${base_url%/}"

curl --fail --silent --show-error --retry 10 --retry-delay 3 "${base_url}/_liveness"
curl --fail --silent --show-error --retry 10 --retry-delay 3 "${base_url}/_readiness"
curl --fail --silent --show-error --retry 10 --retry-delay 3 "${base_url}/" | grep -qi 'buzz'

printf 'Buzz HTTP smoke checks passed for %s
' "$base_url"
