<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="nightbar"
    xmlns="http://www.mpi.nl/IMDI/Schema/IMDI"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.mpi.nl/IMDI/Schema/IMDI ./IMDI_3.0.xsd"
    exclude-result-prefixes="xs local">
<!--
    | this stylesheet is intended to transform Filemaker XML-export
    | sample 'data.xml' into a prettier structure (originally from Pite noun paradigm database)
    -->



  <!-- Input -->
  <xsl:param name="inFile" select="'jkl.xml'"/>
  <!--xsl:param name="inDir" select="'xxxdirxxx'"/-->
  <xsl:param name="inDir" select="'FM2IMDI'"/>
  <xsl:param name="XSLfile" select="base-uri(document(''))"/>
    
  <!-- Output -->
    <xsl:variable name="outputDir" select="'_000_FM2IMDI'"/>
  
  
<!-- output method not used for the direct output -->
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

<!-- output method without name: used for the direct output -->
  <xsl:output method="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:strip-space elements="*"/>

<!-- output method not used for the direct output -->
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>

  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/>

  
  <!-- new line -->
  <xsl:variable name="nl" select="'&#xa;'"/>


<!-- Radiergummi fuer text von allen anderen Knoten als METADATA/RESULTSET (those specified otherwise); ie: phantom killer -->
  <xsl:template match="node()|@*">
    <xsl:apply-templates/>
  </xsl:template>  
<!--/xsl:variable-->

  <!-- Patterns for the feature values -->
  <xsl:variable name="ofx" select="'xml'"/><!-- of=output format-->
  <xsl:variable name="ex" select="$ofx"/>
  <xsl:variable name="oft" select="'txt'"/><!-- of=output format-->
  <xsl:variable name="et" select="$oft"/>
  <xsl:variable name="ofIMDI" select="'imdi'"/><!-- of=output format-->
  <xsl:variable name="exIMDI" select="$ofIMDI"/>



<!-- template to test if input DIR and FILE exist -->
  <xsl:template match="/" name="main">

    <xsl:if test="doc-available($inFile)">
      <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing file: ', $inFile,' ......')"/>
      </xsl:message>      
      <!-- uncomment following to see in terminal -->
      <!--xsl:call-template name="processFile">
    	<xsl:with-param name="theFile" select="document($inFile)"/>
    	<xsl:with-param name="theName" select="$file_name"/>
      </xsl:call-template-->
    </xsl:if>

    <xsl:if test="not(doc-available($inFile) or not($inDir = 'originalXMLfromEXCEL'))">
      <xsl:value-of select="concat('Neither ', $inFile, ' nor ', $inDir, ' found.', $nl)"/>
    </xsl:if>   


    <xsl:variable name="docNamePrefix" select="'00_mutated4IMDI_'"/>
    <!--xsl:variable name="newDocName" select="concat($docNamePrefix,$activeSession)"/-->
    <xsl:variable name="newDocName" select="$activeSession"/>
    <!--xsl:apply-templates/--><!-- this makes result show up in terminal -->
    <!--xsl:result-document href="{$docNamePrefix}{$activeSession}.{$exIMDI}" format="{$ofx}"-->
    <xsl:result-document href="{$activeSession}.{$exIMDI}" format="{$ofx}">
      <xsl:apply-templates/>
    </xsl:result-document>

    <xsl:message terminate="no"><xsl:value-of select="concat('+++++Created document ',$newDocName,'.',$exIMDI,$nl,'    ...at ',current-time(),' on ',current-date())"/></xsl:message>
    <!--xsl:result-document href="thievesLtd.{$et}" format="{$oft}">
      <xsl:apply-templates/>
    </xsl:result-document-->
   
  </xsl:template>


<!-- patterns for language codes -->
<xsl:variable name="LangCodes">
  <LangCode ISO="ISO639-3:sje">Pite Saami</LangCode>
  <LangCode ISO="ISO639-3:eng">English</LangCode>
  <LangCode ISO="ISO639-3:swe">Swedish</LangCode>
  <LangCode ISO="ISO639-3:deu">German</LangCode>
  <LangCode ISO="ISO639-3:smj">Lule Saami</LangCode>
  <LangCode ISO="ISO639-3:nor">Norwegian</LangCode>
</xsl:variable>

  <!-- active session name -->
<xsl:variable name="activeSession" select="$meaningfulTags/*[position()=1 and name()='session']"/>

<!--xsl:variable name="outPut"-->
<!--  <xsl:template name="processFile">
    <xsl:param name="theFile"/>
    <xsl:param name="theName"/>-->



  <xsl:template name="processFile" match="*:FMPXMLRESULT">
    <xsl:param name="theFile"/>
    <xsl:param name="theName"/>

    <xsl:element name="METATRANSCRIPT">
<!-- following line adds xmlns lines to METATRANSCRIPT -->
    <xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="'http://www.mpi.nl/IMDI/Schema/IMDI ./IMDI_3.0.xsd'"/></xsl:attribute>
    <xsl:attribute name="Date"><xsl:value-of  select="current-date()"/></xsl:attribute>
    <xsl:attribute name="Version"><xsl:value-of  select="'0'"/></xsl:attribute>
    <xsl:attribute name="FormatId"><xsl:value-of  select="'IMDI 3.03'"/></xsl:attribute>
    <xsl:attribute name="Type"><xsl:value-of  select="'SESSION'"/></xsl:attribute>

  <xsl:copy-of select="$outPut"/>
    </xsl:element>
    <xsl:value-of select="$nl"/>
  </xsl:template>
  


<xsl:variable name="outPut">  
  <xsl:for-each select="*/*:RESULTSET/*:ROW">
<!--    <xsl:element name="UeberSession">-->
      <Session>
      <!--meanTags><xsl:copy-of select="$meaningfulTags"/></meanTags-->
        <Name><xsl:value-of select="$meaningfulTags/*[name()='session']"/></Name>
        <Title><xsl:value-of select="$meaningfulTags/*[name()='session_title']"/></Title>
        <Date><xsl:value-of select="$meaningfulTags/*[name()='date']"/></Date>
        <MDGroup>
          <Location>
            <Continent><xsl:value-of select="$meaningfulTags/*[name()='continent']"/></Continent>
            <Country><xsl:value-of select="$meaningfulTags/*[name()='country']"/></Country>
            <Region><xsl:value-of select="$meaningfulTags/*[name()='region']"/></Region>
            <Address><xsl:value-of select="$meaningfulTags/*[name()='address']"/></Address>
          </Location>
          <Project>
            <Name><xsl:value-of select="$meaningfulTags/*[name()='project_name']"/></Name>
            <Title><xsl:value-of select="$meaningfulTags/*[name()='project_title']"/></Title>
            <Id><xsl:value-of select="$meaningfulTags/*[name()='project_ID']"/></Id>
            <Contact>
    <Name><xsl:value-of select="$meaningfulTags/*[name()='project_contact_name']"/></Name>
    <Address><xsl:value-of select="$meaningfulTags/*[name()='project_contact_address']"/></Address>
    <Email><xsl:value-of select="$meaningfulTags/*[name()='project_contact_email']"/></Email>
    <Organisation><xsl:value-of select="$meaningfulTags/*[name()='project_organization']"/></Organisation>
            </Contact>
            <Description><xsl:value-of select="$meaningfulTags/*[name()='project_description']"/></Description>
          </Project>
          <xsl:call-template name="KeysTemplate"/>
          <Content>
            <Genre><xsl:value-of select="$meaningfulTags/*[name()='genre']"/></Genre>
            <!-- subgenre doesn't really work, leaving it out for now -->
            <!--Subgenre><xsl:value-of select="$meaningfulTags/*[name()='subgenre']"/></Subgenre-->
            <!-- subject not required, not in FMP-export; leaving it out for now -->
            <!--Subject><xsl:value-of select="$meaningfulTags/*[name()='subgenre']"/></Subject-->
            <!-- CommunicationContext --><!-- required! but no child elements are required -->
            <CommunicationContext/>
            <Languages>
              <Description/><!-- not required -->
              <xsl:if test="not($meaningfulTags/*[name()='content_languages_used']='')">
                <xsl:call-template name="LangFactsContent"/>
              </xsl:if>
            </Languages>
            <xsl:call-template name="KeysTemplate"/>
              <xsl:if test="not($meaningfulTags/*[name()='session_description']='')"><Description><xsl:value-of select="$meaningfulTags/*[name()='session_description']"/></Description></xsl:if>
          </Content>
          <Actors>
            <Description/>
            <xsl:call-template name="ActorTemplate"/>
          </Actors>
        </MDGroup>
        <Resources/>
        <References/>
      </Session>

<!--xsl:value-of select="concat($nl,$nl,'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++',$nl,$nl)"/-->

  </xsl:for-each>
</xsl:variable>

<xsl:variable name="meaningfulTags"> 
  
  <xsl:for-each select="*/*:RESULTSET/*:ROW/*:COL">
  <xsl:variable name="poser" select="position()"/>
  <xsl:variable name="tagCalc" select="../../../*:METADATA/*[position()=$poser]/@NAME"/>
  <xsl:variable name="tagNameA" select="replace($tagCalc,' ','_')"/>
  <xsl:variable name="tagNameB" select="replace($tagNameA,'::','_')"/>
  <xsl:variable name="tagNameC" select="replace($tagNameB,'consultant_for_IMDIa_','actorA')"/>
  <xsl:variable name="tagNameD" select="replace($tagNameC,'non_consultant_for_IMDIb_','actorB')"/>
  <xsl:variable name="tagNameE" select="replace($tagNameD,'IMDI_language_','Lang')"/>
  <xsl:variable name="tagNameF" select="replace($tagNameE,'IMDI_','')"/>
    <xsl:element name="{$tagNameF}" >
<!--      <xsl:attribute name="descriptor">
        <xsl:value-of select="../../../*:METADATA/*[position()=$poser]/@NAME"/>
      </xsl:attribute>-->
<!--      <xsl:attribute name="type">
        <xsl:variable name="poser" select="position()"/>
        <xsl:value-of select="fn:lower-case(../../../*:METADATA/*[position()=$poser]/@TYPE)"/>
      </xsl:attribute>-->
<!--      <xsl:attribute name="tagName" select="$tagName"/>-->
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:for-each>

</xsl:variable>


<!-- Language facts Content template -->
  <xsl:template name="LangFactsContent">
    <xsl:variable name="contentLs"><xsl:value-of select="$meaningfulTags/*[name()='content_languages_used']"/></xsl:variable>
<!-- Pite -->
    <xsl:if test="contains($contentLs,'Pite Saami')">
    <xsl:element name="Language">
      <xsl:element name="Id">ISO639-3:sje</xsl:element>
      <xsl:element name="Name">Pite Saami</xsl:element>
      <!--xsl:element name="MotherTongue">Pite Saami</xsl:element--><!-- only relevant for Actors! -->
      <!--xsl:element name="PrimaryLanguage">Pite Saami</xsl:element--><!-- only relevant for Actors! -->
      <!--xsl:element name="Dominant">Pite Saami</xsl:element--><!-- only relevant for Actors! -->
      <xsl:element name="Description">aka: Arjeplog Saami, etc.</xsl:element><!-- not required -->
    </xsl:element>
    </xsl:if>
<!-- Swedish -->
    <xsl:if test="contains($contentLs,'Swedish')"><xsl:element name="Language"><xsl:element name="Id">ISO639-3:swe</xsl:element><xsl:element name="Name">Swedish</xsl:element><xsl:element name="Description">aka: svenska</xsl:element><!-- Description not required --></xsl:element></xsl:if>
<!-- English -->
    <xsl:if test="contains($contentLs,'English')"><xsl:element name="Language"><xsl:element name="Id">ISO639-3:eng</xsl:element><xsl:element name="Name">English</xsl:element><xsl:element name="Description"></xsl:element><!-- Description not required --></xsl:element></xsl:if>
    <xsl:variable name="restLsA" select="replace($contentLs,'Pite Saami','')"/>
    <xsl:variable name="restLsB" select="replace($restLsA,'Swedish','')"/>
    <xsl:variable name="restLsC" select="replace($restLsB,'English','')"/>
    <xsl:variable name="restLs" select="replace($restLsC,' ','')"/>
    <xsl:if test="not($restLs='')"><Language>other Languages also used!</Language></xsl:if>
  </xsl:template>



<!-- Keys Template -->
<xsl:template name="KeysTemplate">
   <Keys>
     <xsl:element name="Key">
       <xsl:attribute name="Name"/><!-- this attribute required for Key -->
     </xsl:element>
   </Keys>
</xsl:template>


<!-- Actors Template -->
<xsl:template name="ActorTemplate">
<xsl:variable name="actorSetComplete">
  <xsl:variable name="speakerSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="speakerSet2"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_2')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="speakerSet3"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_3')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="speakerSet4"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_4')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="speakerSet5"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_5')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="speakerSet6"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_6')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="annotatorSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'annotator_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="annotatorSet2"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'annotator_2')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="interviewerSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'interviewer_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="interviewerSet2"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'interviewer_2')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="recorderSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'recording_individual_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="recorderSet2"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'recording_individual_2')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="collectorSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'collector_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
  <xsl:variable name="depositorSet1"><xsl:for-each select="$meaningfulTags/*[starts-with(name(),'depositor_1')]"><xsl:copy-of select="."/></xsl:for-each></xsl:variable>
<!--speakerSet1><xsl:copy-of select="$speakerSet1"/></speakerSet1-->
<Speaker><xsl:copy-of select="$speakerSet1"/></Speaker>
<Speaker><xsl:copy-of select="$speakerSet2"/></Speaker>
<Speaker><xsl:copy-of select="$speakerSet3"/></Speaker>
<Speaker><xsl:copy-of select="$speakerSet4"/></Speaker>
<Speaker><xsl:copy-of select="$speakerSet5"/></Speaker>
<Speaker><xsl:copy-of select="$speakerSet6"/></Speaker>
<Annotator><xsl:copy-of select="$annotatorSet1"/></Annotator>
<Annotator><xsl:copy-of select="$annotatorSet2"/></Annotator>
<Interviewer><xsl:copy-of select="$interviewerSet1"/></Interviewer>
<Interviewer><xsl:copy-of select="$interviewerSet2"/></Interviewer>
<Recording_Individual><xsl:copy-of select="$recorderSet1"/></Recording_Individual>
<Recording_Individual><xsl:copy-of select="$recorderSet2"/></Recording_Individual>
<Collector><xsl:copy-of select="$collectorSet1"/></Collector>
<Depositor><xsl:copy-of select="$depositorSet1"/></Depositor>
</xsl:variable>

<!-- each Speaker -->
<xsl:for-each select="$actorSetComplete/*[name()='Speaker']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Speaker</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages>
    <!-- LangA -->
      <xsl:for-each select="*[ends-with(name(),'_LangA') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangA_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangB -->
      <xsl:for-each select="*[ends-with(name(),'_LangB') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangB_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangC -->
      <xsl:for-each select="*[ends-with(name(),'_LangC') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangC_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangD -->
      <xsl:for-each select="*[ends-with(name(),'_LangD') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangDode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangD_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangE -->
      <xsl:for-each select="*[ends-with(name(),'_LangE') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangEode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangE_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangF -->
      <xsl:for-each select="*[ends-with(name(),'_LangF') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangFode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangF_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    </Languages>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age><xsl:value-of select="*[ends-with(name(),'_Age')]"/></Age>
    <BirthDate><xsl:value-of select="*[ends-with(name(),'_DOB')]"/></BirthDate>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact/>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>


<!-- each Annotator -->
<xsl:for-each select="$actorSetComplete/*[name()='Annotator']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Annotator</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages>
    <!-- LangA -->
      <xsl:for-each select="*[ends-with(name(),'_LangA') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangA_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangB -->
      <xsl:for-each select="*[ends-with(name(),'_LangB') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangB_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangC -->
      <xsl:for-each select="*[ends-with(name(),'_LangC') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangC_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangD -->
      <xsl:for-each select="*[ends-with(name(),'_LangD') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangDode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangD_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangE -->
      <xsl:for-each select="*[ends-with(name(),'_LangE') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangEode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangE_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangF -->
      <xsl:for-each select="*[ends-with(name(),'_LangF') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangFode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangF_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    </Languages>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age><xsl:value-of select="*[ends-with(name(),'_Age')]"/></Age>
    <BirthDate><xsl:value-of select="*[ends-with(name(),'_DOB')]"/></BirthDate>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact/>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>


<!-- each Interviewer -->
<xsl:for-each select="$actorSetComplete/*[name()='Interviewer']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Interviewer</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages>
    <!-- LangA -->
      <xsl:for-each select="*[ends-with(name(),'_LangA') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangA_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangB -->
      <xsl:for-each select="*[ends-with(name(),'_LangB') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangB_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangC -->
      <xsl:for-each select="*[ends-with(name(),'_LangC') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangC_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangD -->
      <xsl:for-each select="*[ends-with(name(),'_LangD') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangDode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangD_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangE -->
      <xsl:for-each select="*[ends-with(name(),'_LangE') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangEode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangE_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangF -->
      <xsl:for-each select="*[ends-with(name(),'_LangF') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangFode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangF_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    </Languages>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age><xsl:value-of select="*[ends-with(name(),'_Age')]"/></Age>
    <BirthDate><xsl:value-of select="*[ends-with(name(),'_DOB')]"/></BirthDate>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact/>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>


<!-- each Recording Individual -->
<xsl:for-each select="$actorSetComplete/*[name()='Recording_Individual']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Recording Individual</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages>
    <!-- LangA -->
      <xsl:for-each select="*[ends-with(name(),'_LangA') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangA_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangB -->
      <xsl:for-each select="*[ends-with(name(),'_LangB') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangB_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangC -->
      <xsl:for-each select="*[ends-with(name(),'_LangC') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangCode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangC_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangD -->
      <xsl:for-each select="*[ends-with(name(),'_LangD') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangDode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangD_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangE -->
      <xsl:for-each select="*[ends-with(name(),'_LangE') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangEode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangE_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    <!-- LangF -->
      <xsl:for-each select="*[ends-with(name(),'_LangF') and not(.='')]">
        <Language>
          <xsl:variable name="currLang" select="."/>
          <Id><xsl:value-of select="$LangCodes/*:LangFode[string()=$currLang]/@ISO"/></Id>
          <Name><xsl:value-of select="."/></Name>
          <MotherTongue><xsl:value-of select="../*[ends-with(name(),'_LangF_native')]"/></MotherTongue>
        </Language>
      </xsl:for-each>
    </Languages>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age><xsl:value-of select="*[ends-with(name(),'_Age')]"/></Age>
    <BirthDate><xsl:value-of select="*[ends-with(name(),'_DOB')]"/></BirthDate>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact/>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>


<!-- each Collector -->
<xsl:for-each select="$actorSetComplete/*[name()='Collector']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Collector</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages/>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age/>
    <BirthDate/>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact>
      <Name><xsl:value-of select="*[ends-with(name(),'_Name')]"/></Name>
      <Address><xsl:value-of select="*[ends-with(name(),'_Address')]"/></Address>
      <Email><xsl:value-of select="*[ends-with(name(),'_Email')]"/></Email>
      <Organisation><xsl:value-of select="*[ends-with(name(),'_Organization')]"/></Organisation>
    </Contact>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>

<!-- each Depositor -->
<xsl:for-each select="$actorSetComplete/*[name()='Depositor']">
<xsl:if test="not(.='')">
  <Actor>
    <Role>Depositor</Role>
    <Name><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></Name>
    <FullName><xsl:value-of select="*[ends-with(name(),'_FullName')]"/></FullName>
    <Code><xsl:value-of select="*[ends-with(name(),'_Code')]"/></Code>
    <FamilySocialRole/>
    <Languages/>
    <EthnicGroup><xsl:value-of select="*[ends-with(name(),'_EthnicGroup')]"/></EthnicGroup>
    <Age/>
    <BirthDate/>
    <Sex><xsl:value-of select="*[ends-with(name(),'_Gender')]"/></Sex>
    <Education/>
    <Anonymized>false</Anonymized>
    <Contact>
      <Name><xsl:value-of select="*[ends-with(name(),'_Name')]"/></Name>
      <Address><xsl:value-of select="*[ends-with(name(),'_Address')]"/></Address>
      <Email><xsl:value-of select="*[ends-with(name(),'_Email')]"/></Email>
      <Organisation><xsl:value-of select="*[ends-with(name(),'_Organization')]"/></Organisation>
    </Contact>
    <Keys/>
    <Description/>
  </Actor>
</xsl:if>
</xsl:for-each>




<!--            <Languages>
  <xsl:for-each select="$meaningfulTags/*[starts-with(name(),'speaker_1_Lang') and string-length(name())=15 and not(.='')]">
      <xsl:variable name="langNameTag" select="name()"/>
      <xsl:variable name="langName" select="."/>
      <xsl:variable name="nativeStateTag" select="concat($langNameTag,'_native')"/>
      <xsl:variable name="nativeState" select="$meaningfulTags/*[name()=$nativeStateTag]"/>
            <Language>
              <Name><xsl:value-of select="$langName"/></Name>
              <Native><xsl:value-of select="$nativeState"/></Native>
            </Language>
  </xsl:for-each>
          </Languages>-->



<!-- speaker transformer goes here!!! -->
<!-- speaker transformer goes here!!! -->
<!-- speaker transformer goes here!!! -->
<!-- speaker transformer goes here!!! -->




</xsl:template>





<!--
    |  <xsl:template match="/">
    |    <xsl:result-document href="theives.{$e}" format="{$of}">
    |        <xsl:copy-of select="."/>
    |    </xsl:result-document>
    |    <xsl:result-document href="{$outDir}/{$file_name}.{$e}" format="{$of}">
    |        <xsl:copy-of select="$myOutput"/>
    |    </xsl:result-document>
    |  </xsl:template>
    -->

<!--  <xsl:template match="/">
    <xsl:variable name="docNamePrefix" select="'00_mutated4IMDI_'"/>
    <xsl:variable name="newDocName" select="concat($docNamePrefix,$activeSession)"/>
    <xsl:result-document href="{$docNamePrefix}{$activeSession}.{$exIMDI}" format="{$ofx}">
      <xsl:apply-templates/>
    </xsl:result-document>
    <xsl:message terminate="no"><xsl:value-of select="concat('++++Created document ',$newDocName,'.',$exIMDI,$nl,'    ...created at ',current-time(),' on ',current-date(),$nl,'    ...to be further transformed using 02_FMP2IMDI.xsl')"/></xsl:message>
    <xsl:result-document href="thievesLtd.{$et}" format="{$oft}">
      <xsl:apply-templates/>
    </xsl:result-document>
  </xsl:template-->


</xsl:stylesheet>