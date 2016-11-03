%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 02 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrend
% Daniel Klotzsche 6535732
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%A1
*/
mutter_von(P1,X),vater_von(X,P2).
P1 ist die Oma von P2

mutter_von(X,P1),mutter_von(Y,X),mutter_von(Y,P2),X\=P2.
P2 ist die\der Tante\Onkel von P1

vater_von(X,P1),mutter_von(Y,X),mutter_von(Y,Z), mutter_von(Z,P2),X\=Z.
P1 ist der\die Cosain\Cosine von P2

mutter_von(X,P1),mutter_von(Y,P2),vater_von(Z,P1), vater_von(Z,P2),P1\=P2,X\=Y.
P1 und P2 sind halbgeschwister (Gleicher Vater unterschidliche Mutter)
/*


%A2


%A3


%A4

%A5