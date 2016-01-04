use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;

my $code = q:to/LISP/;
  (define identity (lambda (x) x))
  (define naive-fib (lambda (x)
    (if (> x 2)
        (+ (naive-fib (- x 1))
	   (naive-fib (- x 2)))
        1)))
LISP

$interpreter.run($code);
  
my %t = '(identity 10)' => 10,
        '(identity true)' => True,
	'(naive-fib 2)' => 1,
	'(naive-fib 4)' => 3;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}

   
    

