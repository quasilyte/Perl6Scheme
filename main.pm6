use v6;

unit module Lisp::Core;

use Lisp::Scheme::Interpreter;

my $interactive = 0;
my $code = q:to/LISP/;
  (define loop (lambda (n arg fn)     
    (define iter (lambda (i)
      (apply fn (list arg))
      (if (= i n)
          "done"
          (iter (+ 1 i)))))
    (iter 1)))

  (define print (lambda (x) (display x)))  
  (loop 4 "hello?" print)
LISP
  
# (loop 3 (list "hello!") (lambda (msg) (display msg)))
sub repl {
    say "[SCHEME REPL]";
    say "   enter `:q` to exit REPL (or press ctrl+c)";

    my $interpreter = Lisp::Scheme::Interpreter.new;

    loop {
	my $input = prompt('>> ');
	last if $input eq ':q';
	say $interpreter.eval($input);
    }
}

if $interactive {
    repl
} else {
    Lisp::Scheme::Interpreter.new.run($code);
}
