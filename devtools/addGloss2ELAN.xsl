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
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <xsl:output method="xml" name="eaf"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
  <!-- Outputs -->
  <xsl:variable name="outDirXML" select="'outDirXML_Layouts'"/>
  <xsl:variable name="outDirEAF" select="'outDirEAF_Layouts'"/>
  <xsl:variable name="outputFileName" select="'ELANoutput'"/><!-- set output file name here -->
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_formatXML" select="'xml'"/>
  <xsl:variable name="output_formatEAF" select="'xml'"/>
  <xsl:variable name="eXML" select="$output_formatXML"/>
  <xsl:variable name="eEAF" select="$output_formatEAF"/>

  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <!--xsl:variable name="currentDateString" select="substring(string(current-date()),1,10)"/-->


<!-- add lexeme/gloss file -->
<xsl:variable name="glossSource" select="document('sjeGlosses.xml')"/>  

<!-- get initial lastUsedAnnotationId -->
<!-- no longer necessary because this gets calculated (cf. new $globalNo) -->
<!--xsl:variable name="globalNoORIG" select="ANNOTATION_DOCUMENT/HEADER/PROPERTY[@NAME='lastUsedAnnotationId']"/-->


<!-- Inhalt wird übertragen	-->
 <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
 </xsl:template>

  <xsl:template match="node()|@*" mode="pass2">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*" mode="pass2"/>
     </xsl:copy>
 </xsl:template>

 <xsl:template match="/">
  <xsl:variable name="pass1Result">
   <xsl:apply-templates/>
  </xsl:variable>
  <!--xsl:result-document href="/Users/me/main/langs/sje/devtools/{$outputFileName}.eaf" format="{$output_formatEAF}"-->
  <xsl:result-document href="{$outputFileName}.eaf" format="{$output_formatEAF}">
    <xsl:apply-templates mode="pass2" select="ext:node-set($pass1Result)/*"/>
  </xsl:result-document>
 </xsl:template>


<!-- extract ANNOTATION_ID values and delete the preceding letter -->
<xsl:variable name="IDextractor">
<IDs>
  <xsl:for-each select="ANNOTATION_DOCUMENT/TIER/ANNOTATION/*[@ANNOTATION_ID]">
  <ANNOTATION_ID><xsl:value-of select="substring-after(@ANNOTATION_ID, 'a')"/></ANNOTATION_ID>
  </xsl:for-each>
</IDs>
</xsl:variable>

<!-- order ANNOTATION_ID values numerically -->
<xsl:variable name="highestID">
<IDs>
  <xsl:for-each select="$IDextractor/IDs/ANNOTATION_ID">
  <xsl:sort select="." data-type="number"/>
  <ID><xsl:value-of select="."/></ID>
  </xsl:for-each>
</IDs>
</xsl:variable>

<!-- extract highest ANNOTATION_ID value -->
<xsl:variable name="globalNo">
  <xsl:value-of select="$highestID/IDs/ID[last()]"/>
</xsl:variable>

<!-- count number of pos-annotations to calculate ANNOTATION_IDs for new gloss tiers, step ONE -->
<xsl:variable name="posAnnotationCounter">
  <posANN>
  <xsl:for-each select="ANNOTATION_DOCUMENT/TIER[starts-with(@TIER_ID, 'pos')]">
  <xsl:variable name="part" select="concat('gloss@',substring-after(@TIER_ID, '@'))"/>
    <instance>
      <xsl:attribute name="instanceNo"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:attribute name="instanceParticipant"><xsl:value-of select="$part"/></xsl:attribute>
      <annotationCount>
        <xsl:variable name="currentCount" select="count(./ANNOTATION)"/>
        <xsl:value-of select="$currentCount"/>
      </annotationCount>
    </instance>
  </xsl:for-each>
  </posANN>
</xsl:variable>

<!-- count number of pos-annotations to calculate ANNOTATION_IDs for new gloss tiers, step TWO -->
<xsl:variable name="posCumAnnotationCounter">
  <posANN>
  <xsl:for-each select="$posAnnotationCounter/posANN/instance">
  <xsl:variable name="POSition" select="position()"/>
  <xsl:variable name="previousPOSition" select="position()-1"/>
  <xsl:variable name="part" select="@instanceParticipant"/>
    <instance>
      <xsl:attribute name="instanceNo"><xsl:value-of select="$POSition"/></xsl:attribute>
      <xsl:attribute name="instanceParticipant"><xsl:value-of select="$part"/></xsl:attribute>
      <annotationCount>
        <xsl:value-of select="./annotationCount"/>
      </annotationCount>
      <previousCumulativeAnnotationCount>
      <xsl:choose>
      <xsl:when test="$POSition=1">
        <xsl:value-of select="0"/>
      </xsl:when>
      <xsl:when test="not($POSition=1)">
        <xsl:value-of select="sum(../instance[not(position()>$previousPOSition)]/annotationCount)"/>
      </xsl:when>
      </xsl:choose>
      </previousCumulativeAnnotationCount>
      <cumulativeAnnotationCount>
      <xsl:choose>
      <xsl:when test="$POSition=1">
        <xsl:value-of select="./annotationCount"/>
      </xsl:when>
      <xsl:when test="not($POSition=1)">
        <xsl:value-of select="sum(../instance[not(position()>$POSition)]/annotationCount)"/>
      </xsl:when>
      </xsl:choose>
      </cumulativeAnnotationCount>
    </instance>
  </xsl:for-each>
  </posANN>
</xsl:variable>

<!-- calculate total new annotations to be added -->
<xsl:variable name="totalPosAnnotationCounter">
  <xsl:value-of select="sum($posAnnotationCounter/posANN/instance/annotationCount)"/>
</xsl:variable>

<!-- calculate new lastUsedAnnotationId -->
<xsl:variable name="newLastUsedAnnotationId">
  <xsl:value-of select="sum($globalNo + $totalPosAnnotationCounter)"/>
</xsl:variable>


<!-- main template here -->
<xsl:template match="ANNOTATION_DOCUMENT" mode="pass2">
<!-- abort if gloss lingtype and tiers are missing -->
<xsl:if test="not(./LINGUISTIC_TYPE[@LINGUISTIC_TYPE_ID='glossT'])">
<xsl:message terminate="yes">
++++There is no linguistic type 'glossT'!
    (so probably no gloss@speaker-tiers either)
    ...cancelling script!
</xsl:message>
</xsl:if>
<xsl:if test="not(./TIER[starts-with(@TIER_ID,'gloss@')])">
<xsl:message terminate="yes">
++++There isn't a single 'gloss@' tier!
    ...cancelling script!
</xsl:message>
</xsl:if>
<xsl:copy>
<xsl:apply-templates select="node() | @*"/>
</xsl:copy>
</xsl:template>
<!--posAnnotationCounter><xsl:copy-of select="$posAnnotationCounter"/></posAnnotationCounter-->
<!--posCumAnnotationCounter><xsl:copy-of select="$posCumAnnotationCounter"/></posCumAnnotationCounter-->
<!--xsl:value-of select="concat($nl,'globalNo: ',$globalNo,'; total new pos: ',$totalPosAnnotationCounter,'; totalTotal: ',sum($globalNo + $totalPosAnnotationCounter),$nl)"/-->
<xsl:template match="ANNOTATION_DOCUMENT/HEADER/PROPERTY[@NAME='lastUsedAnnotationId']">
  <PROPERTY>
    <xsl:attribute name="NAME"><xsl:value-of select="'lastUsedAnnotationId'"/></xsl:attribute>
    <xsl:value-of select="$newLastUsedAnnotationId"/>
  </PROPERTY>
</xsl:template>


<!-- add glosses (one gloss for each existing PoS-annotation per lemma) -->
<xsl:template match="TIER[starts-with(./@TIER_ID,'gloss') and not(./ANNOTATION)]">
  <xsl:variable name="part" select="substring-after(@TIER_ID, '@')"/>
  <xsl:variable name="lemmaTIER_ID" select="concat('lemma@',$part)"/>
  <xsl:variable name="posTIER_ID" select="concat('pos@',$part)"/>
  <xsl:variable name="glossTIER_ID" select="concat('gloss@',$part)"/>
  <TIER DEFAULT_LOCALE="en" LANG_REF="eng" LINGUISTIC_TYPE_REF="glossT" PARENT_REF="{$posTIER_ID}" TIER_ID="{$glossTIER_ID}">
  <xsl:for-each select="../TIER[@TIER_ID=$posTIER_ID]/ANNOTATION">
    <xsl:variable name="ref2lemma" select="./REF_ANNOTATION/@ANNOTATION_REF"/>
    <xsl:variable name="lemma" select="../../TIER[@TIER_ID=$lemmaTIER_ID]/ANNOTATION/REF_ANNOTATION[@ANNOTATION_ID=$ref2lemma]"/>
    <!-- to do: fix next variable to deal better when there is more than one match! -->
    <xsl:variable name="glossEN" select="$glossSource/ELAN_glosses/sje[./lexcLeft=$lemma]/glosses/gloss[@lang='eng']"/>
    <!--xsl:variable name="glossSV" select="$glossSource/ELAN_glosses/sje[./lexcLeft=$lemma]/glosses/gloss[@lang='swe']"/-->
    <xsl:variable name="newAnnotRef" select="./REF_ANNOTATION/@ANNOTATION_ID"/>
    <xsl:variable name="localCumulativeCount">
      <xsl:value-of select="$posCumAnnotationCounter/posANN/instance[@instanceParticipant=$glossTIER_ID]/previousCumulativeAnnotationCount"/>
    </xsl:variable>
    <xsl:variable name="newAnnotationID">
      <xsl:value-of select="sum($globalNo + $localCumulativeCount + position())"/>
    </xsl:variable>
<!--variables><xsl:value-of select="concat('lastValidID: ',$globalNo,'; localCumCount: ',$localCumulativeCount,'; position: ',position(),'; yields: ',$newAnnotationID)"/></variables-->
    <ANNOTATION>
      <REF_ANNOTATION>
      <xsl:attribute name="ANNOTATION_ID"><xsl:value-of select="concat('a',$newAnnotationID)"/></xsl:attribute>
      <xsl:attribute name="ANNOTATION_REF"><xsl:value-of select="$newAnnotRef"/></xsl:attribute>
        <ANNOTATION_VALUE>
        <xsl:choose>
          <xsl:when test="not($glossEN)"><xsl:value-of select="'?'"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$glossEN"/></xsl:otherwise>
        </xsl:choose>
        </ANNOTATION_VALUE>
      </REF_ANNOTATION>
    </ANNOTATION>
  </xsl:for-each>
  </TIER>
</xsl:template>

</xsl:stylesheet>

