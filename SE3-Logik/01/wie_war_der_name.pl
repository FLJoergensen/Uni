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
d)vater_von(otto,Kind). eigentlich mehr??
Kind=hans.

*/