
:- if(current_logtalk_flag(prolog_dialect, sicstus)).
	:- set_prolog_flag(redefine_warnings, off).
:- endif.

:- initialization((
	set_logtalk_flag(report, warnings),
	logtalk_load(library(lgtunit_loader)),
	logtalk_load(loader),
	logtalk_load(tests, [hook(lgtunit)]),
	tests::run
)).
