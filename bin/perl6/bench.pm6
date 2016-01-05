use v6;

use Lisp::Scheme::Interpreter;

my $code = q:to/LISP/;
  (define a 10)
  (define b 20)
  (define c (+ a b))

  (define up-to (lambda (upper)
    (define iter (lambda (current)
      (if (= current upper)
          current
          (iter (+ 1 current)))))
    (iter 0)))
		   
  (set! a (up-to 10))

  (define loop (lambda (n arg fn)     
    (define iter (lambda (i)
      (apply fn (list arg i))
      (if (= i n)
          "done"
          (iter (+ 1 i)))))
    (iter 1)))

  ((lambda (x) x) 10)
  
  (define idle (lambda (x i)
    (set! b (list 1 2 3 4))
    (if (= i (car (cdr b)))
      (+ (if true x a))
      (* (if false x a)))))
  (loop 10 3 idle)
LISP

my $elapsed;
my $min_elapsed = 999999;

for 0..9 {
    $elapsed = now;

    my $interpreter = Lisp::Scheme::Interpreter.new;
    $interpreter.run($code);
    
    $min_elapsed = min(now - $elapsed, $min_elapsed);
}

say $min_elapsed;
