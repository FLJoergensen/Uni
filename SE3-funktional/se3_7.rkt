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
(define (max-of-list xs)
  (m-o-l xs 0))
(define (m-o-l xs acc)
  (cond ((empty? xs) acc)
        ((< acc (car xs)) (m-o-l (cdr xs) (car xs)))
        (else (m-o-l (cdr xs) acc))))
(define (scaleList xs)
  (map (curryr / (max-of-list xs)) xs))
(define (rescale1d xs x)
  (map (curry + (car x)) (map (curry * (- (cdr x) (car x))) (scaleList xs))))
(define (rescale2d xs xX xY)
  (map cons (rescale1d (map car xs) xX) (rescale1d (map cdr xs) xY)))