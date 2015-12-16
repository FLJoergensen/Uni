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
c) Ja, da f ein Parameter ist der als function für arg1 und arg2 verwendet wird
d) Nein, da x eine Zahl sein muss
|#
;;1.3
#|
(pepper max 5) = procedur:f=max,arg1=5,arg2=?
((pepper max 5)7)=procedur:f=max,arg2=5,arg2=7
|#
;;1.4
#|
1: 2/3 ?
2: '((1 . 1) (2 . 2) (3 . 3) (4 . 4)) ?
3: '((a b) (())) ?
4: '(9941.0 212.0 32 33.8 1832.0 -459.66999999999996) ?
|#
;;1.5
;;; die ursprungs Function wandeld °C in Fahrenheit um
(compose (curryr / 18) (curryr - 32))

;2
;;2.1
(define (sqrtXS xs)
  (map sqrt xs))
;;2.2
(define (durch xs)
  (durch-Z 3 xs))
(define (durch-Z x xs)
  (filter (compose (curry = 0) (curryr / x)) xs))
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
;;;Spielkarte = (Card 1 'wave 'solid 'blue)
;;;KM = Kartenmerkmale
(define KM '((1 2 3)
             (waves oval rectangle)
             (outline solid hatched)
             (red green blue)))
(define (Card count img fill color)
  (lambda (x)
    (cond ((equal? x "anzahl") count)
          ((equal? x "bild") img)
          ((equal? x "fill") fill)
          ((equal? x "farbe") color)
          ((equal? x "AsList") `(,count ,img ,fill ,color))
          (else (error "Kein gültiges Argument")))))
;;;Da mit wir eine art object haben und trozdem mit listen arbeiten können
;;3.2
(define (Card-Draw c)
  (drawCard (c "AsList")))
(define (Card-Deck)
  (map (lambda (x) (apply Card x)) (genDeck)))

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
(define (Card-Set? c1 c2 c3)
  (is-a-set? (c1 "AsList") (c2 "AsList") (c3 "AsList")))
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

(define (erstelle-Liste v acc)
  (cond ((= acc 0) '())
        (else (cons v (erstelle-Liste v (- acc 1))))))
(define (Alle-Möglichen x xs)
  (cond ((= x 1) (map list xs))
        (else (all-pos xs (Alle-Möglichen (- x 1) xs)))))
(define (all-pos xs xsbase)
  (apply append (map (lambda (x) (map (lambda (y) (cons x y)) xsbase)) xs)))

(define (Alle-Sets xs)
  (filter ist-eindeutig? (filter ist-eindeutig? (filter (lambda (x) (apply Card-Set? x)) (Alle-Möglichen 3 xs)))))
(define (ist-eindeutig? xs)
  (= 1 (apply max (map (curryr count-v-in-L xs) xs))))
(define (count-v-in-L v xs)
  (c-v-i-L v xs 0))
(define (c-v-i-L v xs acc)
  (cond ((empty? xs) acc)
        ((equal? v (car xs)) (c-v-i-L v (cdr xs) (+ acc 1)))
        (else (c-v-i-L v (cdr xs) acc))))

(define feld (ran-count 12 (Card-Deck)))
(define MCD (curry map Card-Draw))
;(map Card-Draw feld)
;(map (lambda (x) (map (lambda (y) (y "AsList")) x)) (Alle-Möglichen 3 feld))
(MCD feld)
(length (Alle-Möglichen 3 feld))
(map MCD (Alle-Sets feld))
(length (Alle-Sets feld))