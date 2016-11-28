%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 05 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% A1 %%%

% a(B, C) = a(m, p) ?
% a/2 = a/2
% B = m, C = p
% a(m, p) = a(m, p)
% Unifikation erfolgreich!

% s(1, 2) = s(P, P) ? 
% s/2 = s/2
% P = 1
% Unifizieren fehlgeschlagen
% P wird bereits mit 1 belegt und kann nicht mehr mit 2 belegt werden!

% g(f(s, R),f(R, s)) = g(f(S, t(T)), f(t(t), S)) ?
% g/2 = g/2
% g(f/2, f/2) = g(f/2, f/2)
% S = s, R = t(T), t(T) = t(t)
% g(f(s, t(t)), f(t(t), s)) = g(f(s, t(t)), f( t(t), s))
% Unifikation erfolgreich!

% q(t(r,s),c(g),h(g(T)),t) = q(Y,c(f(r,T)),h(Y)) ?
% q/4 =/= q/3
% Unifizieren fehlgeschlagen
% q/4 und q/3 lassen sich nicht Unifizieren, weil sie nicht zusammen passen!

% true = not(not(True)) ?
% not(not(True) = true
% true = true
% Unifikation erfolgreich!

% True = not(false) ?
% not(false) = true, True = true
% true = true
% Unifikation erfolgreich

%%% A2 %%%

%% Ein Praedikat, das eine Peano-Zahl in eine Integer-Zahl umwandelt.
%peanoToInt(?Peano, ?Int)
%Rekursion stoppt bei: 0 = 0
peanoToInt(0,0).
peanoToInt(s(N),X) :- peanoToInt(N,X1), X is X1+1.

%%% A3 %%%


%%% A4 %%%


%%% A5 %%%