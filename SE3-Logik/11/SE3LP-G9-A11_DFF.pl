%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 11 - SE3-LP WiSe 16/17
% 
% Finn-Lasse J�rgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu pr�sentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% A1 %%%

%% 1.1 Implementieren und diskutieren Sie ein Regelsystem, mit dem Sie berechnen
%% k�nnen, ob ein Verkehrsteilnehmer vorfahrtsberechtigt ist. Achten Sie dabei
%% auf eine m�glichst redundanzfreie Modellierung und ber�cksichtigen Sie vor
%% allem die folgenden (Default-)Regeln:
%% 	- Fahrzeuge mit Sondersignal haben immer Vorfahrt.
%% 	- Fahrzeuge im Kreisverkehr haben Vorfahrt.
%% 	- Fahrzeuge auf der Hauptstrasse haben Vorfahrt.
%% 	- Fahrzeuge, die an einer gleichberechtigten Kreuzung von rechts kommen,
%% 	  haben Vorfahrt.

hat_vorfahrt(Verkehrsteilnehmer1, _Verkehrsteilnehmer2) :-
	verkehrsteilnehmer(Verkehrsteilnehmer1, sondersignal),
	!.

hat_vorfahrt(Verkehrsteilnehmer1, Verkehrsteilnehmer2) :-
	verkehrsteilnehmer(Verkehrsteilnehmer1, kreisverkehr),
	verkehrsteilnehmer(Verkehrsteilnehmer2, /*TODO*/)

hat_vorfahrt(_Verkehrsteilnehmer1, _Verkehrsteilnehmer2) :- !, fail.

%% 1.2 Modellieren Sie die folgenden Beobachtungen als Fakten und ermitteln Sie,
%% ob den jeweiligen Fahrzeugen Vorfahrt zu gew�hren ist.
%% Eine Feuerwehr f�hrt mit Sondersignal.
%% Ein grunes Auto f�hrt im Kreisverkehr und kommt von links.
%% Ein Fahrrad f�hrt im Kreisverkehr und kommt von rechts.
%% Ein Traktor kommt von links.
%% Ein Bus befindet sich auf der Hauptstra�e und kommt von links.
%% Ein LKW kommt von rechts.
%% Eine Pferdekutsche f�hrt auf der Hauptstra�e.
%% Ein Jeep kommt auf der Nebenstra�e von rechts.

% Definiert Fahrzeuge mit den dazugeh�rigen Regeln.
%
% verkehrsteilnehmer(?Fahrzeug, ?Regel)
verkehrsteilnehmer(feuerwehr, sondersignal).
verkehrsteilnehmer(gruenes_auto, kreisverkehr).
verkehrsteilnehmer(gruenes_auto, links).
verkehrsteilnehmer(fahrrad, kreisverkehr).
verkehrsteilnehmer(fahrrad, rechts).
verkehrsteilnehmer(traktor, links).
verkehrsteilnehmer(bus, hauptstrasse).
verkehrsteilnehmer(bus, links).
verkehrsteilnehmer(lkw, rechts).
verkehrsteilnehmer(pferdekutsche, hauptstrasse).
verkehrsteilnehmer(jeep, nebenstra�e).
verkehrsteilnehmer(jeep, rechts).

%%% A2 %%%


