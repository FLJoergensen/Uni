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

prioritaet(sondersignal, 5) :- !.
prioritaet(kreisverkehr, 4) :- !.
prioritaet(hauptstrasse, 3) :- !.
prioritaet(rechts, 2) :- !.
prioritaet(links, 1) :- !.

hat_vorfahrt(Fahrzeug_A, Fahrzeug_B) :-
    prioritaet(Fahrzeug_A, Prioritaet_A),
    prioritaet(Fahrzeug_B, Prioritaet_B),
    Prioritaet_A > Prioritaet_B.

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

% Pr�ft ob Fahrzeug_A vorfahrt vor Fahrzeug_B hat. Wenn Fahrzeug_B mehr als einmal vorkommt,
% wird abgebrochen, sobald ein Fahrzeug_B vorfahrt vor Fahrzeug_A hat.
teste_vorfahrt(Fahrzeug_A, Fahrzeug_B) :-
    verkehrsteilnehmer(Fahrzeug_A, RegelA),
    writef('Fahrzeug_A hat die Prioritaet %w\n', [RegelA]),
    
    forall(verkehrsteilnehmer(Fahrzeug_B, RegelB), (
        writef('Testen: %w und %w\n', [RegelA, RegelB]),
        writef('Fahrzeug_B hat die Prioritaet %w\n', [RegelB]),
        hat_vorfahrt(RegelA, RegelB))),
    writef('"%w" hat Vorfahrt vor "%w", weil "%w" die h�chste Prioritaet der getesteten Fahrzeuge hat.\n', [Fahrzeug_A, Fahrzeug_B, RegelA]).
    
teste_nachrang(Fahrzeug_A, Fahrzeug_B) :-
	\+teste_vorfahrt(Fahrzeug_A, Fahrzeug_B),
	 writef('Fahrzeug "%w" hat keine Vorfahrt vor "%w", da die Prioritaet niedriger ist.\n', [Fahrzeug_A, Fahrzeug_B]).
	 
teste_regeln(Fahrzeug_A, Fahrzeug_B) :-
	teste_nachrang(Fahrzeug_A, Fahrzeug_B),
	teste_vorfahrt(Fahrzeug_A, Fahrzeug_B).


%%% A2 %%%


