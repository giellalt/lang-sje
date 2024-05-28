## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

SUBDIRS = fst cg3

#################################################
#### Add language-specific build rules here: ####


# Hfst - add weights to compounds if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
generator-raw-gt-desc.hfst: generator-raw-gt-desc.tmp.hfst
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
			-S '+Cmp' -a 10 --arcs-only -i $< \
		> $@
endif

# The SJE morphology needs language-specific build steps to restrict
# compounds and derivations in normative contexts, and remove tags for that
# purpose in other contexts:
analyser-gt-desc.%: analyser-gt-desc.tmp.% \
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

analyser-gt-norm.%: analyser-gt-norm.tmp.%                                 \
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

analyser-gt-norm.xfst: analyser-gt-norm.tmp.xfst \
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
analyser-oahpa-gt-norm.%: analyser-gt-norm.tmp.% \
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
generator-dict-gt-norm.%: generator-dict-gt-norm.tmp.% \
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
analyser-disamb-gt-desc.%: analyser-disamb-gt-desc.tmp.%      \
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
analyser-dict-gt-desc.%: analyser-dict-gt-desc.tmp.%          \
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
analyser-dict-gt-desc-mobile.%: analyser-dict-gt-desc-mobile.tmp.%          \
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
generator-gt-%.$(1): generator-gt-%.tmp.$(1)                      \
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

include $(top_srcdir)/../giella-core/am-shared/src-dir-include.am
include $(top_srcdir)/../giella-core/am-shared/devtest-include.am
