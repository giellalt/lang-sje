## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = morphology filters phonetics syllabification orthography transcriptions tagsets . test

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS=
GT_GENERATORS=
CUSTOM_FSTS=

#### Local modifications in *fst processing: ####
####
#### Copy the fallback targets, and rename them to the desired targets. Then:
#### Replace the 'cp' command (Xerox) / Prepend the hfst-invert command (Hfst -
#### remember to move the $<) with whatever you need to complete
#### the processing to get the final target transducer.
#### Remember to add the dependencies as well.
#### Also make sure that HFST and Xerox processing are the same.
####
#### If you add new transducers to be built, you need to add them to the
#### relevant variable, e.g.:
####
#### if CAN_HFST
#### GT_GENERATORS+=generator-oahpa-gt-norm.hfst
#### endif
####
#### NB!!!! The HFST targets should get a hyphen after 'analyser'/'generator'
#### respectively, to make the local targets minimally different from and
#### slightly more specific than the fallback targets. This is to avoid warnings
#### about duplicate targets. That is, the local targets should looke like:
####
#### analyser-%.hfst: analyser-%.tmp.hfst
#### generator-%.hfst: generator-%.tmp.hfst

##################################################################
#### BEGIN: Add local processing instructions BELOW this line ####
##################################################################

########################################################
#### Add language-specific transducer targets here: ####

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=
GT_GENERATORS+=

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=
endif # WANT_CUSTOM_FSTS

endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=
endif # WANT_CUSTOM_FSTS

endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####

# Hfst - add weights to compounds if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
.generated/generator-raw-gt-desc.hfst: .generated/generator-raw-gt-desc.tmp.hfst
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
			-S '+Cmp' -a 10 --arcs-only -i $< \
		> $@
endif

# The SJE morphology needs language-specific build steps to restrict
# compounds and derivations in normative contexts, and remove tags for that
# purpose in other contexts:
.generated/analyser-gt-desc.%: .generated/analyser-gt-desc.tmp.% \
					 filters/remove-derivation-position-tags.% \
					 filters/remove-norm-comp-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

.generated/analyser-gt-norm.%: .generated/analyser-gt-norm.tmp.%                                 \
					 filters/remove-derivation-position-tags.%             \
					 filters/remove-illegal-derivation-strings-flagbased.% \
					 filters/insert-default-compounding-tags.%             \
					 filters/insert-default_left_compounding-tags.%        \
					 filters/block-illegal_compound-strings.%              \
					 filters/split-CmpN-tags.%                             \
					 filters/convert_to_flags-CmpNP-tags.%                 \
					 filters/split-CmpNP-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.$*\"             \
			.o. @\"filters/block-illegal_compound-strings.$*\"              \
			.o. @\"filters/split-CmpN-tags.$*\"                             \
			.o. @\"filters/insert-default_left_compounding-tags.$*\"        \
			.o. @\"filters/insert-default-compounding-tags.$*\"             \
			.o. @\"filters/remove-illegal-derivation-strings-flagbased.$*\" \
			.o. @\"filters/convert_to_flags-CmpNP-tags.$*\"                 \
			.o. @\"filters/split-CmpNP-tags.$*\"                            \
			.o. @\"$<\"                                                     \
			;\n\
		 twosided flag-diacritics\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

.generated/analyser-gt-norm.xfst: .generated/analyser-gt-norm.tmp.xfst \
					 filters/remove-norm-comp-tags.xfst             \
					 filters/remove-derivation-position-tags.xfst   \
					 filters/remove-illegal-derivation-strings.xfst
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.xfst\"   \
			.o. @\"filters/remove-norm-comp-tags.xfst\"             \
			.o. @\"filters/remove-illegal-derivation-strings.xfst\" \
			.o. @\"$<\"                                             \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) $(VERBOSITY)

# ... and also in the Oahpa analyser:
.generated/analyser-oahpa-gt-norm.%: .generated/analyser-gt-norm.tmp.% \
					filters/remove-derivation-position-tags.% \
					filters/remove-norm-comp-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# Dict-fst local modifications and language-specific changes:
.generated/generator-dict-gt-norm.%: .generated/generator-dict-gt-norm.tmp.% \
					filters/remove-norm-comp-tags.%           \
					filters/remove-derivation-position-tags.% \
					filters/make-optional-variant-tags.%      \
					filters/remove-number-string-tags.%       
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-number-string-tags.$*\"  \
			.o. @\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"filters/make-optional-variant-tags.$*\"      \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_XFST)$(INVERT_FOMA)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# ... as well as in the disambiguation analyser:
.generated/analyser-disamb-gt-desc.%: .generated/analyser-disamb-gt-desc.tmp.%      \
					filters/remove-derivation-position-tags.% \
					filters/remove-norm-comp-tags.%           \
					filters/rename-POS_before_Der-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"filters/rename-POS_before_Der-tags.$*\"      \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# We need to add processing of language-specific tags in the analysers:
.generated/analyser-dict-gt-desc.%: .generated/analyser-dict-gt-desc.tmp.%          \
					filters/remove-norm-comp-tags.%           \
					filters/remove-derivation-position-tags.% 
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# We need to add processing of language-specific tags in the analysers:
.generated/analyser-dict-gt-desc-mobile.%: .generated/analyser-dict-gt-desc-mobile.tmp.%          \
					filters/remove-norm-comp-tags.%           \
					filters/remove-derivation-position-tags.% 
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			    @\"filters/remove-derivation-position-tags.$*\" \
			.o. @\"filters/remove-norm-comp-tags.$*\"           \
			.o. @\"$<\"                                         \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# We need to add processing of language-specific tags in the generator:
define giella_generators
.generated/generator-gt-%.$(1): .generated/generator-gt-%.tmp.$(1)                      \
					 filters/remove-derivation-position-tags.$(1) \
					 filters/remove-norm-comp-tags.$(1)
	$$(AM_V_XFST_TOOL)$$(PRINTF) "read regex \
				@\"filters/remove-derivation-position-tags.$(1)\" \
			.o. @\"filters/remove-norm-comp-tags.$(1)\"           \
			.o. @\"$$<\"                                          \
			;\n\
		 $$(INVERT_XFST)$$(INVERT_FOMA)\
		 save stack $$@\n\
		 quit\n" | $$(XFST_TOOL)
endef
$(foreach fst,hfst xfst foma,$(eval $(call giella_generators,$(fst))))

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/../giella-core/am-shared/src-fst-dir-include.am
include $(top_srcdir)/../giella-core/am-shared/devtest-include.am
