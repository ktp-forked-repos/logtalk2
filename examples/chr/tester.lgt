
:- if(	(current_logtalk_flag(prolog_dialect, Dialect),
		(Dialect == qp; Dialect == sicstus; Dialect == swi; Dialect == yap))).

	:- initialization((
		set_logtalk_flag(report, warnings),
		logtalk_load(library(lgtunit_loader)),
		logtalk_load(loader),
		logtalk_load(tests, [hook(lgtunit)]),
		tests::run
	)).

:- else.

	:- initialization((
		write('(not applicable)'), nl
	)).

:- endif.