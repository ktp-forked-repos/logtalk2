
/*
This file contains an adaptation to Logtalk of code for logical assignment 
of Prolog terms developed by Nobukuni Kino. For more information, please 
consult the URL http://www.kprolog.com/en/logical_assignment/

I have added a new operator, =>>/2, described below, not found in the 
original code.
*/


:-op(100, xfx, '<=').
:-op(100, xfx, '=>').
:-op(100, xfx, '=>>').


:- category(assignvars).

	:- info([
		version is 1.0,
		author is 'Nobukuni Kino and Paulo Moura',
		date is 2005/1/7,
		comment is 'Assignable variables (supporting logical, backtracable assignement of non-variable terms).']).

	:- public(assignable/1).
	:- mode(assignable(-assignvar), one).
	:- info(assignable/1, [
		comment is 'Makes Variable an assignable variable. Initial state will be empty.',
		argnames is ['Variable']]).

	:- public(assignable/2).
	:- mode(assignable(-assignvar, @nonvar), one).
	:- info(assignable/2, [
		comment is 'Makes Variable an assignable variable and sets its initial value to Value.',
		argnames is ['Variable', 'Value']]).

	:- public((<=)/2).
	:- mode(<=(?assignvar, @nonvar), one).
	:- info((<=)/2, [
		comment is 'Sets the value of assignable variable Variable to Value (initializing the variable if needed).',
		argnames is ['Variable', 'Value']]).

	:- public((=>)/2).
	:- mode(=>(+assignvar, ?nonvar), zero_or_one).
	:- info((=>)/2, [
		comment is 'Unifies Value with the current value of the assignable variable Variable.',
		argnames is ['Variable', 'Value']]).

	:- public((=>>)/2).
	:- mode(=>>(+assignvar, ?nonvar), zero_or_more).
	:- info((=>>)/2, [
		comment is 'Enumerates, by backtracking, the current and past variable values, starting with the current one.',
		argnames is ['Variable', 'Value']]).

	:-op(100, xfx, <=).
	:-op(100, xfx, =>).
	:-op(100, xfx, =>>).

	assignable(Assig) :-
		nonvar(Assig),
		self(Self),
		sender(Sender),
		throw(error(type_error(variable, Assig), Self::assignable(Assig), Sender)).

	assignable([_| _]).

	assignable(Assig, Init) :-
		nonvar(Assig),
		self(Self),
		sender(Sender),
		throw(error(type_error(variable, Assig), Self::assignable(Assig, Init), Sender)).

	assignable(Assig, Init) :-
		var(Init),
		self(Self),
		sender(Sender),
		throw(error(instantiation_error, Self::assignable(Assig, Init), Sender)).

	assignable([_, Init| _], Init).

	Assig <= Value :-
		var(Value),
		self(Self),
		sender(Sender),
		throw(error(instantiation_error, Self::Assig <= Value, Sender)).

	[_| Tail] <= Value :-
		nonvar(Tail) ->
			Tail <= Value
			;
			Tail = [Value| _].

	Assig => Value :-
		var(Assig),
		self(Self),
		sender(Sender),
		throw(error(instantiation_error, Self::Assig => Value, Sender)).

	[Current| Tail] => Value :-
		nonvar(Tail) ->
			Tail => Value
			;
			Current = Value.

	Assig =>> Element :-
		var(Assig),
		self(Self),
		sender(Sender),
		throw(error(instantiation_error, Self::Assig =>> Element, Sender)).

	[_| Tail] =>> Value :-
		enumerate(Tail, Value).

	enumerate([_| Tail], Value) :-
		nonvar(Tail),
		enumerate(Tail, Value).

	enumerate([Value| _], Value).

:- end_category.
