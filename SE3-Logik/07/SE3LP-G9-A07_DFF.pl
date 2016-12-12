%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 07 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
?- [medien2].
%%% A1 %%%
%% 1.
%Ein Praedikat, das den Umsatz fuer jedes Produkt in einer vorgegebenen Kategorie
%in einem vorgegebenen Jahr berechnet.

umsatz(Kategorie_ID ,Jahr ,Produkt_ID ,Umsatz) :-
  produkt( Produkt_ID , Kategorie_ID , _ , _ , _ , _ , _ ),
  verkauft( Produkt_ID , Jahr , Preis , Anzahl ),
  Umsatz is Preis * Anzahl.

%% 2.
% Ein Praedikat, das fur eine gegebene Kategorie ermittelt, ob sich der mit den
% betreffenden Produkten erzielte Umsatz in den letzten fuenf Jahren gesteigert
% oder verringert hat. Ueberlegen Sie sich dafuer eine geeignete Heuristik zur
% Trendabschaetzung (z.B. Anstieg der Regressionsgeraden oder relative Hoehe
% des Umsatzes im letzten Jahr im Vergleich zum Mittelwert der letzten fuenf
% Jahre.)

% Es wird der Umsatz aller Jahre aufsummiert und der Durchschnitt gebildet. 
% Wenn der Durchschnitt groesser als der aktuelle Umsatz (aus dem im Praedikatsaufruf angegebenen Jahr) ist, 
% ist der Umsatz gestiegen und es wird 'true' ausgegeben. Wenn nicht, dann wird 'false' ausgegeben. 
umsatz_gesteigert(Kategorie_ID, Jahr) :-
	umsatz_gesteigert_in_fuenf(Kategorie_ID, Jahr, 5).
	
umsatz_gesteigert_in_fuenf(Kategorie_ID, Jahr, Jahre) :-
  findall(Umsatz ,
           (umsatz( Kategorie_ID, Jahr1,_, Umsatz) ,
             Jahr1 < Jahr,
             Jahr1 >= Jahr - Jahre),
           Umsaetze),
  umsatz(Kategorie_ID, Jahr,_, AktuellerUmsatz),
  sum_list(Umsaetze , SummeUmsaetze),
  Durchschnitt is (SummeUmsaetze + AktuellerUmsatz) / (Jahre + 1),
  Durchschnitt < AktuellerUmsatz.

?- umsatzGesteigert( 7 , 2012 , 5 ).
% -> false.
?- umsatzGesteigert(9, 2009, 5).
% -> true.

%% 3.


%%% A2 %%%


