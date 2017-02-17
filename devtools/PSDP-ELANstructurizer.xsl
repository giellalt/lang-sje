<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:ext="http://exslt.org/common"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsi ext">

	<!-- TEIL 1
		LINGUISTIC_TYPEs werden aktualisiert
		leere TIERs werden gelöscht
		bestehende TIERs werden aktualisiert
	-->
	
	<!-- variablen -->

<xsl:param name="refT" select="'refT'"/>
<xsl:param name="wordT" select="'wordT'"/>
<xsl:param name="orthT" select="'orthT'"/>
<xsl:param name="lemmaT" select="'lemmaT'"/>
<xsl:param name="morphT" select="'morphT'"/>
<xsl:param name="posT" select="'posT'"/>
<xsl:param name="ft-langT" select="'ft-langT'"/>
<xsl:param name="orth-origT" select="'orth-origT'"/>
<xsl:param name="glossT" select="'glossT'"/>
<xsl:param name="NOTES" select="'NOTES'"/>

<xsl:param name="en" select="'en'"/>

<xsl:param name="Symb_Sub" select="'Symbolic_Subdivision'"/>
<xsl:param name="Symb_Ass" select="'Symbolic_Association'"/>

<xsl:param name="true" select="'true'"/>
<xsl:param name="false" select="'false'"/>

<xsl:param name="sje" select="'sje'"/>
<xsl:param name="und" select="'und'"/>



<!-- Inhalt wird übertragen	-->
 
 <xsl:template match="node()|@*"  name="identity">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
 </xsl:template>

  <xsl:template match="node()|@*" mode="pass2">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*" mode="pass2"/>
     </xsl:copy>
 </xsl:template>
 
   <xsl:template match="node()|@*" mode="pass3">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*" mode="pass3"/>
     </xsl:copy>
 </xsl:template>
 

 <xsl:template match="/">
	<xsl:variable name="pass1Result">
		<xsl:apply-templates/>
	</xsl:variable>

	<xsl:variable name="pass2Result">
		<xsl:apply-templates mode="pass2"
		select="ext:node-set($pass1Result)/*"/>
	</xsl:variable>
	
	<xsl:apply-templates mode="pass3"
	select="ext:node-set($pass2Result)/*"/>
 </xsl:template>
 
 <!-- einheitliche Versionen -->
 <xsl:template match="@xsi:noNamespaceSchemaLocation">
      <xsl:attribute name="xsi:noNamespaceSchemaLocation">http://www.mpi.nl/tools/elan/EAFv2.8.xsd</xsl:attribute>
   </xsl:template>
 <xsl:template match="@FORMAT">
      <xsl:attribute name="FORMAT">2.8</xsl:attribute>
   </xsl:template>
 <xsl:template match="@VERSION">
      <xsl:attribute name="VERSION">2.8</xsl:attribute>
   </xsl:template>
 

	<!-- TIERs löschen, die keine Annotationen enthalten, außer ref;
		damit bleiben alle eingetragenen Sprecher erhalten -->
	
<xsl:template match="TIER[not(starts-with(@TIER_ID, 'ref'))][not(ANNOTATION)]">
</xsl:template>


	<!-- TIERs konfigurieren -->

<xsl:template match="TIER">
<xsl:variable name="part" select="substring-after(@TIER_ID, '@')"/>
		<xsl:choose>
		
			<!-- alle Type ref > refT, wenn ref@, da Notes oft Type ref sind -->
			<xsl:when test="@LINGUISTIC_TYPE_REF='ref' and starts-with(@TIER_ID, 'ref')">
			<TIER LINGUISTIC_TYPE_REF="{$refT}">
			<xsl:apply-templates select="@*[not(name()='LINGUISTIC_TYPE_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<!-- alle top level > NOTES, wenn nicht ref@ -->
			<xsl:when test="(not(@PARENT_REF) and not(starts-with(@TIER_ID, 'ref')))">
			<TIER LINGUISTIC_TYPE_REF="{$NOTES}">
			<xsl:apply-templates select="@*[not(name()='LINGUISTIC_TYPE_REF')] | node()"/>
			</TIER>
			</xsl:when>	
			
			<!-- Nach TIER_IDs sortiert, werden Attribute angepasst (TIER_ID, LINGUISTIC_TYPE, PARENT_REF) -->
			<xsl:when test="starts-with(@TIER_ID, 'ref')">
			<TIER LINGUISTIC_TYPE_REF="{$refT}" TIER_ID="{replace(@TIER_ID,'.*@','ref@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'text')">
			<TIER LINGUISTIC_TYPE_REF="{$orthT}" TIER_ID="{replace(@TIER_ID,'.*@','orth@')}" LANG_REF="{$sje}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'ftrE')">
			<TIER LINGUISTIC_TYPE_REF="{$ft-langT}" TIER_ID="{replace(@TIER_ID,'.*@','ft-eng@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>

			<xsl:when test="starts-with(@TIER_ID, 'ftrS')">
			<TIER LINGUISTIC_TYPE_REF="{$ft-langT}" TIER_ID="{replace(@TIER_ID,'.*@','ft-swe@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'ftrD')">
			<TIER LINGUISTIC_TYPE_REF="{$ft-langT}" TIER_ID="{replace(@TIER_ID,'.*@','ft-deu@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'ftrLing') or starts-with(@TIER_ID, 'ftLing')">
			<TIER LINGUISTIC_TYPE_REF="{$ft-langT}" TIER_ID="{replace(@TIER_ID,'.*@','ft-ling@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'ftrBible')">
			<TIER LINGUISTIC_TYPE_REF="{$ft-langT}" TIER_ID="{replace(@TIER_ID,'.*@','ft-bible@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<!-- notes können auf höchster ebene sein oder einem participant untergeordnet, müssen bei top-level typ NOTES sein, weil alignable -->
			<xsl:when test="starts-with(@TIER_ID, 'nt@') or starts-with(@TIER_ID, 'note@') or starts-with(@TIER_ID, 'notes@')">
			<TIER LINGUISTIC_TYPE_REF="{$wordT}" TIER_ID="{replace(@TIER_ID,'.*@','notes@')}" PARENT_REF="{concat('ref@', $part)}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'mph@') or starts-with(@TIER_ID, 'morph@') or starts-with(@TIER_ID, 'morph2@')">
			<TIER LINGUISTIC_TYPE_REF="{$morphT}" TIER_ID="{replace(@TIER_ID,'.*@','morph@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','pos@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>

			<xsl:when test="starts-with(@TIER_ID, 'ps@') or starts-with(@TIER_ID, 'pos@') or starts-with(@TIER_ID, 'PoS@')">
			<TIER LINGUISTIC_TYPE_REF="{$posT}" TIER_ID="{replace(@TIER_ID,'.*@','pos@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','lemma@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>

			<xsl:when test="starts-with(@TIER_ID, 'ge') or starts-with(@TIER_ID, 'gloss@') or starts-with(@TIER_ID, 'gloss2@') ">
			<TIER LINGUISTIC_TYPE_REF="{$glossT}" TIER_ID="{replace(@TIER_ID,'.*@','gloss@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','pos@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>

			<xsl:when test="starts-with(@TIER_ID, 'tokens') or starts-with(@TIER_ID, 'token') or starts-with(@TIER_ID, 'wrd') or starts-with(@TIER_ID, 'word') or starts-with(@TIER_ID, 'word2')">
			<TIER LINGUISTIC_TYPE_REF="{$wordT}" TIER_ID="{replace(@TIER_ID,'.*@','word@')}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}" LANG_REF="{$sje}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:when test="starts-with(@TIER_ID, 'ipa@')">
			<TIER LINGUISTIC_TYPE_REF="{$orthT}" TIER_ID="{@TIER_ID}" PARENT_REF="{replace(@PARENT_REF,'.*@','orth@')}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID' or name()='LINGUISTIC_TYPE_REF' or name()='PARENT_REF')] | node()"/>
			</TIER>
			</xsl:when>
			
			<xsl:otherwise>
			<TIER TIER_ID="{@TIER_ID}">
			<xsl:apply-templates select="@*[not(name()='TIER_ID')] | node()"/>
			</TIER>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>


<xsl:template match="LOCALE[position()=1]" mode="pass2">
   <xsl:call-template name="identity"/>

	<!-- LANGUAGE sje/und erstellen, falls noch nicht vorhanden -->
		<xsl:variable name="sje-lang_def">http://cdb.iso.org/lg/CDB-00137454-001</xsl:variable>
		<xsl:variable name="sje-lang_lable">Pite Sami (sje)</xsl:variable>
		<xsl:variable name="und-lang_def">http://cdb.iso.org/lg/CDB-00130975-001</xsl:variable>
		<xsl:variable name="und-lang_lable">undetermined (und)</xsl:variable>
		<xsl:if test="not(/ANNOTATION_DOCUMENT/LANGUAGE/@LANG_ID='sje')">
				<xsl:text>&#10;</xsl:text>
		<LANGUAGE LANG_DEF="{$sje-lang_def}" LANG_ID="{$sje}" LANG_LABEL="{$sje-lang_lable}"/>
		</xsl:if>
		<xsl:if test="not(/ANNOTATION_DOCUMENT/LANGUAGE/@LANG_ID='und')">
		<xsl:text>&#10;</xsl:text>
		<LANGUAGE LANG_DEF="{$und-lang_def}" LANG_ID="{$und}" LANG_LABEL="{$und-lang_lable}"/>
		</xsl:if>
</xsl:template>


<xsl:template match="LINGUISTIC_TYPE[position()=1]" mode="pass2">
	<!-- TIERs der neuen Struktur anlegen, falls es sie für ein ref nicht gibt -->
	<xsl:for-each select="../TIER">
		<xsl:variable name="part" select="substring-after(@TIER_ID, '@')"/>
		<xsl:variable name="participant" select="@PARTICIPANT"/>
		
		<xsl:choose>		
		<xsl:when test="starts-with(@TIER_ID, 'ref')">
			<xsl:variable name="wordpart" select="concat('word@', $part)"/>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('orth@', $part))">
			<TIER TIER_ID="{concat('orth@', $part)}" LINGUISTIC_TYPE_REF="{$orthT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('ref@', $part)}" PARTICIPANT="{$participant}" />
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('word@', $part))">
			<TIER TIER_ID="{concat('word@', $part)}" LINGUISTIC_TYPE_REF="{$wordT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('orth@', $part)}" PARTICIPANT="{$participant}" LANG_REF="sje"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('lemma@', $part))">
			<TIER TIER_ID="{concat('lemma@', $part)}" LINGUISTIC_TYPE_REF="{$lemmaT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('word@', $part)}" PARTICIPANT="{$participant}" />
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('morph@', $part))">
			<TIER TIER_ID="{concat('morph@', $part)}" LINGUISTIC_TYPE_REF="{$morphT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('pos@', $part)}" PARTICIPANT="{$participant}" />
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('pos@', $part))">
			<TIER TIER_ID="{concat('pos@', $part)}" LINGUISTIC_TYPE_REF="{$posT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('lemma@', $part)}" PARTICIPANT="{$participant}" />
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			<xsl:if test="not(/ANNOTATION_DOCUMENT/TIER/@TIER_ID=concat('gloss@', $part))">
			<TIER TIER_ID="{concat('gloss@', $part)}" LINGUISTIC_TYPE_REF="{$glossT}" DEFAULT_LOCALE="{$en}" PARENT_REF="{concat('pos@', $part)}" PARTICIPANT="{$participant}" />
				<xsl:text>&#10;</xsl:text>
			</xsl:if>
			</xsl:when>
			<xsl:otherwise>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	
	
	<!-- überprüfen, ob es notwendige TYPEs gibt,
		TYPEs, die es noch nicht gibt, anlegen -->
		<xsl:if test="not(../LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='refT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$refT}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$true}"/>
		</xsl:if>
		<xsl:if test="not(../LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='orthT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$orthT}" CONSTRAINTS="{$Symb_Ass}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='wordT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$wordT}" CONSTRAINTS="{$Symb_Sub}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='lemmaT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$lemmaT}" CONSTRAINTS="{$Symb_Sub}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='morphT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$morphT}" CONSTRAINTS="{$Symb_Sub}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='posT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$posT}" CONSTRAINTS="{$Symb_Sub}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='ft-langT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$ft-langT}" CONSTRAINTS="{$Symb_Ass}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='orth-origT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$orth-origT}" CONSTRAINTS="{$Symb_Ass}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='NOTES')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$NOTES}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$true}"/>
		</xsl:if>	
		<xsl:if test="not(parent::LINGUISTIC_TYPE/@LINGUISTIC_TYPE_ID='glossT')">
			<xsl:text>&#10;</xsl:text>
			<LINGUISTIC_TYPE LINGUISTIC_TYPE_ID="{$glossT}" CONSTRAINTS="{$Symb_Ass}" GRAPHIC_REFERENCES="{$false}" TIME_ALIGNABLE="{$false}"/>
		</xsl:if>
   <xsl:call-template name="identity"/>
 </xsl:template>	
	

<!-- alle TYPEs löschen, die von keinem TIER verwendet werden -->
<xsl:template match="LINGUISTIC_TYPE" mode="pass2">
			<xsl:variable name="id" select="@LINGUISTIC_TYPE_ID"/>

			<xsl:if test="/ANNOTATION_DOCUMENT/TIER/@LINGUISTIC_TYPE_REF=$id">
			<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
			</xsl:copy>
			</xsl:if>
</xsl:template>


<!-- CV löschen, wenn es nicht verwendet wird -->
<xsl:template match="CONTROLLED_VOCABULARY" mode="pass3">
			<xsl:variable name="cvid" select="@CV_ID"/>
			<xsl:if test="/ANNOTATION_DOCUMENT/LINGUISTIC_TYPE/@CONTROLLED_VOCABULARY_REF=$cvid">
				<xsl:copy>
				<xsl:apply-templates select="node()|@*"/>
				</xsl:copy>
			</xsl:if>
</xsl:template>

<xsl:template match="LINGUISTIC_TYPE" mode="pass3">
			<xsl:variable name="id" select="@LINGUISTIC_TYPE_ID"/>

			<xsl:if test="/ANNOTATION_DOCUMENT/TIER/@LINGUISTIC_TYPE_REF=$id">
			<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
			</xsl:copy>
			</xsl:if>
</xsl:template>
</xsl:stylesheet>