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

% Aufgabe 2.1
% Prüft ob die gegebene Oberkategorie (spezifizierbar durch ID und / oder Name) in der Herachie über 
% der gegebenen Unterkategorie steht bzw. umgekehrt.
% Kann ebenfalls Ober- bzw. Unterkaegorien finden oder Paare von Ober- und Unterkategorien finden.
% oberkategorie_von(Oberkategorie ID, Oberkategorie Name, Unterkategorie ID, Unterkaegorie Name)

oberkategorie_von(0, wurzelkategorie, UK_ID, Uk_Name) :-
	kategorie(UK_ID, Uk_Name, 0).				% Alles soll unterkategorie von 0 sein.

oberkategorie_von(Ok_ID, OK_Name, UK_ID, Uk_Name) :-
	kategorie(Ok_ID, OK_Name, _),				% checke ob es Oberkategorie gibt / finde Name oder ID
	kategorie(UK_ID, Uk_Name, Ok_ID).			% Prüfe den direkten Fall und dass Unterkategorie existiert.
	
oberkategorie_von(Ok_ID, OK_Name, UK_ID, Uk_Name) :-
	kategorie(UK_ID, Uk_Name, X), 			% Prüfe dass Unterkategorie existiert und finde irgendeine direkte Oberkategorie
	oberkategorie_von(Ok_ID, OK_Name, X, _).	% Rekursiver Aufruf.

% Aufgabe 2.2
% Ist true, wenn in der PfadListe der Pfad vom Wurzelknoten zur angegebenen Kategorie enthalten ist.
% kategorie_pfad(Kategorie ID, Kategorie Name, Liste mit Pfad in der From [(0, wurzelkategorie), (1, buch), ...]) )

kategorie_pfad(K_ID, K_Name, PfadListe) :-
	kategorie(K_ID, K_Name, _),	% Make sure category exists or for iteration over all categories
	findall((Ok_ID, OK_Name),
		oberkategorie_von(Ok_ID, OK_Name, K_ID, _),
	ReversePfadListe),
	reverse(ReversePfadListe, PfadListe).


% Aufgabe 2.3
% liste alle Prokdukte der Kategorie einschließlich  derer ihrer Unterkategorien auf.
% alle_produkte_in_kategorie( Kategorie ID, Kategorie Name, Liste der Produkte in Kategorie in der Form [(34567, hoffnung, sand_molly), ...])
% nur wenn wurzelkategorie angegeben prüfen wir nicht, ob kategorie exsitiert.

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
	
% Aufgabe 2.4
% Listet die Anzahl aller Produkte in einer Kategorie einschließlich ihrer Unterkaegorien auf.
% anzahl_produkte_in_kategorie( Kategorie ID, Kategorie Name, Anzahl der Produckte in Kategorie einschließlich Unterkaegorien)
anzahl_produkte_in_kategorie(K_ID, K_Name, ProduktAnzahl) :-
	alle_produkte_in_kategorie(K_ID, K_Name, ProduktListe),
	length(ProduktListe, ProduktAnzahl).
	
% Aufgabe 2.5
% ermittelt wie vielei Produkte in welcher Kategorie in einem Jar verkauft wurden.
% verkaufte_produkte_in_kategorie_in_jahr( Kategorie ID, kategorie Name, Anzahl der Produkte, das Jahr in dem gesucht werden soll)
% nur wenn kategorie wurzelkategorie nicht prüfen ob kateorie existiert.
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

