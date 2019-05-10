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
	//.wait(200);
	+at(OX,OY);
	.print("at", OX, OY);
	+visited(OX,OY);
	//.wait(200);
	!count_moves;
	!locate_garbage;
	//.wait(200);
	if (not garbage(OX-1,OY-1)) {+visited(OX-1,OY-1);
	//.print("telling others that I visited",OX-1,OY-1); 
	.broadcast(tell, visited(OX-1,OY-1));
	//.drop_intention(move(OX-1,OX-1));
	}
	if (not garbage(OX-1,OY)) {+visited(OX-1,OY);
	//.print("telling others that I visited",OX-1,OY);
	.broadcast(tell, visited(OX-1,OY));
	//.drop_intention(move(OX-1,OY));
	}
	if (not garbage(OX-1,OY+1)) {+visited(OX-1,OY+1);
	//.print("telling others that I visited",OX-1,OY+1);
	.broadcast(tell, visited(OX-1,OY+1));
	//.drop_intention(move(OX-1,OY+1));
	}
	if (not garbage(OX+1,OY-1)) {+visited(OX+1,OY-1);
	//.print("telling others that I visited",OX+1,OY-1);
	.broadcast(tell, visited(OX+1,OY-1));
	//.drop_intention(move(OX+1,OY-1));
	}
	if (not garbage(OX+1,OY)) {+visited(OX+1,OY);
	//.print("telling others that I visited",OX+1,OY);
	.broadcast(tell, visited(OX+1,OY));
	//.drop_intention(move(OX+1,OY));
	}
	if (not garbage(OX+1,OY+1)) {+visited(OX+1,OY+1);
	//.print("telling others that I visited",OX+1,OY+1);
	.broadcast(tell, visited(OX+1,OY+1));
	//.drop_intention(move(OX+1,OY+1));
	}
	if (not garbage(OX,OY-1)) {+visited(OX,OY-1);
	//.print("telling others that I visited",OX,OY-1);
	.broadcast(tell, visited(OX,OY-1));
	//.drop_intention(move(OX,OY-1));
	}
	if (not garbage(OX,OY+1)) {+visited(OX,OY+1);
	//.print("telling others that I visited",OX,OY+1);
	.broadcast(tell, visited(OX,OY+1));
	//.drop_intention(move(OX,OY+1));
	}.

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
	.print("telling everyone garbage is no longer at",X,Y);
	.broadcast(untell, garbage(X,Y));
	.print("1 garbage grabbed at", X,Y);
	!increase_holding.

+at(X,Y) : garbage(X,Y) & holding(H) & H <2 <-
	!pickup_garbage(X,Y).

+holding(2) <-
	.print("going to (0,0) to drop garbage(s)");
	!move(0,0);
	!drop_garbage;
	!drop_garbage.

+garbage(X,Y) : garbage(OX,OY) & OX > X & holding(H) & H <2 & at(XX,YY) & XX >X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX < X & holding(H) & H <2 & at(XX,YY) & XX >X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY > Y & holding(H) & H <2 & at(XX,YY) & XX >X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY < Y & holding(H) & H <2 & at(XX,YY) & XX >X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX > X & holding(H) & H <2 & at(XX,YY) & YY >Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX < X & holding(H) & H <2 & at(XX,YY) & YY >Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY > Y & holding(H) & H <2 & at(XX,YY) & YY >Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY < Y & holding(H) & H <2 & at(XX,YY) & YY >Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX > X & holding(H) & H <2 & at(XX,YY) & XX <X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX < X & holding(H) & H <2 & at(XX,YY) & XX <X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY > Y & holding(H) & H <2 & at(XX,YY) & XX <X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY < Y & holding(H) & H <2 & at(XX,YY) & XX <X <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX > X & holding(H) & H <2 & at(XX,YY) & YY <Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OX < X & holding(H) & H <2 & at(XX,YY) & YY <Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY > Y & holding(H) & H <2 & at(XX,YY) & YY <Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).

+garbage(X,Y) : garbage(OX,OY) & OY < Y & holding(H) & H <2 & at(XX,YY) & YY <Y <-
	//.print("garbage detected at",X,Y,". Moving to collect it");
	!move(X,Y).
 
+visited[source(Sender)] <-
	+visited(X,Y);
	.print("added visisted(",X,Y,") information from", Sender).
	
+garbage(X,Y)[source(Sender)] <-
	+garbage(X,Y);
	.print("added garbage(",X,Y,") belief from", Sender).

-garbage(X,Y)[source(Sender)] <-
	-garbage(X,Y).
	//.print("remove garbage(",X,Y,") belief from", Sender).
