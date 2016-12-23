#!/bin/sh
zip -r org.doctales.terminology.zip . -x *.zip* *.git/* *temp/* *out/*
curl -LO https://github.com/dita-ot/dita-ot/releases/download/2.4.1/dita-ot-2.4.1.zip
unzip -q dita-ot-2.4.1.zip
mv dita-ot-*/ dita-ot/
chmod +x dita-ot/bin/dita
dita-ot/bin/dita -install org.doctales.terminology.zip
dita-ot/bin/dita -input dita-ot/plugins/org.doctales.terminology/samples/terminology.ditamap -format termchecker-dita -verbose -Dprocessing-mode=strict -Dargs.language=en-GB -o out/termchecker-dita
dita-ot/bin/dita -input dita-ot/plugins/org.doctales.terminology/samples/terminology.ditamap -format termchecker-xliff -verbose -Dprocessing-mode=strict -Dargs.language=en-GB -o out/termchecker-xliff
dita-ot/bin/dita -input dita-ot/plugins/org.doctales.terminology/samples/terminology.ditamap -format tbx-basic -verbose -Dprocessing-mode=strict -o out/tbx-basic
dita-ot/bin/dita -input dita-ot/plugins/org.doctales.terminology/samples/terminology.ditamap -format tbx-min -verbose -Dprocessing-mode=strict -Dargs.source.language=en-GB -Dargs.target.language=de-DE -o out/tbx-min
dita-ot/bin/dita -input dita-ot/plugins/org.doctales.terminology/samples/terminology.ditamap -format termbrowser-html5 -verbose -Dargs.default.language=en-GB -o out/termbrowser-html5