#lang swindle
(require se3-bib/prolog/prologInScheme)

;1
;;1.1
;;1.2
(?- (vorbestellung "P_201" ?A))
(?- (leser Linux Leo ?A ?B))
(?- (ausleihe "P_30" ?A) :- (leser ?Nachname ?Vorname ?A ?B))