![DOCTALES Logo](https://doctales.github.io/images/doctales-logo-without-subtitle.svg)

- - - -

org.doctales.terminology
========================

[![Build Status](https://travis-ci.org/doctales/org.doctales.terminology.svg?branch=master)](https://travis-ci.org/doctales/org.doctales.terminology)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

**org.doctales.terminology** is a plugin for the [DITA-OT](http://dita-ot.github.io) for creating a DITA-based terminology database.

- Create and change terms easily using specialized DITA topics (DTD/RNG). The new DITA `<termentry>` topic represents a single term. Terms are linked together to a terminology database using the `<termmap>` map.
- Author terms easily using an &lt;oXygen/&gt; XML framework with author mode stylesheets, that simplify the editing of `<termentry>` and `<termmap>` topics.
- Navigate through the terminology database with a classic or responsive terminology browser ([DEMO](https://doctales.github.io/samples/termbrowser-responsive/index.html)) based on the &lt;oXygen/&gt; webhelp transformation.
- Check DITA or XLIFF files with a Schematron based terminology checker.
- Export the terminology to *TBX-Basic* or *TBX-Min* for your Language Service Provider (LSP).

## Installation

**Prerequisites**

- DITA-OT 2.3.x, DITA-OT 2.4.x, DITA-OT 2.5.x or DITA-OT 3.x
- The termbrowser needs the [OOPS Consultancy XMLTask](http://www.oopsconsultancy.com/software/xmltask/) library on classpath. If this library is missing, you can provide it by installing the DITA-OT utility plugin [org.doctales.xmltask](https://github.com/doctales/org.doctales.xmltask). 
- &lt;oXygen/&gt; XML 18 or higher (optional)
- To use the Relax NG topics and maps, you need to install the **dita-relaxng-defaults** plugin.
  ```shell
  dita --install https://github.com/oxygenxml/dita-relaxng-defaults/archive/master.zip
  ```  

**Install the plugin**

Install the plugin with the [`dita` command](http://www.dita-ot.org/dev/parameters/dita-command-arguments.html).
```shell
dita --install https://github.com/doctales/org.doctales.terminology/archive/master.zip
```

**Install the &lt;oXygen/&gt; XML Framework**

1. In &lt;oXygen/&gt; open the menu `Options` > `Preferences`.
2. In the preferences, open `Document Type Association` > `Locations`.
3. Add the directory of the plugin in the DITA-OT as an additional framework directory, e.g. `/home/user/workspace/DITA/dita-ot/plugins/org.doctales.terminology`.

## Using the Plugin

Please refer to the [documentation](https://doctales.atlassian.net/wiki/display/TERM/org.doctales.terminology).

## Licenses

**org.doctales.terminology** is available under the [Apache Public License (APL) 2](https://www.apache.org/licenses/LICENSE-2.0). The plugin contains SVG flags taken from the [flag-icon-css](https://github.com/lipis/flag-icon-css) project, which is available under the [MIT license](https://opensource.org/licenses/MIT).

## Contribution

People that contribute to **org.doctales.terminology**:

* [Stefan Eike](https://de.linkedin.com/in/stefan-eike-a02a9939) - Development, DITA Specialization, Content Design
* [Sascha Nothofer](https://de.linkedin.com/in/sascha-nothofer-32563811a) - Content Design
* [Prof. Dr. Claudia Villiger](https://de.linkedin.com/in/claudia-villiger-6989b526) - Content Design
