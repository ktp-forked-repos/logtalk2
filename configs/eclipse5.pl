%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Logtalk - Open source object-oriented logic programming language
%  Release 2.35.0
%
%  Copyright (c) 1998-2009 Paulo Moura.        All Rights Reserved.
%  Logtalk is free software.  You can redistribute it and/or modify
%  it under the terms of the "Artistic License 2.0" as published by 
%  The Perl Foundation. Consult the "LICENSE.txt" file for details.
%
%
%  configuration file for ECLiPSe 5.10#26 and later versions
%
%  last updated: November 7, 2008
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- pragma(system).
:- pragma(nodebug).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ISO Prolog Standard predicates that we must define because they are
%  not built-in
%
%  add a clause for lgt_iso_predicate/1 declaring each ISO predicate that
%  we must define; there must be at least one clause for this predicate
%  whose call should fail if we don't define any ISO predicates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- dynamic(lgt_exception_/1).


initialization(Goal) :-
	call(Goal).


% '$lgt_iso_predicate'(?callable).

'$lgt_iso_predicate'(assertz(_)).
'$lgt_iso_predicate'(atom_codes(_, _)).
'$lgt_iso_predicate'(atom_concat(_, _, _)).
'$lgt_iso_predicate'(catch(_, _, _)).
'$lgt_iso_predicate'(current_input(_)).
'$lgt_iso_predicate'(current_output(_)).
'$lgt_iso_predicate'(number_codes(_, _)).
'$lgt_iso_predicate'(throw(_)).
'$lgt_iso_predicate'(unify_with_occurs_check(_, _)).


assertz(Clause) :-
	assert(Clause).


atom_codes(Atom, List) :-
	var(Atom),
	string_list(String, List),
	atom_string(Atom, String).

atom_codes(Atom, List) :-
	nonvar(Atom),
	atom_string(Atom, String),
	string_list(String, List).


atom_concat(Atom1, Atom2, Atom3) :-
	nonvar(Atom1), nonvar(Atom2),
	!,
	concat_atoms(Atom1, Atom2, Atom3).

atom_concat(Atom1, Atom2, Atom3) :-
	nonvar(Atom3),
	name(Atom3, Codes3),
	'$lgt_append'(Codes1, Codes2, Codes3),
	name(Atom1, Codes1),
	name(Atom2, Codes2).


catch(Goal, Catcher, Recovery) :-
	block(Goal, Tag, lgt_catch_recovery(Tag, Catcher, Recovery)).


lgt_catch_recovery(Tag, Catcher, Recovery) :-
	(	Tag = lgt_error ->
		retract(lgt_exception_(Ball)),
		!,
		(	Catcher = Ball ->
			call(Recovery)
		;	exit_block(Tag)
		)
	;	exit_block(Tag)
	).


lgt_uncatched_exception :-
	(	retract(lgt_exception_(Ball)) ->
		writeq(Ball), nl
	;	write('uncatched exception'), nl
	),
	abort.


:- set_error_handler(230, lgt_uncatched_exception/0).


current_input(Stream) :-
	get_stream(input, Stream).


current_output(Stream) :-
	get_stream(output, Stream).


number_codes(Number, Codes) :-
	var(Number),
	string_list(String, Codes),
	number_string(Number, String).

number_codes(Number, Codes) :-
	nonvar(Number),
	number_string(Number, String),
	string_list(String, Codes).


throw(Ball) :-
	asserta(lgt_exception_(Ball)),
	exit_block(lgt_error).


:- set_flag(occur_check, on).
unify_with_occurs_check(X, X).
:- set_flag(occur_check, off).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  predicate properties
%
%  this predicate must return at least static, dynamic, and built_in 
%  properties for an existing predicate
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_predicate_property'(+callable, ?predicate_property)

'$lgt_predicate_property'(Predicate, built_in) :-
	functor(Predicate, Functor, Arity),
	current_built_in(Functor/Arity).

'$lgt_predicate_property'(Predicate, dynamic) :-
	functor(Predicate, Functor, Arity),
	current_predicate(Functor/Arity),
	is_dynamic(Functor/Arity).

'$lgt_predicate_property'(Predicate, static) :-
	functor(Predicate, Functor, Arity),
	current_built_in(Functor/Arity).

'$lgt_predicate_property'(Predicate, static) :-
	functor(Predicate, Functor, Arity),
	current_predicate(Functor/Arity),
	\+ is_dynamic(Functor/Arity).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  meta-predicates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% call_cleanup(+callable, +callble)

call_cleanup(_, _) :-
	throw(not_supported(call_cleanup/2)).


% forall(+callable, +callble) -- built-in

forall(Generate, Test) :-
	\+ (Generate, \+ Test).


% retractall(+callable)

retractall(Head) :-
	retract_all(Head).


% call_with_args/2-9
%
% use these definitions only if your compiler does
% not provide call_with_args/2-9 as built-in predicates

call_with_args(F, A) :-
	Call =.. [F, A],
	call(Call).

call_with_args(F, A1, A2) :-
	Call =.. [F, A1, A2],
	call(Call).

call_with_args(F, A1, A2, A3) :-
	Call =.. [F, A1, A2, A3],
	call(Call).

call_with_args(F, A1, A2, A3, A4) :-
	Call =.. [F, A1, A2, A3, A4],
	call(Call).

call_with_args(F, A1, A2, A3, A4, A5) :-
	Call =.. [F, A1, A2, A3, A4, A5],
	call(Call).

call_with_args(F, A1, A2, A3, A4, A5, A6) :-
	Call =.. [F, A1, A2, A3, A4, A5, A6],
	call(Call).

call_with_args(F, A1, A2, A3, A4, A5, A6, A7) :-
	Call =.. [F, A1, A2, A3, A4, A5, A6, A7],
	call(Call).

call_with_args(F, A1, A2, A3, A4, A5, A6, A7, A8) :-
	Call =.. [F, A1, A2, A3, A4, A5, A6, A7, A8],
	call(Call).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Prolog built-in meta-predicates
%
%  (excluding ISO Prolog Standard meta-predicates)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_pl_meta_predicate'(?callable, ?atom).

'$lgt_pl_meta_predicate'(block(::, *, ::), predicate).
'$lgt_pl_meta_predicate'(call_priority(::, *), predicate).
'$lgt_pl_meta_predicate'(coverof(*, ::, *), predicate).
'$lgt_pl_meta_predicate'(do(*, ::), predicate).
'$lgt_pl_meta_predicate'(event_create(::, *, *), predicate).
'$lgt_pl_meta_predicate'(make_suspension(::, *, *), predicate).
'$lgt_pl_meta_predicate'(mutex(*, ::), predicate).
'$lgt_pl_meta_predicate'(suspend(::, *, *), predicate).
'$lgt_pl_meta_predicate'(suspend(::, *, *, *), predicate).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  file extension predicates
%
%  these extensions are used by Logtalk load/compile predicates
%
%  you may want to change the extension for Prolog files to match 
%  the one expected by your Prolog compiler
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_file_extension'(?atom, ?atom)

'$lgt_file_extension'(logtalk, '.lgt').
'$lgt_file_extension'(prolog, '.pl').
'$lgt_file_extension'(xml, '.xml').



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  default flag values
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_default_flag'(?atom, ?atom)
%
% default values for all flags

'$lgt_default_flag'(prolog, eclipse).

'$lgt_default_flag'(xmldocs, on).
'$lgt_default_flag'(xslfile, 'lgtxml.xsl').
'$lgt_default_flag'(xmlspec, dtd).
'$lgt_default_flag'(xmlsref, local).

'$lgt_default_flag'(unknown, warning).
'$lgt_default_flag'(misspelt, warning).
'$lgt_default_flag'(singletons, warning).
'$lgt_default_flag'(lgtredef, warning).
'$lgt_default_flag'(plredef, silent).
'$lgt_default_flag'(portability, silent).

'$lgt_default_flag'(report, on).

'$lgt_default_flag'(smart_compilation, off).
'$lgt_default_flag'(reload, always).

'$lgt_default_flag'(startup_message, flags(verbose)).

'$lgt_default_flag'(underscore_variables, dont_care).

'$lgt_default_flag'(code_prefix, '').

'$lgt_default_flag'(debug, off).
'$lgt_default_flag'(break_predicate, supported).

'$lgt_default_flag'(complements, off).
'$lgt_default_flag'(dynamic_declarations, off).
'$lgt_default_flag'(events, off).

'$lgt_default_flag'(altdirs, off).
'$lgt_default_flag'(tmpdir, 'lgt_tmp/').
'$lgt_default_flag'(xmldir, 'xml_docs/').

'$lgt_default_flag'(encoding_directive, unsupported).
'$lgt_default_flag'(multifile_directive, unsupported).
'$lgt_default_flag'(threads, unsupported).

'$lgt_default_flag'(context_switching_calls, allow).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  list predicates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


'$lgt_append'([], List, List).
'$lgt_append'([Head| Tail], List, [Head| Tail2]) :-
	'$lgt_append'(Tail, List, Tail2).


'$lgt_member'(Head, [Head| _]).
'$lgt_member'(Head, [_| Tail]) :-
	'$lgt_member'(Head, Tail).


'$lgt_member_var'(V, [H| _]) :-
	V == H.
'$lgt_member_var'(V, [_| T]) :-
	'$lgt_member_var'(V, T).


'$lgt_is_list'([]) :-
    !.
'$lgt_is_list'([_| Tail]) :-
    '$lgt_is_list'(Tail).


'$lgt_is_proper_list'(List) :-
    List == [], !.
'$lgt_is_proper_list'([_| Tail]) :-
    nonvar(Tail),
    '$lgt_is_proper_list'(Tail).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  file predicates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_file_exists'(+atom)
%
% see if a file exist in the current directory

'$lgt_file_exists'(File) :-
	exists(File).


% '$lgt_directory_exists'(+atom)
%
% checks if a directory exists

'$lgt_directory_exists'(Directory) :-
	atom_string(Directory, DirectoryString),
	canonical_path_name(DirectoryString, Path),
	exists(Path).


% '$lgt_current_directory'(-atom)
%
% gets current working directory

'$lgt_current_directory'(Directory) :-
	getcwd(Directory).


% '$lgt_change_directory'(+atom)
%
% changes current working directory

'$lgt_change_directory'(Directory) :-
	cd(Directory).


% '$lgt_make_directory'(+atom)
%
% makes a new directory; succeeds if the directory already exists

'$lgt_make_directory'(Directory) :-
	(	exists(Directory) ->
		true
	;	mkdir(Directory)
	).


% '$lgt_load_prolog_code'(+atom, +atom, +list)
%
% compile and load a Prolog file, resulting from a
% Logtalk source file, given a list of options

'$lgt_load_prolog_code'(File, _, _) :-
	get_flag(debug_compile, Current),
	set_flag(debug_compile, off),
	compile(File),
	set_flag(debug_compile, Current).


% '$lgt_compare_file_mtimes'(?atom, +atom, +atom)
%
% compare file modification times

'$lgt_compare_file_mtimes'(Result, File1, File2) :-
	get_file_info(File1, mtime, Time1),
	get_file_info(File2, mtime, Time2),
	compare(Result, Time1, Time2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  sorting predicates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_keysort'(+list, -list)

'$lgt_keysort'(List, Sorted) :-
	keysort(List, Sorted).


% '$lgt_sort'(+list, -list)

'$lgt_sort'(List, Sorted) :-
	sort(List, Sorted).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  time and date predicates
%
%  if your Prolog compiler does not provide access to the operating system 
%  time and date just write dummy definitions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:-  use_module(library(calendar)).


% '$lgt_current_date'(?Year, ?Month, ?Day)

'$lgt_current_date'(Year, Month, Day) :-
	mjd_now(MJD),
	mjd_to_date(MJD, Day/Month/Year).


% '$lgt_current_time'(?Hours, ?Mins, ?Secs)

'$lgt_current_time'(Hours, Mins, Secs) :-
	mjd_now(MJD),
	mjd_to_time(MJD, Hours:Mins:Secs).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  timing predicate
%
%  if your Prolog compiler does not provide access to a timing predicate 
%  just write dummy definition
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_cpu_time'(-Seconds)

'$lgt_cpu_time'(Seconds) :-
	cputime(Seconds).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  comparison predicate
%
%  the usual compare/3 definition
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% compare(?atom, @term, @term) -- built-in



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  callable predicate
%
%  the usual callable/1 definition
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% callable(@term)

callable(Term) :-
	nonvar(Term),
	functor(Term, Functor, _),
	atom(Functor).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  read character predicate
%
%  read a single character echoing it and writing a newline after
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


'$lgt_read_single_char'(Char) :-
	flush(user), tyi(Code), put(Code), nl, char_code(Char, Code).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  pretty print a term by naming its free variables
%  (avoid instantiating variables in term by using double negation if necessary)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


'$lgt_pretty_print_vars'(Stream, Term) :-
	write_term(Stream, Term, [numbervars(true)]).


'$lgt_pretty_print_vars_quoted'(Stream, Term) :-
	write_term(Stream, Term, [numbervars(true), quoted(true)]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  getting stream current line number
%  (needed for improved compiler error messages)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_stream_current_line_number'(@stream, -integer)

'$lgt_stream_current_line_number'(Stream, Line) :-
	get_stream_info(Stream, line, Last),
	Line is Last + 1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  customized version of the read_term/3 predicate for returning the line
%  where the term starts (needed for improved compiler error messages)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_read_term'(@stream, -term, +list, -integer)

'$lgt_read_term'(Stream, Term, Options, -1) :-
	read_term(Stream, Term, Options).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  handling of Prolog-proprietary directives on Logtalk source files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% '$lgt_ignore_pl_directive'(@callable)

'$lgt_ignore_pl_directive'(mode(_)).


% '$lgt_rewrite_and_copy_pl_directive'(@callable, -callable)

'$lgt_rewrite_and_copy_pl_directive'(_, _) :-
	fail.


% '$lgt_rewrite_and_recompile_pl_directive'(@callable, -callable)

'$lgt_rewrite_and_recompile_pl_directive'(local(Functor/Arity), private(Functor/Arity)).

'$lgt_rewrite_and_recompile_pl_directive'(lib(Library), use_module(library(Library), Exports)) :-
	'$lgt_eclipse_list_of_exports'(library(Library), Exports).

'$lgt_rewrite_and_recompile_pl_directive'(use_module(Library), use_module(Library, Exports)) :-
		'$lgt_eclipse_list_of_exports'(Library, Exports).


'$lgt_eclipse_list_of_exports'(Library, Exports) :-
	(	atom(Library) ->
		Module = Library
	;	Library =..[_, Module]
	),
	current_module(Module),
	get_module_info(Module, interface, Interface),
	'$lgt_eclipse_filter_exports'(Interface, Exports).


'$lgt_eclipse_filter_exports'([], []).

'$lgt_eclipse_filter_exports'([export(Predicate)| Interface], [Predicate| Exports]) :-
	'$lgt_eclipse_filter_exports'(Interface, Exports).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Shortcut to the Logtalk built-in predicate logtalk_load/1
%
%  defined in the config files in order to be able to comment it out in case
%  of conflict with some Prolog native feature; it implies conformance with
%  the ISO Prolog standard regarding the definition of the {}/1 syntax
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

{File, Files} :-
	!,
	logtalk_load(File),
	{Files}.
{File} :-
	logtalk_load(File).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  end!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%