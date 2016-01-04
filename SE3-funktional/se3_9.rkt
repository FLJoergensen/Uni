#lang swindle
(require swindle/setf
         swindle/misc
         racket/format)

;1
;;1.1
;;;Publikation
(defclass* publikation ()
  (key
   :reader publikation-schlüssel
   :writer set-publikation-schlüssel!
   :initvalue void
   :initarg :pubSchlüssel
   :documentation "eindeutiger schlüssel"
   )
  (autoren
   :reader publikation-autoren
   :writer set-publikation-autoren!
   :initvalue '()
   :initarg :pubAutoren
   :type <list>
   :documentation "die autoren"
   )
  (jahr
   :reader publikation-jahr
   :writer set-publikation-jahr!
   :initvalue "0"
   :initarg :pubJahr
   :type <string>
   :documentation "erscheinungsjahr"
   )
  (titel
   :reader publikation-titel
   :writer set-publikation-titel!
   :initvalue ""
   :initarg :pubTitel
   :type <string>
   :documentation "Titel"
   )
  :autopred #t
  :printer #t
  :documentation "publikations ober klasse"
  )

;;;Buch erbt Publikation
(defclass* buch (publikation)
  (verlag
   :reader buch-verlag
   :writer set-buch-verlag!
   :initvalue ""
   :initarg :buchVerlag
   :type <string>
   :documentation "verlag"
   )
  (verlagort
   :reader buch-verlagort
   :writer set-buch-verlagort!
   :initvalue ""
   :initarg :buchVerlagort
   :type <string>
   :documentation "ort des verlages"
   )
  (reihe
   :reader buch-reihe
   :writer set-buch-reihe!
   :initvalue ""
   :initarg :buchReihe
   :type <string>
   :documentation "buchreihe"
   )
  (reihe-seriennummer
   :reader buch-reihe-seriennummer
   :writer set-buch-reihe-seriennummer!
   :initvalue "0"
   :initarg :buchSeriennummer
   :type <string>
   )
  (edition
   :reader buch-edition
   :writer set-buch-edition!
   :initvalue ""
   :initarg :buchEdition
   :documentation "Editions angabe"
   )
  :autopred #t
  :printer #t
  :documentation "Publiziertes Buch"
  )

;;;Sammelbände erbt Buch
(defclass* sammelband (buch)
  (herausgeber
   :reader sammelband-herausgeber
   :writer set-sammelband-herausgeber!
   :initvalue ""
   :initarg :sammelbandHerausgeber
   :type <string>
   :documentation "Herausgeber des Sammelbands"
   )
  (seitenangabe
   :reader sammelband-seitenangabe
   :writer set-sammelband-seitenangabe!
   :initvalue 0
   :initarg :sammelbandSeitenangabe
   :type <integer>
   :documentation "Seite zum Artikel"
   )
  (name
   :reader sammelband-name
   :writer set-sammelband-name!
   :initvalue ""
   :initarg :sammelbandName
   :type <string>
   :documentation "Name des Sammelbandes"
   )
  :autopred #t
  :printer #t
  :documentation "Sammelband von Büchern"
  )

;;;Zeitschriftenartikel erbt Publikation
(defclass* zeitschrift (publikation)
  (name
   :reader zeitschrift-name
   :writer set-zeitschrift-name!
   :initvalue ""
   :initarg :zeitschriftName
   :type <string>
   :documentation "Name"
   )
  (band-nummer
   :reader zeitschrift-band-nummer
   :writer set-zeitschrift-band-nummer!
   :initvalue 0
   :initarg :zeitschriftBandnummer
   :type <integer>
   :documentation "Bandnummer der Zeitschrift"
   )
  (heft-nummer
   :reader zeitschrift-heft-nummer
   :writer set-zeitschrift-heft-nummer!
   :initvalue 0
   :initarg :zeitschriftHeftnummer
   :type <integer>
   :documentation "Nummer des Heftes"
   )
  (monat
   :reader zeitschrift-monat
   :writer set-zeitschrift-monat!
   :initvalue 'Januar
   :initarg :zeitschriftMonat
   :type <symbol>
   :documentation "Der Erscheinungsmonat der Zeitschrift"
   )
  :autopred #t
  :printer #t
  :documentation "Zeitschriftenartikel"
  )

;;;Nessie
(define NESSIE 
  (make buch 
        :pubTitel "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
        :pubJahr "1790"
        :pubSchlüssel 'Nessie1790
        :pubAutoren '("Nessie")
        :buchVerlag "Minority-Verlag"
        :buchVerlagort "Inverness"
        :buchReihe "Die besondere Biographie"
        :buchSeriennummer "Band 2 der Reihe"))

;;;Prefect, F.
(define PREFECT
  (make sammelband 
        :pubTitel "Mostly harmless - some observations concerning the third planet of the solar system"
        :pubJahr "1979"
        :pubSchlüssel 'Prefect1979
        :pubAutoren '("Prefect, F.")
        :buchVerlag "Galactic Press"
        :buchVerlagort "Vega-System, 3rd planet"
        :buchReihe "Travel in Style"
        :buchSeriennummer "volume 5 of"
        :buchEdition "1337 edition"
        :sammelbandHerausgeber "Adams D."
        :sammelbandSeitenangabe 420
        :sammelbandName "The Hitchhiker's Guide to the Galaxy"
        ))

;;;Wells
(define WELLS
  (make zeitschrift
        :pubSchlüssel 'Wells3200
        :pubTitel "Zeitmaschinen leicht gemacht"
        :pubAutoren '("Wells, H. G.")
        :pubJahr "3200"
        :zeitschriftName "Heimwerkerpraxis für Anfänger"
        :zeitschriftBandnummer 550
        :zeitschriftHeftnummer 3
        ))
;;1.2
(defgeneric cite ((pub publikation)))
; cite Methode für Bücher
(defmethod cite ((pub buch))
  (string-append 
   (car (publikation-autoren pub))
   " (" (publikation-jahr pub) "). "
   (publikation-titel pub) ", "
   (buch-reihe-seriennummer pub) ": " 
   (buch-reihe pub) ". "
   (buch-verlag pub) ", " (buch-verlagort pub)))
; cite Methode für Sammelbände
(defmethod cite ((pub sammelband))
  (string-append 
   (car (publikation-autoren pub))
   " (" (publikation-jahr pub) "). "
   (publikation-titel pub) ". In "
   (sammelband-herausgeber pub) ", "
   (sammelband-name pub) ", "
   (buch-reihe-seriennummer pub)" " 
   (buch-reihe pub) ". "
   (buch-verlag pub) ", " (buch-verlagort pub)
   ", " (buch-edition pub) ", " 
   "p. " (~a (sammelband-seitenangabe pub)) "."))
; cite Methode für Zeitschriften
(defmethod cite ((pub zeitschrift))
  (string-append
   (car (publikation-autoren pub))
   " (" (publikation-jahr pub) "). "
   (publikation-titel pub) ". "
   (zeitschrift-name pub) ", "
   (~a (zeitschrift-band-nummer pub)) "("
   (~a (zeitschrift-heft-nummer pub)) ")."))

(display (cite NESSIE))
(display (cite PREFECT))
(display (cite WELLS))
  
;;1.3
#|
Eine Ergänzungsmethode kann vor und nach der Methode der Oberklasse ausgeführt werden.
Außerdem kann sie einhüllend wirken und wird sowohl vor als auch nach der Elternmethode aufgerufen.

Die Vorteile sind, dass jede Ergänzungsmethode ausgeführt wird und damit keine Initialisierungen vergessen oder unterdrückt werden können,
die in den Oberklassen definiert wurden.
Desweiteren brauchen die geerbten Methoden nicht durch Modifikationen überladen zu werden, sondern werden nur ergänzt.

Ergänzungsmethoden könnten dazu genutzt werden die Basis-cite Methode zu ergänzen, sodass nicht eine Methode für jede Publikationsform von Nöten ist.
Dabei könnten die Informationen schrittweise aufgebaut werden.
Allgemeine Information zu Beginn, dann buchspezifische, dann sammelbandspezifische.
Für Zeitschriften würde eine alternative Reihenfolge von allgemeinen und zeitschriftenspezifischen Informationen genutzt werden.

Allerdings käme es dort zu Problemen, wo Informationen zwischendrin eingefügt werden müssen.
Die Sammelbandseitenangabe zum Beispiel erfolgt am Schluss, die restlichen Informationen jedoch in der Mitte vor den Buchinformationen wie Reihe und Verlag.
|#

;2
;;2.1
#|
(defclass fahrzeug ())
  (defclass landfahrzeug (fahrzeug))
    (defclass schienenfahrzeug (landfahrzeug))
    (defclass straßenfahrzeug (landfahrzeug))
  (defclass wasserfahrzeug (fahrzeug))
  (defclass luftfahrzeug (fahrzeug))
(defclass amphibienfahrzeug (wasserfahrzeug landfahrzeug))
(defclass amphibienflugzeug (straßenfahrzeug wasserfahrzeug luftfahrzeug))
(defclass zweiwegefahrzeug (straßenfahrzeug schienenfahrzeug))
(defclass zeitzug (schienenfahrzeug luftfahrzeug))
|#

; 2.2

; da ein Fahrzeug mehrere Medien aufweisen kann, ist es sinnvoll
; diese in einer Liste zurückzugeben 
(defgeneric getMedium ((fz fahrzeug))
  :combination generic-list-combination)
; von allen Medien muss die geringste Höchstgeschwindigkeit genommen werden
; daher ist die min combination hier richtig
(defgeneric getMaxSpeed ((fz fahrzeug))
  :combination generic-min-combination)
; auch bei der Tragfähigkeit ist die geringst mögliche Tragfähigkeit
; von Interesse
(defgeneric getTragfähigkeit ((fz fahrzeug))
  :combination generic-min-combination)
; beim Verbrauch hingegen ist der maximale Verbrauch über alle
; Medien interessant
(defgeneric getVerbrauchPro100km ((fz fahrzeug))
  :combination generic-max-combination)
; die Passagierzahl wiederum ist durch die geringste Größe unter allen Medien
; limitiert, womit hier ebenso eine min combination anzuwenden ist
(defgeneric getPassagierzahl ((fz fahrzeug))
  :combination generic-min-combination)

; 2.3

; Implementation zur Abfrage des Mediums

(defclass fahrzeug ()
  :printer #t)
(defclass landfahrzeug (fahrzeug)
  (check
   :reader landfahrzeug-check
   :initvalue #t
   )
  :printer #t)
(defmethod getMedium ((fz landfahrzeug))
  'Land)

(defclass schienenfahrzeug (fahrzeug)
  :printer #t)
(defmethod getMedium ((fz schienenfahrzeug))
  'Schiene)

(defclass straßenfahrzeug (fahrzeug)
  :printer #t)
(defmethod getMedium ((fz straßenfahrzeug))
  'Straße)

(defclass wasserfahrzeug (fahrzeug))
(defmethod getMedium ((fz wasserfahrzeug))
  'Wasser)

(defclass luftfahrzeug (fahrzeug))
(defmethod getMedium ((fz luftfahrzeug))
  'Luft)

(defclass amphibienfahrzeug (wasserfahrzeug landfahrzeug))
(defclass amphibienflugzeug (luftfahrzeug wasserfahrzeug straßenfahrzeug))
(defclass zweiwegefahrzeug (schienenfahrzeug straßenfahrzeug))
(defclass zeitzug (schienenfahrzeug luftfahrzeug))

; Die Funktion getMedium wird bei ampFahrzeug zunächst für
; Wasserfahrzeuge aufgerufen, da nach der Klassenpräzedenz-
; liste Wasserfahrzeug vor Landfahrzeug kommt.
; Anschließend wird die Funktion für Landfahrzeuge aufgerufen.

; Da die generische Funktion getMedium mit der list combination
; verwendet wird, werden die Ausgaben der einzelnen Funktionsaufrufe
; in eine Liste kombiniert und zurückgegeben. Das wären in diesem
; Fall also 'Wasser und 'Land, die insgesamte Rückgabe sieht dann
; so aus: '(Wasser Land)
; Da Fahrzeug die generische Funktion nicht implementiert,
; bleibt es bei den beiden Funktionsaufrufen.

; Bei ampFlugzeug funktioniert es analog und es wird
; '(Luft Wasser Straße) zurückgegeben.

; Bei schienenbus verhält es sich analog und die Rückgabe
; ist '(Schiene Straße).

; Für zug wird '(Schiene Luft) zurückgegeben.

; Die Klassenpräzedenzliste ist hier unerlässlich, um die Reihenfolge
; der Funktionen zu bestimmen. Wenn die combination der jeweiligen
; generischen Funktion nur ein Ergebnis zurückgibt (bspw. begin combination),
; dann bestimmt die Liste auch das Ergebnis.
; Ohne eine combination wird auch nur die Funktion ausgeführt,
; deren zugehörige Klasse in der Präzendenzliste ganz vorne steht.

(define ampFahrzeug (make amphibienfahrzeug))
(define ampFlugzeug (make amphibienflugzeug))
(define schienenbus (make zweiwegefahrzeug))
(define zug (make zeitzug))