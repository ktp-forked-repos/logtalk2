
:- object(list,
	implements(listp),
	extends(compound)).

	:- info([
		version is 1.8,
		author is 'Paulo Moura',
		date is 2009/5/15,
		comment is 'List predicates.']).

	:- public(as_difflist/2).
	:- mode(as_difflist(+list, -list), one).
	:- info(as_difflist/2,
		[comment is 'Converts a list to a difference list.',
		 argnames is ['List', 'Diffist']]).

	append([], []).
	append([List| Lists], Concatenation) :-
		append(List, Tail, Concatenation),
		append(Lists, Tail).

	append([], List, List).
	append([Head| Tail], List, [Head| Tail2]) :-
		append(Tail, List, Tail2).

	as_difflist([], Back-Back).
	as_difflist([Head| Tail], [Head| Tail2]-Back) :-
		as_difflist(Tail, Tail2-Back).

	delete([], _, []).
	delete([Head| Tail], Element, Remaining) :-
		(	Head == Element ->
			delete(Tail, Element, Remaining)
		;	Remaining = [Head| Tail2],
			delete(Tail, Element, Tail2)
		).

	delete_matches([], _, []).
	delete_matches([Head| Tail], Element, Remaining) :-
		(	\+ \+ Head = Element ->
			delete_matches(Tail, Element, Remaining)
		;	Remaining = [Head| Tail2],
			delete_matches(Tail, Element, Tail2)
		).

	empty(List) :-
		List == [].

	flatten(List, Flatted) :-
		flatten(List, [], Flatted).

	flatten(Var, Tail, [Var| Tail]) :-
		var(Var),
		!.
	flatten([], Flatted, Flatted) :-
		!.
	flatten([Head| Tail], List, Flatted) :-
		!,
		flatten(Tail, List, Aux),
		flatten(Head, Aux, Flatted).
	flatten(Head, Tail, [Head| Tail]).

	keysort(List, Sorted) :-
		{keysort(List, Sorted)}.		

	last([Head| Tail], Last) :-
		last(Tail, Head, Last).

	last([], Last, Last).
	last([Head| Tail], _, Last) :-
		last(Tail, Head, Last).

	length(List, Length) :-
		(	integer(Length) ->
			Length >= 0,
			make_list(Length, List)
		;	length(List, 0, Length)
		).

	make_list(0, []):-
		!.
	make_list(N, [_| Tail]):-
		M is N-1,
		make_list(M, Tail).

	length([], Length, Length).
	length([_| Tail], Acc, Length) :-
		Acc2 is Acc + 1,
		length(Tail, Acc2, Length).

	max([N| Ns], Max) :-
		max(Ns, N, Max).

	max([], Max, Max).
	max([N| Ns], Aux, Max) :-
		(	N @> Aux ->
			max(Ns, N, Max)
		;	max(Ns, Aux, Max)
		).

	member(Element, [Element| _]).
	member(Element, [_| List]) :-
		member(Element, List).


	memberchk(Element, [Element| _]) :-
		!.
	memberchk(Element, [_| List]) :-
		memberchk(Element, List).

	min([N| Ns], Min) :-
		min(Ns, N, Min).

	min([], Min, Min).
	min([N| Ns], Aux, Min) :-
		(	N @< Aux ->
			min(Ns, N, Min)
		;	min(Ns, Aux, Min)
		).

	new([]).

	nextto(X, Y, [X, Y| _]).
	nextto(X, Y, [_| Tail]) :-
		nextto(X, Y, Tail).

	nth0(Nth, List, Element) :-
		nth(Element, List, 0, Nth, _).

	nth0(Nth, List, Element, Tail) :-
		nth(Element, List, 0, Nth, Tail).

	nth1(Nth, List, Element) :-
		nth(Element, List, 1, Nth, _).

	nth1(Nth, List, Element, Tail) :-
		nth(Element, List, 1, Nth, Tail).

	nth(Element, List, Acc, Nth, Tail) :-
		(	integer(Nth),
			Nth >= Acc,
			nth_aux(NthElement, List, Acc, Nth, Tail) ->
			Element = NthElement
		;	var(Nth),
			nth_aux(Element, List, Acc, Nth, Tail)
		).

	nth_aux(Head, [Head| Tail], Position, Position, Tail).
	nth_aux(Head, [_| List], Count, Position, Tail) :-
		Count2 is Count + 1,
		nth_aux(Head, List, Count2, Position, Tail).

	partition([], _, [], [], []).
	partition([X| Xs], Y, Less, Equal, Greater) :-
		compare(Order, X, Y),
		partition(Order, X, Xs, Y, Less, Equal, Greater).
	
	partition(<, X, Xs, Y, [X| Less], Equal, Greater) :-
		partition(Xs, Y, Less, Equal, Greater).
	partition(=, X, Xs, Y, Less, [X| Equal], Greater) :-
		partition(Xs, Y, Less, Equal, Greater).
	partition(>, X, Xs, Y, Less, Equal, [X| Greater]) :-
		partition(Xs, Y, Less, Equal, Greater).

	permutation(List, Permutation) :-
		same_length(List, Permutation),
		permutation2(List, Permutation).

	permutation2([], []).
	permutation2(List, [Head| Tail]) :-
		select(Head, List, Remaining),
		permutation2(Remaining, Tail).

	prefix([], _).
	prefix([Element| Tail], [Element| Tail2]) :-
		prefix(Tail, Tail2).

	reverse(List, Reversed) :-
		reverse(List, [], Reversed, Reversed).

	reverse([], Reversed, Reversed, []).
	reverse([Head| Tail], List, Reversed, [_| Bound]) :-
		reverse(Tail, [Head| List], Reversed, Bound).

	same_length([], []).
	same_length([_| Tail1], [_| Tail2]) :-
		same_length(Tail1, Tail2).

	same_length(List1, List2, Length) :-
		(	integer(Length) ->
			same_length_length(Length, List1, List2)
		;	var(List1) ->
			same_length_list(List2, List1, 0, Length)
		;	same_length_list(List1, List2, 0, Length)
		).

	same_length_length(Length, List1, List2) :-
		(	Length =:= 0 ->
			List1 = [],
			List2 = []
		;	Length > 0,
			Length2 is Length - 1,
			List1 = [_| Tail1],
			List2 = [_| Tail2],
			same_length_length(Length2, Tail1, Tail2)
		).

	same_length_list([], [], Length, Length).
	same_length_list([_| Tail1], [_| Tail2], Acc, Length) :-
		Acc2 is Acc + 1,
		same_length_list(Tail1, Tail2, Acc2, Length).

	select(Head, [Head| Tail], Tail).
	select(Head, [Head2| Tail], [Head2| Tail2]) :-
		select(Head, Tail, Tail2).

	selectchk(Elem, List, Remaining) :-
		select(Elem, List, Rest) ->
		Remaining = Rest.

	sort(List, Sorted) :-
		{sort(List, Sorted)}.		

	sublist(List, List).
	sublist(Sublist, [Head| Tail]):-
		sublist(Tail, Head, Sublist).

	sublist(Sublist, _, Sublist).
	sublist([Head| Tail], _, Sublist):-
		sublist(Tail, Head, Sublist).
	sublist([Head| Tail], Element, [Element| Sublist]):-
		sublist(Tail, Head, Sublist).

	subsequence([], [], []).
	subsequence([Head| Tail], Subsequence, [Head| Remaining]) :-
		subsequence(Tail, Subsequence, Remaining).
	subsequence([Head| Tail], [Head| Subsequence], Remaining) :-
		subsequence(Tail, Subsequence, Remaining).

	subtract([], _, []).
	subtract([Head| Tail], List, Rest) :-
		(	memberchk(Head, List) ->
			subtract(Tail, List, Rest)
		;	Rest = [Head| Tail2],
			subtract(Tail, List, Tail2)
		).

	suffix(List, List).
	suffix(List, [_| Tail]) :-
		suffix(List, Tail).

	valid(-) :-		% catch variables and lists with unbound tails
		!,
		fail.
	valid([]).
	valid([_| List]) :-
		valid(List).

	check(Term) :-
		this(This),
		sender(Sender),
		(	valid(Term) ->
			true
		;	var(Term) ->
			throw(error(instantiation_error, This::check(Term), Sender))
		;	throw(error(type_error(This, Term), This::check(Term), Sender))
		).

:- end_object.
