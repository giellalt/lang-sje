#!/bin/bash

# script to generate paradigms for generating word forms with poss suff
# command:
# sh poss_minip.sh PATTERN
# example, when you are in smn:
# sh devtools/poss_minip.sh LAAVU | less
# sh devtools/poss_minip.sh smiergâs 
# Only get the lemma you ask for:
# sh devtools/poss_minip.sh '^smiergâs[:+]' 


LOOKUP=$(echo $LOOKUP)
GTLANGS=$(echo $GTLANGS)


PATTERN=$1
L_FILE="in.txt"
cut -d '!' -f1 src/fst/morphology/stems/nouns.lexc | egrep $PATTERN | tr '+' ':'|cut -d ':' -f1>$L_FILE

P_FILE="src/fst/morphology/test/testposs.txt"

for lemma in $(cat $L_FILE);
do
 for form in $(cat $P_FILE);
 do
   echo "${lemma}${form}" | $LOOKUP $GTLANGS/lang-sje/src/generator-gt-norm.xfst
 done
 rm -f $L_FILE
done

