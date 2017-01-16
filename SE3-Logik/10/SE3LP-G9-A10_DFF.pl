%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 01 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vollständige Ausgabe von Listen aktivieren
?- set_prolog_flag(answer_write_options, [quoted(true), spacing(next_argument)]).

%%% A1 %%%

%% 1.1 Betrachten Sie die Dateien zum Feinstaub in der Habichtstraße (Station 68HB)
%% Anfang 2015, Ende 2015 und Anfang 2016 (2015-w01, 2015-w50, 2016-w01).
%% Interpretieren Sie die in den CSV-Dateien enthaltene Information und stellen
%% Sie die Verknüpfung her zu den Inhalten der entsprechenden Prolog-Dateien
%% (XY-facts.pl).
%
% In den CSV-Dateien findet man Informationen zu der Menge an Feinstaub an einer
% bestimmten Station (in unserem Fall "Habichtstraße").
% Dabei gibt die zweite Zeile die Art des Feinstaubs an (PM10 und/oder PM2,5), die
% dritte Zeile die Einheit, in der gemessen wurde, und die vierte Zeile die Messzeit.
% Alle nachfolgenden Werte geben den Feinstaubanteil zu einem bestimmten Zeitpunkt
% in dem Format "TT.MM.JJJJ HH:MM Anteil" an. Gegebenenfalls kommt noch ein zweiter Wert
% für den Anteil hinzu, falls sowohl PM10 als auch PM2,5 gemessen wurde.
%
% In den "XY-facts.pl"-Dateien gibt es Fakten (pollution_data), welche die Daten in
% folgender Reihenfolge halten:
% Station, Komponente(n), Messzeit (24hg für 24-Stundenwerte (gleitend)),
% UNIX-Timestamp vom ersten Tag in der Datei, Abstand der Messungen in Sekunden,
% Liste mit den gemessenen Daten.

%% 1.2 Implementieren Sie ein Prädikat, das eine CSV-Datei in das Format überführt,
%% das in 68HB-2015-w01-facts.pl deklariert ist und verwendet wird.
%
% Laden des Prolog-Moduls zur Verarbeitung von CSV
:- use_module(library(csv)).
% Um Encoding-Probleme zu vermeiden
:- set_prolog_flag(encoding, utf8).

% TO BE CONTINUED
csv_to_pl(CSV, PL) :-
	csv_read_file(CSV, Rows, [match_arity(false), convert(true)]),
	Rows = PL.

%
csv_to_pl(PL, Station, Komponenten, Messzeit, Timestamp, Abstand, Daten) :-
	PL = pollution_data(Station, Komponenten, Messzeit, Timestamp, Abstand, Daten).

%%% A2 %%%


%%% A3 %%%
:-['68HB-2016-w01-facts.pl'].

korrelationskoeffzient(Zeitreihe1,Zeitreihe2,E):-
	length(Zeitreihe1,Laenge),
	N is Laenge,
	sum_list(Zeitreihe1,Xi), 
	sum_list(Zeitreihe2,Yi), 
	multipliziereListen(Zeitreihe1,Zeitreihe2,Zwischenliste), 
	sum_list(Zwischenliste,Zwischenergebnis), 
	quadriereListen(Zeitreihe1,XiQuadrat), 
	quadriereListen(Zeitreihe2,YiQuadrat), 
	sum_list(XiQuadrat,QuadrierteListe1), 
	sum_list(YiQuadrat,QuadrierteListe2), 
	E is ((N * Zwischenergebnis)-(Xi * Yi))/(sqrt(N * QuadrierteListe1 - (Xi^2))* sqrt((N * QuadrierteListe2) - (Yi^2))).

% Dies ist ein Hilfsprädikat, welches die Elemente von zwei Listen miteinander multipliziert.
multipliziereListen([],[],[]).
multipliziereListen([Ergebnis1 | Restliste1],[Ergebnis2 | Restliste2],[Ergebnis | Restliste3]):-
	Ergebnis is Ergebnis1 * Ergebnis2,
	multipliziereListen(Restliste1,Restliste2,Restliste3).
	
% Dies ist ein Hilfsprädikat, welches die Elemente von zwei Listen miteinander quadriert.
quadriereListen([],[]).
quadriereListen([Ergebnis1|Rest1],[Ergebnis2|Rest2]):-
	Ergebnis2 is Ergebnis1*Ergebnis1,
	quadriereListen(Rest1,Rest2).
	
%Test
%?- korrelationskoeffzient([1,2,3],[1,2,3],E).
%E = 1.0000000000000002.
%?- korrelationskoeffzient([1,2,3],[2,3,8],E).
%E = 0.9332565252573828.
%?- korrelationskoeffzient([1,2,3],[2,6000,8],E).
%E = 0.0008667473679564494.
%?- korrelationskoeffzient([1,2,3],[10,3,5],E).
%E = -0.6933752452815364.

%pollution_data(_,'PM10',_,_,_,L1), pollution_data(_,'PM2,5',_,_,_,L2),korrelationskoeffzient(L1,L2,E).
%L1 = [36, 37, 37, 38, 39, 39, 40, 41, 41, 42, 42, 43, 43, 44, 44, 45, 45, 46, 47, 47, 48, 48, 49, 49, 49, 49, 
%50, 50, 50, 51, 51, 52, 52, 53, 53, 54, 54, 54, 54, 54, 54, 53, 53, 53, 52, 52, 51, 50, 50, 50, 50, 50,
% 49, 50, 50, 50, 50, 49, 49, 48, 48, 47, 47, 47, 47, 47, 46, 46, 46, 46, 46, 47, 48, 49, 50, 51, 53, 54, 
% 55, 56, 57, 59, 61, 63, 66, 69, 72, 74, 77, 79, 81, 83, 86, 88, 90, 91, 91, 91, 90, 89, 87, 84, 81, 78, 
% 74, 71, 67, 63, 59, 54, 50, 46, 43, 40, 37, 34, 31, 28, 26, 24, 22, 20, 19, 17, 16, 16, 17, 17, 18, 18, 
% 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 22, 22, 23, 23, 23, 24, 24, 25, 25, 26, 
% 26, 26, 26, 27, 27, 27, 27, 27, 26, 26, 26, 25, 25],
%L2 = [31, 32, 33, 34, 34, 35, 36, 36, 37, 38, 38, 39, 39, 40, 40, 41, 41, 42, 42, 42, 43, 43, 43, 44, 
%44, 44, 44, 44, 45, 45, 45, 46, 46, 46, 46, 47, 47, 47, 47, 47, 47, 46, 46, 46, 46, 45, 45, 44, 44, 
%44, 44, 44, 44, 44, 44, 44, 44, 44, 43, 43, 42, 42, 41, 41, 41, 40, 40, 39, 39, 39, 39, 39, 40, 40, 
%41, 41, 42, 43, 44, 45, 46, 47, 49, 52, 54, 57, 59, 61, 64, 66, 68, 70, 72, 74, 76, 77, 78, 78, 78, 77, 
%76, 73, 70, 67, 64, 61, 57, 54, 50, 46, 42, 39, 36, 33, 31, 28, 25, 23, 20, 18, 16, 14, 13, 11, 10, 10, 
%10, 10, 10, 11, 11, 11, 12, 12, 12, 12, 12, 11, 11, 11, 12, 12, 12, 12, 12, 12, 13, 13, 14, 14, 14, 15, 
%16, 16, 17, 17, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 18],
%E = 0.9925835437213651.




