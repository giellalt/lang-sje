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

<!-- add GT xml stylesheets to header (no idea why; appeared v18.06.2024) -->
<xsl:processing-instruction name="xml-stylesheet">
  <xsl:text>media="screen"              title="Dictionary view"   href="../../giella-core/dicts/scripts/gt_dictionary_XXE.css"     type="text/css"</xsl:text>
</xsl:processing-instruction>
<xsl:value-of select="$nl"/>
<xsl:processing-instruction name="xml-stylesheet">
  <xsl:text>media="screen"              title="Hierarchical view" href="../../giella-core/dicts/scripts/gt_dictionary_XXE_alt.css" type="text/css" alternate="yes" </xsl:text>
</xsl:processing-instruction>
<xsl:value-of select="$nl"/>
<xsl:processing-instruction name="xml-stylesheet">
  <xsl:text>media="print,tv,projection" title="Dictionary view"   href="../../giella-core/dicts/scripts/gt_dictionary.css"         type="text/css"</xsl:text>
</xsl:processing-instruction>
<xsl:value-of select="$nl"/>
<xsl:processing-instruction name="xml-stylesheet">
  <xsl:text>media="print,tv,projection" title="Hierarchical view" href="../../giella-core/dicts/scripts/gt_dictionary_alt.css"     type="text/css" alternate="yes" </xsl:text>
</xsl:processing-instruction>
<xsl:value-of select="$nl"/>


<!-- header -->
<r xmlns:xhtml="http://www.w3.org/1999/xhtml" id="smenob" xml:lang="sme">
   <lics xmlns:xhtml="http://www.w3.org/1999/xhtml" xml:space="preserve"><lic xml:lang="en">
This code is made available under a Creative Commons Attribution license
<a>http://creativecommons.org/licenses/by/3.0/no/deed.en</a>.

You are free to copy, distribute and adapt the work, as long as you always give
proper attribution using the attribution text below.

For the full license text, see the link above.</lic><ref>Lexicographic work done by 
	 Nils-Henrik Bengtsson, Marianne Eriksson, Inger Fjällås, Eva-Karin Rosenberg, Gry Helen Sivertsen, Valborg Sjaggo, Dagny Skaile, Peter Steggo, Olve Utne and Joshua Wilbur.
	 With technical support from Giellatekno at UiT. 
	 Source code available at <a>https://victorio.uit.no/langtech/trunk/</a>.</ref><sourcenote>
     THIS TEXT IS THE ORIGINAL SOURCE CODE. This is NOT a fully styled and
     published dictionary. As such it can and
     will contain unfinished entries, unpublished entries, entries with
     objectionable translations, etc. If you find any errors, send your comments to
     <a>mailto:psdp@gmx.de</a> and/or <a>mailto:giellatekno@uit.no</a>.
     Please also note that the entries are not necessarily sorted,
     or could be wrongly sorted.
** This is a GENERATED FILE which means any changes you make manually will probably be overwritten later. This xml file was extracted from Joshua Wilbur's Pite Saami lexcial database (FileMaker Pro). Translations and item numbers are from that database; see also https://sjelex.keeleressursid.ee
** Generated at: <xsl:value-of select="concat(date:date-time(),$nl)"/>

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

<!-- add copula and negation verbs, but only for verb export -->
<xsl:if test="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW/fm:COL[position()=3]/fm:DATA='verb'">
<e>
    <lg>
    	<l pos="V" psdpDBno="2340">lä</l>
    </lg>
    <mg>
    	<tg xml:lang="eng">
    		<t>be</t>
    	</tg>
    	<tg xml:lang="swe">
    		<t>vara</t>
    	</tg>
    	<tg xml:lang="nob">
    		<t>være</t>
    	</tg>
    </mg>
</e>
<e>
	<lg>
		<l context="manne" pos="V" psdpDBno="6233">ij</l>
		<analysis>Neg_Prs_Sg3</analysis>
		<mini_paradigm>
			<analysis ms="Neg_Prs_Sg1">
				<wordform>iv</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Sg2">
				<wordform>i</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Sg3">
				<wordform>ij</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Du1">
				<wordform>en</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Du2">
				<wordform>ehpen</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Du3">
				<wordform>iebá</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Pl1">
				<wordform>iehpe</wordform>
				<wordform>ep</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Pl2">
				<wordform>ehpit</wordform>
			</analysis>
			<analysis ms="Neg_Prs_Pl3">
				<wordform>e</wordform>
				<wordform>ie</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Sg1">
				<wordform>idtjiv</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Sg2">
				<wordform>idtji</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Sg3">
				<wordform>idtjij</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Du1">
				<wordform>iejme</wordform>
				<wordform>idtjijmen</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Du2">
				<wordform>iejden</wordform>
				<wordform>iejde</wordform>
				<wordform>idtjijden</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Du3">
				<wordform>iejga</wordform>
				<wordform>iejgan</wordform>
				<wordform>idtjijga</wordform>
				<wordform>idtjijgan</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Pl1">
				<wordform>iejme</wordform>
				<wordform>idtjijme</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Pl2">
				<wordform>iejde</wordform>
				<wordform>idtjijde</wordform>
			</analysis>
			<analysis ms="Neg_Prt_Pl3">
				<wordform>idtjin</wordform>
			</analysis>
			<analysis ms="Neg_Imprt_Sg2">
				<wordform>iele</wordform>
			</analysis>
			<analysis ms="Neg_Imprt_Du2">
				<wordform>iellen</wordform>
			</analysis>
			<analysis ms="Neg_Imprt_Pl2">
				<wordform>illit</wordform>
			</analysis>
		</mini_paradigm>
	</lg>
	<mg>
		<tg xml:lang="eng">
			<t>not (negation verb)</t>
		</tg>
		<tg xml:lang="swe">
			<t>inte (negationsverb)</t>
		</tg>
		<tg xml:lang="nob">
			<t>ikke (negasjonsverb)</t>
		</tg>
	</mg>
</e></xsl:if>

</r>

  </xsl:template>
  
</xsl:stylesheet>

