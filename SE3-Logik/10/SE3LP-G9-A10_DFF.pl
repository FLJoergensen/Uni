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
