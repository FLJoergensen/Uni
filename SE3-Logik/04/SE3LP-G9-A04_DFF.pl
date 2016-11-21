%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 04 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[medien2]
%%% A1 %%%


%%% A2 %%%

%% Aufgabe 2.1
% Prüft ob die gegebene Oberkategorie (spezifizierbar durch ID und / oder Name) in der Herachie über 
% der gegebenen Unterkategorie steht bzw. umgekehrt.
% Kann ebenfalls Ober- bzw. Unterkategorien finden oder Paare von Ober- und Unterkategorien finden.

% oberkategorie_von(Oberkategorie ID, Oberkategorie Name, Unterkategorie ID, Unterkategorie Name)
oberkategorie_von(0, wurzelkategorie, UK_ID, Uk_Name) :-
	kategorie(UK_ID, Uk_Name, 0).

oberkategorie_von(Ok_ID, OK_Name, UK_ID, Uk_Name) :-
	kategorie(Ok_ID, OK_Name, _),	
	kategorie(UK_ID, Uk_Name, Ok_ID).
	
oberkategorie_von(Ok_ID, OK_Name, UK_ID, Uk_Name) :-
	kategorie(UK_ID, Uk_Name, X), 			
	oberkategorie_von(Ok_ID, OK_Name, X, _).	

%% Aufgabe 2.2
% Gibt true aus, wenn der Pfad vom Wurzelknoten zur angegebenen Kategorie in der PfadListe enthalten ist.

% kategorie_pfad(Kategorie ID, Kategorie Name, Liste mit Pfad in der From [(0, wurzelkategorie), (1, buch), ...]) )
kategorie_pfad(K_ID, K_Name, PfadListe) :-
	kategorie(K_ID, K_Name, _),
	findall((Ok_ID, OK_Name),
		oberkategorie_von(Ok_ID, OK_Name, K_ID, _),
	ReversePfadListe),
	reverse(ReversePfadListe, PfadListe).

%% Aufgabe 2.3
% Es werden alle Produkte der Kategorie und alle Produkte der Unterkategorien aufgelistet.
% Wenn die Wurzelkategorie angegeben wird, wird nicht geprüft, ob diese existiert.

% alle_produkte_in_kategorie( Kategorie ID, Kategorie Name, Liste der Produkte in Kategorie in der Form [(34567, hoffnung, sand_molly), ...])
alle_produkte_in_kategorie(0, wurzelkategorie, ProduktListe) :-
	findall((P_ID, P_Titel, P_Autor), (
		in_kategorie(P_ID,0),
		produkt(P_ID, _, P_Titel, P_Autor, _, _, _)
	),ProduktListe).

alle_produkte_in_kategorie(K_ID, K_Name, ProduktListe) :-
	kategorie(K_ID, K_Name, _),
	findall((P_ID, P_Titel, P_Autor), (
		in_kategorie(P_ID,K_ID),
		produkt(P_ID, _, P_Titel, P_Autor, _, _, _)
	),ProduktListe).

in_kategorie(P_ID, K_ID) :-
	produkt(P_ID,K_ID,_,_,_,_,_).
	
in_kategorie(P_ID, K_ID) :-
	kategorie(UK_ID, _, K_ID),
	in_kategorie(P_ID, UK_ID).
	
%% Aufgabe 2.4
% Listet die Anzahl aller Produkte in einer Kategorie einschließlich ihrer Unterkategorien auf.

% anzahl_produkte_in_kategorie( Kategorie ID, Kategorie Name, Anzahl der Produkte in Kategorie einschließlich Unterkategorien)
anzahl_produkte_in_kategorie(K_ID, K_Name, ProduktAnzahl) :-
	alle_produkte_in_kategorie(K_ID, K_Name, ProduktListe),
	length(ProduktListe, ProduktAnzahl).
	
%% Aufgabe 2.5
% Es wird ermittelt wie viele Produkte aus welcher Kategorie in einem Jahr wie oft verkauft wurde.
% Wenn die Wurzelkategorie angegeben wird, wird nicht geprüft, ob diese existiert.

% verkaufte_produkte_in_kategorie_in_jahr( Kategorie ID, kategorie Name, Anzahl der Produkte, das Jahr in dem gesucht werden soll)
verkaufte_produkte_in_kategorie_in_jahr(0, wurzelkategorie,  ProduktAnzahl, Jahr) :-
	verkauft(_,Jahr,_,_), % finde ein jahr falls nicht angegeben
	findall(Anzahl, (
		in_kategorie(P_ID,0),
		verkauft(P_ID,Jahr,_,Anzahl)
	),AnzahlListe),
	sum_list(AnzahlListe, ProduktAnzahl).

verkaufte_produkte_in_kategorie_in_jahr(K_ID, K_Name,  ProduktAnzahl, Jahr) :-
	verkauft(_,Jahr,_,_), % finde ein jahr falls nicht angegeben
	kategorie(K_ID, K_Name, _),
	findall(Anzahl, (
		in_kategorie(P_ID,K_ID),
		verkauft(P_ID,Jahr,_,Anzahl)
	),AnzahlListe),
	sum_list(AnzahlListe, ProduktAnzahl).

%%% A3 %%%

?- [gleisplan].

%% 1.

% Gleis1 hat eine direkte oder eine indirekte Verbindung zu Gleis2,
% ohne dabei die Fahrtrichtung wechseln zu müssen.
%
% verbindungA1(?Gleis1, ?Gleis2)
verbindungA1(Gleis1, Gleis2) :-
	weiche(_, Gleis1, Gleis2, _).

verbindungA1(Gleis1, Gleis2) :-
	weiche(_, Gleis1, GleisMitte, _),
	verbindungA1(GleisMitte, Gleis2).

%% 2.

% Das Prädikat "belegt(Gleis)" legt fest, dass ein Gleis belegt ist.
?- assert(belegt(g2)).
?- assert(belegt(g3)).
?- assert(belegt(g4)).
?- assert(belegt(g9)).

% Angepasste Definition, sodass eine Verbindung nur besteht, wenn
% keines der Gleise belegt ist.
%
% verbindungA2(?Gleis1, ?Gleis2)
verbindungA2(Gleis1, Gleis2) :-
	\+ belegt(Gleis1),
	\+ belegt(Gleis2),
	weiche(_, Gleis1, Gleis2, _).

verbindungA2(Gleis1, Gleis2) :-
	weiche(_, Gleis1, GleisMitte, _),
	\+ belegt(GleisMitte),
	verbindungA2(GleisMitte, Gleis2).

% Tests für A2
?- verbindungA2(a1, z5).
% true.

?- verbindungA2(z1, z5).
% true.

?- verbindungA2(a11, a5).
% false.

?- verbindungA2(z2, a4).
% false.

%% 3.

% Erweiterte Definition, sodass der Zug nur Gleise, die mindestens die Länge
% des Zuges aufweisen, befahren darf.
%
% verbindungA3(?Gleis1, +Gleis2, ?Zuglaenge)
passend(Gleis, Zuglaenge, Typ) :-
	gleis(Gleis, Laenge, Typ),
	Laenge > Zuglaenge.

verbindungA3(Gleis1, Gleis2, Zuglaenge) :-
	\+ belegt(Gleis1),
	\+ belegt(Gleis2),
	passend(Gleis1, Zuglaenge, _),
	passend(Gleis2, Zuglaenge, _),
	weiche(_, Gleis1, Gleis2, _).

verbindungA3(Gleis1, Gleis2, Zuglaenge) :-
	weiche(_, Gleis1, GleisMitte, _),
	\+ belegt(GleisMitte),
	verbindungA3(GleisMitte, Gleis2, Zuglaenge).

%% 4.

% Dient zur Bestimmung eines Ankunftsgleises eines Zuges.
%
% ankunft(?Von_Ort, -Gleis, ?Zuglaenge)
ankunft(Von_Ort, Gleis, Zuglaenge) :-
	einfahrt(Ankunftsgleis, Von_Ort),
	verbindungA3(Ankunftsgleis, Gleis, Zuglaenge).

% Dient zur Bestimmung eines Abfahrtsgleises eines Zuges.
%
% abfahrt(?Nach_Ort, -Gleis, ?Zuglaenge)
abfahrt(Nach_Ort, Gleis, Zuglaenge) :-
	ausfahrt(Abfahrtsgleis, Nach_Ort),
	verbindungA3(Abfahrtsgleis, Gleis, Zuglaenge).
