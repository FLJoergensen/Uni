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

%% 2.2 (define (foo2 x y)
%%         (if (null? x)
%%             y
%%             (if (member (car x) y)
%%                 (foo2 (cdr x) y)
%%                 (cons (car x) (foo2 (cdr x) y) ) ) ) )

%% 2.3 (define (foo3 x y)
%%         (if (null? x)
%%             (quote ())
%%             (if (member (car x) y)
%%                 (foo3 (cdr x) y)
%%                 (cons (car x) (foo3 (cdr x) y) ) ) ) )

%% 2.4 (define (foo4 x)
%%         (letrec
%%             ((foo4a (lambda (x y)
%%                       (if (null? x) y
%%                         (if (> (car x) y)
%%                           (foo4a (cdr x) (car x) )
%%                           (foo4a (cdr x) y) ) ) )) )
%%         (foo4a (cdr x) (car x)) ) )

%% Hinweis: letrec ist eine Variante von let, die auch die Verwendung rekursiver
%% Funktionsdefinitionen unterstützt.

%% 2.5 (define (foo5 x y)
%%         (if (or (null? x) (null? y))
%%             0
%%             (+ (* (car x) (car y))
%%                (foo5 (cdr x) (cdr y))) ) )



%%% A3 %%%

%% Überlegen Sie sich eine geeignete Repräsentation für die Peano-Zahlen in Scheme.
%% Reimplementieren Sie die Prädikate lt/2, integer2peano/2 und add/3 für das
%% Rechnen mit Peano-Zahlen als Scheme-Funktionen. Diskutieren Sie Unterschiede
%% und Gemeinsamkeiten zwischen den Prolog- und Scheme-Implementationen.

% Peano-Zahlen in Scheme
%
% (define (peano? x)
%  (if (and (equal? (car x) 0)
%           (null? (cdr x)))
%      #t
%      (if(equal? (car x) 's)
%      (peano? (cdr x))
%      #f
%      )
%  )
% )

% lt/2 in Scheme
%
%

% integer2peano/2
%
%

% add/3
%
%
