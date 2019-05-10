+!move(X,Y): at(X,Y) <-
true.
//.print("arrived at",X,Y).

+!move(X,Y): at(OX,OY) & OX>X <-
-at(OX,OY);
.west;
.print("moved west");
!locate_agent(X,Y);
!move(X,Y).

+!move(X,Y): at(OX,OY) & OX<X <-
-at(OX,OY);
.east;
.print("moved east");
!locate_agent(X,Y);
!move(X,Y).

+!move(X,Y): at(OX,OY)& OY>Y <-
-at(OX,OY);
.south;
.print("moved south");
!locate_agent(X,Y);
!move(X,Y).

+!move(X,Y): at(OX,OY) & OY<Y <-
-at(OX,OY);
.north;
.print("moved north");
!locate_agent(X,Y);
!move(X,Y).

+!locate_agent(X,Y) <-
.sense_location(OX,OY);
+at(OX,OY);
.print("at", OX, OY);
+visited(OX,OY);
!count_moves;
!locate_garbage.

+!locate_garbage <-
.check_for_garbage.

+!count_moves : num_moves(N) <-
NewCount = N + 1;
-num_moves(N);
+num_moves(NewCount);
.print("moves count:",NewCount).
