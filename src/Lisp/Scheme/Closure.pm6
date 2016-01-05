use v6;

unit class Lisp::Scheme::Closure;

has @.exprs;
has @.params;

#TODO: closure should have captured environment
