%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Aufgabenblatt 01 - SE3-LP WiSe 16/17
% 
% Finn-Lasse Jörgensen 6700628 4joergen@informatik.uni-hamburg.de
% Fabian Behrend
% Daniel Klotzsche 6535732 daniel_klotzsche@hotmail.de
%
% Wir sind bereit folgende Aufgaben zu präsentieren:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[haeuser]
%%% A1 %%%


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


%%% A4 %%%


%%% A5 %%%