#lang racket
(require racket/set)

;1
(define spiel #(0 0 0 0 0 9 0 7 0
                  0 0 0 0 8 2 0 5 0
                  3 2 7 0 0 0 0 4 0
                  0 1 6 0 4 0 0 0 0
                  0 5 0 0 0 0 3 0 0
                  0 0 0 0 9 0 7 0 0
                  0 0 0 6 0 0 0 0 5
                  8 0 2 0 0 0 0 0 0
                  0 0 4 2 0 0 0 0 8))
;;1.1.1
(define (xy->index x y)
  (+ x (* y 9)))
;;1.1.2
(define (zeile->indizes x)
  (map (lambda (z) (+ z (* x 9))) '(0 1 2 3 4 5 6 7 8)))
(define (spalte->indizes y)
  (map (lambda (z) (+ z y)) '(0 9 18 27 36 45 54 63 72)))
(define (quadrant->indizes x)
  (q->i (modulo x 3) (truncate (/ x 3))))
(define (q->i x y)
  (map (lambda (z) (+ z (* x 3) (* y 3 9) )) '(0 1 2 9 10 11 18 19 20)))
;;1.1.3
(define (spiel->eintraege game xs)
  (map (lambda (x) (vector-ref game x)) xs))
;;1.1.4
(define (sequenz-konsistent? xs)
  (cond ((empty? xs) #t)
        ((equal? 0 (car xs)) (sequenz-konsistent? (cdr xs)))
        ((foldl (lambda (x i) (and (not (equal? (car xs) x)) i)) #t (cdr xs)) (sequenz-konsistent? (cdr xs)))
        (else #f)))
(define (s-k? xs)
  (sequenz-konsistent? xs))
(define (spiel-konsistent? game)
  (and
   (foldl (lambda (x i) (and (s-k? (spiel->eintraege game (zeile->indizes x))) i)) #t (range 9))
   (foldl (lambda (x i) (and (s-k? (spiel->eintraege game (spalte->indizes x))) i)) #t (range 9))
   (foldl (lambda (x i) (and (s-k? (spiel->eintraege game (quadrant->indizes x))) i)) #t (range 9))))
(define (spiel-geloest? game)
  (and (spiel-konsistent? game) (not (member 0 (vector->list game)))))