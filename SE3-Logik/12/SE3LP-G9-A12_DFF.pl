%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 12 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrendt 6534523 fabian.behrendt95@gmail.com
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% A1 %%%

%% Geben Sie für die folgenden s-Ausdrücke an, in welcher Reihenfolge und mit wel-
%% chen Zwischenergebnissen ein Scheme-Interpreter ihren Wert ermittelt. Z.B. lässt
%% sich für den Ausdruck
%% (> (car (quote (2 4))) (car (cdr (quote (1 2 3)))) )
%% die Auswertungsreihenfolge durch folgendes Ablaufprotokoll veranschaulichen:
%% (> (car (quote (2 4)) (car (cdr (quote (1 2 3)))) )
%%    (car (quote (2 4))
%%         (quote (2 4))
%%         ==> (2 4)
%%    ==> 2
%%    (car (cdr (quote (1 2 3))))
%%         (cdr (quote (1 2 3)))
%%              (quote (1 2 3))
%%              ==> (1 2 3)
%%         ==> (2 3)
%%    ==> 2
%% ==> #f

%% 1.1 (list (cdr (cdr (cdr (quote (1 2 3 4)))))
%% (car (cdr (quote (1 2 3 4)))) )

%    (cdr (cdr (cdr (quote (1 2 3 4)))))
%         (cdr (cdr (quote (1 2 3 4))))
%              (cdr (quote (1 2 3 4)))
%                   (quote (1 2 3 4))
%                   ==> (1 2 3 4)
%              ==> (2 3 4)
%         ==> (3 4)
%    ==> (4)
%    (car (cdr (quote (1 2 3 4))))
%         (cdr (quote (1 2 3 4)))
%              (quote (1 2 3 4))
%              ==> (1 2 3 4)
%         ==> (2 3 4)
%    ==> 2
% ==> ((4) 2)

%% 1.2 (if (< (car (quote (5 -3 4 -2))) 0) 0 1)

%    (< (car (quote (5 -3 4 -2))) 0)
%       (car (quote (5 -3 4 -2)))
%            (quote (5 -3 4 -2))
%            ==> (5 -3 4 -2)
%       ==> 5
%    ==> #f
% ==> 1

%% Geben Sie für die folgenden Scheme-Ausdrücke an, zu welchem Wert sie evaluieren.

%% 1.3 (cons (cdr (quote (1 . 2)))
%% (cdr (quote (1 2 . 3))) )

% ==> (2 2 . 3)

%% 1.4 (map (lambda (x) (if (pair? x) (cdr x) x))
%% (quote (lambda (x) (if (pair? x) (cdr x) x))) )

% ==> (lambda () ((pair? x) (cdr x) x))

%% 1.5 (filter (curry < 5)
%% (reverse (quote (1 3 5 7 9))) )

% ==> (9 7)

%% 1.6 (filter (compose negative?
%% (lambda (x) (- x 5)) )
%% (quote (1 3 5 7 9)) )

% ==> (1 3)



%%% A2 %%%

%% Was berechnen die folgenden Funktionen? Reimplementieren Sie jeweils ein analoges
%% Prädikat in Prolog. Diskutieren Sie Unterschiede und Gemeinsamkeiten der
%% beiden Implementationen.

%% 2.1 (define (foo1 x y)
%%         (if (null? x)
%%             #t
%%             (if (null? y)
%%                 #f
%%                 (if (eq? (car x) (car y))
%%                     (foo1 (cdr x) (cdr y))
%%                     (foo1 x (cdr y)) ) ) ) )

% Alle Listenelemente von X sind in gegebender Reihenfolge in Y enthalten.
foo1([], _).
foo1(_, []) :- fail, !.
foo1([X | X_Rest], [Y | Y_Rest]) :-
    X = Y ->
        foo1(X_Rest, Y_Rest);
        foo1([X | X_Rest], Y_Rest).
        
% ?- foo1([1,2,3,4,5,6], [1,2,3,4,5,6,7,8,9]).
% true .
% ?- foo1([1,2,3,5], [2,3,4,5,6,7]).
% false.
% ?- foo1([1,3,2], [3,1,2]).
% false.

%% 2.2 (define (foo2 x y)
%%         (if (null? x)
%%             y
%%             (if (member (car x) y)
%%                 (foo2 (cdr x) y)
%%                 (cons (car x) (foo2 (cdr x) y) ) ) ) )

% Berechnet eine Liste aus den Listen X und Y, welche die Elemente von 
% X und Y ohne duplikate enthält.
foo2([], Y, Y).
foo2([X | X_Rest], Y, Ergebnis_Liste) :-
    member(X, Y) ->
        foo2(X_Rest, Y, Ergebnis_Liste);
        (
            foo2(X_Rest, Y, Ergebnis_Liste_Rest),
            Ergebnis_Liste = [X | Ergebnis_Liste_Rest]
        ).
        
% ?- foo2([1,2,3,4,5,6], [1,2,3,4,5,6,7,8],E).
% E = [1, 2, 3, 4, 5, 6, 7, 8].

%% 2.3 (define (foo3 x y)
%%         (if (null? x)
%%             (quote ())
%%             (if (member (car x) y)
%%                 (foo3 (cdr x) y)
%%                 (cons (car x) (foo3 (cdr x) y) ) ) ) )

% Es wird eine Liste mit allen Elementen aus X, die nicht in Y sind ausgegeben.
foo3([],_,[]).
foo3([X | X_Rest], Y, Ergebnis_Liste) :-
    member(X, Y) ->
        foo3(X_Rest, Y, Ergebnis_Liste);
        (
            foo3(X_Rest, Y, Ergebnis_Liste_Rest),
            Ergebnis_Liste = [X | Ergebnis_Liste_Rest]
        ).

% ?- foo3([1,2,3,4,5],[3,4,5,6],E).
% E = [1, 2].

%% 2.4 (define (foo4 x)
%%         (letrec
%%             ((foo4a (lambda (x y)
%%                       (if (null? x) y
%%                         (if (> (car x) y)
%%                           (foo4a (cdr x) (car x) )
%%                           (foo4a (cdr x) y) ) ) )) )
%%         (foo4a (cdr x) (car x)) ) )

% Der Maximale Wert der Liste wird berechnet.
foo4([X], X).
foo4([X | X_Rest], Maximum) :-
    foo4(X_Rest, Maximum_Zwischenergebnis),
    ((X > Maximum_Zwischenergebnis) ->
        Maximum = X;
        Maximum = Maximum_Zwischenergebnis).
        
% ?- foo4([20, 35, 99, 2, 50],M).
% M = 99 .

%% Hinweis: letrec ist eine Variante von let, die auch die Verwendung rekursiver
%% Funktionsdefinitionen unterstützt.

%% 2.5 (define (foo5 x y)
%%         (if (or (null? x) (null? y))
%%             0
%%             (+ (* (car x) (car y))
%%                (foo5 (cdr x) (cdr y))) ) )

%Berechnet das Skalarprodukt
foo5([],_, 0).
foo5(_,[],0).
foo5([X | X_Rest], [Y | Y_Rest], Ergebnis) :-
    foo5(X_Rest, Y_Rest, Zwischenergebnis),
    Ergebnis is X* Y + Zwischenergebnis.
    
% foo5([1,2,3],[1,4,2],E).
% E = 15 .

%%% A3 %%%

%% Überlegen Sie sich eine geeignete Repräsentation für die Peano-Zahlen in Scheme.
%% Reimplementieren Sie die Prädikate lt/2, integer2peano/2 und add/3 für das
%% Rechnen mit Peano-Zahlen als Scheme-Funktionen. Diskutieren Sie Unterschiede
%% und Gemeinsamkeiten zwischen den Prolog- und Scheme-Implementationen.

% Peano-Zahlen in Prolog
peano(0).
peano(s(X)) :- peano(X).

% Peano-Zahlen in Scheme
%
% (define (peano? x)
%   (if (and (equal? (car x) 0)
%           (null? (cdr x)))
%      #t
%      (if (equal? (car x) 's)
%      (peano? (cdr x))
%      #f
%      )
%  )
% )


% lt/2 in Prolog
lt(0, s(_)).
lt(s(X), s(Y)) :- lt(X, Y).

% lt/2 in Scheme
%
% (define (lt x y)
%   (if (and (equal? (car x) 0)
%            (> (length y) 1))
%       #t
%       (if (and (equal? (car x) 's)
%                (equal? (car y) 's))
%           (lt (cdr x) (cdr y))
%           #f)
%       )
%   )


% integer2peano/2 in Prolog
integer2peano(0, 0) :- !.
integer2peano(I, s(P)) :- I1 is I - 1, integer2peano(I1, P).

% integer2peano/2 in Scheme
%
% (define (integer2peano x)
%   (if (equal? x 0)
%       '(0)
%       (append '(s) (integer2peano (- x 1)))
%       )
%   )


% add/3 in Prolog
add(0, X, X).
add(s(X), Y, s(R)) :- add(X, Y, R).

% add/3 in Scheme
%
% (define (add x y)
%   (if (equal? (car x) 0)
%       y
%       (append '(s) (add (cdr x) y))
%       )
%   )
