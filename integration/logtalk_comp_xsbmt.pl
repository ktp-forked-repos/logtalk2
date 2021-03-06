
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Logtalk - Open source object-oriented logic programming language
%  Release 2.44.1
%  
%  Copyright (c) 1998-2012 Paulo Moura.        All Rights Reserved.
%  Logtalk is free software.  You can redistribute it and/or modify
%  it under the terms of the "Artistic License 2.0" as published by 
%  The Perl Foundation. Consult the "LICENSE.txt" file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- import stat_set_flag/2 from machine.	% workaround for compiling/loading source files
:- stat_set_flag(79, 1).				% when more than one thread is active

:- compiler_options([xpp_on]).

#include ../compiler/logtalk.pl

% tables of defined events and monitors
:- thread_shared('$lgt_before_event_'/5).
:- thread_shared('$lgt_after_event_'/5).

% tables of loaded entities, entity properties, and entity relations
:- thread_shared('$lgt_current_protocol_'/5).
:- thread_shared('$lgt_current_category_'/6).
:- thread_shared('$lgt_current_object_'/11).

:- thread_shared('$lgt_entity_property_'/2).

:- thread_shared('$lgt_implements_protocol_'/3).
:- thread_shared('$lgt_imports_category_'/3).
:- thread_shared('$lgt_instantiates_class_'/3).
:- thread_shared('$lgt_specializes_class_'/3).
:- thread_shared('$lgt_extends_protocol_'/3).
:- thread_shared('$lgt_extends_object_'/3).
:- thread_shared('$lgt_complemented_object_'/5).

% table of loaded files
:- thread_shared('$lgt_loaded_file_'/3).

% debugger status and tables
:- thread_shared('$lgt_debugging_entity_'/1).

:- thread_shared('$lgt_debugger.debugging_'/0).
:- thread_shared('$lgt_debugger.tracing_'/0).
:- thread_shared('$lgt_debugger.skipping_'/0).
:- thread_shared('$lgt_debugger.spying_'/2).
:- thread_shared('$lgt_debugger.spying_'/4).
:- thread_shared('$lgt_debugger.leashing_'/1).

% runtime flags
:- thread_shared('$lgt_current_flag_'/2).

% static binding caches
:- thread_shared('$lgt_static_binding_entity_'/1).
:- thread_shared('$lgt_send_to_obj_static_binding_cache_'/4).
:- thread_shared('$lgt_ctg_call_static_binding_cache_'/4).

% lookup caches for messages to an object, messages to self, and super calls
:- thread_shared('$lgt_send_to_obj_'/3).
:- thread_shared('$lgt_send_to_obj_ne_'/3).
:- thread_shared('$lgt_send_to_self_'/3).
:- thread_shared('$lgt_obj_super_call_same_'/3).
:- thread_shared('$lgt_obj_super_call_other_'/3).
:- thread_shared('$lgt_ctg_super_call_same_'/3).
:- thread_shared('$lgt_ctg_super_call_other_'/3).
:- thread_shared('$lgt_ctg_call_'/3).

% lookup cache for asserting and retracting dynamic facts
:- thread_shared('$lgt_db_lookup_cache_'/5).

% table of library paths
:- thread_shared(logtalk_library_path/2).

% compiler hook term and goal expansion:
:- thread_shared('$lgt_hook_term_expansion_'/2).
:- thread_shared('$lgt_hook_goal_expansion_'/2).

% multi-threading tags
:- thread_shared('$lgt_threaded_tag_counter_'/1).
:- thread_shared('$lgt_settings_file_loaded_'/1).
