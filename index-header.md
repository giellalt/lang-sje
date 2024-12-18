# Pite Sami documentation

[![Maturity](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgiellalt%2Flang-sje%2Fgh-pages%2Fmaturity.json)](https://giellalt.github.io/MaturityClassification.html)
![Lemma count](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgiellalt%2Flang-sje%2Fgh-pages%2Flemmacount.json)
[![License](https://img.shields.io/github/license/giellalt/lang-sje)](https://github.com/giellalt/lang-sje/blob/main/LICENSE)
[![Issues](https://img.shields.io/github/issues/giellalt/lang-sje)](https://github.com/giellalt/lang-sje/issues)
[![Build Status](https://divvun-tc.giellalt.org/api/github/v1/repository/giellalt/lang-sje/main/badge.svg)](https://github.com/giellalt/lang-sje/actions)

This page documents the work on the [Pite Sami language model](http://github.com/giellalt/lang-sje). 

The morphological analyser contains the basic vocabulary and morphology, all in all some 8100 words
plus inflectional and partly also derivatoinal patterns.

The analyser was initially created by Ann-Charlott Sjaggo and Trond Trosterud,
but the principal developer the last years has been Joshua Wilbur.

# Project documentation

##  Grammatical issues

* [Jämnstaviga verb](Verbbojning_Pitesamiska_jamnst.html)
* [Uddastaviga verb](Verbbojning_Pitesamiska_uddast.html)
* [Adjektiv](Adjektivbojning.html)

## Tags

* [A list of the morphological tags in use for Pite Saami, with an explanation](docu-sje-grammartags.html)
* [A general list of morphological tags in use at Giellatekno](/lang/common/MorphologicalTags.html)
* The file **root.lexc** file contains the tags that are in actual use, cf. [an overview over the tags](root-morphology.html) and [the source file itself](https://github.com/giellalt/lang-sje/blob/main/src/fst/root.lexc)


## Using the analysers

* In the terminal: analyse words by writing *usje*, generate with *dsje*
* For more info, see [How to use the morphological parsers](/tools/docu-sme-manual.html)
* Generation of [paradigms](http://giellatekno.uit.no/cgi/p-sje.nob.html)

# In-source documentation

Below is an autogenerated list of documentation pages built from structured comments in the source code. All pages are also concatenated and can be read as one long text [here](sje.md).