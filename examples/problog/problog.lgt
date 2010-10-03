
:- category(problog).

	:- public(problog_exact/3).

	problog_exact(A,B,C) :-
		this(This),
		problog:problog_exact(This::A,B,C).

	:- public(problog_max/3).

	problog_max(A,B,C) :-
		this(This),
		problog:problog_max(This::A,B,TC),
		decompile_facts(TC, C).

	decompile_facts([], []).
	decompile_facts([TFact| TFacts], [Fact| Facts]) :-
		functor(TFact, TFunctor, TArity),
		Arity is TArity - 1,
		TFact =.. [TFunctor| TArgs],
		list::append(Args, [_], TArgs),
		this(This),
		{'$lgt_current_object_'(This, Prefix, _, _, _, _, _, _, _, _, _)},
		atom_concat(Prefix, Functor, TFunctor),
		Fact =.. [Functor| Args],
		decompile_facts(TFacts, Facts).

	:- public(problog_kbest/4).

	problog_kbest(A, B, C, D) :-
		this(This),
		problog:problog_kbest(This::A, B, C, D).

	:- public(problog_montecarlo/3).

	problog_montecarlo(A,B,C) :-
		this(This),
		problog:problog_montecarlo(This::A,B,C).

	:- public(problog_delta/5).

	problog_delta(A, B, C, D, E) :-
		this(This),
		problog:problog_delta(This::A, B, C, D, E).

	:- public(problog_threshold/5).

	problog_threshold(A, B, C, D, E) :-
		this(This),
		problog:problog_threshold(This::A, B, C, D, E).

	:- public(problog_low/4).

	problog_low(A, B, C, D) :-
		this(This),
		problog:problog_low(This::A, B, C, D).

:- end_category.



:- category(dtproblog).

	:- public(dtproblog_solve/2).

	dtproblog_solve(A, B) :-
		dtproblog:dtproblog_solve(A, B).

	:- public(dtproblog_ev/2).

	dtproblog_ev(A, B) :-
		compile_facts(A, TA),
		dtproblog:dtproblog_ev(TA, B).

	compile_facts([], []).
	compile_facts([Fact| Facts], [TFact| TFacts]) :-
		functor(Fact, Functor, Arity),
		Fact =.. [Functor| Args0],
		list::append(Args0, [_], Args),
		this(This),
		{'$lgt_current_object_'(This, Prefix, _, _, _, _, _, _, _, _, _)},
		atom_concat(Prefix, Functor, TFunctor),
		TFact =.. [TFunctor| Args],
		compile_facts(Facts, TFacts).

:- end_category.



:- category(problog_learning).

	:- public(do_learning/1).

	do_learning(A) :-
		learning:do_learning(A).

:- end_category.
