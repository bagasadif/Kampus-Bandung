/* Knowledge Base */
kampus(unpas):-
    anak_sultan(no),
    anak_soleh(no),
    bandung_coret_mau(no),
    gedung_kampus_mewah(no).
kampus(unikom):-
    anak_sultan(no),
    anak_soleh(no),
    bandung_coret_mau(no),
    gedung_kampus_mewah(yes).
kampus(unpad):-
    anak_sultan(no),
    anak_soleh(no),
    bandung_coret_mau(yes),
    jalannya_macet_mau(no),
    mau_cari_pacar(yes).
kampus(ikopin):-
    anak_sultan(no),
    anak_soleh(no),
    bandung_coret_mau(yes),
    jalannya_macet_mau(no),
    mau_cari_pacar(no).
kampus(telkom):-
    anak_sultan(no),
    anak_soleh(no),
    anak_soleh(yes),
    ingin_merasakan_sejuknya_bandung(no),
    bandung_coret_mau(yes),
    jalannya_macet_mau(yes).
kampus(unisba):-
    anak_sultan(no),
    anak_sultan(yes),
    anak_soleh(yes),
    ingin_merasakan_sejuknya_bandung(yes),
    suka_party(no),
    almamater_membuat_bangga(yes),
    kamu_ambis(no).
kampus(polban):-
    anak_sultan(no),
    anak_sultan(yes),
    anak_soleh(yes),
    ingin_merasakan_sejuknya_bandung(yes),
    suka_party(no),
    almamater_membuat_bangga(yes),
    kamu_ambis(yes),
    kamu_wibu(no).
kampus(itb):-
    anak_sultan(no),
    anak_sultan(yes),
    anak_soleh(yes),
    ingin_merasakan_sejuknya_bandung(yes),
    suka_party(no),
    almamater_membuat_bangga(yes),
    kamu_ambis(yes),
    kamu_wibu(yes).
kampus(itenas):-
    anak_sultan(yes),
    suka_party(no),
    almamater_membuat_bangga(no).
kampus(maranata):-
    anak_sultan(yes),
    suka_party(yes),
    banyak_alumni_selebriti(no).
kampus(unpar):-
    anak_sultan(yes),
    suka_party(yes),
    banyak_alumni_selebriti(yes).

/* Asking the user */
anak_sultan(X):-
    menuask(anak_sultan, X, [yes, no]).
suka_party(X):-
    menuask(suka_party, X, [yes, no]).
anak_soleh(X):-
    menuask(anak_soleh, X, [yes, no]).
banyak_alumni_selebriti(X):-
    menuask(banyak_alumni_selebriti, X, [yes, no]).
almamater_membuat_bangga(X):-
    menuask(almamater_membuat_bangga, X, [yes, no]).
ingin_merasakan_sejuknya_bandung(X):-
    menuask(ingin_merasakan_sejuknya_bandung, X, [yes, no]).
bandung_coret_mau(X):-
    menuask(bandung_coret_mau, X, [yes, no]).
kamu_ambis(X):-
    menuask(kamu_ambis, X, [yes, no]).
jalannya_macet_mau(X):-
    menuask(jalannya_macet_mau, X, [yes, no]).
gedung_kampus_mewah(X):-
    menuask(gedung_kampus_mewah, X, [yes, no]).
kamu_wibu(X):-
    menuask(kamu_wibu, X, [yes, no]).
mau_cari_pacar(X):-
    menuask(mau_cari_pacar, X, [yes, no]).

/* Menus for user */
menuask(A, V, _):-
    known(yes, A, V), % succeed if true
    !. % stop looking
menuask(A, V, _):-
    known(_, A, V), % fail if false
    !,
    fail.
menuask(A, V, MenuList) :-
    write('Apakah kamu '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(yes, A, X)),
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
top_goal(X):- kampus(X).

solve:-
    abolish(known, 3),
    top_goal(X),
    write('Rekomendasi kampus buat kamu adalah : '), write(X), nl.
solve:-
    write('No answer found.'), nl.


/* Command loop */
go:-
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == quit.

greeting:-
    write('Program panduan memilih kampus di bandung.'), nl,
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

/* handle undefined procedure */
:- unknown(trace, fail).