#!/usr/bin/perl -w
use utf8 ;

while (<>)

{
s/vihtta//g ;			 # 5
s/tuvsán//g ;			 # 1000
s/tjuot//g ;			 # 100short
s/tjuohte//g ;			 # 100
s/tjuode//g ;			 # 100gen
s/niellje//g ;			 # 4
s/niellje//g ;       ### Delete doublet
s/niellja//g ;			 # 
s/milliárdda//g ;		 # 
s/millijåvnnå//g ;		 # 
s/miljona//g ;			 # 
s/milijåvnnå//g ;		 # 
s/låk//g ;				 # 10
s/låhke//g ;			 # 10
s/låhke#akta#tuvsán//g ; # 11000
s/lågev//g ;			 # teen
s/lågenan//g ;			 # ten
s/gålmmå//g ;			 # 3
s/gáktsa//g ;			 # 8
s/guokta//g ;        ### Delete doublet
s/guokta//g ;        ### Delete doublet
s/guok//g ;				 # 2
s/guhtta//g ;			 # 6
s/gietjav//g ;       ### Delete doublet
s/gietja//g ;			 # 7
s/giehtja//g ;       ### Delete doublet
s/duhát//g ;         ### Delete doublet
s/aktse//g ;			 # 9
s/akta//g ;				 # 1


print ;
}
