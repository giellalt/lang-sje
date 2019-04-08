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
  <xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
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

<!-- set original PoS (Swedish) variable -->
<xsl:variable name="PoS_Samica">
  <xsl:value-of select="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW[position()=1]/fm:COL[position()=3]/fm:DATA"/>
</xsl:variable>

<!-- set variable for PoS in English -->
<xsl:variable name="PoS">
  <xsl:choose>
  <xsl:when test="$PoS_Samica = 'subst'"><xsl:value-of select="'noun'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'verb'"><xsl:value-of select="'verb'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'adj'"><xsl:value-of select="'adj'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'post'"><xsl:value-of select="'post'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'adv'"><xsl:value-of select="'adv'"/></xsl:when>
  <xsl:when test="$PoS_Samica = 'egen'"><xsl:value-of select="'prop'"/></xsl:when>
  <xsl:otherwise><xsl:value-of select="'unknown'"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- set variable for LEXICON name -->
<xsl:variable name="LexName">
  <xsl:choose>
  <xsl:when test="$PoS = 'noun'"><xsl:value-of select="'Noun'"/></xsl:when>
  <xsl:when test="$PoS = 'verb'"><xsl:value-of select="'Verb'"/></xsl:when>
  <xsl:when test="$PoS = 'adj'"><xsl:value-of select="'Adjective'"/></xsl:when>
  <xsl:when test="$PoS = 'post'"><xsl:value-of select="'Postposition'"/></xsl:when>
  <xsl:when test="$PoS = 'adv'"><xsl:value-of select="'Adverb'"/></xsl:when>
  <xsl:when test="$PoS = 'prop'"><xsl:value-of select="'ProperNoun'"/></xsl:when>
  <xsl:otherwise><xsl:value-of select="'ERROR'"/></xsl:otherwise>
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
! This is a GENERATED FILE which means any changes you make manually will probably be overwritten later. This LEXC file was extracted from J. Wilbur's Pite Saami lexcial database in FileMaker Pro. Translations and item numbers are from that database; see also http://saami.uni-freiburg.de/psdp/pite-lex/
! Timestamp: </xsl:text>
<xsl:value-of select="date:date-time()"/>
<!--xsl:value-of select="current-date(),current-time()"/-->

<xsl:choose>

<!-- NOUN HEADER -->
  <xsl:when test="$PoS = 'noun'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

LEXICON </xsl:text><xsl:value-of select="$LexName"/><xsl:text>   !!= * __@CODE@__ is the main lexicon

!! !!Lexc inflectional classes (Mini-grammar)

!! * Even-syllable stem patterns: 
!! ** N_EVEN: bisyllabic stems except those ending in -o- (e.g. juällge, bijjla, gisstá, gällu, båsskå) 
!! ** N_EVEN_O: bisyllabic stems ending in -o- (e.g. iello)
!! ** N_EVEN4: tetrasyllabic stems (trisyllabic in Nom.Sg) ending in -k/-g-, -tj- (e.g. mánnodak, såbmelatj)
!! ** N_EVEN4_ISA: tetrasyllabic stems (trisyllabic in Nom.Sg) ending in -is/-as- (e.g. guoksagis)
!! * Odd-syllable stem patterns:  
!! ** N_ODD: odd-syllable stems ending in a closed syllable and without consonant gradation (e.g. almatj) 
!! ** N_ODD_OPEN: odd-syllable stems ending in an open syllable (e.g. biena) 
!! ** N_ODD_VH: odd-syllable stems ending in a closed syllable and with vowel harmony (e.g. ålol) 
!! ** N_ODD_WG: odd-syllable stems ending in a closed syllable (e.g. vanas)
!! * Contracted stem patterns: 
!! ** N_CONTR_AJA: contracted stems ending in -aj or -a (e.g. ålmaj) 
!! ** N_CONTR_ESA: contracted stems ending in -es or -á (e.g. sarves) 
!! ** N_CONTR_OJU: contracted stems ending in -oj or -u (e.g. båtsoj) 
!! ** N_CONTR_OU: contracted stems ending in -o or -u (e.g. suolo)

</xsl:text>
  </xsl:when>

<!-- VERB HEADER -->
  <xsl:when test="$PoS = 'verb'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

LEXICON </xsl:text><xsl:value-of select="$LexName"/><xsl:text>   !!= * __@CODE@__ is the main lexicon

!! !!Lexc inflectional classes (Mini-grammar)

! Even-syllable stem patterns:

!! * V_EVEN_E: even-syllable stems ending in -e- (e.g. båhtet)
!! * V_EVEN_A: even-syllable stems ending in -a- (e.g. dahkat)
!! * V_EVEN_O: even-syllable stems ending in -o- (e.g. viessot)
!! * V_EVEN_Å: even-syllable stems ending in -å- (e.g. bårråt)

! Odd-syllable stem patterns:

!! * V_ODD: odd-syllable stems (e.g. ságastit)

! Contracted stem patterns:

!! * V_CONTR: contracted stems (e.g. gullit -j-, tjerrut -j-)


LE "copula/auxiliary verb" ; !!= * @CODE@ 
IJ "negation verb" ; !!= * @CODE@ 

! special case for gallgat -> gilgij
gallgat:gilgi V_GILGIJ "shall" ; ! no. 522

</xsl:text>
  </xsl:when>

<!-- ADJECTIVE HEADER -->
  <xsl:when test="$PoS = 'adj'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

LEXICON </xsl:text><xsl:value-of select="$LexName"/><xsl:text>   !!= * __@CODE@__ is the main lexicon

!! !!Lexc inflectional classes (Mini-grammar)

! adjective classes are named after a prototypical adjective

</xsl:text>
  </xsl:when>

<!-- ADVERB HEADER -->
  <xsl:when test="$PoS = 'adv'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

LEXICON adv   !!= * __@CODE@__ adds the tag +Adv
+Adv: # ;

LEXICON Adverb   !!= * __@CODE@__ is the list
</xsl:text>
  </xsl:when>

<!-- ADPOSITION HEADER -->
  <xsl:when test="$PoS = 'post'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

LEXICON PP   !!= * __@CODE@__  adds the tag +Po
+Po: # ;

LEXICON Postposition   !!= * __@CODE@__ is the list
</xsl:text>
  </xsl:when>

<!-- PROPER NOUNS HEADER -->
  <xsl:when test="$PoS = 'prop'">
<xsl:text>

!! !!!Pite Saami </xsl:text><xsl:value-of select="$LexName"/><xsl:text>s

!! Propernouns
!+Prop
!+Sem/Fem (female)
!+Sem/Mal (male)
!+Sem/Ani (animal)
!+Sem/Sur (surname)
!+Sem/Plc (place)
!+Sem/Org (organisation)
!+Sem/Obj (film, book, etc.)

LEXICON ProperNoun   !!= * __@CODE@__

</xsl:text>
  </xsl:when>

<!-- ERROR HEADER -->
  <xsl:otherwise>
    <xsl:value-of select="concat($nl,$nl,'unknown (++++ERROR in header, PoS, listed as ',$PoS,')',$nl,$nl)"/>
  </xsl:otherwise>
</xsl:choose>
<!--xsl:value-of select="$nl"/-->

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
    +-->

<!-- insert data -->
    <xsl:for-each select="fm:FMPXMLRESULT/fm:RESULTSET/fm:ROW">
      <!-- sort for sje-alphabet -->
      <xsl:sort select="./fm:COL[position()=7]/fm:DATA"/>
      <xsl:sort select="./fm:COL[position()=4]/fm:DATA"/>
<xsl:value-of select="concat(./fm:COL[position()=5]/fm:DATA,':',./fm:COL[position()=6]/fm:DATA,' ',./fm:COL[position()=7]/fm:DATA,' ',$dq)"/>
  <xsl:choose>
    <xsl:when test="./fm:COL[position()=8]/fm:DATA=''">
      <xsl:value-of select="./fm:COL[position()=9]/fm:DATA"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="./fm:COL[position()=8]/fm:DATA"/>
    </xsl:otherwise>
  </xsl:choose>
<xsl:value-of select="concat($dq,' ; ! no. ',./fm:COL[position()=1]/fm:DATA,$nl)"/>
    </xsl:for-each>

<!-- ADJECTIVE TAIL (until Sjaggo adjectives have been absorbed) -->
<xsl:choose>
  <xsl:when test="$PoS = 'adj'">
<xsl:text>

! original lemmas from A-C and Trond:

almelatj:almelatj A_EVEN_D ;
gåbbde A_EVEN_B ;
järbme A_EVEN_B ;
!maŋŋe A_EVEN_0 ;  !stadieväxling fungerar ej
njállge A_EVEN_B ; !alternativ attributiv form njálga, alternativ komparering njálgap, njálgamus alt. njállgap, njallgajmus
sjnuttjo A_EVEN_NOCG_S ;
tjåvvgå A_EVEN_IES ;
tjavvga A_EVEN_0 ; ! fungerar
uhttse A_EVEN_B ; !little
suddulatj:suddulatj A_EVEN_D ;
vuojnodibme A_EVEN_0 ; !bm:m attr. vuojnodis
ávos A_ODD_Å ; !happy, glad
gilos:gil A_ODD_DD ; !gillus?
grávvat:grávv A_ODD_S ;
gullis A_ODD ;
máhtalk:máhtal A_ODD_GIS ;
nággár A_ODD ;
njálmuk:njálmu A_ODD_GIS ;
njálbmok:njálbmo A_ODD_GIS ;
nåjdes:nåj A_ODD_SIS ;
rádes:rád A_ODD_AA ;  !inlagt även alt.form rádep, rádemus
rádes:rád A_ODD_ÖÖ ;  !inlagt även alt.form rádásup
rávvat:rávv A_ODD_S ;
sjlusgos A_ODD_Å ;
stumbu:stumbu A_ODD_Ä ;
suddes:sudd A_ODD_AA ; 
suojmuk:suojmu A_ODD_GIS ;
tjuavvgat:tju A_ODD_Y ;
tjuorak:tjuora A_ODD_k_K ;
tjurguk:tjurgu A_ODD_GIS ;
låmmsje:låm A_EVEN_KONTR_D ; 
låmsjes:låm A_EVEN_KONTR_H ; 
mivkes:miv A_EVEN_KONTR_E ; !soft? muvkes?
sjtänntjáj:sjtänntjá A_EVEN_KONTR_C ; !slushy?

</xsl:text>
  </xsl:when>
</xsl:choose>

  </xsl:template>
  
</xsl:stylesheet>

