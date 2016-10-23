![DOCTALES Logo](https://doctales.github.io/images/doctales-logo-without-subtitle.svg)

- - - -

org.doctales.terminology
========================

[![Build Status](https://travis-ci.org/doctales/org.doctales.terminology.svg?branch=master)](https://travis-ci.org/doctales/org.doctales.terminology)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

**org.doctales.terminology** is a plugin for the [DITA-OT](http://dita-ot.github.io) for creating a DITA-based terminology database.

- Create and change terms easily using specialized DITA topics. The new DITA `<termentry>` topic represents a single term. Terms are linked together to a terminology database using the `<termmap>` map.
- Author terms easily using an &lt;oXygen/&gt; XML framework with author mode stylesheets, that simplify the editing of `<termentry>` and `<termmap>` topics.
- Navigate through the terminology database with a classic or responsive terminology browser based on the &lt;oXygen/&gt; webhelp transformation.
- Check DITA or XLIFF files with a Schematron based terminology checker.
- Export the terminology to *TBX-Basic* or *TBX-Min* for your Language Service Provider (LSP).

> **Table of Contents**
>
> * [Installation](#installation)
> * [Install Framework](#install-framework)
>   * [Activate &lt;oXygen/&gt; Author Mode Stylesheet](#activate-oxygen-author-mode-stylesheet)
> * [Usage](#usage)
>   * [DITA Termbrowser](#dita-termbrowser)
>   * [DITA Termchecker](#dita-termchecker)
>   * [TBX](#tbx)
> * [Contribution](#contribution)

### Installation

**Prerequisites**

- DITA-OT 2.3 or higher
- &lt;oXygen/&gt; XML 18 or higher (optional)

You can install the plugin to the DITA-OT with the following command:

```shell
dita -install https://github.com/doctales/org.doctales.terminology/archive/master.zip
```


### Install &lt;oXygen/&gt; Framework

1. In &lt;oXygen/&gt; open the menu `Options` > `Preferences`.
2. In the preferences, open `Document Type Association` > `Locations`.
3. Add the directory of the plugin.
   ![framework](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/framework.png)

The framework contains &lt;oXygen/&gt; XML author mode stylesheets that simplify the editing of `<termentry>` and `<termmap>` topics. The stylesheet is available in the following languages:

- English
- German


#### Example

The following code snippet shows the sample file `truck.dita`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE termentry PUBLIC "-//DOCTALES//DTD DITA DOCTALES Termentry//EN" "termentry.dtd">
<termentry id="truck">
  <title>Truck</title>
  <definition>
    <definitionText>A truck is a motor vehicle designed to transport cargo.</definitionText>
    <definitionSource>
      <sourceReference href="https://en.wikipedia.org/wiki/Truck"
                       format="html"
                       scope="external">
        Wikipedia
      </sourceReference>
    </definitionSource>
  </definition>
  <termBody>
    <fullForm language="de-DE" usage="preferred">
      <termVariant>Lastkraftwagen</termVariant>
    </fullForm>
    <acronym language="de-DE" usage="preferred">
      <termVariant>LKW</termVariant>
    </acronym>
    <fullForm usage="preferred" language="en-US">
      <termVariant>truck</termVariant>
    </fullForm>
    <fullForm language="en-GB" usage="notRecommended">
      <termVariant>truck</termVariant>
    </fullForm>
    <fullForm usage="preferred" language="en-GB">
      <termVariant>lorry</termVariant>
    </fullForm>
  </termBody>
  <relations>
    <relatedTerms>
      <relatedTerm keyref="car"/>
    </relatedTerms>
  </relations>
</termentry>
```

The screenshot shows the same file rendered with the &lt;oXygen/&gt; XML author mode stylesheet.

![author-mode](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/author-mode.png)


#### Activate &lt;oXygen/&gt; Author Mode Stylesheet

Choose the style **DOCTALES Termentry** in the **Styles** menu.<br/>
![author-mode](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/styles-menu.png)


### Usage

**org.doctales.terminology** ships a few sample files, that show you how to create terms and create the various outputs. To test the transformations, just open the `terminology.ditamap` in the &lt;oXygen/&gt; DITA Maps Manager and run a transformation scenario.


#### DITA Termbrowser

The DITA Termbrowser is based on the &lt;oXygen/&gt; plugin **com.oxygenxml.webhelp** and is used to browse through the terminology database.

![DITA Termbrowser](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/termbrowser.png)

#### DITA Termchecker

The DITA Termchecker is technically a [Schematron](http://www.schematron.com) file, that searches for not recommended terms and replaces them with preferred synonyms..

1. Open the samples DITA map `~/org.doctales.terminology/samples/terminology.ditamap` in the &lt;oXygen/&gt; DITA Maps Manager.
2. In the `Transformation Scenarios` view, double click the entry `Termchecker for DITA`.<br/>
   ![Transformation Scenario Termchecker for DITA](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/termchecker-dita-transformation-scenario.png)<br/>
   The terminology is transformed to the Schematron file `~/out/termchecker-dita/terminology-DITA-en-GB.sch`.
   By default, the terminology checker is generated for British English (`en-GB`).
   If you want to generate the terminology checker for another language, you have to change the parameter `args.language` of the transformation scenario.
3. Create a new DITA validation scenario and refer to the generated Schematron file.
   1. In &lt;oXygen/&gt; open the menu `Options` > `Preferences`.
   2. In the `Document Type Association` menu, select the `DITA` document type association and click the button `Edit`.
   3. Open the `Validation` tab and click the **+** button, to create a new validation scenario.
   4. Create a new validation scenario named `Terminology` and specify the Schematron schema.<br/>
      ![Specify DITA Termchecker Schematron Schema](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/specify-schema-termchecker-dita.png)<br/>
      ![Create new DITA validation scenario](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/termchecker-dita-new-scenario.png)<br/>
      ![DITA Document Type Association](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/termchecker-dita-document-type.png)<br/>
4. Create a new DITA topic.
5. Set the `xml:lang` attribute of the topic to `en-GB` and write the word `truck` somewhere in the topic.<br/>
   The term violation is indicated with a small lamp icon ![Lamp icon](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/images/icon-lamp.png).
   Click on the lamp select the `Replace with an allowed term` action.
   This works both in text and in author mode.<br/>
   ![DITA term replacement author view](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/animations/dita-term-replacement-author-view.gif)<br/>
   ![DITA term replacement text view](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/animations/dita-term-replacement-text-view.gif)<br/>
   The deprecated term has been replaced.

**Explanation**

The deprecated and the allowed term notations are defined in the `truck.dita` file.

```xml
<fullForm usage="notRecommended" language="en-GB">
  <termVariant>truck</termVariant>
</fullForm>
<fullForm usage="preferred" language="en-GB">
  <termVariant>lorry</termVariant>
</fullForm>
```

> **Note**
>
> You can also generate the Schematron file using the `dita` command:
>
> ```bash
> dita -i terminology.ditamap -f termchecker-dita -Dargs.language=en-GB -o termchecker-dita
> ```


#### TBX

The transformation scenarios `TBX-Basic` and `TBX-Min` transform the terminology to a TBX-Basic/TBX-Min file. A TBX (TermBase eXchange) file is a file format for exchanging terminology. You can send this file to a language service provider to make sure, that the translator uses the correct terminology during translation.


### Contribution

If you want to support **org.doctales.terminology**, you can:

* Use the plugin
* Give feedback and submit bug reports
* Translate frameworks and term samples
* Send pull requests
* Ask for professional support and training

People that contribute to **org.doctales.terminology**:

* [Stefan Eike](https://de.linkedin.com/in/stefan-eike-a02a9939) - Development, DITA Specialization, Content Design
* [Sascha Nothofer](https://de.linkedin.com/in/sascha-nothofer-32563811a) - Content Design
* [Prof. Dr. Claudia Villiger](https://de.linkedin.com/in/claudia-villiger-6989b526) - Content Design
