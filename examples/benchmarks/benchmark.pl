
% benchmark a goal using a default number of repetitions and printing some 
% useful statistics

benchmark(Goal) :-
	N = 1000000,
	write('Number of repetitions: '), write(N), nl,
	'$lgt_cpu_time'(Seconds1),		% defined in the config files
	benchmark(N, Goal),
	'$lgt_cpu_time'(Seconds2),
	Average is (Seconds2 - Seconds1)/N,
	write('Average time per call: '), write(Average), write(' seconds'), nl,
	Speed is 1.0/Average,
	write('Number of calls per second: '), write(Speed), nl.


% repeat a goal N times using a failure-driven loop to avoid the interference 
% of Prolog compiler memory management mechanism (such as garbage collection) 
% on the results

benchmark(N, Goal) :-
	repeat(N),		% another option would be to use a between/3 built-in predicate
		call(Goal),
	fail.

benchmark(_, _).


% some Prolog compilers define the predicate repeat/1 as a built-in predicate;
% if that's the case of the Prolog compiler you are using, then comment out 
% the definition that follows

repeat(_).

repeat(N) :-
	N > 1,
	N2 is N - 1,
	repeat(N2).
