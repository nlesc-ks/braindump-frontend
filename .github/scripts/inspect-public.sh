#!/usr/bin/env bash
# Dump everything we can learn about the built site, into the job summary.
# Usage: inspect-public.sh <label>
set -euo pipefail

label="${1:-public}"
cd public

emit() { printf '%s\n' "$*" >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"; }

emit "## Inspection: ${label}"
emit ""
emit "- files: $(find . -type f | wc -l)"
emit "- dirs: $(find . -type d | wc -l)"
emit "- bytes: $(du -sb . | cut -f1)"
emit ""

emit '<details><summary>case-insensitive collisions</summary>'
emit ""
emit '```'
find . -type f | tr 'A-Z' 'a-z' | sort | uniq -d >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}" || true
emit '```'
emit '</details>'
emit ""

emit '<details><summary>non-ASCII paths</summary>'
emit ""
emit '```'
find . -type f | LC_ALL=C grep '[^ -~]' >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}" || echo "(none)" >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
emit '```'
emit '</details>'
emit ""

emit '<details><summary>paths with doubled dots</summary>'
emit ""
emit '```'
find . -type f | grep -E '\.\.' >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}" || echo "(none)" >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
emit '```'
emit '</details>'
emit ""

emit '<details><summary>symlinks and non-regular files</summary>'
emit ""
emit '```'
find . ! -type f ! -type d >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}" || true
echo "(end)" >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
emit '```'
emit '</details>'
emit ""

emit '<details><summary>longest paths</summary>'
emit ""
emit '```'
find . -type f | awk '{ print length, $0 }' | sort -rn | head -10 >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
emit '```'
emit '</details>'
emit ""

emit '<details><summary>full listing with sizes</summary>'
emit ""
emit '```'
find . -type f -printf '%10s  %p\n' | sort -k2 >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
emit '```'
emit '</details>'

# Also echo the essentials to the plain log, so they are greppable via `gh run view --log`.
echo "=== ${label}: case-insensitive collisions ==="
find . -type f | tr 'A-Z' 'a-z' | sort | uniq -d || true
echo "=== ${label}: non-ASCII paths ==="
find . -type f | LC_ALL=C grep '[^ -~]' || echo "(none)"
echo "=== ${label}: doubled-dot paths ==="
find . -type f | grep -E '\.\.' || echo "(none)"
echo "=== ${label}: file count: $(find . -type f | wc -l) ==="
