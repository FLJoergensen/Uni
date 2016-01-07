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

;Aufgabe 2: Wiederholung und Klausurvorbereitung
;1
;a.) -1
;b.) '(+,(- 2 4) 2)
;c.) 'Alle
;d.) '(auf (dem See))
;e.) '(Listen sind einfach)
;f.) '(Paare . auch)
;g.) #true
;h.) #false
;i.) '(1 8 27)
;j.) '(1 2345)
;k.) 2
;l.) #true
;2.
;a.) 10
;b.) hat keinen wohldefinierten Wert, da *b* den Wert von dem Symbol '*a* hat
;c.) 20, da wir das Symbol '*a* mit eval evaluieren
;d.) #false
;e.) Fehler, da man nicht durch 0 teilen kann
;f.) wir merken uns hier die 3 ohne sie wiederzugeben, daher kann nicht
;    mit 2 addiert werden
;g.) 5
;h.) 16
;3.
;a.)(+ (*3 4) (*5 6))
;b.) (define (3b x)
;       (sqrt (- 1 (expt (sin x) 2))))
;4.
;a.) (define (4a a b)
;      (sqrt (+ (*a a) (* b b))))
;b.) (define (4b alpha)
;      (/ (sin alpha) (sqrt (-1 (expt (sin alpha) 2)))))
;5.
;a.) (+ 1 (- (/ 4 2) 1))
;b.) (/ (- 2 (/ (+ 1 3) (+ 3 (* 2 3)))) (sqrt 3))
;6. (1+2+3)*(2-3-(2-1))
;7.
;a.) Bei der inneren Reduktion werden die Terme von innen nach außen reduziert.Bei der äußeren Reduktion werden die Terme von außen nach innen reduziert.
;b.) Wenn wir keine special form expression vorliegen haben, rechnet Racket mit der inneren Reduktion.
;    Im Falle einer special form expression rechnet Racket abhängig davon was die special form verlangt.
;    Wenn die Bezugstransparenz gewährleistet ist, dann ist das Ergebnis unabhängig von der Reduktionsreihenfolge und die innere Reduktion und äußere Reduktion führen zum selben Ergebnis.
;8.
;linear rekursiv:
;(define (laengen1 x y z)
;  (list (laengenhilfe1 x) (laengenhilfe1 y) (laengenhilfe1 z)))
;(define (laengenhilfe1 xs)
;  (cond ((empty? xs) 0)
;        ((empty? (cdr xs)) 1)
;       (else (+ (laengenhilfe1 (cdr xs)) 1))))
;endrekursiv, erkennt man an der zusätzlichen Variable, die nach oben mitgegeben wird:
;(define (laengen2 x y z)
;  (list (laengenhilfe2 x 0) (laengenhilfe2 y 0) (laengenhilfe2 z 0)))
;(define (laengenhilfe2 xs akk)
;  (cond ((empty? xs) akk)
;        (else (laengenhilfe2 (cdr xs) (+ akk 1)))))
