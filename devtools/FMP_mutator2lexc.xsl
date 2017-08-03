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
! This LEXC file was extracted from J. Wilbur's Pite Saami lexcial database in FileMaker Pro. Translations and item numbers are from that database; see also http://saami.uni-freiburg.de/psdp/pite-lex/
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

<!-- ERROR HEADER -->
  <xsl:otherwise>
    <xsl:value-of select="'unknown (error in header, PoS)'"/>
  </xsl:otherwise>
</xsl:choose>
<!--xsl:value-of select="$nl"/-->


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

! komparering framför vissa j- former verkar ej fungera

!állke A_EVEN_NOCG_S ; !ill. állkáj fungerar ej
almelatj:almelatj A_EVEN_D ;
assá A_EVEN_NOCG_S ; !finns i två former assáp, asáp
basske A_EVEN_B ;
binna A_EVEN_NOCG_0 ; !funkar delvis
buorre A_EVEN_0 ;
!buässje A_EVEN_B ; !alternativ kontrakt form buässjaj:buässja-/buosjes (attr)
buäjjde A_EVEN_B ;
!bånndá A_EVEN_B ; 
fávvro A_EVEN_B ;
gárrtje A_EVEN_B ;
guhkke A_EVEN_B ; 
gåbbde A_EVEN_B ;
gädtse:giedtse A_EVEN_NOCG_SS ; !omljud ä-ie fungerar vid komp men ej kasusböjn. pos
gähppe A_EVEN_B ;
gävvra A_EVEN_B ;
hárrge A_EVEN_B ;
hávvske A_EVEN_B ;
hiejjo A_EVEN_B ;
hiedjo A_EVEN_B ;
hådje A_EVEN_B ;
iedna A_EVEN_0 ;
jállo A_EVEN_B ;
jasska A_EVEN_NOCG_S ;
järrme A_EVEN_B ;
järbme A_EVEN_B ;
lihkulatj:lihkulatj A_EVEN_D ; 
låjje A_EVEN_B ;
maŋŋe A_EVEN_0 ;  !stadieväxling fungerar ej
njállge A_EVEN_B ; !alternativ attributiv form njálga, alternativ komparering njálgap, njálgamus alt. njállgap, njallgajmus
njárrbe A_EVEN_B ;  
nuorra A_EVEN_0 ;
nävvre A_EVEN_B ;
sájjge A_EVEN_B ;
sávvre A_EVEN_B ;
sjullo A_EVEN_B ;
slinntso A_EVEN_B ;
smávve A_EVEN_B ;
sjnuttjo A_EVEN_NOCG_S ;
stuorra A_EVEN_0 ;
stuorra A_EVEN_IES ; !även predikativ stuor
sägge:siegge A_EVEN_NOCG_SS ; !siegges, omljud fungerar ej, ej heller kasusböjn. framför j
!tjábbe:tjábbe A_EVEN_BB ; !
tjåvvgå A_EVEN_IES ;
tjavvga A_EVEN_0 ; ! fungerar

!tjähppe:tjiehppe A_EVEN_B ; !
uhttse A_EVEN_B ; !
unne A_EVEN_BB ; !superlativ funkar ej
vájjve A_EVEN_B ;
vallje A_EVEN_B ;
vasste A_EVEN_B ;
vuodnje A_EVEN_B ; !stadieväxling fungerar ej
ådne A_EVEN_B ;
ådne:ådn A_EVEN_A ; !fungerar
ballvagis:ballvagiss A_EVEN_4 ;
bargodibme A_EVEN_0 ; !bm:m attr. bargodis
båddnedibme A_EVEN_0 ; !bm:m attr. båddnedis
fábmogis:fábmogiss A_EVEN_4 ;
gaŋŋadibme A_EVEN_0 ; !bm:m attr. gaŋŋadis
gullogis:gullogiss A_EVEN_4 ;
sjávodibme A_EVEN_0 ; !bm:m attr. sjávodis
suddulatj:suddulatj A_EVEN_D ;
!tjalmedibme A_EVEN_0 ; !bm:m attr. tjalmedis
tjerrulis:tjerruliss A_EVEN_4 ;
unugis:unugiss A_EVEN_4 ;
vigedibme A_EVEN_0 ; !bm:m attr. vigedis
vuojnodibme A_EVEN_0 ; !bm:m attr. vuojnodis
ånegatj:ånegatj A_EVEN_D ;

allak:all A_ODD_TT ;
allak:alla A_ODD_Q ;
!amás:a A_ODD_Ö ;
árvas:árv A_ODD_GG ;
!aset:ase A_ODD_DIS ;
ávos A_ODD_Å ;
basstel A_ODD_Å ;
!báhkas:báhk A_ODD_G ;

bavrek:bavre A_ODD_GIS ;
!bivval A_ODD ;
!blávvat:blávv A_ODD_S ;
buorak:buora A_ODD_GIS ;
buorremielak:buorremiela A_ODD_Z ;
dájgas:dájg A_ODD_ZZ ;
dimes:di A_ODD_H ;
dimes:di A_ODD_HA ; 
dulutj A_ODD_Å ;

gájvas:gáj A_ODD_BB ;
galmas:gal A_ODD_M ;
galmas:gal A_ODD_N ;
garras:garra A_ODD_KK ;
gassak:gassa A_ODD_Q ;
gassak:gass A_ODD_HIS ;
gieres:g A_ODD_CC ;
gilos:gil A_ODD_DD ;
grávvat:grávv A_ODD_S ;
gullis A_ODD ;
gåjkes:gåj A_ODD_QQ ;
gåjkes:gåj A_ODD_SS ; !
gåstes:gås A_ODD_ÅÅ ;
gåstes:gås A_ODD_RR ;
háhppel A_ODD ;
hánes:há A_ODD_FF ;
jallgat:j A_ODD_U ;
jallgat:jallga A_ODD_P ;
lieggas:l A_ODD_I ;
livák:livá A_ODD_GIS ;
luovas:lu A_ODD_J ;
lusjgos A_ODD_Å ;
luovas:luov A_ODD_GG ;
låssåt:låsså A_ODD_P ;
låssåt:l A_ODD_UU ;
måskås:mås A_ODD_HH ;
máhtak:máhta A_ODD_GIS ;
máhtalk:máhtal A_ODD_GIS ;
mårret:mårre A_ODD_DIS ;
måskos:m A_ODD_LL ;
nanos:n A_ODD_MM ;
nieros:n A_ODD_NN ;
mällgat:mällg A_ODD_A ;
nággár A_ODD ;
nárbak:nárba A_ODD_Z ;
njálmuk:njálmu A_ODD_GIS ;
njálbmuk:njálbmu A_ODD_GIS ;
njuallgat:njuallga A_ODD_P ;
nåjdes:nåj A_ODD_SIS ;
práres:prár A_ODD_L ;
rabás:ra A_ODD_OO ;
rádes:rád A_ODD_AA ;  !inlagt även alt.form rádep, rádemus
rádes:rád A_ODD_ÖÖ ;  !inlagt även alt.form rádásup
rájnas:ráj A_ODD_ÄÄ ;
rájnas:ráj A_ODD_K ;
rávvat:rávv A_ODD_S ;
ruappsat:ru A_ODD_V ;
rusjkat:rusjk A_ODD_S ;
sielas:siel A_ODD_BIS ;
sjkiebtjas:sjk A_ODD_O ;
sjlusgos A_ODD_Å ;

sjnjutjok:sjnjutjo A_ODD_GIS ;
stumbu:stumbu A_ODD_Ä ;
stuorre A_EVEN_A ;
stuores:stuor A_ODD_F ; 
suddes:sudd A_ODD_AA ; 
suohkat:su A_ODD_X ;
suohtas:su A_ODD_CIS ;
suojmas:su A_ODD_XX ;
suojmas:su A_ODD_YY ; 
suojmuk:suojmu A_ODD_GIS ;
såmes:så A_ODD_B ;
!tjáhppat:tj A_ODD_T ; 
tjuavvgat:tju A_ODD_Y ;
tjalmak:tjalma A_ODD_GIS ;

tjuorak:tjuora A_ODD_k_K ;
tjáhket:tjáhke A_ODD_DIS ;
tjavdes:tjav A_ODD_C ;
tjiegŋal A_ODD ;
tjielgos:tj A_ODD_II ;
tjurguk:tjurgu A_ODD_GIS ;
!tjåskes:tjås A_ODD_D ;
!tjåskes:tjås A_ODD_JIS ; 
vájbas:váj A_ODD_PP ;
várrok:várro A_ODD_GIS ;
vassjal A_ODD ;
visskat:vissk A_ODD_S ;
vuollak:vuolla A_ODD_Q ;
vuoras:vuor A_ODD_R ;
vällgat:v A_ODD_VV ;
åhpes:åhp A_ODD_E ;
åvros A_ODD_Å ;

!buässjáj:bu A_EVEN_KONTR_F ; !även jämnstavig buossje:buosje fungerar
gärrgáj:gärrgá A_EVEN_KONTR_B ; !
hålláj:hållá A_EVEN_KONTR_B ; !fungerar
låmmsje:låm A_EVEN_KONTR_D ; !fungerar
låmsjes:låm A_EVEN_KONTR_H ; !
mivkes:miv A_EVEN_KONTR_E ; !fungerar
mårráj:mårrá A_EVEN_KONTR_B ; !fungerar
sádnes:sád A_EVEN_KONTR_A ; !fungerar
sjtänntjáj:sjtänntjá A_EVEN_KONTR_C ; !fungerar
suvres:suv A_EVEN_KONTR_G ; !fungerar

</xsl:text>
  </xsl:when>
</xsl:choose>

  </xsl:template>
  
</xsl:stylesheet>

