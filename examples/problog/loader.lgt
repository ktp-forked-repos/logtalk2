
:- initialization((
	logtalk_load([problog, hook], [reload(skip)]),		% allow for static binding
	logtalk_load([graph, office, learn_graph, viralmarketing], [hook(hook)])
)).