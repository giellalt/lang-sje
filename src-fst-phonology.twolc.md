
# Pite Sámi TWOLC file
This file documents the [phonology.twolc file](http://github.com/giellalt/lang-sje/blob/main/src/fst/phonology.twolc) 

* **%^WG:0**:  weak grade
* **%^G3:0**:  marks grade three for stems w/o Cgrad
* **%^V2E2AA:0**:  e to á in V2 (e.g. ILL.SG, DIM, 1/2-Sg)
  %^V2O2U:0  * o to u in V2 (e.g. Ill.Sg, Dim, some N_ODD) etc.
* **%^CDEL:0**:  delete final consonant odd (biednag)
* **%^VDEL:0**:  delete final V2 vowel in compounds or gájk
* **%^MON:0**:  Monophthong in contracted stems
* **%^UAUML:0**:  uo to uä juolge / juällge
* **%^IEUML:0**:  ie to ä, gielbar / gällbara
  %^IUML:0    * a to i, gallgat gillgin
  %^IJ:0      * e to i in front of Plural j and Sg Com
  %^MONB4J:0  * what is this?

# Rules

## Consonant gradation rules

**Consonant Gradation for htt(j|s):ht(j|s)**  

**Consonant Gradation for hxx:hx**  

**Consonant Gradation for xdn(j):xn(j)**  

**Consonant Gradation for xx:x**  

**Consonant Gradation for xxy:xy**  

**Consonant Gradation for xxt(j|s):xt(j|s) **  

**Consonant Gradation for xxsj:xsj **  

**Consonant Gradation for xy:y**  

**Delete h in hx:y **  

**Intervocalic voiced plosives in hx:y **  

**Consonant Gradation for l/jbm:l/jm **  

**Consonant Gradation for nnjg:njg **  

**Consonant Gradation for vgŋ:vŋ **  

**Consonant Gradation for rdj:rj **  

**Consonant Gradation for ldj:lj **  

## Other consonant rules 

**Final C Deletion**  

**Final devoicing**  

**Word Final Simplification in -st **  

**Word-final De-Affricatization for tj **  

**Word-final reduction for -dtj **  

## Vowel rules 

###  metaphony

**Default VH **  

**Default VH for 4syllables **  

**Default UA in G3 **  

* *lu^Oddan^UAUMLi%>t*
* *luaddan0i0t*

**Special UÄ (VH) in G3 **  

* *gu^Odde^G3%>t*
* *guädde00t*

* *gu^Odde^G3%>t*
* *guädde00t*

**Special VH for u^O **  

**Special VH for ie **  

* *sjievdnje^IJ%>s*
* *sj0evdnji00s*

* *hierrge^WG^IJ%>j*
* *h0er0gi000j*

* *hierrge%>j^V2E2AA*
* *h0ärrgá0j0*

**Ä in G3 **  

**Ä in G3 capitalized **  

**V2 E to I before j-suffixes **  

**V2 E to Á **  

* *båhte^WG%>v^V2E2AA*
* *bå0dá00v0*
* *båhte^WG%>^V2E2AA*
* *bå0dá000*
* *máhtte^WG%>v^V2E2AA*
* *máht0á00v0*
* *máhtte^WG%>^V2E2AA*
* *máht0á000*

**V2 E to Á before S or R **  

**V2 O to U **  

**Final V Deletion **  

* *a*
* *b*

* * *

<small>This (part of) documentation was generated from [src/fst/phonology.twolc](https://github.com/giellalt/lang-sje/blob/main/src/fst/phonology.twolc)</small>

---

