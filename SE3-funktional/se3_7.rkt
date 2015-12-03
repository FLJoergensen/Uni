#lang racket

;1
;;1.1
(define (range x acc)
  (reverse (r x acc (/ (- (cdr x) (car x)) acc))))
(define (r x acc x2)
  (cond ((= acc 0) '())
        (else (cons (+ (car x) (* (- acc 1) x2)) (r x (- acc 1) x2)))))
(range '(0 . 10) 5)
;;1.2
(define (range2 x acc)
  (r2 x acc (/ (- (cdr x) (car x)) acc) '()))
(define (r2 x acc x2 accxs)
  (cond ((= acc 0) accxs)
        (else (r2 x (- acc 1) x2 (cons (+ (car x) (* (- acc 1) x2)) accxs)))))
(range2 '(0 . 10) 5)
;;1.3
(define (range3 x acc)
  (map (curry + (car x)) (build-list acc (lambda (y) (* y (/ (- (cdr x) (car x)) acc))))))
(range3 '(0 . 10) 5)

(define Range range3)
;2
;;2.1
(define (function->points func x acc)
  (map cons
       (Range x acc)
       (map func (Range x acc))))
;;2.2