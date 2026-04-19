#!/usr/bin/env bash
# Copies Sonic Pi .rb example songs into sonic-pi-examples/ for Docker volume mounting.
# Run this before 'docker compose up'. Source directories that don't exist are skipped.
# The destination directory is gitignored to avoid committing copyrighted material.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="$SCRIPT_DIR/sonic-pi-examples"

SONIC_PI_APP_DIR="${SONIC_PI_EXAMPLES_DIR:-/Applications/Sonic Pi.app/Contents/Resources/etc/examples}"
USER_SONGS_DIR="${SONIC_PI_USER_SONGS_DIR:-$HOME/code/sonicpi}"

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"

copy_rb_files() {
    local src="$1"
    local label="$2"

    if [ ! -d "$src" ]; then
        echo "Skipping $label (directory not found: $src)"
        return
    fi

    local count
    count=$(find "$src" -name "*.rb" -type f | wc -l | tr -d ' ')
    echo "Copying $count .rb files from $label ($src)"
    rsync -a --include='*/' --include='*.rb' --exclude='*' "$src/" "$DEST_DIR/$label/"
}

copy_rb_files "$SONIC_PI_APP_DIR" "sonic-pi-app"
copy_rb_files "$USER_SONGS_DIR" "user-songs"

total=$(find "$DEST_DIR" -name "*.rb" -type f | wc -l | tr -d ' ')
echo "Staged $total example songs in $DEST_DIR"
