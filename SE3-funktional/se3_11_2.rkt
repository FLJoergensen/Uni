#lang lazy

(require racket/format)
;2
(define (BöseSieben x)
  (cond ((= 0 (modulo x 7)) (cons 'sum (BöseSieben (+ x 1))))
        ((member #\7 (string->list (~a x))) (cons 'sum (BöseSieben (+ x 1))))
        (else (cons x (BöseSieben (+ x 1))))))
;3