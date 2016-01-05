use v6;

use Lisp::Core::BaseTok;

unit class Lisp::Core::SymTok is Lisp::Core::BaseTok is export;

method Str { "sym($.val)" }
