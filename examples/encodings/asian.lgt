
:- encoding('UTF-16').		% this directive, when present, must be the first term in a source file


:- object(asian).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2008/01/16,
		comment is 'Simple test of the encoding/1 directive.']).

	:- public(country/3).
	:- mode(country(?atom, ?atom, ?atom), zero_or_more).
	:- info(country/3, [
		comment is 'Table of native names and capitals for some Asian countries.',
		argnames is ['Country', 'NativeName', 'Capital']]).

	country(china, '中国', '北京').
	country(japan, '日本', '東京').
	country(mongolia, 'Монгол Улс', 'Улаанбатаар').
	country(taiwan, '臺灣', '臺北').
	country(tajikistan, 'Тоҷикистон', 'Душанбе').

:- end_object.
