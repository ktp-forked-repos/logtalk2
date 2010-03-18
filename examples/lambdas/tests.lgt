
:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Parker Jones and Paulo Moura',
		date is 2010/03/16,
		comment is 'Unit tests for the "lambdas" example.']).

	:- discontiguous(succeeds/1).
	:- discontiguous(throws/2).

	succeeds(lambdas_1) :-
		logtalk << call([X,Y]>>(Y is X*X), 5, R),
		R == 25.

	succeeds(lambdas_2) :-
		logtalk << call([Z]>>(call([X,Y]>>(Y is X*X), 5, R), Z is R*R), T),
		T == 625.

	succeeds(lambdas_3) :-
		meta::map([X]>>(X>3),[4,5,9]).

	succeeds(lambdas_4) :-
		meta::map([X,Y]>>(X=A-B,Y=B-A), [1-a,2-b,3-c], Zs),
		Zs == [a-1,b-2,c-3].

	succeeds(lambdas_5) :-
		meta::map([X,B-A]>>(X=A-B), [1-a,2-b,3-c], Zs),
		Zs == [a-1,b-2,c-3].

	succeeds(lambdas_6) :-
		meta::map([A-B,B-A]>>true, [1-a,2-b,3-c], Zs),
		Zs == [a-1,b-2,c-3].

	succeeds(lambdas_7) :-
		meta::map([A-B]>>([B-A]>>true), [1-a,2-b,3-c], Zs) ->
		Zs == [a-1,b-2,c-3].

	succeeds(lambdas_8) :-
		Points = [(1,4),(2,5),(8,3)], meta::map([(X,Y),Z]>>(Z is sqrt(X*X + Y*Y)), Points, Distances),
		Distances = [Distance1, Distance2, Distance3],
		Error1 is abs(Distance1 - 4.1231056256176606),
		Error2 is abs(Distance2 - 5.3851648071345037),
		Error3 is abs(Distance3 - 8.5440037453175304),
		Error1 < 0.00001, Error2 < 0.00001, Error3 < 0.00001, Points == [(1,4),(2,5),(8,3)].

	succeeds(lambdas_9) :-
		Points = [(1,4),(2,5),(8,3)], meta::map([(X,Y)]>>([Z]>>(Z is sqrt(X*X + Y*Y))), Points, Distances),
		Distances = [Distance1, Distance2, Distance3],
		Error1 is abs(Distance1 - 4.1231056256176606),
		Error2 is abs(Distance2 - 5.3851648071345037),
		Error3 is abs(Distance3 - 8.5440037453175304),
		Error1 < 0.00001, Error2 < 0.00001, Error3 < 0.00001, Points == [(1,4),(2,5),(8,3)].

	succeeds(lambdas_10) :-
		meta::map([[X,Y],Z]>>(Z is X*X + Y*Y), [[1,2],[3,4],[5,6]], Result),
		Result == [5,25,61].

	succeeds(lambdas_11) :-
		meta::map([[X,Y]]>>([Z]>>(Z is X*X + Y*Y)), [[1,2],[3,4],[5,6]], Result),
		Result == [5,25,61].

	succeeds(lambdas_12) :-
		Xsss = [[[1,2,3],[4]],[[5]]], meta::map(meta::map(meta::map([X,Y]>>(Y is X+3))), Xsss,  Ysss),
		Xsss == [[[1,2,3],[4]],[[5]]], Ysss == [[[4,5,6],[7]],[[8]]].

	succeeds(lambdas_13) :-
		meta::map([X,[X]]>>true,[1,2],Ys),
		Ys == [[1],[2]].

	succeeds(lambdas_14) :-
		meta::map([X,[X]]>>true,Xs,[[1],[2]]),!,         %%%% need to check whether there should be a choicepoint.
		Xs == [1,2].

	succeeds(lambdas_15) :-
		meta::map([N,M]>>(list::length(L, N), list::length([_|L], M)), [999,123],R),
		R == [1000,124].

	succeeds(lambdas_16) :-
		meta::map([N]>>([M]>>(list::length(L, N), list::length([_|L], M))), [999,123],R),
		R == [1000,124].

	succeeds(lambdas_17) :-
		logtalk << ([]>>true).

	succeeds(lambdas_18) :-
		logtalk << ({}/true).

	succeeds(lambdas_19) :-
		logtalk << ({}/[]>>true).

	succeeds(lambdas_20) :-
		logtalk << ({_}/true).

	throws(lambdas_21, error(representation_error(lambda_parameters), _,_)) :-
		logtalk << ({X}/[X]>>true).

	throws(lambdas_22, error(representation_error(lambda_parameters), _,_)) :-
		meta::map({X}/[X]>>char_code(X), [a,b,c], _).

	throws(lambdas_23, error(representation_error(lambda_parameters), _,_)) :-
		meta::map([X,_,_]>>char_code(X), [a,b,c], _).

	succeeds(lambdas_24) :-
		findall(Currencies, countries::currencies_wrong(Currencies), Solutions),
		list::msort(Solutions, SolutionsSorted),
		SolutionsSorted==[[dinar], [dinar], [euro], [euro], [pound_sterling], [ringgit]].
		
	succeeds(lambdas_25) :-
		countries::currencies_no_lambda(Currencies),
		Currencies==[dinar, euro, pound_sterling, ringgit].

	succeeds(lambdas_26) :-
		countries::currencies_lambda(Currencies),
		Currencies==[dinar, euro, pound_sterling, ringgit].

	succeeds(lambdas_27) :-
		sigma::sum([X,Y]>>(Y is X), 0, 9, R),
		R == 45.

	succeeds(lambdas_28) :-
		sigma::sum([X,Y]>>(Y is X*X), 0, 9, R),
		R == 285.

	succeeds(lambdas_29) :-
		sigma::sum([X,Y]>>sum([W,Z]>>(Z is W), X, 9, Y), 0, 9, R),
		R == 330.

:- end_object.
