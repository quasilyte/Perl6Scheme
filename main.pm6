use v6;

unit module Lisp::Core;

use Lisp::Scheme::Interpreter;

#TODO: those should be tests in /t directory

my $code = q:to/LISP/;
  (define x 100)
  (display x)
  (set! x 20)
  (display x)
  (if (= x 20)
      (display "yes")
      (display "no"))
LISP  

# Lisp::Scheme::Interpreter.new.run($code);

$code = q:to/LISP/;
  (define countdown (lambda (n)
    (display n)
    (if (= 0 n)
        n
        (countdown (- n 1)))))
  
  (countdown 5)
LISP  

# Lisp::Scheme::Interpreter.new.run($code);

$code = q:to/LISP/;
  (define high-order (lambda (fn)
    (fn)))

  (high-order (lambda () (display "it works!")))
LISP

# Lisp::Scheme::Interpreter.new.run($code);

$code = q:to/LISP/;
  (define sqr (lambda (x) (* x x)))
  (display (apply sqr (list 3)))
LISP

Lisp::Scheme::Interpreter.new.run($code);
