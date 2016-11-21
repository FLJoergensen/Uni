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

%%% A1 %%%


%%% A2 %%%


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

%%% A4 %%%


%%% A5 %%%