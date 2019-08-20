#!/bin/sh
zip -r org.doctales.terminology.zip . -x *.zip* *.git/* *temp/* *out/*

# DITA-OT 2.5.4
curl -LO https://github.com/dita-ot/dita-ot/releases/download/2.5.4/dita-ot-2.5.4.zip
unzip -q dita-ot-2.5.4.zip
chmod +x dita-ot-2.5.4/bin/ant
chmod +x dita-ot-2.5.4/bin/dita
dita-ot-2.5.4/bin/dita --install https://github.com/oxygenxml/dita-relaxng-defaults/archive/master.zip
dita-ot-2.5.4/bin/dita --install https://github.com/doctales/org.doctales.xmltask/archive/master.zip
dita-ot-2.5.4/bin/dita --install org.doctales.terminology.zip
dita-ot-2.5.4/bin/dita --input dita-ot-2.5.4/plugins/org.doctales.terminology/samples/terminology.ditamap --format termchecker-dita -Dprocessing-mode=strict -Dargs.language=en-GB --output out/termchecker-dita --verbose
dita-ot-2.5.4/bin/dita --input dita-ot-2.5.4/plugins/org.doctales.terminology/samples/terminology.ditamap --format termchecker-xliff -Dprocessing-mode=strict -Dargs.language=en-GB -Dargs.check.elements=both --output out/termchecker-xliff --verbose
dita-ot-2.5.4/bin/dita --input dita-ot-2.5.4/plugins/org.doctales.terminology/samples/terminology.ditamap --format tbx-basic -Dprocessing-mode=strict --output out/tbx-basic --verbose
dita-ot-2.5.4/bin/dita --input dita-ot-2.5.4/plugins/org.doctales.terminology/samples/terminology.ditamap --format tbx-min -Dprocessing-mode=strict -Dargs.source.language=en-GB -Dargs.target.language=de-DE --output out/tbx-min --verbose
dita-ot-2.5.4/bin/dita --input dita-ot-2.5.4/plugins/org.doctales.terminology/samples/terminology.ditamap --format termbrowser-html5 -Dargs.default.language=en-GB --output out/termbrowser-html5 --verbose

# DITA-OT 3.3.3
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.3.3/dita-ot-3.3.3.zip
unzip -q dita-ot-3.3.3.zip
chmod +x dita-ot-3.3.3/bin/ant
chmod +x dita-ot-3.3.3/bin/dita
dita-ot-3.3.3/bin/dita --install https://github.com/oxygenxml/dita-relaxng-defaults/archive/master.zip
dita-ot-3.3.3/bin/dita --install https://github.com/doctales/org.doctales.xmltask/archive/master.zip
dita-ot-3.3.3/bin/dita --install org.doctales.terminology.zip
dita-ot-3.3.3/bin/dita --input dita-ot-3.3.3/plugins/org.doctales.terminology/samples/terminology.ditamap --format termchecker-dita -Dprocessing-mode=strict -Dargs.language=en-GB --output out/termchecker-dita --verbose
dita-ot-3.3.3/bin/dita --input dita-ot-3.3.3/plugins/org.doctales.terminology/samples/terminology.ditamap --format termchecker-xliff -Dprocessing-mode=strict -Dargs.language=en-GB -Dargs.check.elements=both --output out/termchecker-xliff --verbose
dita-ot-3.3.3/bin/dita --input dita-ot-3.3.3/plugins/org.doctales.terminology/samples/terminology.ditamap --format tbx-basic -Dprocessing-mode=strict --output out/tbx-basic --verbose
dita-ot-3.3.3/bin/dita --input dita-ot-3.3.3/plugins/org.doctales.terminology/samples/terminology.ditamap --format tbx-min -Dprocessing-mode=strict -Dargs.source.language=en-GB -Dargs.target.language=de-DE --output out/tbx-min --verbose
dita-ot-3.3.3/bin/dita --input dita-ot-3.3.3/plugins/org.doctales.terminology/samples/terminology.ditamap --format termbrowser-html5 -Dargs.default.language=en-GB --output out/termbrowser-html5 --verbose
