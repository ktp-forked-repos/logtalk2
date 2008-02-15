 
:- protocol(loopp).

	:- info([
		version is 1.2,
		author is 'Paulo Moura',
		date is 2008/2/15,
		comment is 'Loop control constructs protocol.']).

	:- public(dowhile/2).
	:- meta_predicate(dowhile(::, ::)).
	:- mode(dowhile(+callable, @callable), zero_or_one).
	:- info(dowhile/2, [
		comment is 'Do Action while Condition is true.',
		argnames is ['Action', 'Condition']]).

	:- public(forto/3).
	:- meta_predicate(forto(*, *, ::)).
	:- mode(forto(+integer, +integer, @callable), zero_or_one).
	:- info(forto/3, [
		comment is 'Counting from First to Last do Call. For convenience and clarity, First and Last can be arithmetic expressions.',
		argnames is ['First', 'Last', 'Call']]).

	:- public(forto/4).
	:- meta_predicate(forto(*, *, *, ::)).
	:- mode(forto(-integer, +integer, +integer, @callable), zero_or_one).
	:- info(forto/4, [
		comment is 'Do Call counting from First to Last and instantiating Count to each successive value. For convenience and clarity, First and Last can be arithmetic expressions.',
		argnames is ['Count', 'First', 'Last', 'Call']]).

	:- public(fordownto/3).
	:- meta_predicate(fordownto(*, *, ::)).
	:- mode(fordownto(+integer, +integer, @callable), zero_or_one).
	:- info(fordownto/3, [
		comment is 'Counting from First to Last do Call. For convenience and clarity, First and Last can be arithmetic expressions.',
		argnames is ['First', 'Last', 'Call']]).

	:- public(fordownto/4).
	:- meta_predicate(fordownto(*, *, *, ::)).
	:- mode(fordownto(-integer, +integer, +integer, @callable), zero_or_one).
	:- info(fordownto/4, [
		comment is 'Do Call counting from First to Last and instantiating Count to each successive value. For convenience and clarity, First and Last can be arithmetic expressions.',
		argnames is ['Count', 'First', 'Last', 'Call']]).

	:- public(whiledo/2).
	:- meta_predicate(whiledo(::, ::)).
	:- mode(whiledo(+callable, @callable), zero_or_one).
	:- info(whiledo/2, [
		comment is 'While Condition is true do Action.',
		argnames is ['Condition', 'Action']]).

:- end_protocol.
