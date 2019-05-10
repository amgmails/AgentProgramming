total_moves(0).

+!incinerate[source(Sender)]<- 
.print("got request from", Sender, "to incinerate. Incinerating...");
.incinerate;
.print("garbage incinerated").

+!tally_moves(M)[source(Sender)] : total_moves(TM) <-
	-total_moves(TM);
	+total_moves(TM+M);
	.print("total moves:",TM+M, "after receiving",M, "from",Sender).
