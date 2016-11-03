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


%%% A3 %%%

%%1.
%anschluss(NR,Name)
anschluss(0,otter)
anschluss(1,hans)
anschluss(2,peter)
anschluss(3,hellen)
anschluss(4,petra)

%ip(ip,von,bis,anschlussNR)
ip(0.0.0.1,20120101,20130101,0)
ip(0.2.0.0,20120101,20120307,1)
ip(0.0.1.0,20120307,20130101,1)
ip(10.0.0.1,20120101,20130101,4)
ip(0.10.0.1,20120101,20121120,3)
ip(0.10.3.1,20121120,20130101,3)
ip(0.10.66.1,20120301,20120701,2)


%connection(ip,ip,zeitpunk)
connection(0.0.0.1,0.2.0.0,20120203)
connection(10.0.0.1,0.10.66.1,20120203)
connection(0.10.0.1,10.0.0.1,20120403)

%%3.

%%% A4 %%%
/*
Fakt: Fakten sind elementare Klauseln einer Datenbank, welche jeweils ein Element
einer Relation mit dem angegebenen Prädikatsnamen und den dazugehörigen
Argumenten spezifizieren, wobei eine unterschiedliche Stelligkeit desselben
Prädikatsnamens eine unterschiedliche Relation definiert.

Regel:

Anfrage: Anfragen sind ebenfalls elementare Klauseln einer Datenbank, welche am
Systemprompt einzugeben sind. Sie prüfen anhand der Fakten der Datenbasis auf Konsistenz
unter Berücksichtigung der closed world assumption (alle Fakten, welche nicht in der
Datenbasis vorliegen, sind als false anzunehmen).
*/

