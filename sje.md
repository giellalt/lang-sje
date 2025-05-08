# Pite Sami language model documentation

All doc-comment documentation in one large file.

---

# src-cg3-disambiguator.cg3.md 



### dealing with apostrophe before enclitic copula

### Negation rules

* **ConNeg3** conneg form when neg-verb to the left

### Agreement rules for subject NP

### choose relative pronoun when preceded by NP and not ending in Q-mark

### choose iterrogative pronoun when ending in Q-mark and NOT preceded by NP 

### rule out imperative forms in questions

### rule out finite verbforms after infinitive verbform

### Agreement rule for verb triggered by PersPron

### Agreement rules for verb triggered by full NP

# Rules for collocations, multiword expressions etc.

# Mapping rules

## Mapping CC

* **CCasCNPCVP** Map (@CNP @CVP) to CC

## Mapping verbs
* **+FMAINVinfv** maps to main verb followed by inf

## Add language code

* * *

<small>This (part of) documentation was generated from [src/cg3/disambiguator.cg3](https://github.com/giellalt/lang-sje/blob/main/src/cg3/disambiguator.cg3)</small>

---

# src-fst-morphology-affixes-adjectives.lexc.md 



# Adjectives !

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/affixes/adjectives.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/affixes/adjectives.lexc)</small>

---

# src-fst-morphology-affixes-symbols.lexc.md 


# Symbol affixes

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/affixes/symbols.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/affixes/symbols.lexc)</small>

---

# src-fst-morphology-affixes-verbs.lexc.md 



# Even syllabled verbs

# Odd syllabled verbs

# contracted verbs

# Auxiliaries

* LEXICON LE  

* LEXICON LEPRS  

* LEXICON LEPRT  

* LEXICON IJ  

* LEXICON IJPRS  
* +Sg1:iv    K ;   

* LEXICON IJPRT  
* +Sg1:idtjiv    K ;   

* LEXICON IJIMP  

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/affixes/verbs.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/affixes/verbs.lexc)</small>

---

# src-fst-morphology-compounding.lexc.md 



* * *

<small>This (part of) documentation was generated from [src/fst/morphology/compounding.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/compounding.lexc)</small>

---

# src-fst-morphology-phonology.twolc.md 


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

**Consonant Gradation for ht(j|s):t(j|s) **  

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

<small>This (part of) documentation was generated from [src/fst/morphology/phonology.twolc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/phonology.twolc)</small>

---

# src-fst-morphology-root.lexc.md 


# Pite Sámi morphological analyser

This file contains the tags and reference to main lexica

# Multichar_Symbols  definitions

## POS
* +N 	        Noun
* +V 	        Verb
* +A	        Adjective
* +Adv        Adverb
* +CC	        Coordinating conjuction
* +CS	        Subordinating conjuction
* +Interj     Interjection
* +Pron       Pronoun
* +Num        Numeral
* +Pcle       Particle
* +Po	        Postposition
* +Pr	        Preposition

## Subclasses
* +Pers 		   Personal
* +Dem 		   Demonstrative
* +Interr 	   Interrogative
* +Indef 		   Indefinite
* +Refl 		   Reflexive
* +Recipr 	   Reciprocal
* +Rel 		   Relative
* +NomAg		   Agent noun
* +Attr		   Attributive
* +Comp		   Comparative
* +Superl		   Superlative

## Morphosyntactic properties

### Verbal MSP

Tense-mode
* +Prs	   	   Present tense
* +Prt	   	   Preterite (past) tense
* +Ind	   	   Indicative mood
* +Imprt	   	   Imperative mood
* +Pot	   	   Potential mood

Person-number
* +Sg1	   	   First person singular
* +Sg2	   	   Second person singular
* +Sg3	   	   Third person singular
* +Du1	   	   First person dual
* +Du2	   	   Second person dual
* +Du3	   	   Third person dual
* +Pl1	   	   First person plural
* +Pl2	   	   Second person plural
* +Pl3	   	   Third person plural

Infinite forms
* +Inf	   	   Infinitive
* +Neg	   	   Negation verb
* +ConNeg	   	   Connegative verb
* +GerI	   	   Gerund I
* +GerII	   	   Gerund II
* +PrfPrc	   	   Perfect participle
* +PrsPrc	   	   Present participle
* +VAbess	   	   Verb abessive
* +Cmp	   	   Compound
* +TV		   	   Transitive verb
* +IV		   	   Intransitive verb
* +Vsubst	   	   "actio" verb

Other tags
* +ABBR	   	   Abbreviation
* +Symbol = independent symbols in the text stream, like £, €, ©
* +Coll	   	   Collocation
* +Cmp/SgNom 	   Compound component using Nominative Singular form
* +Cmp/SgGen 	   Compound component using Genitive Singular form
* +Det	   	   Determiner
* +Clt Clitic 'l for some forms of copula/auxiliary verb following V-final word

Derivation tags
* +Der/NomAg 	   Derived agent noun
* +Der/Dimin 	   Derived diminutive
* +Der/State 	   Derived state noun
* +Der/VAdv 	   Derived deverbal adverb

### Nominal MSP
* +Sg 	   Singular
* +Pl 	   Plural

### Case

* +Nom    Nominative
* +Acc    Accusative
* +Gen    Genitive
* +Ill    Illative
* +Ine    Inessive
* +Ela    Elative
* +Com    Comitative
* +Ess    Essive
* +Abe    Abessive
* +Ord    Ordinal
* +Card   Cardinal

Semantic properties of names

Pssessive suffixes
* +PxSg1     First person singular possessive suffix
* +PxSg2     Second person singular possessive suffix
* +PxSg3     Third person singular possessive suffix
* +PxDu1     First person dual possessive suffix
* +PxDu2     Second person dual possessive suffix
* +PxDu3     Third person dual possessive suffix
* +PxPl1     First person plural possessive suffix
* +PxPl2     Second person plural possessive suffix
* +PxPl3     Third person plural possessive suffix

Other tags
* +Err/Orth      Not part of standard orthography
* +Use/NG        Found in reality, but not generated
* +Use/Circ      
* +Cmp/Hyph      
* +Cmp/SplitR    
* +Use/-Spell    
* +Use/NGminip  
* **+Use/TTS** – **only** retained in the HFST Text-To-Speech disambiguation tokeniser
* **+Use/-TTS** – **never** retained in the HFST Text-To-Speech disambiguation tokeniser
* **+Use/PMatch** means that the following is only used in the analyser feeding the disambiguator
* **+Use/-PMatch** Do not include in fst's made for hfst-pmatch

### Compounding tags

The tags are of the following form:
* **+CmpNP/xxx** - Normative (N), Position (P), ie. the tag describes what
position the tagged word can be in in a compound
* **+CmpN/xxx**  - Normative (N) **form** ie. the tag describes what
form the tagged word should use when making compounds
* **+Cmp/xxx**   - Descriptive compounding tags, ie. tags that*describes*
what form a word actually is using in a compound

Normative/prescriptive compounding tags:
(to govern compound behaviour for the speller, ie. what a compound SHOULD BE)

The first part of the component may be ..
* +CmpN/Sg = Singular
* +CmpN/SgN = Singular Nominative
* +CmpN/SgG = Singular Genitive
* +CmpN/PlG = Plural Genitive

* +CmpNP/All - ... be in all positions, **default**, this tag does not have to be written
* +CmpNP/First - ... only be first part in a compound or alone
* +CmpNP/Pref - ... only **first** part in a compound, NEVER alone
* +CmpNP/Last - ... only be last part in a compound or alone
* +CmpNP/Suff - ... only **last** part in a compound, NEVER alone
* +CmpNP/None - ... not take part in compounds
* +CmpNP/Only - ... only be part of a compound, i.e. can never
be used alone, but can appear in any position

* +CmpN/SgLeft  Singular to the left
* +CmpN/SgNomLeft  Singular nominative to the left
* +CmpN/SgGenLeft  Singular genitive to the left
* +CmpN/PlGenLeft  Plural genitive to the left

* **+Cmp/Sg**  Singular
* **+Cmp/SgNom**  Singular Nominative
* **+Cmp/SgGen**  Singular Genitive
* **+Cmp/PlGen**  Plural Genitiv
* **+Cmp/PlNom**  Plural Nominative
* **+Cmp/Attr**  Attribute
* **+Cmp**  Dynamic compound - this tag should always be part of a
dynamic compound.
It is important for Apertium, and useful in other cases as well.
* **+Cmp/SplitR**  This is a split compound with the other part to the right:
"Arbeids- og inkluderingsdepartementet" => Arbeids- = +Cmp/SplitR
* **+Cmp/SplitL**  This is a split compound with the other part to the left
* **+Cmp/Sh**  testing ShCmp

## Punctuation tags
* +CLB      Clause boundary
* +PUNCT    Punctuation
* +LEFT     
* +RIGHT    
* +SENT     

Morphophonological symbols 

### Symbols for regulating the twolc file

^WG       * weak grade
^G3       * marks grade three for stems w/o Cgrad
^V2E2AA   * e to á (before j), o to u before j in V2
^CDEL     * Deleting final consonant, biednag
^VDEL     * Deleting final V2 vowel in compounds or gájk
^MON      * Monophthong in contract
^UAUML    * uo to uä juolge / juällge
^IEUML    * ie to ä etc. gielbar gællbara
^IUML     * a to i, gallgat gillgin
^IJ       * e to i in front of Plural j and Sg Com
^V2O2U    * o to u in V2 (e.g. Ill.Sg, Dim, some N_ODD) etc.
^MONB4J   * No rules for this one in twolc!

### Archiphonemes
i2   * Variable vowel, does not trigger VH
u2   * Variable vowel, does not trigger VH
ä2   * Variable vowel, does not undergo (further) VH
b2 d2 g2 t2 j2   * Variable consonants, undergo final devoicing or other alternations
^O        * o but ä in uä, a in ua

```
 »7       * »
 «7       * «
 %[%>%]   * >
 %[%<%]   * <
```

## Flag diacritics
We have manually optimised the structure of our lexicon using following
flag diacritics to restrict morhpological combinatorics - only allow compounds
with verbs if the verb is further derived into a noun again:
|  @P.NeedNoun.ON@  | (Dis)allow compounds with verbs unless nominalised
|  @D.NeedNoun.ON@  | (Dis)allow compounds with verbs unless nominalised
|  @C.NeedNoun@  | (Dis)allow compounds with verbs unless nominalised

For languages that allow compounding, the following flag diacritics are needed
to control position-based compounding restrictions for nominals. Their use is
handled automatically if combined with +CmpN/xxx tags. If not used, they will
do no harm.
|  @P.CmpFrst.FALSE@  | Require that words tagged as such only appear first
|  @D.CmpPref.TRUE@  | Block such words from entering ENDLEX
|  @P.CmpPref.FALSE@  | Block these words from making further compounds
|  @D.CmpLast.TRUE@  | Block such words from entering R
|  @D.CmpNone.TRUE@  | Combines with the next tag to prohibit compounding
|  @U.CmpNone.FALSE@  | Combines with the prev tag to prohibit compounding
|  @P.CmpOnly.TRUE@  | Sets a flag to indicate that the word has passed R
|  @D.CmpOnly.FALSE@  | Disallow words coming directly from root.

Use the following flag diacritics to control downcasing of derived proper
nouns (e.g. Finnish Pariisi -> pariisilainen). See e.g. North Sámi for how to use
these flags. There exists a ready-made regex that will do the actual down-casing
given the proper use of these flags.
|  @U.Cap.Obl@  | Allowing downcasing of derived names: deatnulasj.
|  @U.Cap.Opt@  | Allowing downcasing of derived names: deatnulasj.

The following flag diacritics are used to control case inflection of numbers:

| Flag diacritic | Explanation
| :------------- |:-----------
| @U.number.one@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.two@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.three@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.four@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.five@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.six@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.seven@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.eight@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.nine@ | Flag used to give arabic numerals in smj different cases ;
| @U.number.zero@ | Flag used to give arabic numerals in smj different cases ;

The following flag diacritic look-alikes are used in hfst-pmatch/hfst-tokenise to properly
handle (possibly) multitoken single strings.

| Flag | Explanation
| ---- | -----------
|  @P.Pmatch.Loc@ | Used on multi-token analyses; tell hfst-tokenise/pmatch where in the form/analysis the token should be split.
|  @P.Pmatch.Backtrack@ | Used on single-token analyses; tell hfst-tokenise/pmatch to backtrack by reanalysing the substrings before and after this point in the form (to find combinations of shorter analyses that would otherwise be missed)

# Key lexicon
Lexicon Root starts the analyser and directs paths to all POS.

# Lexicon ENDLEX
And this is the ENDLEX of everything:
```
@D.CmpOnly.FALSE@@D.CmpPref.TRUE@@D.NeedNoun.ON@ # ; 
```
The `@D.CmpOnly.FALSE@` flag diacritic is ued to disallow words tagged
with +CmpNP/Only to end here.
The `@D.NeedNoun.ON@` flag diacritic is used to block illegal compounds.

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/root.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/root.lexc)</small>

---

# src-fst-morphology-stems-abbreviations.lexc.md 


# File containing abbreviations

Lexica for adding tags and periods

Splitting in 3 groups, because of the preprocessor

* **LEXICON Abbreviation   **

* **LEXICON trab-ab-noun   **
* **LEXICON trab-ab-adj   **
* **LEXICON trab-ab-adv   **
* **LEXICON trab-ab-verb   **
* **LEXICON trab-ab-num   **
* **LEXICON trab-ab-cc   **

* **LEXICON itrab-ab-noun   **
* **LEXICON itrab-ab-adj   **
* **LEXICON itrab-ab-adv   **
* **LEXICON itrab-ab-num   **

* **LEXICON trnumab-ab-noun   **
* **LEXICON trnumab-ab-adj   **

* **LEXICON ab-nodot-noun   **   The bulk
Here come POS and Case tags, and no period.

* **LEXICON ab-nodot-adj   **

* **LEXICON ab-nodot-adv   **

* **LEXICON ab-nodot-num   **

* **LEXICON ab-nodot-cc   **

* **LEXICON ab-nodot-verb   **

## Intransitive abbreviations 

* **LEXICON ITRAB   **

* **LEXICON TRNUMAB   **

## Transitive abbreviations 

* **LEXICON TRAB   **

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/abbreviations.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/abbreviations.lexc)</small>

---

# src-fst-morphology-stems-adjectives.lexc.md 


# Pite Saami Adjectives

* **LEXICON Adjective   ** is the main lexicon

## Lexc inflectional classes (Mini-grammar)

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/adjectives.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/adjectives.lexc)</small>

---

# src-fst-morphology-stems-adpositions.lexc.md 


# Adpositions

* **LEXICON Postposition   ** is the list

* **LEXICON PrePostposition   ** is the list

* **LEXICON PostP   **  adds the tag +Po

* **LEXICON PrePost   **  adds the tags +Po and +Pr

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/adpositions.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/adpositions.lexc)</small>

---

# src-fst-morphology-stems-adverbs.lexc.md 


Adverbs

* **LEXICON adv   ** adds the tag +Adv

* **LEXICON Adverb   ** is the list

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/adverbs.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/adverbs.lexc)</small>

---

# src-fst-morphology-stems-conjunctions.lexc.md 



# Conjunctions

* **LEXICON CC   ** gives +CC

* **LEXICON Conjunction   ** is the list.

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/conjunctions.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/conjunctions.lexc)</small>

---

# src-fst-morphology-stems-nouns.lexc.md 


# Pite Saami Nouns

* **LEXICON Noun   ** is the main lexicon

## Lexc inflectional classes (Mini-grammar)

* Even-syllable stem patterns: 
- N_EVEN: bisyllabic stems except those ending in -o- (e.g. juällge, bijjla, gisstá, gällu, båsskå) 
- N_EVEN_O: bisyllabic stems ending in -o- (e.g. iello)
- N_EVEN4: tetrasyllabic stems (trisyllabic in Nom.Sg) ending in -k/-g-, -tj- (e.g. mánnodak, såbmelatj)
- N_EVEN4_ISA: tetrasyllabic stems (trisyllabic in Nom.Sg) ending in -is/-as- (e.g. guoksagis)
* Odd-syllable stem patterns:  
- N_ODD: odd-syllable stems ending in a closed syllable and without consonant gradation (e.g. almatj) 
- N_ODD_OPEN: odd-syllable stems ending in an open syllable (e.g. biena) 
- N_ODD_VH: odd-syllable stems ending in a closed syllable and with vowel harmony (e.g. ålol) 
- N_ODD_WG: odd-syllable stems ending in a closed syllable (e.g. vanas)
* Contracted stem patterns: 
- N_CONTR_AJA: contracted stems ending in -aj or -a (e.g. ålmaj) 
- N_CONTR_ESA: contracted stems ending in -es or -á (e.g. sarves) 
- N_CONTR_OJU: contracted stems ending in -oj or -u (e.g. båtsoj) 
- N_CONTR_OU: contracted stems ending in -o or -u (e.g. suolo)

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/nouns.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/nouns.lexc)</small>

---

# src-fst-morphology-stems-numerals.lexc.md 


# Pite Saami numerals 

* **LEXICON Numeral					   **

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/numerals.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/numerals.lexc)</small>

---

# src-fst-morphology-stems-pronouns.lexc.md 


Pronouns

* **LEXICON Pronoun   **

* **LEXICON Personal   **

* **LEXICON perssgA   **

* **LEXICON perssg   **

* **LEXICON persdu   **

* **LEXICON perspl   **

* **LEXICON Demonstrative   **

* **LEXICON Determiner   **

* **LEXICON Relative   **

* **LEXICON Interrogative   **

* **LEXICON Indefinita   **

* **LEXICON Reflexive   **

* **LEXICON gallacase   **

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/pronouns.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/pronouns.lexc)</small>

---

# src-fst-morphology-stems-sje-propernouns.lexc.md 


# Pite Saami ProperNouns

Propernouns

* **LEXICON ProperNoun   **

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/sje-propernouns.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/sje-propernouns.lexc)</small>

---

# src-fst-morphology-stems-verbs.lexc.md 


# Pite Saami Verbs

* **LEXICON Verb   ** is the main lexicon

## Lexc inflectional classes (Mini-grammar)

* V_EVEN_E: even-syllable stems ending in -e- (e.g. båhtet)
* V_EVEN_A: even-syllable stems ending in -a- (e.g. dahkat)
* V_EVEN_O: even-syllable stems ending in -o- (e.g. viessot)
* V_EVEN_Å: even-syllable stems ending in -å- (e.g. bårråt)

* V_ODD: odd-syllable stems (e.g. ságastit)

* V_CONTR: contracted stems (e.g. gullit -j-, tjerrut -j-)

* lä: LE "copula/auxiliary verb" ;  
* ij: IJ "negation verb" ;  

* * *

<small>This (part of) documentation was generated from [src/fst/morphology/stems/verbs.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/morphology/stems/verbs.lexc)</small>

---

# src-fst-phonetics-txt2ipa.xfscript.md 



retroflex plosive, voiceless			t`  ʈ	    0288, 648 (` = ASCII 096)
retroflex plosive, voiced			d`	ɖ		0256, 598
labiodental nasal					F 	ɱ		0271, 625
retroflex nasal						n` 	ɳ		0273, 627
palatal nasal						J 	ɲ		0272, 626
velar nasal							N 	ŋ		014B, 331
uvular nasal							N\	ɴ		0274, 628
	
bilabial trill						B\ 	ʙ		0299, 665
uvular trill							R\ 	ʀ		0280, 640
alveolar tap							4	ɾ		027E, 638
retroflex flap						r` 	ɽ		027D, 637
bilabial fricative, voiceless		p\ 	ɸ		0278, 632
bilabial fricative, voiced			B 	β		03B2, 946
dental fricative, voiceless			T 	θ		03B8, 952
dental fricative, voiced				D 	ð		00F0, 240
postalveolar fricative, voiceless	S	ʃ		0283, 643
postalveolar fricative, voiced		Z 	ʒ		0292, 658
retroflex fricative, voiceless		s` 	ʂ		0282, 642
retroflex fricative, voiced			z` 	ʐ		0290, 656
palatal fricative, voiceless			C 	ç		00E7, 231
palatal fricative, voiced			j\ 	ʝ		029D, 669
velar fricative, voiced	        	G 	ɣ		0263, 611
uvular fricative, voiceless			X	χ		03C7, 967
uvular fricative, voiced				R 	ʁ		0281, 641
pharyngeal fricative, voiceless		X\ 	ħ		0127, 295
pharyngeal fricative, voiced			?\ 	ʕ		0295, 661
glottal fricative, voiced			h\	ɦ		0266, 614

alveolar lateral fricative, vl.		K 
alveolar lateral fricative, vd.		K\

labiodental approximant				P (or v\) 
alveolar approximant					r\ 
retroflex approximant				r\` 
velar approximant					M\

retroflex lateral approximant		l` 
palatal lateral approximant			L 
velar lateral approximant			L\
Clicks

bilabial								O\	(O = capital letter) 
dental								|\
(post)alveolar						!\ 
palatoalveolar						=\ 
alveolar lateral						|\|\
Ejectives, implosives

ejective								_>	e.g. ejective p		p_>
implosive							_<	e.g. implosive b	b_<
Vowels

close back unrounded					M
close central unrounded 				1 
close central rounded				} 
lax i								I 
lax y								Y 
lax u								U

close-mid front rounded				2 
close-mid central unrounded			@\ 
close-mid central rounded			8 
close-mid back unrounded				7

schwa	ə							@

open-mid front unrounded				E 
open-mid front rounded				9
open-mid central unrounded			3 
open-mid central rounded				3\ 
open-mid back unrounded				V 
open-mid back rounded				O

ash (ae digraph)						{ 
open schwa (turned a)				6

open front rounded					& 
open back unrounded	        		A 
open back rounded					Q
Other symbols

voiceless labial-velar fricative		W 
voiced labial-palatal approx.		H 
voiceless epiglottal fricative		H\ 
voiced epiglottal fricative			<\ 
epiglottal plosive					>\

alveolo-palatal fricative, vl. 		s\ 
alveolo-palatal fricative, voiced	z\ 
alveolar lateral flap				l\ 
simultaneous S and x					x\ 
tie bar								_
Suprasegmentals

primary stress						" 
secondary stress						% 
long									: 
half-long							:\ 
extra-short							_X 
linking mark							-\
Tones and word accents

level extra high						_T 
level high							_H
level mid							_M 
level low							_L 
level extra low						_B
downstep								! 
upstep								^	(caret, circumflex)

contour, rising						 
contour, falling						_F 
contour, high rising					_H_T 
contour, low rising					_B_L 

contour, rising-falling				_R_F 
(NB Instead of being written as diacritics with _, all prosodic 
marks can alternatively be placed in a separate tier, set off 
by < >, as recommended for the next two symbols.)
global rise						<R> 
global fall						<F>
Diacritics						
									
voiceless						_0	(0 = figure), e.g. n_0
voiced							_v 
aspirated						_h 
more rounded						_O	(O = letter) 
less rounded						_c 
advanced							_+
retracted						_-
centralized						_" 
syllabic							=	(or _=) e.g. n= (or n_=) 
non-syllabic						_^ 
rhoticity						`
									
breathy voiced					_t 
creaky voiced					_k
linguolabial						_N 
labialized						_w 
palatalized						'	(or _j) e.g. t' (or t_j) 
velarized						_G 
pharyngealized					_?\
									
dental							_d 
apical							_a 
laminal							_m
nasalized						~	(or _~) e.g. A~ (or A_~) 
nasal release					_n
lateral release					_l 
no audible release				_}

velarized or pharyngealized		_e 
velarized l, alternatively		5 
raised							_r 
lowered							_o 
advanced tongue root				_A 
retracted tongue root			_q

* * *

<small>This (part of) documentation was generated from [src/fst/phonetics/txt2ipa.xfscript](https://github.com/giellalt/lang-sje/blob/main/src/fst/phonetics/txt2ipa.xfscript)</small>

---

# src-fst-transcriptions-transcriptor-abbrevs2text.lexc.md 



We describe here how abbreviations are in Pite Sami are read out, e.g.
for text-to-speech systems.

For example:

* s.:syntynyt # ;  
* os.:omaa% sukua # ;  
* v.:vuosi # ;  
* v.:vuonna # ;  
* esim.:esimerkki # ; 
* esim.:esimerkiksi # ; 

* * *

<small>This (part of) documentation was generated from [src/fst/transcriptions/transcriptor-abbrevs2text.lexc](https://github.com/giellalt/lang-sje/blob/main/src/fst/transcriptions/transcriptor-abbrevs2text.lexc)</small>

---

# tools-grammarcheckers-grammarchecker.cg3.md 


P I T E   S A A M I   G R A M M A R   C H E C K E R

# DELIMITERS

# TAGS AND SETS

## Tags

This section lists all the tags inherited from the fst, and used as tags
in the syntactic analysis. The next section, **Sets**, contains sets defined
on the basis of the tags listed here, those set names are not visible in the output.

### Beginning and end of sentence
BOS
EOS

### Parts of speech tags

N
A
Adv
V
Pron
CS
CC
CC-CS
Po
Pr
Pcle
Num
Interj
ABBR
ACR
CLB
LEFT
RIGHT
WEB
PPUNCT
PUNCT

COMMA
¶

### Tags for POS sub-categories

Pers
Dem
Interr
Indef
Recipr
Refl
Rel
Coll
NomAg
Prop
Allegro
Arab
Romertall

### Tags for morphosyntactic properties

Nom
Acc
Gen
Ill
Loc
Com
Ess
Ess
Sg
Du
Pl
Cmp/SplitR
Cmp/SgNom Cmp/SgGen
Cmp/SgGen
PxSg1
PxSg2
PxSg3
PxDu1
PxDu2
PxDu3
PxPl1
PxPl2
PxPl3
Px

Comp
Superl
Attr
Ord
Qst
IV
TV
Prt
Prs
Ind
Pot
Cond
Imprt
ImprtII
Sg1
Sg2
Sg3
Du1
Du2
Du3
Pl1
Pl2
Pl3
Inf
ConNeg
Neg
PrfPrc
VGen
PrsPrc
Ger
Sup
Actio
VAbess

Err/Orth

### Semantic tags

Sem/Act
Sem/Ani
Sem/Atr
Sem/Body
Sem/Clth
Sem/Domain
Sem/Feat-phys
Sem/Fem
Sem/Group
Sem/Lang
Sem/Mal
Sem/Measr
Sem/Money
Sem/Obj
Sem/Obj-el
Sem/Org
Sem/Perc-emo
Sem/Plc
Sem/Sign
Sem/State-sick
Sem/Sur
Sem/Time
Sem/Txt

HUMAN

PROP-ATTR
PROP-SUR

TIME-N-SET

###  Syntactic tags

@+FAUXV
@+FMAINV
@-FAUXV
@-FMAINV
@-FSUBJ>
@-F<OBJ
@-FOBJ>
@-FSPRED<OBJ
@-F<ADVL
@-FADVL>
@-F<SPRED
@-F<OPRED
@-FSPRED>
@-FOPRED>
@>ADVL
@ADVL<
@<ADVL
@ADVL>
@ADVL
@HAB>
@<HAB
@>N
@Interj
@N<
@>A
@P<
@>P
@HNOUN
@INTERJ
@>Num
@Pron<
@>Pron
@Num<
@OBJ
@<OBJ
@OBJ>
@OPRED
@<OPRED
@OPRED>
@PCLE
@COMP-CS<
@SPRED
@<SPRED
@SPRED>
@SUBJ
@<SUBJ
@SUBJ>
SUBJ
SPRED
OPRED
@PPRED
@APP
@APP-N<
@APP-Pron<
@APP>Pron
@APP-Num<
@APP-ADVL<
@VOC
@CVP
@CNP
OBJ
<OBJ
OBJ>
<OBJ-OTHERS
OBJ>-OTHERS
SYN-V
@X

## Sets containing sets of lists and tags

This part of the file lists a large number of sets based partly upon the tags defined above, and
partly upon lexemes drawn from the lexicon.
See the sourcefile itself to inspect the sets, what follows here is an overview of the set types.

### Sets for Single-word sets

INITIAL

### Sets for word or not

WORD
NOT-COMMA

### Case sets

ADLVCASE

CASE-AGREEMENT
CASE

NOT-NOM
NOT-GEN
NOT-ACC

### Verb sets

NOT-V

### Sets for finiteness and mood

REAL-NEG

MOOD-V

NOT-PRFPRC

### Sets for person

SG1-V
SG2-V
SG3-V
DU1-V
DU2-V
DU3-V
PL1-V
PL2-V
PL3-V

### Pronoun sets

### Adjectival sets and their complements

### Adverbial sets and their complements

### Sets of elements with common syntactic behaviour

### NP sets defined according to their morphosyntactic features

### The PRE-NP-HEAD family of sets

These sets model noun phrases (NPs). The idea is to first define whatever can
occur in front of the head of the NP, and thereafter negate that with the
expression **WORD - premodifiers**.

### Border sets and their complements

### Grammarchecker sets

* * *

<small>This (part of) documentation was generated from [tools/grammarcheckers/grammarchecker.cg3](https://github.com/giellalt/lang-sje/blob/main/tools/grammarcheckers/grammarchecker.cg3)</small>

---

# tools-tokenisers-tokeniser-disamb-gt-desc.pmscript.md 

# Tokeniser for sje

Usage:
```
$ make
$ echo "ja, ja" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "Juos gorreválggain lea (dárbbašlaš) deavdit gáibádusa boasttu olmmoš, man mielde lahtuid." | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "(gáfe) 'ja' ja 3. ja? ц jaja ukjend \"ukjend\"" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "márffibiillagáffe" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

Pmatch documentation:
<https://github.com/hfst/hfst/wiki/HfstPmatch>

Characters which have analyses in the lexicon, but can appear without spaces
before/after, that is, with no context conditions, and adjacent to words:
* Punct contains ASCII punctuation marks
* The symbol after m-dash is soft-hyphen `U+00AD`
* The symbol following {•} is byte-order-mark / zero-width no-break space
`U+FEFF`.

Whitespace contains ASCII white space and
the List contains some unicode white space characters
* En Quad U+2000 to Zero-Width Joiner U+200d'
* Narrow No-Break Space U+202F
* Medium Mathematical Space U+205F
* Word joiner U+2060

Apart from what's in our morphology, there are
1. unknown word-like forms, and
2. unmatched strings
We want to give 1) a match, but let 2) be treated specially by
`hfst-tokenise -a`
Unknowns are made of:
* lower-case ASCII
* upper-case ASCII
* select extended latin symbols
ASCII digits
* select symbols
* Combining diacritics as individual symbols,
* various symbols from Private area (probably Microsoft),
so far:
* U+F0B7 for "x in box"

## Unknown handling
Unknowns are tagged ?? and treated specially with `hfst-tokenise`
hfst-tokenise --giella-cg will treat such empty analyses as unknowns, and
remove empty analyses from other readings. Empty readings are also
legal in CG, they get a default baseform equal to the wordform, but
no tag to check, so it's safer to let hfst-tokenise handle them.

Finally we mark as a token any sequence making up a:
* known word in context
* unknown (OOV) token in context
* sequence of word and punctuation
* URL in context

* * *

<small>This (part of) documentation was generated from [tools/tokenisers/tokeniser-disamb-gt-desc.pmscript](https://github.com/giellalt/lang-sje/blob/main/tools/tokenisers/tokeniser-disamb-gt-desc.pmscript)</small>

---

# tools-tokenisers-tokeniser-gramcheck-gt-desc.pmscript.md 

# Grammar checker tokenisation for sje

Requires a recent version of HFST (3.10.0 / git revision>=3aecdbc)
Then just:
```
$ make
$ echo "ja, ja" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

More usage examples:
```
$ echo "Juos gorreválggain lea (dárbbašlaš) deavdit gáibádusa boasttu olmmoš, man mielde lahtuid." | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "(gáfe) 'ja' ja 3. ja? ц jaja ukjend \"ukjend\"" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "márffibiillagáffe" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

Pmatch documentation:
<https://github.com/hfst/hfst/wiki/HfstPmatch>

Characters which have analyses in the lexicon, but can appear without spaces
before/after, that is, with no context conditions, and adjacent to words:
* Punct contains ASCII punctuation marks
* The symbol after m-dash is soft-hyphen `U+00AD`
* The symbol following {•} is byte-order-mark / zero-width no-break space
`U+FEFF`.

Whitespace contains ASCII white space and
the List contains some unicode white space characters
* En Quad U+2000 to Zero-Width Joiner U+200d'
* Narrow No-Break Space U+202F
* Medium Mathematical Space U+205F
* Word joiner U+2060

Apart from what's in our morphology, there are
1) unknown word-like forms, and
2) unmatched strings
We want to give 1) a match, but let 2) be treated specially by hfst-tokenise -a
* select extended latin symbols
* select symbols
* various symbols from Private area (probably Microsoft),
so far:
* U+F0B7 for "x in box"

TODO: Could use something like this, but built-in's don't include šžđčŋ:

Simply give an empty reading when something is unknown:
hfst-tokenise --giella-cg will treat such empty analyses as unknowns, and
remove empty analyses from other readings. Empty readings are also
legal in CG, they get a default baseform equal to the wordform, but
no tag to check, so it's safer to let hfst-tokenise handle them.

Finally we mark as a token any sequence making up a:
* known word in context
* unknown (OOV) token in context
* sequence of word and punctuation
* URL in context

* * *

<small>This (part of) documentation was generated from [tools/tokenisers/tokeniser-gramcheck-gt-desc.pmscript](https://github.com/giellalt/lang-sje/blob/main/tools/tokenisers/tokeniser-gramcheck-gt-desc.pmscript)</small>

---

# tools-tokenisers-tokeniser-tts-cggt-desc.pmscript.md 

# TTS tokenisation for smj

Requires a recent version of HFST (3.10.0 / git revision>=3aecdbc)
Then just:
```sh
make
echo "ja, ja" \
| hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

More usage examples:
```sh
echo "Juos gorreválggain lea (dárbbašlaš) deavdit gáibádusa \
boasttu olmmoš, man mielde lahtuid." \
| hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
echo "(gáfe) 'ja' ja 3. ja? ц jaja ukjend \"ukjend\"" \
| hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
echo "márffibiillagáffe" \
| hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

Pmatch documentation:
<https://kitwiki.csc.fi/twiki/bin/view/KitWiki/HfstPmatch>

Characters which have analyses in the lexicon, but can appear without spaces
before/after, that is, with no context conditions, and adjacent to words:
* Punct contains ASCII punctuation marks
* The symbol after m-dash is soft-hyphen `U+00AD`
* The symbol following {•} is byte-order-mark / zero-width no-break space
`U+FEFF`.

Whitespace contains ASCII white space and
the List contains some unicode white space characters
* En Quad U+2000 to Zero-Width Joiner U+200d'
* Narrow No-Break Space U+202F
* Medium Mathematical Space U+205F
* Word joiner U+2060

Apart from what's in our morphology, there are
1) unknown word-like forms, and
2) unmatched strings
We want to give 1) a match, but let 2) be treated specially by hfst-tokenise -a
* select extended latin symbols
* select symbols
* various symbols from Private area (probably Microsoft),
so far:
* U+F0B7 for "x in box"

TODO: Could use something like this, but built-in's don't include šžđčŋ:

Simply give an empty reading when something is unknown:
hfst-tokenise --giella-cg will treat such empty analyses as unknowns, and
remove empty analyses from other readings. Empty readings are also
legal in CG, they get a default baseform equal to the wordform, but
no tag to check, so it's safer to let hfst-tokenise handle them.

Needs hfst-tokenise to output things differently depending on the tag they get

* * *

<small>This (part of) documentation was generated from [tools/tokenisers/tokeniser-tts-cggt-desc.pmscript](https://github.com/giellalt/lang-sje/blob/main/tools/tokenisers/tokeniser-tts-cggt-desc.pmscript)</small>
