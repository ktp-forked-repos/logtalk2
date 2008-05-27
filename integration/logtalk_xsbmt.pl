
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Logtalk - Open source object-oriented logic programming language
%  Release 2.31.7
%
%  Copyright (c) 1998-2008 Paulo Moura.  All Rights Reserved.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- import expand_atom/2 from standard.

:- expand_atom('$LOGTALKUSER/configs/xsb.config', Config), reconsult(Config).
:- expand_atom('$LOGTALKHOME/integration/logtalk_comp_xsbmt.pl', Compiler), reconsult(Compiler).
:- expand_atom('$LOGTALKUSER/libpaths/libpaths.pl', Libpaths), reconsult(Libpaths).
