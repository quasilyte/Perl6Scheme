use v6;

unit module Lisp::Scheme::utils;

use Lisp::Scheme::Grammar;
use Lisp::Scheme::Tokenizer;

sub tokenize_scheme(Str $input) is export {
    Lisp::Scheme::Grammar.parse(
	$input,
    	:actions(Lisp::Scheme::Tokenizer.new())
    ).made
}

sub parse_scheme(Str $input) is export {
    Lisp::Scheme::Grammar.parse($input)
}
