#lang racket
#|Aufgabe 1:
Kopfstück: ist linaer weil mit der Funktion nur eine Rekursion aufgeruefen wird und direkt, 
           da in Kopfstück wieder Kopfstück aufgerufen wird
Endstück: Genauso wie in Kopfstück, ruft sich die Funktion nur selbst auf
Merge: Ist eine Baumrekursion, da im else-Zweig sich merge zweimal selbst aufruft. 
       Es ist direkt da merge nur merge rekursiv aufruft.
Merge-sort: Ist geschachtelt, da in der merge Rekursion auf merge-sort zurückgegriffen wird. 
            Außerdem ist es Baumrekursiv und indirekt, da versch. Rekursive Funktionen aufgerufen werden.
|#

(require racket/trace)

;2.1
(define (sorted? xs comp)
  (cond ((empty? (cdr xs)) #t)
        ((comp (car xs) (cadr xs)) (sorted? (cdr xs) comp))
        (else #f)))
(define (IS xs comp)
  (IS_ xs comp (length xs)))
(define (IS_ xs comp c)
  (cond ((= c 0) xs)
        (else (IS_ (Insertion-Sort xs comp) comp (- c 1)))))
(define (IS2 xs comp)
  (cond ((sorted? xs comp) xs)
        (else (IS2 (Insertion-Sort xs comp) comp))))
(define (Insertion-Sort xs comp)
  (cond ((empty? (cdr xs))  xs)
        ((comp (car xs) (cadr xs)) (cons (car xs) (Insertion-Sort (cdr xs) comp)))
        (else (cons (cadr xs) (Insertion-Sort (cons (car xs) (cddr xs)) comp)))))

;(trace Insertion-Sort)
;(trace IS)
(IS '(2 3 5 1 6 9 8 7 4) <)
(IS '(9 3 5 4 6 2 8 7 1) <)
(IS '(9 8 7 6 5 4 3 2 1) <)

;2.3
(require 2htdp/image)
(define icons
  (list
   (star-polygon 35 5 2 "solid" "gold")
   (ellipse 44 44 "solid" "red")
   (rectangle 38 38 "solid" "blue")
   (isosceles-triangle 45 65 "solid" "darkgreen")))
(define (bildvergleich b1 b2)
  (eq? b1 b2))
(IS icons bildvergleich)

;3
(define (genBaum)
  (genÄste 0 0 20 4 (rectangle 40 60 "solid" "brown")))
(define (genÄste x X Y acc prePic)
  (cond ((= acc 0) (overlay/offset (isosceles-triangle (* 45 acc) 105 "solid" "darkgreen") X (- Y 50) prePic))
        (else (overlay/offset (isosceles-triangle (* 45 acc) 105 "solid" "darkgreen") X (- Y 50) (genÄste x X (+ Y (* 105 0.5)) (- acc 1) prePic)))))
(genBaum)