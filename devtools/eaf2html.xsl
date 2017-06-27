<?xml version="1.0"?>
<!--+
    | stylesheet for converting FILEMAKER XML export into LEXC format directly via FM-export
    | created by J. Wilbur, Pite Saami Documentation Project
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:fm="http://www.filemaker.com/fmpxmlresult"
		xmlns:date="http://exslt.org/dates-and-times"
		xmlns:ext="http://exslt.org/common"
		exclude-result-prefixes="xs fm date xsi ext">


  <xsl:strip-space elements="*"/>
  
<!--  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <xsl:output method="xml" name="eaf"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
              -->
  <xsl:output method="html" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
  <!-- Outputs -->
  <xsl:variable name="outDirXML" select="'outDirXML_Layouts'"/>
  <xsl:variable name="outDirEAF" select="'outDirEAF_Layouts'"/>
  <xsl:variable name="outputFileName" select="'outputVersion'"/><!-- set output file name here -->
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_formatTXT" select="'txt'"/>
  <xsl:variable name="output_formatHTML" select="'html'"/>
  <xsl:variable name="output_formatXML" select="'xml'"/>
  <xsl:variable name="output_formatEAF" select="'xml'"/>
  <xsl:variable name="eTXT" select="$output_formatTXT"/>
  <xsl:variable name="eHTML" select="$output_formatHTML"/>
  <xsl:variable name="eXML" select="$output_formatXML"/>
  <xsl:variable name="eEAF" select="$output_formatEAF"/>

  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <!--xsl:variable name="currentDateString" select="substring(string(current-date()),1,10)"/-->


<xsl:template match="/">
  <xsl:result-document href="/Applications/MAMP/htdocs/PSDP/texter/{$outputFileName}.html" format="{$output_formatHTML}">

<html>
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="Pite Saami"/>
  <link href="../components/style_sami.css" rel="stylesheet" type="text/css"/>
  <link rel="shortcut icon" href="../components/farben4.gif"/>
</head>

<body>
<!-- sje original -->
<!--  <p style="margin:10px;">
  <xsl:for-each select="./ANNOTATION_DOCUMENT/TIER[./@TIER_ID='orth@EmFj']/ANNOTATION">
    <xsl:variable name="pos"><xsl:value-of select="position()"/></xsl:variable>
    <xsl:if test="not(./REF_ANNOTATION/ANNOTATION_VALUE='')"> 
        <xsl:value-of select="./REF_ANNOTATION/ANNOTATION_VALUE"/>
        <br/>
        <xsl:value-of select="$nl"/>
    </xsl:if>
  </xsl:for-each>
  </p>
  -->

<!-- sje linked original -->
  <p style="margin:10px;">
  <xsl:for-each select="./ANNOTATION_DOCUMENT/TIER[./@TIER_ID='orth@EmFj']/ANNOTATION">
    <xsl:variable name="utteranceLink"><xsl:value-of select="./REF_ANNOTATION/@ANNOTATION_ID"/></xsl:variable>
    <xsl:if test="not(./REF_ANNOTATION/ANNOTATION_VALUE='')"> <!-- ignore empty annotations -->
        <!--xsl:value-of select="concat($utteranceLink,' +++ ')"/-->
<!--        <xsl:for-each select="../../TIER[./@TIER_ID='word@EmFj']">
          <xsl:variable name="wordCount"><xsl:value-of select="count(./ANNOTATION/REF_ANNOTATION[@ANNOTATION_REF=$utteranceLink])"/></xsl:variable>
          <xsl:value-of select="concat('total words: ',$wordCount,' +++ ')"/>
        </xsl:for-each>-->
        <xsl:for-each select="../../TIER[./@TIER_ID='word@EmFj']/ANNOTATION/REF_ANNOTATION[@ANNOTATION_REF=$utteranceLink]">
          <xsl:variable name="annID"><xsl:value-of select="@ANNOTATION_ID"/></xsl:variable>
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('http://saami.uni-freiburg.de/psdp/pite-lex/simple_search.php?sje=',../../../TIER[@TIER_ID='lemma@EmFj']/ANNOTATION/REF_ANNOTATION[@ANNOTATION_REF=$annID]/ANNOTATION_VALUE,'&amp;lang=Swe&amp;searchMode=basic')"/>
            </xsl:attribute>
            <xsl:value-of select="./ANNOTATION_VALUE"/>
            <xsl:if test="not(position()=last())"><xsl:value-of select="' '"/></xsl:if>
            <xsl:if test="position()=last()"><xsl:value-of select="'.'"/></xsl:if>
          </xsl:element>
        </xsl:for-each>
        <br/>
        <xsl:value-of select="$nl"/>
    </xsl:if>
  </xsl:for-each>
  </p>

<!-- swe-translation -->
<!--  <p>
  <xsl:for-each select="./ANNOTATION_DOCUMENT/TIER[./@TIER_ID='ft-swe@EmFj']/ANNOTATION">
    <xsl:variable name="pos"><xsl:value-of select="position()"/></xsl:variable>
    <xsl:value-of select="concat(./REF_ANNOTATION/ANNOTATION_VALUE,$nl)"/>
  </xsl:for-each>
  </p>
      -->

</body>
</html>
  </xsl:result-document>
</xsl:template>

</xsl:stylesheet>

