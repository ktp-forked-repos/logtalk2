
:- object(object).

	:- info([
		version is 1.2,
		author is pm,
		date is 2009/6/12,
		comment is 'Example object for illustrating the use of compiler hooks.',
		license is artistic2]).

	:- public(out/0).

	out :-
		write('A'), nl,
		write(x(A, A)), nl,
		write(3), nl.

	:- local_data(item/1).

	item(zeta).
	item(omega).
	item(alpha).

	:- public(items/1).

	items(Items) :-
		findall(Item, item(Item), Items).

:- end_object.
