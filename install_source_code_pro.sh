#!/bin/bash
set -euo pipefail

cleanup() {
  rm -rf "$DIR"
  echo 'Done installing source code pro!'
}

URL='https://github.com/adobe-fonts/source-code-pro/releases/download/2.030R-ro%2F1.050R-it/source-code-pro-2.030R-ro-1.050R-it.zip'
DIR="$( mktemp -d )"
ZIP="$DIR/sourcecodepro.zip"

trap cleanup EXIT

wget -O "$ZIP" "$URL"
unzip "$ZIP" -d "$DIR"
mkdir -p ~/.fonts
cp "$DIR"/*/OTF/*.otf ~/.fonts/
fc-cache -f -v
