use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;

my %t = '(list 1 2)' => (1, 2),
        '(cdr (list 1 2 3))' => (2, 3),
	'(car (list 1 2 3))' => 1,
	'(car (cdr (cdr (list 1 2 (list 3 4) 5))))' => (3, 4);

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}

