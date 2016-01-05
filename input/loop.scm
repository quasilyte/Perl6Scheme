(define (loop n arg fn)
  (define (iter i)
    (apply fn (list arg))
    (if (= i n)
	"done"
	(iter (+ 1 i))))
  (iter 1))

(define (print x) (display x))
(loop 4 "hello?" print)
