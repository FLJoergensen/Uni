%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 08 - SE3-LP WiSe 16/17
% 
% Finn-Lasse J�rgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu pr�sentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% A1 %%%
%% 1.1

% d(Merkmalsvektor,Klasse)
d([1, 2, 3], a).
d([2, 4, 1], a).
d([5, 3, 4], b).
d([7, 2, 4], b).
d([8, 2, 5], c).
d([4, 3, 8], c).

%% 1.2 Definieren Sie ein Pr�dikat, das den Abstand von zwei Punkten in einem
%% rein numerischen Merkmalsraum mit beliebiger Dimensionalit�t berechnet.
%% Verwenden Sie daf�r z.B. die Euklidische Distanz.

% In dem Pr�dikat abstand(Punkt1, Punkt2, Abstand) wird zun�chst die Summe unter der
% Wurzel berechnet (bezogen auf die Formel zur Berechnung der Euklidischen Distanz),
% um abschlie�end davon die Quadratwurzel an die Variable "Abstand" zu binden.
%
% abstand(+Punkt1, +Punkt2, -Abstand)
abstand(Punkt1, Punkt2, Abstand) :-
	summeUnterWurzel(Punkt1, Punkt2, Summe),
	Abstand is sqrt(Summe).

% Hilfspr�dikat zur Berechnung der Summe unter der Wurzel mit Hilfe von Rekursion.
summeUnterWurzel([], [], 0). % Rekursionsabschluss
summeUnterWurzel(Punkt1, Punkt2, Summe) :-
	Punkt1 = [Punkt1Akt | Punkt1Rest], % erste "Koordinate" des ersten Punkts
	Punkt2 = [Punkt2Akt | Punkt2Rest], % erste "Koordinate" des zweiten Punkts
	summeUnterWurzel(Punkt1Rest, Punkt2Rest, Summe1), % rekursiver Aufruf mit der
													  % jeweiligen Restliste der Koordinaten
	Summe is ((Punkt1Akt - Punkt2Akt) ** 2) + Summe1. % Zuweisung des Ergebnisses

%% 1.3 Definieren Sie ein Pr�dikat, das eine Liste erzeugt, die f�r jedes Trainings- �
% beispiel eine Struktur mit zwei Angaben enth�lt: den Abstand zwischen dem
% Trainingsbeispiel und dem aktuellen Testbeispiel, sowie die Klassenzugeh�rigkeit
% des jeweiligen Trainingsbeispiels.

% Innerhalb des Pr�dikats erzeugeListe(AktTestbeispiel, Liste) wird zun�chst die
% gesamte Datenbasis der Trainingsdaten in eine Liste "ListeMerkmal" geschrieben.
% Mit dieser Liste wird dann das Helper-Pr�dikat aufgerufen.
%
% erzeugeListe(+AktTestbeispiel, -Liste)
erzeugeListe(AktTestbeispiel, Liste) :-
	findall(Merkmal, d(Merkmal, _), ListeMerkmal),
	erzeugeListeHelper(AktTestbeispiel, ListeMerkmal, Liste).

% Rekursionsabschluss, wenn die Datenbasis der Trainingsdaten abgearbeitet wurde.
erzeugeListeHelper(_, [], []).
% Zun�chst wird das erste Element der Trainingsdatenliste mit der Variablen "Merkmals-
% vektor" unifiziert, um mit diesem im n�chsten Schritt den Abstand zu dem aktuellen
% Testbeispiel "AktTestbeispiel" zu berechnen.
% In der darauffolgenden Zeile wird die Klasse des Merkmalsvektors mit der
% Variablen "Klasse" unifiziert, um diese dann zusammen mit dem Abstand als Kopf
% der Ergebnisliste "Liste" zu unifizieren.
% Abschlie�end erfolgt der rekursive Aufruf des Helpers, um die noch fehlenden Merkmals-
% vektoren mit einbeziehen zu k�nnen.
erzeugeListeHelper(AktTestbeispiel, ListeMerkmal, Liste) :-
	ListeMerkmal = [Merkmalsvektor | RestlisteMerkmal],
	abstand(Merkmalsvektor, AktTestbeispiel, Abstand),
	d(Merkmalsvektor, Klasse),
	Liste = [Abstand, Klasse | RestlisteErgebnis],
	erzeugeListeHelper(AktTestbeispiel, RestlisteMerkmal, RestlisteErgebnis).

%% 1.4 Modifizieren Sie das Pr�dikat aus Aufgabenteil 3 so, dass nur die Klassenzuordnung
% f�r dasjenige Trainingsbeispiel berechnet wird, das den geringsten
% Abstand zur Beobachtung aufweist.

%%% A2 %%%


%%% A3 %%%
