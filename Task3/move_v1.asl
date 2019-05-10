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
	!locate_garbage;
	.wait(50);
	if (not garbage(OX-1,OY-1)) {+visited(OX-1,OY-1);}
	if (not garbage(OX-1,OY)) {+visited(OX-1,OY);}
	if (not garbage(OX-1,OY+1)) {+visited(OX-1,OY+1);}
	if (not garbage(OX+1,OY-1)) {+visited(OX+1,OY-1);}
	if (not garbage(OX+1,OY)) {+visited(OX+1,OY);}
	if (not garbage(OX+1,OY+1)) {+visited(OX+1,OY+1);}
	if (not garbage(OX,OY-1)) {+visited(OX,OY-1);}
	if (not garbage(OX,OY+1)) {+visited(OX,OY+1);}.

+!locate_garbage <-
	.check_for_garbage.

+!count_moves : num_moves(N) <-
	NewCount = N + 1;
	-num_moves(N);
	+num_moves(NewCount);
	.print("moves count:",NewCount).

+!increase_holding <-
	?holding(H);
	NewCount = H + 1;
	-holding(H);
	.print("holding", NewCount, "garbage(s)");
	+holding(NewCount).

+!decrease_holding <-
	?holding(H);
	NewCount = H - 1;
	-holding(H);
	.print("holding", NewCount, "garbage(s)");
	+holding(NewCount).

+!drop_garbage <-
	.drop;
	.print("dropped 1 garbage");
	!decrease_holding;
	.send(incinerator, achieve, incinerate);
	.print("told incinerator to incinerate").

+!pickup_garbage(X,Y) <-
	.pickup;
	-garbage(X,Y);
	.print("1 garbage grabbed at", X,Y);
	!increase_holding.

+at(X,Y) : garbage(X,Y) & holding(H) & H <2 <-
	!pickup_garbage(X,Y).

+holding(2) <-
	.print("going to (0,0) to drop garbage(s)");
	!move(0,0);
	!drop_garbage;
	!drop_garbage.
