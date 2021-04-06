/* Knowledge Base */
kampus(kerja_aja):-
    mau_kuliah(no).

kampus(unpar):-
    mau_kuliah(yes),
    anak_sultan(yes).

kampus(uin):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(yes).

kampus(unpas):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(no).

kampus(itb):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(yes).

kampus(unjani):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(no),
    ingin_merasakan_sejuknya_bandung(no).

kampus(upi):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(no),
    ingin_merasakan_sejuknya_bandung(yes),
    kuliah_di_bandung_coret_gapapa(no).

kampus(telkom):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(no),
    ingin_merasakan_sejuknya_bandung(yes),
    kuliah_di_bandung_coret_gapapa(yes),
    mau_jalannya_macet(yes).

kampus(unpad):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(no),
    ingin_merasakan_sejuknya_bandung(yes),
    kuliah_di_bandung_coret_gapapa(yes),
    mau_jalannya_macet(no),
    mau_cari_pacar(yes).

kampus(ipdn):-
    mau_kuliah(yes),
    anak_sultan(no),
    anak_soleh(no),
    mau_punya_gedung_kampus_mewah(yes),
    wibu(no),
    ingin_merasakan_sejuknya_bandung(yes),
    kuliah_di_bandung_coret_gapapa(yes),
    mau_jalannya_macet(no),
    mau_cari_pacar(no).

/* Asking the user */
mau_kuliah(X):-
    menuask(mau_kuliah, X, [yes, no]).
anak_sultan(X):-
    menuask(anak_sultan, X, [yes, no]).
anak_soleh(X):-
    menuask(anak_soleh, X, [yes, no]).
mau_punya_gedung_kampus_mewah(X):-
    menuask(mau_punya_gedung_kampus_mewah, X, [yes, no]).
wibu(X):-
    menuask(wibu, X, [yes, no]).
ingin_merasakan_sejuknya_bandung(X):-
    menuask(ingin_merasakan_sejuknya_bandung, X, [yes, no]).
kuliah_di_bandung_coret_gapapa(X):-
    menuask(kuliah_di_bandung_coret_gapapa, X, [yes, no]).
mau_jalannya_macet(X):-
    menuask(mau_jalannya_macet, X, [yes, no]).
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
    write('Apakah_kamu_'), write(A), write('?'), nl,
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
    write('Rekomendasi buat kamu adalah : '), write(X), nl.
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