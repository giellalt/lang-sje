<?xml version="1.0"?>
<!--+
    | stylesheet for converting FILEMAKER XML export into LEXC format directly via FM-export
    | created by J. Wilbur, Pite Saami Documentation Project
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:fm="http://www.filemaker.com/fmpxmlresult"
		xmlns:date="http://exslt.org/dates-and-times"
		exclude-result-prefixes="xs fm date">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <!--xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/-->
  
  <!-- Outputs -->
  <xsl:variable name="outDirXML" select="'outDirXML_Layouts'"/>
  <!--xsl:variable name="outDirTXT" select="'outDirTXT_Layouts'"/>
  <xsl:variable name="outDirLEXC" select="'outDirLEXC_Layouts'"/-->
  <xsl:variable name="outputFileName" select="'sjeGlosses'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_formatXML" select="'xml'"/>
  <!--xsl:variable name="output_formatTXT" select="'txt'"/>
  <xsl:variable name="output_formatLEXC" select="'txt'"/-->
  <xsl:variable name="eXML" select="$output_formatXML"/>
  <!--xsl:variable name="eTXT" select="$output_formatTXT"/>
  <xsl:variable name="eLEXC" select="$output_formatLEXC"/-->

  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <!--xsl:variable name="currentDateString" select="substring(string(current-date()),1,10)"/-->

  <xsl:template match="/" name="main">

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
    | 9. Samica SV
    |10. ELAN gloss (EN)
    +-->

<!-- set original PoS (Swedish) variable -->
<xsl:variable name="PoS_SamicaSV">
  <xsl:value-of select="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW[position()=1]/fm:COL[position()=3]/fm:DATA"/>
</xsl:variable>

<!-- set variable for PoS in English -->
<xsl:variable name="PoS_EN">
  <xsl:choose>
  <xsl:when test="$PoS_SamicaSV = 'subst'"><xsl:value-of select="'noun'"/></xsl:when>
  <xsl:when test="$PoS_SamicaSV = 'verb'"><xsl:value-of select="'verb'"/></xsl:when>
  <xsl:when test="$PoS_SamicaSV = 'adj'"><xsl:value-of select="'adj'"/></xsl:when>
  <xsl:when test="$PoS_SamicaSV = 'post'"><xsl:value-of select="'post'"/></xsl:when>
  <xsl:when test="$PoS_SamicaSV = 'adv'"><xsl:value-of select="'adv'"/></xsl:when>
  <xsl:otherwise><xsl:value-of select="'unknown'"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- set variable for LEXICON name -->
<xsl:variable name="LexName">
  <xsl:choose>
  <xsl:when test="$PoS_EN = 'noun'"><xsl:value-of select="'Noun'"/></xsl:when>
  <xsl:when test="$PoS_EN = 'verb'"><xsl:value-of select="'Verb'"/></xsl:when>
  <xsl:when test="$PoS_EN = 'adj'"><xsl:value-of select="'Adjective'"/></xsl:when>
  <xsl:when test="$PoS_EN = 'post'"><xsl:value-of select="'Postposition'"/></xsl:when>
  <xsl:when test="$PoS_EN = 'adv'"><xsl:value-of select="'Adverb'"/></xsl:when>
  <xsl:otherwise><xsl:value-of select="'ERROR'"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>




<!-- insert data -->
<ELAN_glosses>
    <xsl:for-each select="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW">
      <!-- sort for sje-alphabet -->
      <xsl:sort select="./fm:COL[position()=3]/fm:DATA"/><!-- pos -->
      <xsl:sort select="./fm:COL[position()=4]/fm:DATA"/><!-- num-spelling -->
    <!-- set variable for PoS in English -->
<xsl:variable name="PoS_Samica">
  <xsl:value-of select="./fm:COL[position()=3]/fm:DATA"/>
</xsl:variable>
    <xsl:variable name="PoS">
      <xsl:choose>
      <xsl:when test="$PoS_Samica = 'subst'"><xsl:value-of select="'noun'"/></xsl:when>
      <xsl:when test="$PoS_Samica = 'verb'"><xsl:value-of select="'verb'"/></xsl:when>
      <xsl:when test="$PoS_Samica = 'adj'"><xsl:value-of select="'adj'"/></xsl:when>
      <xsl:when test="$PoS_Samica = 'post'"><xsl:value-of select="'post'"/></xsl:when>
      <xsl:when test="$PoS_Samica = 'adv'"><xsl:value-of select="'adv'"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="'unknown'"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <sje>
  <xsl:attribute name="FMPid"><xsl:value-of select="./fm:COL[position()=1]/fm:DATA"/></xsl:attribute>
  <xsl:attribute name="pos"><xsl:value-of select="$PoS"/></xsl:attribute>
      <orth>
    <xsl:attribute name="numSpell"><xsl:value-of select="./fm:COL[position()=4]/fm:DATA"/></xsl:attribute>
    <xsl:value-of select="./fm:COL[position()=2]/fm:DATA"/>
      </orth>
      <lexcLeft>
    <xsl:value-of select="translate(./fm:COL[position()=5]/fm:DATA,'#','')"/><!-- translate for xsl-v1.0 (instead of replace) -->
      </lexcLeft>
      <glosses>
        <gloss>
          <xsl:attribute name="lang">eng</xsl:attribute>
          <xsl:attribute name="fullEN"><xsl:value-of select="./fm:COL[position()=8]/fm:DATA"/></xsl:attribute>
          <xsl:choose>
            <xsl:when test="./fm:COL[position()=10]/fm:DATA = ''">
              <xsl:value-of select="./fm:COL[position()=8]/fm:DATA"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="./fm:COL[position()=10]/fm:DATA"/>
            </xsl:otherwise>
          </xsl:choose>
        </gloss>
        <gloss>
          <xsl:attribute name="lang">swe</xsl:attribute>
          <xsl:value-of select="./fm:COL[position()=9]/fm:DATA"/>
        </gloss>
      </glosses>
    </sje>
    </xsl:for-each>
</ELAN_glosses>

</xsl:template>

</xsl:stylesheet>

