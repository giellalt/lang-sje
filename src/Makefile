# This is a makefile that builds the Pite Sámi morphological parser
# *****************************************************************

# Here we build the final generator , an inverted transducer of the analyzer.
# It is dependent upon sje.save

XFST = xfst
LEXC = lexc
TWOLC = twolc

ifeq (victorio.uit.no, $(shell hostname))
XFST = /opt/sami/xerox/c-fsm/ix86-linux2.6-gcc3.4/bin/fst -utf8
LEXC = /opt/sami/xerox/bin/lexc -utf8
TWOLC = /opt/sami/xerox/bin/twolc -utf8
endif


isje.fst: ../bin/isje.fst
../bin/isje.fst: ../bin/sje.fst
	@echo
	@echo "*** Building the inverse isje.fst ***"
	@echo
	@printf "load ../bin/sje.save \n\
	invert net \n\
	save stack ../bin/isje.fst \n\
	quit \n" > ../../tmp/isje-fst-script
	$(XFST) < ../../tmp/isje-fst-script
	@rm -f ../../tmp/isje-fst-script


# This goal is to build the final analyser. It depends on all the files.

sje.fst: ../bin/sje.fst
../bin/sje.fst: ../bin/sje.save ../bin/caseconv.fst 
	@echo
	@echo "*** Building sje.fst ***" ;
	@echo
	@printf "read regex [[@\"../bin/sje.save\"] .o. \
	[@\"../bin/caseconv.fst\"]] ; \n\
	save stack ../bin/sje.fst \n\
	quit \n" > ../../tmp/sje-fst-script
	$(XFST) < ../../tmp/sje-fst-script
	@rm -f ../../tmp/sje-fst-script


# The second goal is to build the caseconv.fst file
# This goal depends on case.regex

caseconv.fst: ../bin/caseconv.fst
../bin/caseconv.fst: case.regex
	@echo
	@echo "*** Building caseconv.fst ***" ;
	@echo
	@printf "read regex < case.regex \n\
	save stack ../bin/caseconv.fst \n\
	quit \n" > ../../tmp/caseconv-script
	$(XFST) < ../../tmp/caseconv-script
	@rm -f ../../tmp/caseconv-script





sje.save: ../bin/sje.save
../bin/sje.save: ../bin/twol-sje.bin sje-lex.txt adj-sje-lex.txt propernoun-sje-lex.txt \
adv-sje-lex.txt conjunction-sje-lex.txt subjunction-sje-lex.txt interjection-sje-lex.txt \
noun-sje-lex.txt numeral-sje-lex.txt pp-sje-lex.txt particle-sje-lex.txt \
pronoun-sje-lex.txt punct-sje-lex.txt verb-sje-lex.txt 
	@echo
	@echo "*** Building sje.save ***" ;
	@echo
	printf "compile-source sje-lex.txt adj-sje-lex.txt propernoun-sje-lex.txt \
	adv-sje-lex.txt conjunction-sje-lex.txt subjunction-sje-lex.txt \
	interjection-sje-lex.txt noun-sje-lex.txt numeral-sje-lex.txt pp-sje-lex.txt \
	particle-sje-lex.txt pronoun-sje-lex.txt punct-sje-lex.txt verb-sje-lex.txt  \n\
	read-rules ../bin/twol-sje.bin \n\
	compose-result \n\
	save-result ../bin/sje.save \n\
	quit \n" > ../../tmp/sje-save-script
	$(LEXC) < ../../tmp/sje-save-script
	rm -f ../../tmp/sje-save-script

twol-sje.bin: ../bin/twol-sje.bin


# The second goal is to build twol-sje.bin
# This goal depends on twol-sje.txt

../bin/twol-sje.bin: twol-sje.txt
	@echo
	@echo "*** Building twol-sje.bin ***" ;
	@echo
	@printf "read-grammar twol-sje.txt \n\
	compile \n\
	save-binary ../bin/twol-sje.bin \n\
	quit \n" > ../../tmp/twol-sje-script
	$(TWOLC) < ../../tmp/twol-sje-script
	@rm -f ../../tmp/twol-sje-script

clean:
	@rm -f ../bin/*.bin ../bin/*.fst ../bin/*.save


