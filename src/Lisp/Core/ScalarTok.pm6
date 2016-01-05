use v6;

use Lisp::Core::BaseTok;

unit class Lisp::Core::ScalarTok is Lisp::Core::BaseTok is export;

method Str { "atom($.val)" }
