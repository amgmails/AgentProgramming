{include("move.asl")}
num_moves(0).
!move_to(10,10).

+!move_to(X,Y) <-
?at(OX,OY);
.print("at",OX,OY);
!move(X,Y).
