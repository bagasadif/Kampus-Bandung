/* Knowledge Base */
os(ios):-
    fear_technology(ya),
    daddy_rich(ya).
os(chrome):-
    fear_technology(ya),
    daddy_rich(tidak).
os(windows):-
    fear_technology(tidak),
    care_privacy(tidak).
os(ubuntu):-
    fear_technology(tidak),
    care_privacy(ya),
    have_life(ya).
os(kali):-
    fear_technology(tidak),
    care_privacy(ya),
    have_life(tidak).

/* Asking the user */
anak_sultan(X):-
    menuask(anak_sultan, X, [ya, tidak]).
suka_party(X):-
    menuask(suka_party, X, [ya,tidak]).
anak_soleh(X):-
    menuask(anak_soleh, X, [ya, tidak]).
banyak_alumni_selebriti(X):-
    menuask(banyak_alumni_selebriti, X, [ya, tidak]).
almamater_membuat_bangga(X):-
    menuask(almamater_membuat_bangga, X, [ya,tidak]).
ingin_merasakan_sejuknya_bandung(X):-
    menuask(ingin_merasakan_sejuknya_bandung, X, [ya,tidak]).
bandung_coret_mau(X):-
    menuask(bandung_coret_mau, X, [ya,tidak]).
kamu_ambis(X):-
    menuask(kamu_ambis, X, [ya,tidak]).
jalannya_macet_mau(X):-
    menuask(jalannya_macet_mau, X, [ya,tidak]).
gedung_kampus_mewah(X):-
    menuask(gedung_kampus_mewah, X, [ya,tidak]).
kamu_wibu(X):-
    menuask(kamu_wibu, X, [ya,tidak]).
mau_cari_pacar(X):-
    menuask(mau_cari_pacar, X, [ya,tidak]).

/* Menus for user */
menuask(A, V, _):-
    known(ya, A, V), % succeed if true
    !. % stop looking
menuask(A, V, _):-
    known(_, A, V), % fail if false
    !,
    fail.
menuask(A, V, MenuList) :-
    write('Do you '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(ya, A, X)),
    X==V.

/* Check input */
check_val(X, _A, _V, MenuList):-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList):-
    write(X), write(' is not a legal value, try again.'), nl,
    menuask(A, V, MenuList).

/* Member rules */
member(X, [X|_]).
member(X, [_|T]):-member(X,T).

/* Simple shell */
top_goal(X):- os(X).

solve:-
    abolish(known, 3),
    top_goal(X),
    write('The answer is '), write(X), nl.
solve:-
    write('No answer found.'), nl.
:-unknown(trace, fail).

/* Command loop */
go:-
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == quit.

greeting:-
    write('This is the Choosing an OS Prolog Exsys.'), nl,
    write('Enter start or quit at the prompt.'), nl.

/* Running Program */
do(start):-
    solve,
    !.

/* Quit Program */
do(quit).
do(X):-
    write(X),
    write('is not a legal command.'), nl,
    fail.
