<?xml version="1.0"?>
<!--+
    | stylesheet for converting FILEMAKER XML export into NDS (neahttadigisániid) format directly via FM-export
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

  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <!--xsl:variable name="currentDateString" select="substring(string(current-date()),1,10)"/-->



   <xsl:template match="@* | node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
   </xsl:template>


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

<!-- header -->
<r xmlns:xhtml="http://www.w3.org/1999/xhtml" id="smenob" xml:lang="sme">
   <lics xmlns:xhtml="http://www.w3.org/1999/xhtml" xml:space="preserve"><lic xml:lang="en">
This code is made available under a Creative Commons Attribution license
<a>http://creativecommons.org/licenses/by/3.0/no/deed.en</a>.

You are free to copy, distribute and adapt the work, as long as you always give
proper attribution using the attribution text below.

For the full license text, see the link above.</lic><ref>Work by Nils Jernsletten, Giellatekno and Divvun at UiT,
          and members of the language communities. Source code
          available at <a>https://victorio.uit.no/langtech/trunk/</a>.</ref><sourcenote>
     THIS TEXT IS THE ORIGINAL SOURCE CODE. This is NOT a fully styled and
     published dictionary. As such it can and
     will contain unfinished entries, unpublished entries, entries with
     objectionable translations, etc. If you find any errors, send your comments to
     <a>mailto:psdp@gmx.de</a> and/or <a>mailto:giellatekno@uit.no</a>.
     Please also note that the entries are not necessarily sorted,
     or could be wrongly sorted.
** This is a GENERATED FILE which means any changes you make manually will probably be overwritten later. This xml file was extracted from J. Wilbur's Pite Saami lexcial database (FileMaker Pro). Translations and item numbers are from that database; see also http://saami.uni-freiburg.de/psdp/pite-lex/
** Timestamp: <xsl:value-of select="concat(date:date-time(),$nl)"/>

</sourcenote></lics>

<!--+
	| export order:
	| 1 record nr JW
	| 2 headword
	| 3 pos
	| 4 numSpell
	| 5 EN
	| 6 SV
	| 7 NO
	| 8 note
	+-->

<!-- insert data -->
    <xsl:for-each select="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW">
      <!-- sort for sje-alphabet -->
      <xsl:sort select="./fm:COL[position()=3]/fm:DATA"/> <!-- pos -->
      <xsl:sort select="./fm:COL[position()=4]/fm:DATA"/> <!-- numSpell -->

<!-- set original PoS (Swedish) variable -->
<xsl:variable name="PoS_Samica">
  <xsl:value-of select="./fm:COL[position()=3]/fm:DATA"/>
</xsl:variable>

<!-- set variable for PoS for GT -->
<xsl:variable name="PoS">
  <xsl:choose>
  <xsl:when test="$PoS_Samica = 'subst'"><xsl:value-of select="'N'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'verb'"><xsl:value-of select="'V'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'adj'"><xsl:value-of select="'A'"/></xsl:when>
  <!--xsl:when test="$PoS_Samica = 'post'"><xsl:value-of select="'Po'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'adv'"><xsl:value-of select="'Adv'"/></xsl:when-->
  <xsl:when test="$PoS_Samica = 'egen'"><xsl:value-of select="'N'"/></xsl:when>
  <xsl:otherwise><xsl:value-of select="'unknown'"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- set variable for PoS subtype (such as for proper nouns) -->
<xsl:variable name="PoStype">
  <xsl:choose>
  <xsl:when test="$PoS_Samica = 'egen'"><xsl:value-of select="'Prop'"/></xsl:when>
  </xsl:choose>
</xsl:variable>



<!-- add data here -->
<e>
	<lg>
		<l>
			<xsl:attribute name="pos"><xsl:value-of select="$PoS"/></xsl:attribute>
			<xsl:if test="not($PoStype='')">
			<xsl:attribute name="type"><xsl:value-of select="$PoStype"/></xsl:attribute><!-- eg prop noun -->
			</xsl:if>
			<!-- psdp FMP record number -->
			<xsl:attribute name="psdpDBno"><xsl:value-of select="./fm:COL[position()=1]/fm:DATA"/></xsl:attribute>
			<xsl:value-of select="./fm:COL[position()=2]/fm:DATA"/>
		</l>
	</lg>
	<mg>
		<tg>
			<xsl:attribute name="xml:lang"><xsl:value-of select="'eng'"/></xsl:attribute>
			<t>
				<xsl:value-of select="./fm:COL[position()=5]/fm:DATA"/>
			</t>
		</tg>
		<tg>
			<xsl:attribute name="xml:lang"><xsl:value-of select="'swe'"/></xsl:attribute>
			<xsl:if test="not(./fm:COL[position()=8]/fm:DATA='')">
			<re>
				<xsl:value-of select="./fm:COL[position()=8]/fm:DATA"/>
			</re>
			</xsl:if>
			<t>
				<xsl:value-of select="./fm:COL[position()=6]/fm:DATA"/>
			</t>
		</tg>
		<tg>
			<xsl:attribute name="xml:lang"><xsl:value-of select="'nob'"/></xsl:attribute>
			<t>
				<xsl:value-of select="./fm:COL[position()=7]/fm:DATA"/>
			</t>
		</tg>
	</mg>
</e>

</xsl:for-each>

</r>

  </xsl:template>
  
</xsl:stylesheet>

