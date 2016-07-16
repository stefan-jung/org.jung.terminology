#!/bin/sh

rm org.doctales.terminology
rm -R dita-ot-2.3.1

zip -r org.doctales.terminology.zip . -x *.zip* *.git/* *temp/* *out/*
#zip -r org.doctales.terminology.zip .
#curl -LO https://github.com/dita-ot/dita-ot/releases/download/2.3.1/dita-ot-2.3.1.zip
unzip -q dita-ot-2.3.1.zip
chmod +x dita-ot-2.3.1/bin/dita
dita-ot-2.3.1/bin/dita -install org.doctales.terminology.zip
dita-ot-2.3.1/bin/dita -i dita-ot-2.3.1/plugins/org.doctales.terminology/samples/terminology.ditamap -f termchecker -Dargs.language=de-DE -o out/termchecker
dita-ot-2.3.1/bin/dita -i dita-ot-2.3.1/plugins/org.doctales.terminology/samples/terminology.ditamap -f tbx-basic -o out/tbx-basic
dita-ot-2.3.1/bin/dita -i dita-ot-2.3.1/plugins/org.doctales.terminology/samples/terminology.ditamap -f tbx-min -Dargs.source.language="en" -Dargs.target.language="de" -o out/tbx-min