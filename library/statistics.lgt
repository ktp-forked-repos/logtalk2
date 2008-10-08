
:- category(statistics,
	implements(statisticsp)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2008/10/4,
		comment is 'Statistical calculations over a list of numbers.']).

	arithmetic_mean([X| Xs], Mean) :-
		arithmetic_mean(Xs, 1, _, X, Mean).

	arithmetic_mean([], Length, Length, Sum, Mean) :-
		Mean is Sum / Length.
	arithmetic_mean([X| Xs], Lacc, Length, Sacc, Mean) :-
		Lacc2 is Lacc + 1,
		Sacc2 is Sacc + X,
		arithmetic_mean(Xs, Lacc2, Length, Sacc2, Mean).

	geometric_mean([X| Xs], Mean) :-
		geometric_mean(Xs, 1, X, Mean).

	geometric_mean([], Length, Product, Mean) :-
		Mean is Product ** (1.0 / Length).
	geometric_mean([X| Xs], Lacc, Pacc, Mean) :-
		Lacc2 is Lacc + 1,
		Pacc2 is Pacc * X,
		geometric_mean(Xs, Lacc2, Pacc2, Mean).

	harmonic_mean([X| Xs], Mean) :-
	    Sum is 1.0 / X,
		harmonic_mean(Xs, 1, Sum, Mean).

	harmonic_mean([], Length, Sum, Mean) :-
		Mean is Length / Sum.
	harmonic_mean([X| Xs], Lacc, Sacc, Mean) :-
		Lacc2 is Lacc + 1,
		Sacc2 is Sacc + 1.0 / X,
		harmonic_mean(Xs, Lacc2, Sacc2, Mean).

    mean_deviation([X| Xs], Deviation) :-
        arithmetic_mean(Xs, 1, Length, X, Mean),
        average_deviation([X| Xs], Mean, 1, Length, 0, Sum),
        Deviation is Sum / Length.

    median_deviation([X| Xs], Deviation) :-
        median([X| Xs], Median, Length),
        average_deviation([X| Xs], Median, 1, Length, 0, Sum),
        Deviation is Sum / Length.

    average_deviation([X| Xs], CentralTendency, Deviation) :-
        average_deviation([X| Xs], CentralTendency, 1, Length, 0, Sum),
        Deviation is Sum / Length.

    average_deviation([], _, Length, Length, Sum, Sum).
    average_deviation([X| Xs], CentralTendency, Lacc, Length, Sacc, Sum) :-
		Lacc2 is Lacc + 1,
		Sacc2 is Sacc + abs(X - CentralTendency),
        average_deviation(Xs, CentralTendency, Lacc2, Length, Sacc2, Sum).

    standard_deviation([X| Xs], Deviation) :-
        X2 is X ** 2,
        standard_deviation(Xs, 1, Length, X2, Squares, X, Mean),
        Deviation is sqrt(Squares / Length - Mean ** 2).

    standard_deviation([], Length, Length, Squares, Squares, Sum, Mean) :-
    	Mean is Sum / Length.
    standard_deviation([X| Xs], Lacc, Length, Sacc, Squares, Macc, Mean) :-
		Lacc2 is Lacc + 1,
		Sacc2 is Sacc + X ** 2,
        Macc2 is Macc + X,
        standard_deviation(Xs, Lacc2, Length, Sacc2, Squares, Macc2, Mean).

    coefficient_of_variation([X| Xs], Coefficient) :-
        standard_deviation([X| Xs], Deviation),
        arithmetic_mean([X| Xs], Mean),
        Coefficient is Deviation / Mean.

    relative_standard_deviation(Xs, Percentage) :-
        coefficient_of_variation(Xs, Coefficient),
        Percentage is Coefficient * 100.

    variance([X| Xs], Variance) :-
        variance(Xs, 1, Length, X, 0, M2),
        Variance is M2 / (Length - 1).

    variance([], Length, Length, _, M2, M2).
    variance([X| Xs], Lacc, Length, Mean, M2acc, M2) :-
		Lacc2 is Lacc + 1,
		Delta is X - Mean,
        Mean2 is Mean + Delta/Lacc2,
        M2acc2 is M2acc + Delta*(X - Mean2),
        variance(Xs, Lacc2, Length, Mean2, M2acc2, M2).

    squares_and_cubes([], _, Squares, Squares, Cubes, Cubes).
    squares_and_cubes([X| Xs], Mean, Sacc, Squares, Cacc, Cubes) :-
        Sacc2 is Sacc + (X - Mean) ** 2,
        Cacc2 is Cacc + (X - Mean) ** 3,
        squares_and_cubes(Xs, Mean, Sacc2, Squares, Cacc2, Cubes).

    median([X| Xs], Median) :-
        median([X| Xs], Median, _).

    median([X| Xs], Median, Length) :-
        quicksort([X| Xs], [], Sorted, 0, Length),
        (   Length mod 2 =:= 1 ->
            Middle is Length // 2 + 1,
            middle_element(1, Middle, Sorted, Median)
        ;   Left is Length // 2,
            middle_elements(1, Left, Sorted, XLeft, XRight),
            Median is XLeft + (XRight - XLeft) / 2
        ).

	quicksort([], Sorted, Sorted, Length, Length).
	quicksort([Pivot| List], Aux, Sorted, Acc, Length) :-
		partition(List, Pivot, Small, Large),
		Acc2 is Acc + 1,
		quicksort(Large, Aux, Sorted1, Acc2, Acc3),
		quicksort(Small, [Pivot| Sorted1], Sorted, Acc3, Length).

	partition([], _, [], []).
	partition([X| Xs], Pivot, Small, Large) :-
		(	X < Pivot ->
			Small = [X| Small1], Large = Large1
		;	Small = Small1, Large = [X| Large1]
		),
		partition(Xs, Pivot, Small1, Large1).

    middle_element(N, N, [X| _], X) :-
        !.
    middle_element(M, N, [_| Xs], X) :-
        M2 is M + 1,
        middle_element(M2, N, Xs, X).

    middle_elements(N, N, [X1, X2| _], X1, X2) :-
        !.
    middle_elements(M, N, [_| Xs], X1, X2) :-
        M2 is M + 1,
        middle_elements(M2, N, Xs, X1, X2).

	min([X| Xs], Min) :-
		min(Xs, X, Min).

	min([], Min, Min).
	min([X| Xs], Aux, Min) :-
		(	X < Aux ->
			min(Xs, X, Min)
		;	min(Xs, Aux, Min)
		).

	max([X| Xs], Max) :-
		max(Xs, X, Max).

	max([], Max, Max).
	max([X| Xs], Aux, Max) :-
		(	X > Aux ->
			max(Xs, X, Max)
		;	max(Xs, Aux, Max)
		).

    range([X| Xs], Range) :-
		range(Xs, X, Min, X, Max),
		Range is Max - Min.

    range([], Min, Min, Max, Max).
    range([X| Xs], CurrentMin, Min, CurrentMax, Max) :-
        (   X < Min ->
            range(Xs, X, Min, CurrentMax, Max)
        ;   X > Max ->
            range(Xs, CurrentMin, Min, X, Max)
        ;   range(Xs, CurrentMin, Min, CurrentMax, Max)
        ).

	product([X| Xs], Product) :-
		product(Xs, X, Product).

	product([], Product, Product).
	product([X| Xs], Acc, Product) :-
		Acc2 is Acc * X,
		product(Xs, Acc2, Product).

	sum([X| Xs], Sum) :-
		sum(Xs, X, Sum).

	sum([], Sum, Sum).
	sum([X| Xs], Acc, Sum) :-
		Acc2 is Acc + X,
		sum(Xs, Acc2, Sum).

	valid(-) :-		% catch variables and lists with unbound tails
		!,
		fail.
	valid([]).
	valid([Element| List]) :-
		number(Element),
		valid(List).

:- end_category.