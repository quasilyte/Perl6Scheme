use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;
  
my %t = '(+ 1 2)' => 3,
        '(- 9 3)' => 6,
        '(* 3 5)' => 15,
	'(/ 10 2)' => 5.0;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}

   
