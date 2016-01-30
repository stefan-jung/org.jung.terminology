#!/bin/sh
wget -c https://github.com/dita-ot/dita-ot/releases/download/2.2.2/dita-ot-2.2.2.tar.gz
tar -xf dita-ot-2.2.2.tar.gz
zip -r org.doctales.terminology.zip . -x "/dita-ot*" "*.zip" "*.xpr" "/.git*"
chmod +x dita-ot-2.2.2/bin/ant
chmod +x dita-ot-2.2.2/bin/dita
dita-ot-2.2.2/bin/dita -install org.doctales.terminology.zip
