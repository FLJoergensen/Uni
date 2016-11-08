%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 02 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[haeuser]

%%% A1 %%%
/*
mutter_von(P1,X),vater_von(X,P2).
P1 ist die Oma von P2

mutter_von(X,P1),mutter_von(Y,X),mutter_von(Y,P2),X\=P2.
P2 ist die\der Tante\Onkel von P1

vater_von(X,P1),mutter_von(Y,X),mutter_von(Y,Z), mutter_von(Z,P2),X\=Z.
P1 ist der\die Cosain\Cosine von P2

mutter_von(X,P1),mutter_von(Y,P2),vater_von(Z,P1), vater_von(Z,P2),P1\=P2,X\=Y.
P1 und P2 sind halbgeschwister (Gleicher Vater unterschidliche Mutter)
*/

%%% A2 %%%

%% 1.

?- obj(_,efh,Strasse,_,_).
% -> Strasse = gaertnerstr ;
% -> Strasse = bahnhofsstr ;
% -> Strasse = bahnhofsstr ;
% -> Strasse = gaertnerstr.

%% 2.

?- obj(Nr,Typ,Strasse,Hausnummer,Baujahr),Baujahr > 2006.
%-> false.
% Es ist kein Haus in der Datenbank, welches in den letzten 10 Jahren gebaut wurde.
?- obj(Nr,Typ,Strasse,Hausnummer,Baujahr),Baujahr > 2006.
%-> Nr = 8,
%-> Typ = informatikum,
%-> Strasse = vogt_koelln_strasse,
%-> Hausnummer = 30,
%-> Baujahr = 2010.

%% 3.

?- obj(Nr,_,Strasse,HsNr,_),\+(obj(Nr,efh,Strasse,HsNr,_)).
%-> Nr = 4,
%-> Strasse = bahnhofsstr,
%-> HsNr = 28 ;
%-> Nr = 5,
%-> Strasse = bahnhofsstr,
%-> HsNr = 30 ;
%-> Nr = 6,
%-> Strasse = bahnhofsstr,
%-> HsNr = 26 ;
%-> Nr = 8,
%-> Strasse = vogt_koelln_strasse,
%-> HsNr = 30.

%% 4.

?- bew(_,Nr1,_,K1,_,Datum),Datum>20111103, bew(_,Nr2,V2,_,_,_),Nr1=Nr2,K1=V2.
%-> false.
% Keine passenden Einträge.
?- assert(bew(5, 8, stadthamburg, danielklotzsche, 1000000, 20121103)).
?- assert(bew(6, 8, danielklotzsche, donaldtrump, 100000000, 20140101)).

?- bew(_,Nr1,_,K1,_,Datum),Datum>20111103, bew(_,Nr2,V2,_,_,_),Nr1=Nr2,K1=V2.
%-> Nr1 = Nr2, Nr2 = 8,
%-> K1 = V2, V2 = danielklotzsche,
%-> Datum = 20121103 ;
%-> false.

%% 5.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TODO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
?- obj(Nr,_,gaertnerstr,_,_),bew(_,Nr,Verkaeufer,Kaeufer,Preis1,_),(bew(_,_,_,_,PreisGroesser,_),PreisGroesser>Preis1.

%%% A3 %%%

%%1.

:- dynamic anschluss/2.

%anschluss(NR,Name)
anschluss(0,otter).
anschluss(1,hans).
anschluss(2,peter).
anschluss(3,hellen).
anschluss(4,petra).

:- dynamic ip/4.

%ip(ip,von,bis,anschlussNR)
ip("0.0.0.1",20120101,20130101,0).
ip("0.2.0.0",20120101,20120307,1).
ip("0.0.1.0",20120307,20130101,1).
ip("10.0.0.1",20120101,20130101,4).
ip("0.10.0.1",20120101,20121120,3).
ip("0.10.3.1",20121120,20130101,3).
ip("0.10.66.1",20120301,20120701,2).

:- dynamic connection/3.

%connection(ip,ip,zeitpunk)
connection("0.0.0.1","0.2.0.0",20120203).
connection("10.0.0.1","0.10.66.1",20120203).
connection("0.10.0.1","10.0.0.1",20120403).

%%3.
%Welche IP wurde wem zugewiesen
?- anschluss(ID,Name) , ip(IP,_,_,ID).


%%% A4 %%%
/*
Fakt: Fakten sind elementare Klauseln einer Datenbank, welche jeweils ein Element
einer Relation mit dem angegebenen Prädikatsnamen und den dazugehörigen
Argumenten spezifizieren, wobei eine unterschiedliche Stelligkeit desselben
Prädikatsnamens eine unterschiedliche Relation definiert.

Regel: Regeln sind Einträge bzw. Klauseln in einer Datenbank. Diese besagen, dass bei Gültigkeit
eines bestimmten Fakts ein anderer, durch die Regel definierter Fakt ebenso gilt.
Mithilfe von Regeln lassen sich neue Fakten aus bisher bekannten Fakten ableiten.
Durch Regeln wird eine mögliche Redundanz vermieden und es können Relationen über
unendlichen Domänen spezifiziert werden.

Anfrage: Anfragen sind ebenfalls elementare Klauseln einer Datenbank, welche am
Systemprompt einzugeben sind. Sie prüfen anhand der Fakten der Datenbasis auf Konsistenz
unter Berücksichtigung der closed world assumption (alle Fakten, welche nicht in der
Datenbasis vorliegen, sind als false anzunehmen).
*/

