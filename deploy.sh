#!/bin/bash
# Deploy script for blog — uses cwRsync bundled binaries to avoid Windows
# compatibility issues with the Chocolatey shim (dup() in/out/err bug).
set -euo pipefail

CWRSYNCHOME="C:/ProgramData/chocolatey/lib/rsync/tools"
export PATH="$CWRSYNCHOME/bin:$PATH"

RSYNC="$CWRSYNCHOME/bin/rsync.exe"
SSH="$CWRSYNCHOME/bin/ssh.exe"

exec "$RSYNC" -avz --delete --exclude=.user.ini \
  -e "$SSH -o StrictHostKeyChecking=accept-new" \
  ./dist/ myserver:/www/wwwroot/panel_ssl_site
