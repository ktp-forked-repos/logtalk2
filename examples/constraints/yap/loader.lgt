
:- initialization((
	ensure_loaded(library(clpfd)),
	logtalk_load(library(metapredicates_loader)),
	logtalk_load([hexagon, queens, puzzle, sudoku]))).
