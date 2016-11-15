%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 03 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[medien]

%%% A1 %%%
/*
Syntax:
beschreibt die Regeln, nach denen die Sprachkonstrukte gebildet werden.

Semantik:
beschreibt die Bedeutung der Sprachkonstrukte.

Denotationelle Semantik:
Beschreibt elementare syntaktische Elemente in allgemeiner (zb mathematischer) Sprache..

Operationale Semantik:
beschreibt die Auswertung eines Programms als Folge elementarer Berechnungsschritte auf einer konkreten oder abstrakten Maschine.
 Die operationelle Semantik beschreibt also im Detail sämtliche Zwischenzustände bei der Abarbeitung des Programms.
 Bei syntaktischen Fehlern wird das Programm Fehler werfen, entweder wird nicht Kompiliert oder man bekommt Error bei der Ausführung.
 Semantikfehler kann man so nicht erkennen, da das Programm allgemein Fehlerfrei durchläuft, jedoch nicht die gewünschten Ergebnisse liefert. 
*/

%%% A2 %%%
%1.
?- Kategorie=,Titel=,Autor=,Verlag=,Erscheinungsjahr=,Lagerbestand=,produkt(PId,Kategorie,Titel,Autor,
Verlag,Erscheinungsjahr,Lagerbestand),verkauft(PId,_,Preis,_,_).
%2.

%3.
?- produkt(PId,KId,Titel,Autor,Verlag,Jahr,Lagerbestand),verkauft(PId,Jahr,Preis,Anzahl),Lagerbestand>Anzahl.

%%% A3 %%%
%1.
?- KId is 10,aggregate_all(count, produkt(_,KId,_,_,_,_,_), Count).
%2.

%3.

%%% A4 %%%
%1.
?- KId=1,kategorie(Id_Unterkategorie,Name,KId)
%2.
?-

%%% A5 %%%