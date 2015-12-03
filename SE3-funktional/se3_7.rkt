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
;;;(function->points (curry + 2) 10 5)
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
;;2.3
(require 2htdp/image)
(require lang/posn)
;(place-image (ellipse 10 10 "solid" "blue") 0 0 (empty-scene 800 600))
(define SCENE (empty-scene 800 600))
(define (draw-points xs)
  (place-images
   (map (lambda (x)(ellipse 10 10 "solid" "blue")) xs)
   (map (lambda (x)(make-posn (car x) (cdr x)))
        (rescale2d xs '(0 . 800) '(0 . 600)))
   SCENE))

(define (draw-points2 xs)
  (map
   (curryr draw-point SCENE)
       (rescale2d xs '(0 . 800) '(0 . 600))))
(define (draw-point XY s)
  (place-image (ellipse 10 10 "solid" "blue") (car XY) (cdr XY) s))
;;2.4
(define (function->plot func x acc)
  (draw-points (function->points func x acc)))