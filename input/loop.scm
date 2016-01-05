(define loop
  (lambda (n arg fn)     
    (define iter
      (lambda (i)
	(apply fn (list arg))
	(if (= i n)
	    "done"
	    (iter (+ 1 i)))))
    (iter 1)))

(define print (lambda (x) (display x)))  
(loop 4 "hello?" print)
