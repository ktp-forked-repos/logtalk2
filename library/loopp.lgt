
:- protocol(loopp).

	:- info([
		version is 1.21,
		author is 'Paulo Moura',
		date is 2009/5/19,
		comment is 'Loop control constructs protocol.']).

	:- public(whiledo/2).
	:- meta_predicate(whiledo(0, 0)).
	:- mode(whiledo(+callable, @callable), zero_or_one).
	:- info(whiledo/2, [
		comment is 'While Condition is true do Action.',
		argnames is ['Condition', 'Action']]).

	:- public(dowhile/2).
	:- meta_predicate(dowhile(0, 0)).
	:- mode(dowhile(@callable, +callable), zero_or_one).
	:- info(dowhile/2, [
		comment is 'Do Action while Condition is true.',
		argnames is ['Action', 'Condition']]).

	:- public(foreach/3).
	:- meta_predicate(foreach(*, *, 0)).
	:- mode(foreach(@var, +list(term), @callable), zero_or_one).
	:- info(foreach/3, [
		comment is 'For each element Element in List call Goal.',
		argnames is ['Element', 'List', 'Goal']]).

	:- public(forto/3).
	:- meta_predicate(forto(*, *, 0)).
	:- mode(forto(+number, +number, @callable), zero_or_one).
	:- info(forto/3, [
		comment is 'Call Goal counting up from First to Last. Increment is 1. For convenience and clarity, First and Last can be arithmetic expressions. This predicate fails iff the Goal fails.',
		argnames is ['First', 'Last', 'Goal']]).

	:- public(forto/4).
	:- meta_predicate(forto(*, *, *, 0)).
	:- mode(forto(@var, +number, +number, @callable), zero_or_one).
	:- info(forto/4, [
		comment is 'Call Goal counting up from First to Last and instantiating Count to each successive value. Increment is 1. For convenience and clarity, First and Last can be arithmetic expressions. This predicate fails iff the Goal fails.',
		argnames is ['Count', 'First', 'Last', 'Goal']]).

	:- public(forto/5).
	:- meta_predicate(forto(*, *, *, *, 0)).
	:- mode(forto(@var, +number, +number, +number, @callable), zero_or_one).
	:- info(forto/5, [
		comment is 'Call Goal counting up from First to Last and instantiating Count to each successive value. For convenience and clarity, First, Last, and Increment can be arithmetic expressions (uses Increment absolute value). This predicate fails iff the Goal fails.',
		argnames is ['Count', 'First', 'Last', 'Increment', 'Goal']]).

	:- public(fordownto/3).
	:- meta_predicate(fordownto(*, *, 0)).
	:- mode(fordownto(+number, +number, @callable), zero_or_one).
	:- info(fordownto/3, [
		comment is 'Call Goal counting down from First to Last. Decrement is 1. For convenience and clarity, First and Last can be arithmetic expressions. This predicate fails iff the Goal fails.',
		argnames is ['First', 'Last', 'Goal']]).

	:- public(fordownto/4).
	:- meta_predicate(fordownto(*, *, *, 0)).
	:- mode(fordownto(@var, +number, +number, @callable), zero_or_one).
	:- info(fordownto/4, [
		comment is 'Call Goal counting down from First to Last and instantiating Count to each successive value. Decrement is 1. For convenience and clarity, First and Last can be arithmetic expressions. This predicate fails iff the Goal fails.',
		argnames is ['Count', 'First', 'Last', 'Goal']]).

	:- public(fordownto/5).
	:- meta_predicate(fordownto(*, *, *, *, 0)).
	:- mode(fordownto(@var, +number, +number, +number, @callable), zero_or_one).
	:- info(fordownto/5, [
		comment is 'Call Goal counting down from First to Last and instantiating Count to each successive value. For convenience and clarity, First, Last, and Decrement can be arithmetic expressions (uses Decrement absolute value). This predicate fails iff the Goal fails.',
		argnames is ['Count', 'First', 'Last', 'Decrement', 'Goal']]).

:- end_protocol.
