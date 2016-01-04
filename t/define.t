use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;

my $code = q:to/LISP/;
  (define x 10)
  (define xx x)
  (define y 11)
  (define yy y)
  (set! x 0)
  (set! y 1)
LISP

$interpreter.run($code);

my %t = 'x' => 0,
        'y' => 1,
	'xx' => 10,
	'yy' => 11;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}
