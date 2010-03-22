
:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Parker Jones and Paulo Moura',
		date is 2010/03/16,
		comment is 'Unit tests for the "complements" example.']).

	test(complements_1) :-
		complements_object(Category, Object),
		Category==logging, Object==employee.

	test(complements_2) :-
		employee::name(Name),
		Name == john.

	test(complements_3) :-
		employee::predicates(Predicates),
		list::msort(Predicates, PredicatesSorted),
		PredicatesSorted = [after/3, age/1, before/3, income/1, name/1, predicates/1, salary/1].

	test(complements_4) :-
		findall(Property, employee::predicate_property(predicates(_), Property), Properties),
		list::msort(Properties, PropertiesSorted),
		PropertiesSorted = [public, static, declared_in(logging), defined_in(logging)].

	test(complements_5) :-
		findall(Property, employee::predicate_property(income(_), Property), Properties),
		list::msort(Properties, PropertiesSorted),
		PropertiesSorted = [public, static, alias_of(salary(_)), declared_in(employee), defined_in(employee)].

:- end_object.