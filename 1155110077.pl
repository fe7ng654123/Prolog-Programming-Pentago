
%List out all the win cases
win([1,7,13,19,25]).
win([1,2,3,4,5]).
win([1,8,15,22,29]).
win([2,8,14,20,26]).
win([2,3,4,5,6]).
win([2,9,16,23,30]).
win([3,9,15,21,27]).
win([4,10,16,22,28]).
win([5,10,15,20,25]).
win([5,11,17,23,29]).
win([6,11,16,21,26]).
win([6,12,18,24,30]).
win([7,8,9,10,11]).
win([7,13,19,25,31]).
win([7,14,21,28,35]).
win([8,9,10,11,12]).
win([8,14,20,26,32]).
win([8,15,22,29,36]).
win([9,15,21,27,33]).
win([10,16,22,28,34]).
win([11,16,21,26,31]).
win([11,17,23,29,35]).
win([12,17,22,27,32]).
win([12,18,24,30,36]).
win([13,14,15,16,17]).
win([14,15,16,17,18]).
win([19,20,21,22,23]).
win([20,21,22,23,24]).
win([25,26,27,28,29]).
win([26,27,28,29,30]).
win([31,32,33,34,35]).
win([32,33,34,35,36]).



member(X,[X|_]). 
member(X,[_|T]) :- member(X,T).
% incr(X, X1) :-X1 is X+1.

%Board(BlackL, RedL)

threatening(Board,black,TotolCount) :-
	Board = board(BlackL, RedL),
	aggregate_all(count,countThreat(RedL,BlackL),TotolCount),!.
	
threatening(Board,red,TotolCount) :-
	Board = board(BlackL, RedL),
	aggregate_all(count,countThreat(BlackL,RedL),TotolCount),!.
	
countThreat(BoardOfPlayer,BoardOfOpponent) :-
	win(Cases),
	countMatchCases(BoardOfPlayer,Cases,Count),
	Count is 4,
	union(BoardOfPlayer,BoardOfOpponent,UnionBoard),
	countMatchCases(UnionBoard,Cases,Flag),
	not(Flag == 5).


countMatchCases([], [_|_], 0).
countMatchCases([H|T], L, S) :-
	member(H,L),
    countMatchCases(T,L, S1),
    S is S1 + 1,!.
countMatchCases([H|T],L,S) :-
    countMatchCases(T,L,S).
	
	
	
	
%Define rotate movemonets choice
rotationChoice(clockwise).
rotationChoice(anti-clockwise).
quadrantChoice(top-right).
quadrantChoice(top-left).
quadrantChoice(bottom-right).
quadrantChoice(bottom-left).


availablePositons(BlackL,RedL,Pos):-
union(BlackL,RedL,U),
numlist(1, 36, L),
subtract(L,U,K),
member(Pos,K).
	
%black place and win
pentago_ai(Board,black,BestMove,NextBoard) :-Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],BlackL,NewBlackL),
sort(NewBlackL,SortedBlack),
win(Cases),
countMatchCases(SortedBlack,Cases,Count),
Count is 5,
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(SortedBlack,RedL),!.

% Red place and win
pentago_ai(Board,red,BestMove,NextBoard) :- Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],RedL,NewRedL),
sort(NewRedL,SortedRed),
win(Cases),
countMatchCases(SortedRed,Cases,Count),
Count is 5,
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(BlackL,SortedRed),!.


%black place and rotate to win
pentago_ai(Board,black,BestMove,NextBoard) :-Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],BlackL,NewBlackL),
rotate(Direction,Quadrant,NewBlackL,RotatedBlack),
rotate(Direction,Quadrant,RedL,RotatedRed),
win(Cases),
countMatchCases(RotatedBlack,Cases,Count),
Count is 5,
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(RotatedBlack,RotatedRed),!.

%Red place and rotate to win
pentago_ai(Board,red,BestMove,NextBoard) :- Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],RedL,NewRedL),
% sort(TmpRedL,NewRedL),
rotate(Direction,Quadrant,BlackL,RotatedBlack),
rotate(Direction,Quadrant,NewRedL,RotatedRed),
win(Cases),
countMatchCases(RotatedRed,Cases,Count),
Count is 5,
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(RotatedBlack,RotatedRed),!.

% black place bestmove
pentago_ai(Board,black,BestMove,NextBoard) :-
Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],BlackL,NewBlackL),
rotate(Direction,Quadrant,BlackL,RotatedBlack),
rotate(Direction,Quadrant,NewRedL,RotatedRed),
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(RotatedBlack,RotatedRed),
% pentago_ai(NextBoard,red,BestMove2,NextBoard2),
% NextBoard2 = board(BlackL2,RedL2),
% win(Cases),
% countMatchCases(RedL2,Cases,CountRed),
% countMatchCases(BlackL2,Cases,CountBlack),
% goodStep(CountRed,CountBlack),
!.

% red place bestmove
pentago_ai(Board,red,BestMove,NextBoard) :-
Board = board(BlackL, RedL),
availablePositons(BlackL,RedL,Pos),
append([Pos],RedL,NewRedL),
rotate(Direction,Quadrant,BlackL,RotatedBlack),
rotate(Direction,Quadrant,NewRedL,RotatedRed),
rotationChoice(Direction),
quadrantChoice(Quadrant),
BestMove = move(Pos,Direction,Quadrant),
NextBoard =board(RotatedBlack,RotatedRed),
% pentago_ai(NextBoard,red,BestMove2,NextBoard2),
% NextBoard2 = board(BlackL2,RedL2),
% win(Cases),
% countMatchCases(RedL2,Cases,CountRed),
% countMatchCases(BlackL2,Cases,CountBlack),
% goodStep(CountBlack,CountRed),
!.

goodStep(A,B):-
not(A == 5),!.
goodStep(A,B):-
A==5, B == 5.

% rotation 
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- dif(H,O), replace(O, R, T, T2).

rotateA(clockwise, top-left, List, NewList):- 
    replace(1,a3,List, List2),
    replace(2,a9,List2, List3),
    replace(3,a15,List3, List4),
    replace(7,a2,List4, List5),
    replace(9,a14,List5, List6),
    replace(13,a1,List6, List7),
    replace(14,a7,List7, List8),
    replace(15,a13,List8, NewList).

rotateA(clockwise, top-right, List, NewList):- 
    replace(18,a16,List, List2),
    replace(17,a10,List2, List3),
    replace(16,a4,List3, List4),
    replace(12,a17,List4, List5),
    replace(10,a5,List5, List6),
    replace(6,a18,List6, List7),
    replace(5,a12,List7, List8),
    replace(4,a6,List8, NewList).

rotateA(clockwise, bottom-left, List, NewList):- 
    replace(33,a31,List, List2),
    replace(32,a25,List2, List3),
    replace(31,a19,List3, List4),
    replace(27,a32,List4, List5),
    replace(25,a20,List5, List6),
    replace(21,a33,List6, List7),
    replace(20,a27,List7, List8),
    replace(19,a21,List8, NewList).

rotateA(clockwise, bottom-right, List, NewList):- 
    replace(36,a34,List, List2),
    replace(35,a28,List2, List3),
    replace(34,a22,List3, List4),
    replace(30,a35,List4, List5),
    replace(28,a23,List5, List6),
    replace(24,a36,List6, List7),
    replace(23,a30,List7, List8),
    replace(22,a24,List8, NewList),
	!.

rotate(clockwise, Q, List, SortedNewList):- 
    rotateA(clockwise, Q, List, AList), replaceA(AList, NewList), sort(NewList, SortedNewList).

rotate(anti-clockwise, Q, List, SortedNewList):- 
    rotateA(clockwise, Q, List, AList), replaceA(AList, List1),
    rotateA(clockwise, Q, List1, AList1), replaceA(AList1, List2),
    rotateA(clockwise, Q, List2, AList2), replaceA(AList2, NewList),
    sort(NewList, SortedNewList).

replaceA([], []).
replaceA([O|T], [RA|T2]) :- atom_concat(a, R, O),  atom_number(R, RA), replaceA( T, T2), !.
replaceA([H|T], [H|T2]) :- replaceA(T, T2).



