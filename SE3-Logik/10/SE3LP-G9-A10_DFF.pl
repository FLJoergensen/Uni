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

% Laden des Prolog-Moduls zur Verarbeitung von CSV
:- use_module(library(csv)).
% Um Encoding-Probleme zu vermeiden
:- set_prolog_flag(encoding, utf8).
% Um Daten aus dem Internet herunterzuladen
:- use_module(library(http/http_client)).

% Sollte es sich um eine zweispaltige CSV handeln, so greift diese Regel.
% Nach dem Einlesen der CSV holt sich diese Regel die richtigen Werte aus dieser
% und unifiziert sie mit den Variablen, die dann weitergegeben werden.
%
% csv_to_pl(+CSV)
csv_to_pl(CSV) :-
	csv_read_file(CSV, Rows, [match_arity(false), convert(true)]),
	Rows = [StationRaw, KomponenteRaw, _, _, _ | Werte],
	StationRaw = row('Station', Station),
	% Fallunterscheidung für PM10 oder PM2,5
	(KomponenteRaw = row('Komponente', Komponente);
	KomponenteRaw = row('Komponente', KomponenteA, KomponenteB),
	concat(KomponenteA, ',', KomponenteTemp),
	concat(KomponenteTemp, KomponenteB, Komponente)),
	Messzeit = '24hg',
	create_data_zweistellig(Werte, DatumR, DatenR),
	reverse(DatumR, DatumAll),
	DatumAll = [Datum | _],
	date_to_timestamp(Datum, Timestamp),
	Abstand = 3600,
	reverse(DatenR, Daten),
	csv_to_pl_zweistellig(Station, Komponente, Messzeit, Timestamp, Abstand, Daten).

% Sollte es sich um eine dreispaltige CSV handeln, so greift diese Regel.
% Nach dem Einlesen der CSV holt sich diese Regel die richtigen Werte aus dieser
% und unifiziert sie mit den Variablen, die dann weitergegeben werden.
%
% csv_to_pl(+CSV)
csv_to_pl(CSV) :-
	csv_read_file(CSV, Rows, [match_arity(false), convert(true)]),
	Rows = [StationRaw, _, _, _, _ | Werte],
	StationRaw = row('Station', Station1, Station2),
	Messzeit = '24hg',
	create_data_dreistellig(Werte, DatumR, Daten1R, Daten2R),
	reverse(DatumR, DatumAll),
	DatumAll = [Datum | _],
	date_to_timestamp(Datum, Timestamp),
	Abstand = 3600,
	reverse(Daten1R, Daten1),
	reverse(Daten2R, Daten2),
	csv_to_pl_dreistellig(Station1, Station2, 'PM10', 'PM2,5', Messzeit, Messzeit,
						Timestamp, Timestamp, Abstand, Abstand, Daten1, Daten2).

% Zur Umwandlung des gegebenen Formats "DD.MM.YYYY HH:MM" in iso_8601 "YYYYMMDDTHHMM00+0000"
% durch Zerlegen des Formats in seine einzelnen Atome, um diese anschließend in der richtigen
% Reihenfolge wieder zusammenzufügen
%
% date_to_timestamp(+Date, -Timestamp)
date_to_timestamp(Date, Timestamp) :-
	atom_chars(Date, List),
	List = [D1, D2, _, M1, M2, _, Y1, Y2, Y3, Y4, _, H1, H2, _, Min1, Min2],
	concat(Y1, Y2, Year01),
	concat(Y3, Y4, Year02),
	concat(Year01, Year02, Year),
	concat(M1, M2, Month),
	concat(D1, D2, Day),
	concat(H1, H2, Hour),
	concat(Min1, Min2, Minute),
	concat(Year, Month, YM),
	concat(YM, Day, YMD),
	concat(YMD, 'T', YMDT),
	concat(YMDT, Hour, YMDTH),
	concat(YMDTH, Minute, YMDTHM),
	concat(YMDTHM, '00+0000', ISO),
	parse_time(ISO, iso_8601, TimestampTemp),
	Timestamp is round(TimestampTemp).

% Erstellt zwei Listen, wobei List1 die Daten und List2 die Messwerte enthält.
%
% create_data_zweistellig(+ListeDerDatenUndWerte, -List1, -List2)
create_data_zweistellig([], [], []).
create_data_zweistellig([row(Date, Value) | Tail], List1, List2) :-
	append([Date], ListNew1, List1),
	append([Value], ListNew2, List2),
	create_data_zweistellig(Tail, ListNew1, ListNew2).

% Erstellt drei Listen, wobei List1 die Daten, List2 die ersten Messwerte und List3
% die zweiten Messwerte enthält.
%
% create_data_dreistellig(+ListeDerDatenUndWerte, -List1, -List2, -List3)
create_data_dreistellig([], [], [], []).
create_data_dreistellig([row(Date, Value1, Value2) | Tail], List1, List2, List3) :-
	append([Date], ListNew1, List1),
	append([Value1], ListNew2, List2),
	append([Value2], ListNew3, List3),
	create_data_dreistellig(Tail, ListNew1, ListNew2, ListNew3).

% Schreibt den finalen Ausdruck in die Datenbasis und zeigt ihn danach an.
%
% csv_to_pl_zweistellig(+Station, +Komponente, +Messzeit, ...)
csv_to_pl_zweistellig(Station, Komponente, Messzeit, Timestamp, Abstand, Daten) :-
	assertz(pollution_data(Station, Komponente, Messzeit, Timestamp, Abstand, Daten)),
	listing(pollution_data).

% Schreibt die beiden finalen Ausdrücke in die Datenbasis und zeigt diese danach an.
%
% csv_to_pl_dreistellig(+Station1, +Station2, +Komponente1, ...)
csv_to_pl_dreistellig(Station1, Station2, Komponente1, Komponente2, Messzeit1, Messzeit2,
						Timestamp1, Timestamp2, Abstand1, Abstand2, Daten1, Daten2) :-
	assertz(pollution_data(Station1, Komponente1, Messzeit1, Timestamp1, Abstand1, Daten1)),
	assertz(pollution_data(Station2, Komponente2, Messzeit2, Timestamp2, Abstand2, Daten2)),
	listing(pollution_data).

%% 1.Bonus

% Erzeugt eine CSV-Datei, in der die Messwerte der Kieler Straße innerhalb eines
% bestimmten Zeitraums gespeichert werden.
% Angabe von Start und Ende in 'TT.MM.JJJJ'
%
% http_to_csv(+Start, +Ende)
http_to_csv(Start, Ende) :-
	% Formatieren der URL
	URL_Anfang = 'http://hamburg.luftmessnetz.de/station/64KS.csv?componentgroup=pollution&componentperiod=24hg&searchperiod=custom&searchfrom=',
	URL_Ende = '&searchuntil=',
	concat(URL_Anfang, Start, URL_Temp1),
	concat(URL_Temp1, '+00:00', URL_Temp2),
	concat(URL_Temp2, URL_Ende, URL_Temp3),
	concat(URL_Temp3, Ende, URL_Temp4),
	concat(URL_Temp4, '+00:00', URL),
	% Formatieren des Dateinamens
	FILE_Name = 'http_to_csv_',
	get_time(FILE_TimestampTemp),
	FILE_Timestamp is floor(FILE_TimestampTemp),
	concat(FILE_Name, FILE_Timestamp, FILE_NameTemp),
	concat(FILE_NameTemp, '.csv', FILE),
	% CSV-Datei laden
	http_get(URL, Data, []),
	% Datei zum Schreiben öffnen bzw. neu erstellen
	open(FILE, write, Stream),
	write(Stream, Data),
	close(Stream).

%%% A2 %%%


%%% A3 %%%
