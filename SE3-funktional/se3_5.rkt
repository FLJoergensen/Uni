#lang racket

(require se3-bib/butterfly-module)
(require racket/Trace)

;(show-butterfly 'red 'stripes 'curved 'rhomb)
;(show-butterfly 'yellow 'stripes 'straight 'hexagon)
;(show-butterfly 'blue 'dots 'curly 'ellipse)

;Wir speichern alle Merkmale, die ein Schmetterling haben kann jeweils in einer Liste.
;Die Dominanz ist durch die Reihenfolge der Elemente in der Liste geordnet.
;In der Liste wird mit der dominantesten Art eines Merkmals begonnen.
(define musterung '(dots stripes star))
(define fluegelfarbe '(red green blue yellow))
(define fluegelform '(rhomb hexagon ellipse))
(define fuehlerform '(straight curved curly))

#|
Einem Schmetterling muss von jedem dieser Listen ein Element zugeordnet sein.
Zusätzlich besitzt jeder Schmetterling ein zweites rezessives Element von jedem Merkmal,
welches nicht sichtbar ist, aber bei der Vererbung eine Rolle spielt.
Die dominanten Merkmale des Elternpaares sind fest vorgegeben. Die rezessiven
müssen mittels einer Zufall-Funktion zugeteilt werden.
Dann brauchen wir eine Funktion, die uns zufällig Kind-Schmetterlinge aus
den Merkmalen der Eltern erzeugt. Hierbei ist zu beachten, dass für jedes Merkmal
zufällig das dominante oder das rezessive Merkmal des jeweiligen Elternteils weitervererbt
werden kann. Das dominantere von Beiden bestimmt schlussendlich das Aussehen des
Kind-Schmetterlings.
Am Ende brauchen wir eine Funktion, die uns den Schmetterling ausgibt, sodass
klar ist, welches seine dominanten Merkmale sind.

Gliederung:
- 4 Listen mit Merkmalen
- Elternfunktion: Hier werden zwei Schmetterlinge (Listen) und eine
gewünschte Kinderanzahl übergeben
- Zufallfunktion: Generiert zufällig die rezessiven Merkmale bzw. entscheidet
welche Merkmale was dem Kind vom jeweiligen Elternteil übergeben wird
- Auswahlfunktion: von den zwei übergebenen Merkmalen der Eltern muss nun ausgewählt werden
welches der Beiden das dominantere Merkmal ist. Dies wird dann dem Kind vererbt.

Datenstruktur zur Repräsentation des Genoms eines Schmetterlings:
Am Anfang übergeben wir eine Liste der Merkmale. In der Funktion arbeiten wir mit einer Liste an
Pairs. Wir müssen die dominanten Merkmale kennen, daher reicht es eine Liste derer zu übergeben.
Während der Elternfunktion müssen wir dem Kind jedoch zufällig ein rezessives oder dominantes Merkmal übergeben.
Daher erstellen wir ein zufälliges rezessives Merkmal und speichern es mit jeweils dem Dominanten in einem Pair ab.
|#

;Da ein Schmetterling von jedem Merkmaltyp zwei zugewiesen bekommt, muss unter diese zwischen dem dominanteren
;und rezessiven Merkmal unterschieden werden. Dafür sind diese beiden Funktionen.
(define (gibrezesList x xs)
  (cond ((empty? xs) '())
        ((equal? x (car xs)) xs)
        (else (gibrezesList x (cdr xs)))))
(define (gibdominant x1 x2 xs)
  (cond ((empty? xs) (cons x1 x2))
        ((equal? x1 (car xs)) (cons x1 x2))
        ((equal? x2 (car xs)) (cons x2 x1))
        (else (gibdominant x1 x2 (cdr xs)))))

;Der Zufallsgenerator für Listen. Es soll durch shuffle aus xs also immer ein zufälliges Element ausgegeben werden 
(define (gib-Rnd xs)
  (car (shuffle xs)))


(define (genKinder xs1 xs2 i)
  (cond ((> i 0) (display (show-S (genKind xs1 xs2))) (genKinder xs1 xs2 (- i 1)))
        (else (void))))

;Schmetterlingsgene werden random aus den einzelnen Merkmalslisten generiert
(define (genSchmetterling)
  (list (gib-Rnd musterung)
          (gib-Rnd fluegelfarbe)
          (gib-Rnd fluegelform)
          (gib-Rnd fuehlerform)))


(define (genPar xs)
  (list (cons (car xs) (gib-Rnd (gibrezesList (car xs) musterung)))
        (cons (cadr xs) (gib-Rnd (gibrezesList (cadr xs) fluegelfarbe)))
        (cons (caddr xs) (gib-Rnd (gibrezesList (caddr xs) fluegelform)))
        (cons (cadddr xs) (gib-Rnd (gibrezesList (cadddr xs) fuehlerform)))))
(define (genKind xs1 xs2)
  (list (gibGenom (car xs1) (car xs2) musterung)
        (gibGenom (cadr xs1) (cadr xs2) fluegelfarbe)
        (gibGenom (caddr xs1) (caddr xs2) fluegelform)
        (gibGenom (cadddr xs1) (cadddr xs2) fuehlerform)))


(define (gibGenom xpair ypair xs)
  (gibdominant (gib-Rnd (list (car xpair) (cdr xpair))) (gib-Rnd (list (car ypair) (cdr ypair))) xs))
  
(define (show-S xs)
  (show-butterfly (car (cadr xs)) (car (car xs)) (car (cadddr xs)) (car (caddr xs))))
(define (show-1S xs)
  (print (car (list (car (cadr xs)) (car xs) (cadddr xs) (caddr xs)))))

;Definiert einen Mutter und einen Vaterschmetterling
(define M (genPar (genSchmetterling)))
(define V (genPar (genSchmetterling)))

(print "Mutter")(display (show-S M))(display M)"\n"
(print "Vater")(display (show-S V))(display V)"\n"

(genKinder M V 5)"\n"

;2
;Definition der gegebenen Schmetterlinge
(define M1 '(blue stripes curved hexagon))
(define V1 '(green star curly rhomb))
(define Toni '(red star curved rhomb))
(define Tini '(green dots straight rhomb))
(define Tina '(yellow stripes curly ellipse))

;Gentest, ob durch die gegebenen dominanten Merkmale der Eltern, auch wirklich diese Kindschmetterlinge
;gezeugt werden konnten.
(define (genTest M V K)
  (and (genMöglichE? (car M) (car V) (car K) fluegelfarbe)
       (genMöglichE? (cadr M) (cadr V) (cadr K) musterung)
       (genMöglichE? (caddr M) (caddr V) (caddr K) fuehlerform)
       (genMöglichE? (cadddr M) (cadddr V) (cadddr K) fluegelform)))
(define (genMöglichE? M V K xs)
  (or (genMöglich? M K xs) (genMöglich? V K xs)))
(define (genMöglich? E K xs)
  (inList? K (gibrezesList E xs)))
(define (inList? v xs)
  (cond ((empty? xs) #f)
        ((equal? v (car xs)) #t)
        (else (inList? v (cdr xs)))))
#\n
#\n
"Mutter Antonia|Vater Anton|Kind Toni"(genTest M1 V1 Toni)
"Mutter Antonia|Vater Anton|Kind Tini"(genTest M1 V1 Tini)
"Mutter Antonia|Vater Anton|Kind Tina"(genTest M1 V1 Tina)
