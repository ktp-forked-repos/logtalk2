%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Logtalk - Object oriented extension to Prolog
%  Release 2.26.0
%
%  integration code for SWI Prolog 3.3.x and later versions
%  to compile and load Logtalk files using SWI Prolog consult/1
%
%  last updated: May 7, 2005
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- dynamic(prolog_load_file/2).
:- multifile(prolog_load_file/2).

user:prolog_load_file(_:Spec, Options) :-
	absolute_file_name(Spec, [extensions([lgt]), access(read), file_errors(fail)], Path),
	file_directory_name(Path, Dir),
	file_base_name(Path, File),
	file_name_extension(Entity, _, File),
	working_directory(Old, Dir),
	'$lgt_filter_compiler_options'(Options, Options2),
	call_cleanup(logtalk_load(Entity, Options2), working_directory(_, Old)).


'$lgt_filter_compiler_options'([], []).

'$lgt_filter_compiler_options'([Option| Options], [Option| Options2]) :-
	functor(Option, Functor, 1),
	'$lgt_valid_flag'(Functor),
	!,
	'$lgt_filter_compiler_options'(Options, Options2).

'$lgt_filter_compiler_options'([_| Options], Options2) :-
	'$lgt_filter_compiler_options'(Options, Options2).
