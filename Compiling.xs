#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

STATIC SV *compiling_sv;

MODULE = B::Compiling  PACKAGE = B::Compiling

PROTOTYPES: DISABLE

void
PL_compiling ()
    PPCODE:
        XPUSHs (compiling_sv);

void
set_label (value)
    char *value
    PPCODE:
#ifdef CopLABEL
        croak ("label is only settable on perl 5.8 or below");
#else
        PL_compiling.cop_label = savepv (value);
#endif

void
set_stash (value)
    HV *value
    PPCODE:
	CopSTASH_set(&PL_compiling, value);

void
set_stashpv (value)
    char *value
    PPCODE:
	CopSTASHPV_set(&PL_compiling, value);

void
set_file (value)
    char *value
    PPCODE:
	CopFILE_set(&PL_compiling, value);

void
set_cop_seq (value)
    UV value
    PPCODE:
        PL_compiling.cop_seq = value;

void
set_arybase (value)
    I32 value
    PPCODE:
#ifdef CopARYBASE_get
        croak ("arybase is only settable on perl 5.8 or below");
#else
        PL_compiling.cop_arybase = value;
#endif

void
set_line (value)
    U16 value
    PPCODE:
        PL_compiling.cop_line = value;

void
set_warnings (value)
    SV *value
    PPCODE:
#if PERL_REVISION == 5 && (PERL_VERSION >= 10)
        croak ("warnings is only settable on perl 5.8 or below");
#else
        PL_compiling.cop_warnings = newSVsv (value);
#endif

void
set_io (value = NULL)
    SV *value
    PPCODE:
#if PERL_REVISION == 5 && (PERL_VERSION >= 7 && PERL_VERSION < 10)
        PL_compiling.cop_io = newSVsv (value);
#else
        croak ("io is only settable on perl 5.8");
#endif

BOOT:
    {
        HV *cop_stash = gv_stashpv ("B::COP", 0);

        if (!cop_stash) {
            croak ("B doesn't provide B::COP");
        }

        compiling_sv = newRV_noinc (newSViv (PTR2IV (&PL_compiling)));
        sv_bless (compiling_sv, gv_stashpv ("B::Compiling::COP", 0));
    }
