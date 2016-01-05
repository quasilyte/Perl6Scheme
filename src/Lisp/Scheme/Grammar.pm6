use v6;

use Lisp::Core::Grammar;

unit class Lisp::Scheme::Grammar is Lisp::Core::Grammar;

rule list:sym<brackets> { '[' ~ ']' <elts> }
