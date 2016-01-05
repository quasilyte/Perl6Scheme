(define x (let ([x 10]) x))

;; ((lambda (x)
;;   ((lambda (y)
;;      (+ x y)) 2)) 10)
