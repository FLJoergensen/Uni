#lang racket
(require racket/trace)
;1
;;1.1
#|
Wenn die gegebene Function einen Parameter hat der eine Funtion sein soll.
|#
;;1.2
#|
a) Ja,da foldl einen Parameter hat der eine funktion sein muss
b) Nein, da x eine Zahl sein muss
?c) Ja, da f ein Parameter ist der als function für arg1 und arg2 verwendet wird
d) Nein, da x eine Zahl sein muss
|#
;;1.3
;;;?
;;1.4
#|
1: 2/3 ?
2: '((1 . 1) (2 . 2) (3 . 3) (4 . 4)) ?
3: '((a b) (())) ?
4: '(9941.0 212.0 32 33.8 1832.0 -459.66999999999996) ?
|#
;;1.5
;;;ZUSATZ

;2
;;2.1
(define (sqrtXS xs)
  (cond ((empty? xs) '())
        (else (cons (sqrt (car xs)) (sqrtXS (cdr xs))))))
;;2.2
(define (durch xs)
  (durch-Z 3 xs))
(define (durch-Z x xs)
  (cond ((empty? xs) '())
        ((= (modulo (car xs) x) 0) (cons (car xs) (durch-Z x (cdr xs))))
        (else (durch-Z x (cdr xs)))))
;;2.3
(define (SUM-Größer xs)
  (s-gößer-als-x 10 xs 0))
(define (s-gößer-als-x x xs acc)
  (cond ((empty? xs) '())
        ((and (odd? (car xs)) (< x (car xs)))
         (s-gößer-als-x x (cdr xs) (+ (car xs) acc)))
        (else (s-gößer-als-x x (cdr xs) acc))))
;3
(require se3-bib/setkarten-module)
;;3.1
;;;Spielkarte = '(1,'wave,'solid,'blue)
;;;KM = Kartenmerkmale
(define KM '((1 2 3)
             (waves oval rectangle)
             (outline solid hatched)
             (red green blue)))
;;;kp weil es einfacher ist
;;3.2
(define (drawCard xs)
  (show-set-card (car xs) (cadr xs) (caddr xs) (cadddr xs)))
(define (drawCards)
  (map drawCard (genDeck)))
(define (genDeck)
  (genALLcards KM 0 '()))
(define (genALLcards xss acc XS)
  (cond ((= acc 81) XS)
        (else (genALLcards xss (+ 1 acc) (cons
                                          (list (list-ref (car KM) (modulo acc 3))
                                                (list-ref (cadr KM) (modulo (round (/ acc 3)) 3))
                                                (list-ref (caddr KM) (modulo (round (/ acc (expt 3 2))) 3))
                                                (list-ref (cadddr KM) (modulo (round (/ acc (expt 3 3))) 3))) XS)))))
;;3.3
(define (is-a-set?2 . xs)
  (let [(XS (map car xs))]
    (cond ((empty? (cdar xs)) (display XS) (or (is-all-same? XS) (is-all-different? XS)))
          (else (and (or (is-all-same? XS) (is-all-different? XS)) (is-a-set? (map cdr xs)))))))
(define (is-a-set? xs1 xs2 xs3)
  (let [(XS (map car (list xs1 xs2 xs3)))]
    (cond ((empty? (cdr xs1)) (or (is-all-same? XS) (is-all-different? XS)))
          (else (and (or (is-all-same? XS) (is-all-different? XS)) (is-a-set? (cdr xs1) (cdr xs2) (cdr xs3)))))))
(define (is-in? x xs)
  (cond ((empty? xs) #f)
        ((equal? x (car xs)) #t)
        (else (is-in? x (cdr xs)))))
(define (is-all-same? xs)
  (foldl (lambda (x y)(and x y)) #t (map (curry equal? (car xs)) xs)))
(define (is-all-different? xs)
  (i-a-d? xs '()))
(define (i-a-d? xs XS)
  (cond ((empty? xs) #t)
        ((is-in? (car xs) XS) #f)
        (else (i-a-d? (cdr xs) (cons (car xs) XS)))))
#|
(is-a-set? '(2 red oval hatched)
             '(2 red rectangle hatched)
             '(2 red wave hatched))
(is-a-set? '(2 red rectangle outline)
             '(2 green rectangle outline)
             '(1 green rectangle solid))
|#
;(trace is-a-set?)
;;3.4
(define (ran-count x xs)
  (r-c (shuffle xs) x '()))
(define (r-c xs acc XS)
  (cond ((= acc 0) XS)
        (else (r-c (cdr xs) (- acc 1) (cons (car xs) XS)))))
(ran-count 12 (genDeck))