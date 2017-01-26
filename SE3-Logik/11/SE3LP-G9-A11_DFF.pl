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

%% 2.1 Implementieren Sie ein Regelsystem zur Bildung der Flexionsformen f�r deut-
%% sche Verben, das f�r einen gegebenen Infinitiv die 1. Person Plural Pr�sens
%% und Pr�teritum, sowie das Perfektpartizip berechnet und dabei mit m�glichst
%% wenigen wortspezifischen Informationen auskommen soll. Beachten Sie dabei
%% insbesondere die in Tabelle ?? angegebenen F�lle. Lassen Sie zur Vereinfachung
%% Verben mit abtrennbaren Pr�fixen (absagen, ausbauen, einsammeln,
%% durchregnen, zumachen, ...) vorerst au�er Betracht. Behandeln Sie die stark
%% flektierenden Verben als spezielle Ausnahmef�lle.
%% Hinweis: Beginnen Sie auch hier wieder mit den regelm��igen Bildungen und
%% f�gen Sie schrittweise neue Klauseln f�r die jeweils allgemeinsten Ausnah-
%% mef�lle hinzu.

% flexion(+Infinitiv, -Praesens, -Praeteritum, -Partizip)
%
% Gibt die letzten drei Buchstaben des Infinitivs an ein Hilfspr�dikat weiter.
flexion(Infinitiv, Praesens, Praeteritum, Partizip) :-
	atom_chars(Infinitiv, Liste),
	reverse(Liste, ListeR),
	ListeR = [Z, Y, X | _],
	flexion_(X, Y, Z, Infinitiv, Praesens, Praeteritum, Partizip).

% Hilfspr�dikat zu flexion/4
% flexion_(+DrittletzterBuchstabe, +VorletzterBuchstabe, +LetzterBuchstabe,
%		   +Infinitiv, +Praesens, +Praeteritum, +Partizip)

sfv(schreiben,schreiben,schrieben,geschrieben).
sfv(heben,heben,hoben,gehoben).
sfv(schlafen,schlafen,schliefen,geschlafen).
sfv(waschen,waschen,wuschen,gewaschen).
sfv(treten,treten,traten,getreten).
sfv(trinken,trinken,tranken,getrunken).
sfv(singen,singen,sangen,gesungen).
sfv(haengen,haengen,hingen,gehangen).
sfv(haben,haben,hatten,gehabt).
sfv(sein,sind,waren,gewesen).
% regul�re (stark flektierende) Verben
flexion_(X, Y, Z, Infinitiv, Praesens, Praeteritum, Partizip) :-
	sfv(Infinitiv, Praesens, Praeteritum, Partizip).

rvmnap(bewundern,bewundern,bewunderten,bewundert).
rvmnap(verschuetten,verschuetten,verschuetteten,verschuettet).
% regul�re Verben mit nicht abnehmbaren Praefix
flexion_(X, Y, Z, Infinitiv, Praesens, Praeteritum, Partizip) :-
	rvmnap(Infinitiv, Praesens, Praeteritum, Partizip).
	
% regul�re Verben auf -eln / -ern
flexion_(X, Y, Z, Infinitiv, Praesens, Praeteritum, Partizip) :-
	((X = e,
	  Y = l,
	  Z = n);
	 (X = e,
	  Y = r,
	  Z = n)),
	Praesens = Infinitiv,
	atom_chars(Infinitiv, ListeInf),
	reverse(ListeInf, ListeInfR),
	ListeInfR = [_ | RestListeInfR],
	reverse(RestListeInfR, ListeInfAnfang),
	append(ListeInfAnfang, [t, e, n], ListePraet),
	atom_chars(Praeteritum, ListePraet),
	append(ListeInfAnfang, [t], ListePartEnde),
	append([g, e], ListePartEnde, ListePart),
	atom_chars(Partizip, ListePart),
	!.

% regul�re Verben mit Stammauslaut auf -d / -t (genau wie -eln / -ern)
flexion_(X, _Y, _Z, Infinitiv, Praesens, Praeteritum, Partizip) :-
	(X = d;
	 X = t),
	Praesens = Infinitiv,
	atom_chars(Infinitiv, ListeInf),
	reverse(ListeInf, ListeInfR),
	ListeInfR = [_ | RestListeInfR],
	reverse(RestListeInfR, ListeInfAnfang),
	append(ListeInfAnfang, [t, e, n], ListePraet),
	atom_chars(Praeteritum, ListePraet),
	append(ListeInfAnfang, [t], ListePartEnde),
	append([g, e], ListePartEnde, ListePart),
	atom_chars(Partizip, ListePart),
	!.

% regul�re (schwach flektierende) Verben
flexion_(_X, Y, Z, Infinitiv, Praesens, Praeteritum, Partizip) :-
	Y = e,
	Z = n,
	Praesens = Infinitiv,
	atom_chars(Infinitiv, ListeInf),
	append(Wortanfang, [e, n], ListeInf),
	append(Wortanfang, [t], WortanfangT),
	append(WortanfangT, [e, n], ListePraet),
	atom_chars(Praeteritum, ListePraet),
	append([g, e], WortanfangT, ListePart),
	atom_chars(Partizip, ListePart),
	!.
	

%% 2.2 Testen Sie Ihre Implementation mit unterschiedlichen Verben und begr�nden
%% Sie, warum Ihr Programm ggf. fehlerhafte Resultate erzeugt. Ber�cksichtigen �
%% Sie dabei auch Neubildungen wie etwa googeln, d�deln, recyceln, grepen, smsen...
%% Geben Sie an, ob die Ergebnisse Ihres Programms mit Ihrer sprachlichen
%% Intuition �bereinstimmen und erkl�ren Sie etwa auftretende Abweichungen.
%%
%% Korekkte Ergebnisse
%% flexion(sagen,Ptaesens,Praeteritum,Partizip).
%% flexion(beugen,Ptaesens,Praeteritum,Partizip).
%% flexion(warten,Ptaesens,Praeteritum,Partizip).
%% flexion(leiten,Ptaesens,Praeteritum,Partizip).
%% flexion(feiern,Ptaesens,Praeteritum,Partizip).
%% flexion(hobeln,Ptaesens,Praeteritum,Partizip).
%%
%% Fehlerhafte Ergebnisse
%% flexion(bewundern,Ptaesens,Praeteritum,Partizip).
%%
%%
%% Neubildungen
%% funktioniert: googlen, d�deln, smsen
%% funktioniert nicht: recyceln
%%
%% beim recyceln im Partizip d�rfte nicht das ge vorangestellt werden

%% 2.3 Erweitern Sie Ihre Modellierung auf einige Verben mit abtrennbaren Pr�fixen.
flexion(bewundern,Ptaesens,Praeteritum,Partizip).
flexion(verschuetten,Ptaesens,Praeteritum,Partizip).
