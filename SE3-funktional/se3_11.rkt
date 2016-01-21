#lang swindle
(require se3-bib/prolog/prologInScheme)


;1.1
(?- (= (Laptop ?Marke schwarz) (Laptop MacBook ?Farbe)))
; Erzeugt die Variablen:
; ?Marke = MacBook
; ?Farbe = schwarz

(?- (= (Teilnehmer ( (Peter Lustig Gold) (Petra Pfiffig Gold))) (Teilnehmer ( (Peter Lustig Gold) (Petra Pfiffig Silber )))))
;Unifikation nicht erfolgreich

(?- (= (Teilnehmer ( (Peter Lustig Gold) (Petra Pfiffig Gold))) (Teilnehmer ( (Peter Lustig Gold) (Petra Pfiffig ?Rang)))))
; Erzeugt die Variable: ?Rang = Gold

(?- (= (Teilnehmer ( (Peter Lustig Gold) . ?andere)) (Teilnehmer ( (Peter Lustig Gold) (Petra Pfiffig Gold) (Lena Lustig Silber)))))
; Erzeugt die Variable: ?andere = ((Petra Pfiffig Gold) (Lena Lustig Silber))

(?- (= (Tupel (k ?farbe As ) (k Pik ?wert ) ) (Tupel (k Pik ?wert) (k ?farbe As) )))
; Erzeugt die Variablen:
; ?wert = As
; ?farbe = Pik

(?- (= (Tupel (k ?farbe As ) (k Pik ?wert2 ) ) (Tupel (k Pik ?wert) (k ?farbe ?wert) )))
; Erzeugt die Variablen:
; ?wert2 = As
; ?farbe = Pik
; ?wert = As

;1.2
; ( ausleihe Signatur Lesernummer)
(<- ( ausleihe "P 201" 100))
(<- ( ausleihe "P 30" 102))
(<- ( ausleihe "P 32" 104))
(<- ( ausleihe "P 50" 104))

; ( vorbestellung Signatur Lesernummer)
(<- ( vorbestellung "P 201" 104))
(<- ( vorbestellung "P 201" 102))
(<- ( vorbestellung "P 30" 100))
(<- ( vorbestellung "P 30" 104))

; (leser Name Vorname Lesernummer Geburtsjahr)
(<- (leser Neugierig Nena 100 1989))
(<- (leser Linux Leo 102 1990))
(<- (leser Luator Eva 104 1988))

;(?- (vorbestellung "P 201" ?A))
;(?- (leser Linux Leo ?A ?))
;(?- (ausleihe "P 30" ?ID) (leser ?Nachname ?Vorname ?ID ?Geb))
(?- )