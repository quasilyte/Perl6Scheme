use v6;
use Lisp::Scheme::Interpreter;
use Test;

my $interpreter = Lisp::Scheme::Interpreter.new;
  
my %t = '(let ([x 10] [y 2]) (+ x y))' => 12,
        '(let ([x 10]) (let ([y 2]) (+ x y)))' => 12;

plan %t.elems;

for %t.kv -> $given, $expected {
    is-deeply $interpreter.eval($given), $expected, "$given #=> $expected";
}

   
    
