#!/bin/bash -e

tmp=`mktemp -d`
cd $tmp
wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.tar.gz
tar zxvf 1.030R-it.tar.gz
mkdir -p ~/.fonts
cp source-code-pro*/OTF/*.otf ~/.fonts/
fc-cache -f -v
cd -
rm -rf $tmp
