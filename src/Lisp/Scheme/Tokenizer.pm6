use v6;

use Lisp::Core::Tokenizer;

unit class Lisp::Scheme::Tokenizer is Lisp::Core::Tokenizer;

method list:sym<brackets>($/) { self.make_list($/) }
