<?xml version="1.0"?>
<!--+
    | convert FILEMAKER XML export into LEXC format
    | cf. langs/sje/misc/00_README_FM2LEXC.txt for usage (local copy only)
    | Usage: java net.sf.saxon.Transform -it main STYLESHEET_NAME.xsl (inFile=INPUT_FILE_NAME.xml | inDir=INPUT_DIR)
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		xmlns:fmp="http://www.filemaker.com/fmpxmlresult"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		exclude-result-prefixes="xs local fmp ss">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
  <!-- Input -->
  <xsl:param name="inFileNameONLY" select="'fmp4lexc'"/>
  <xsl:param name="inFile" select="concat('../misc/',$inFileNameONLY,'.xml')"/>
  <xsl:param name="inDir" select="'xxxdirxxx'"/>
  <xsl:param name="XSLfile" select="base-uri(document(''))"/>
  
  <!-- Outputs -->
  <xsl:variable name="outDirXML" select="'outDirXML_Layouts'"/>
  <xsl:variable name="outDirTXT" select="'outDirTXT_Layouts'"/>
  <xsl:variable name="outDirLEXC" select="'outDirLEXC_Layouts'"/>
  <xsl:variable name="outputFileName" select="'sjeData'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_formatXML" select="'xml'"/>
  <xsl:variable name="output_formatTXT" select="'txt'"/>
  <xsl:variable name="output_formatLEXC" select="'txt'"/>
  <xsl:variable name="eXML" select="$output_formatXML"/>
  <xsl:variable name="eTXT" select="$output_formatTXT"/>
  <xsl:variable name="eLEXC" select="$output_formatLEXC"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/>
  <xsl:variable name="styleSheet_name" select="(tokenize($XSLfile, '/'))[last()]"/>
  <xsl:variable name="debug" select="true()"/>  

  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="currentDateString" select="substring(string(current-date()),1,10)"/>


  <!-- template to test if input DIR and FILE exist -->
  <xsl:template match="/" name="main">
    
    <xsl:if test="doc-available($inFile)">
      <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing file: ', $inFile)"/>
      </xsl:message>      

      <xsl:call-template name="processFile">
    	<xsl:with-param name="theFile" select="document($inFile)"/>
    	<xsl:with-param name="theName" select="$file_name"/>
      </xsl:call-template>
    </xsl:if>

    <!-- xsl:if test="doc-available($inDir)" -->
    <xsl:if test="not($inDir = 'xxxdirxxx')">
      <xsl:for-each select="for $f in collection(concat($inDir, '?select=*.xml')) return $f">
	
	<xsl:variable name="current_file" select="substring-before((tokenize(document-uri(.), '/'))[last()], '.xml')"/>
	<xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
	<xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
	
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('Processing file: ', $current_file)"/>
	</xsl:message>


	<xsl:call-template name="processFile">
	  <xsl:with-param name="theFile" select="."/>
	  <xsl:with-param name="theName" select="$current_file"/>
	</xsl:call-template>
      </xsl:for-each>
    </xsl:if>
    
    <xsl:if test="not(doc-available($inFile) or not($inDir = 'xxxdirxxx'))">
      <xsl:value-of select="concat('Could not find either ', $inFile, ' or ', $inDir, ', or both.', $nl)"/>
    </xsl:if>    
  </xsl:template>


  <!-- template to process file, once its existence has been determined -->
  <xsl:template name="processFile">
    <xsl:param name="theFile"/>
    <xsl:param name="theName"/>

      <!-- output document LEXC file(s) -->
      <xsl:result-document href="/Users/me/main/langs/sje/misc/{$outputFileName}.lexc" format="{$output_formatLEXC}">
      <xsl:variable name="apos">'</xsl:variable>
      <xsl:variable name="dq">"</xsl:variable>
      <xsl:variable name="acute">´</xsl:variable>

<!--+
    | special characters: 
    | double quotes " : &#34;
    | equals sign = : &#61;
    | semi-colon ; : &#59;
    | apostrophe/single quote ' : &#39;
    +-->

<!--+
    | 1. record number JW no JW
    | 2. Samica headword Unicode
    | 3. Samica PoS
    | 4. sje numSpell
    | 5. lexcRootLeft
    | 6. lexcRootRight stage2
    | 7. LEXC category
    | 8. Samica EN
    +-->

<!-- set original PoS (Swedish) variable -->
<xsl:variable name="PoS_Samica">
  <xsl:value-of select="$theFile/*:FMPXMLRESULT/*:RESULTSET/*:ROW[position()=1]/*:COL[position()=3]/*:DATA"/>
</xsl:variable>

<!-- set variable for PoS in English -->
<xsl:variable name="PoS">
  <xsl:choose>
  <xsl:when test="$PoS_Samica = 'subst'">
      <xsl:value-of select="'noun'"/>
  </xsl:when>
  <xsl:when test="$PoS_Samica = 'verb'">
      <xsl:value-of select="'verb'"/>
  </xsl:when>
  <xsl:otherwise>
      <xsl:value-of select="'unknown'"/>
  </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- set variable for LEXICON name -->
<xsl:variable name="LexName">
  <xsl:choose>
  <xsl:when test="$PoS = 'noun'">
      <xsl:value-of select="'Noun'"/>
  </xsl:when>
  <xsl:when test="$PoS = 'verb'">
      <xsl:value-of select="'Verb'"/>
  </xsl:when>
  <xsl:otherwise>
      <xsl:value-of select="'ERROR'"/>
  </xsl:otherwise>
  </xsl:choose>
</xsl:variable>


<!-- add header -->
<xsl:text>! Divvun &amp; Giellatekno - open source grammars for Sámi and other languages
! Copyright © 2000-2010 The University of Tromsø &amp; the Norwegian Sámi Parliament
! http://giellatekno.uit.no &amp; http://divvun.no
!
! This program is free software; you can redistribute and/or modify
! this file under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version. The GNU General Public License
! is found at http://www.gnu.org/licenses/gpl.html. It is
! also available in the file $GTHOME/LICENSE.txt.
!
! Other licensing options are available upon request, please contact
! giellatekno@hum.uit.no or feedback@divvun.no
!
! This LEXC file was created by Joshua Wilbur as an export of a Pite Saami lexcial database in FileMaker Pro. Translations and item numbers are from that database; see also http://saami.uni-freiburg.de/psdp/pite-lex/
! Timestamp: </xsl:text><xsl:value-of select="current-date(),current-time()"/><xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$PoS"/><xsl:text>s

LEXICON </xsl:text><xsl:value-of select="$LexName"/><xsl:text>   !!= * __@CODE@__ is the main lexicon

!! !!Mini-grammar
</xsl:text>

<!-- list LexC classes for each PoS (Mini-grammar) -->
<xsl:choose>
  <xsl:when test="$PoS = 'noun'">
<xsl:text>
! Even-syllable stem patterns:

!! * juällge: # all stems except -o-stems   N_EVEN
!! * iello: # -o-stems	                    N_EVEN_O

! Odd-syllable stem patterns:

!! * almatj: # -odd, closed second syllable, no CGrad               N_ODD
!! * biena: # -odd, open second syllable, has CGrad                 N_ODD_OPEN
!! * ålol: # -odd closed second syllable, CGrad, V2 alternation     N_ODD_VH
!! * vanas: # -odd, closed second syllable, CGrad                   N_ODD_WG

! Contracted stem patterns:

!! * ålmaj: # -contracted stem ending in -aj or -a: N_CONTR_AJA
!! * sarves: # -contracted stem ending in -es or -á: N_CONTR_ESA
!! * båtsoj: # -contracted stem ending in -oj or -u: N_CONTR_OJU
!! * suolo: # -contracted stem ending in -o or -u: N_CONTR_OU

</xsl:text>
  </xsl:when>
  <xsl:when test="$PoS = 'verb'">
<xsl:text>
! Even-syllable stem patterns:

!! * juällge: # all stems except -o-stems   N_EVEN
!! * iello: # -o-stems	                    N_EVEN_O

! Odd-syllable stem patterns:

!! * almatj: # -odd, closed second syllable, no CGrad               N_ODD
!! * vanas: # -odd, closed second syllable, CGrad                   N_ODD_WG
!! * ålol: # -odd closed second syllable, CGrad, V2 alternation     N_ODD_VH
!! * biena: # -odd, open second syllable, has CGrad                 N_ODD_OPEN

! Contracted stem patterns:
!! * ålmaj: # -contracted stem ending in -aj or -a: N_CONTR_AJA
!! * båtsoj: # -contracted stem ending in -oj or -u: N_CONTR_OJU
!! * sarves: # -contracted stem ending in -es or -á: N_CONTR_ESA

</xsl:text>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="'unknown'"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:value-of select="$nl"/>



<!-- insert data -->
    <xsl:for-each select="$theFile/*:FMPXMLRESULT/*:RESULTSET/*:ROW">
      <!-- sort for sje-alphabet -->
      <xsl:sort select="./*:COL[position()=7]/*:DATA"/>
      <xsl:sort select="./*:COL[position()=4]/*:DATA"/>
<xsl:value-of select="concat(./*:COL[position()=5]/*:DATA,':',./*:COL[position()=6]/*:DATA,' ',./*:COL[position()=7]/*:DATA,' ',$dq,./*:COL[position()=8]/*:DATA,$dq,' ; ! no. ',./*:COL[position()=1]/*:DATA,$nl)"/>
    </xsl:for-each>

      </xsl:result-document>
      
      <xsl:message terminate="no">
	<xsl:value-of select="concat('***Created lexc file: main/langs/sje/misc/',$outputFileName,'.lexc',$nl,'!!!!!!! Remember to update the actual lexc-file(s) in the relevant sje-DIRs!!')"/>
      </xsl:message>

    
  </xsl:template>
  
</xsl:stylesheet>

