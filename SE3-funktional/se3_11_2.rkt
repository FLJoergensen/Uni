#lang lazy

(require racket/format
         se3-bib/tools-module)
;2
(define (BöseSieben x)
  (cond ((= 0 (modulo x 7)) (cons 'sum (BöseSieben (+ x 1))))
        ((member #\7 (string->list (~a x))) (cons 'sum (BöseSieben (+ x 1))))
        (else (cons x (BöseSieben (+ x 1))))))
;3
(define (Fib x)
  (cond ((= x 0) 0)
        ((< x 3) 1)
        (else (+ (Fib (- x 1)) (Fib (- x 2))))))

(define memoFib (memo Fib))
(set! Fib memoFib)