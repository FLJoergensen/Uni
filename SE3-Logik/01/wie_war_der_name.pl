[familie]
%consult('familie.pl').
listing(mutter_von).

assert(mutter_von(helga,assert)).
asserta(mutter_von(helga,asserta)).
assertz(mutter_von(helga,assertz)).
%open('myClauses.pl',write,S), set_output(S), listing, close(S).

/*
A1
1.
2.
3.
assert  : fügt den eintrag an der aktuell letzten stelle hinzu
asserta : fügt den eintrag vorne an die datenbank an
assertz : am ende?
A2
1.
a)mutter_von(julia,otto).
Ja
b)vater_von(otto,helga).
Ja
c)vater_von(Vater,julia).
existiert nicht
d)vater_von(otto,Kind).
Kind=hans;
Kind=helga.
e)mutter_von(M,K1);vater_von(V,K1).
f)not(vater_von(hans,Kind)).
true
g)not(vater_von(johannes,Kind)).
false
h)vater_von(otto,_).
true
2.
mutter_von(charlotte,Kind),(mutter_von(Kind,Enkel);vater_von(Kind,Enkel)).
3.
trace()
help(trace)
nodebug()

*/