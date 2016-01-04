use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;
  
my %t = '(and true true)' => True,
        '(and false true)' => False,
        '(and true false)' => False,
	'(and false false)' => False,
	'(or true true)' => True,
	'(or false true)' => True,
	'(or true false)' => True,
	'(or false false)' => False,
	'(if true 1 0)' => 1,
	'(if false 1 0)' => 0;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}