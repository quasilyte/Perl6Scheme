use v6;

use Lisp::Core::BaseTok;

unit class Lisp::Core::ListTok is Lisp::Core::BaseTok is export;

method Str { "list[$.val]" }
