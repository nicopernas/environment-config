#!/bin/bash

set -u -e

dir="$( mktemp -d )"
zip="/tmp/sourcecodepro.zip"
wget -O "$zip" https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
unzip "$zip" -d "$dir"
mkdir -p ~/.fonts
cp "$dir"/*/OTF/*.otf ~/.fonts/
fc-cache -f -v
rm -rf "$zip" "$dir"
echo 'done installing source code pro!'
