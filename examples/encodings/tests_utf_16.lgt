:- encoding('UTF-16').		% this directive, when present, must be the first
							% term, in the first line, of a source file

:- object(tests_utf_16,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Parker Jones and Paulo Moura',
		date is 2010/03/16,
		comment is 'Unit tests for the "encodings" example.']).

	test(encodings_utf_16_1) :-
		findall(Name-Capital-Country, asian::country(Country, Name, Capital), Solutions),
		Solutions == ['中国'-'北京'-china, '日本'-'東京'-japan, 'Монгол Улс'-'Улаанбатаар'-mongolia, '臺灣'-'臺北'-taiwan, 'Тоҷикистон'-'Душанбе'-tajikistan].

:- end_object.
