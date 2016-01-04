use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;
  
my %t = '(= 1 1)' => True,
        '(= 1 1 1)' => True,
        '(= 1 0 1)' => False,
	'(= 5 3 1 3)' => False,
	'(= 0 0 0)' => True,
	'(> 4 0)' => True,
	'(> 4 4)' => False,
	'(> 0 4)' => False,
	'(> 6 4 2)' => True,
	'(>= 4 0)' => True,
	'(>= 4 4)' => True,
	'(>= 0 4)' => False,
	'(>= 6 6 4 2)' => True,
	'(< 4 0)' => False,
	'(< 4 4)' => False,
	'(< 0 4)' => True,
	'(< 2 4 6)' => True,
	'(<= 4 0)' => False,
	'(<= 4 4)' => True,
	'(<= 0 4)' => True,
	'(<= 2 4 6 6)' => True;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}

