{include("move_v2.asl")}

!sweep.

+!sweep <-
	?at(X,Y);
	.print("at",X,Y);
	?bornes(B,T,S);
	for (.range(B,I)) {
	    for (.range(B,J)) {
		if (I >=T & I <S){
		    if ( not visited(I,J) ) {
		        if (I mod 2 == 0){
			    !move(I, J);
		        }
		        if (I mod 2 == 1){
			    !move(I, 10 - J);
		        }
		    }
		}
	    }
	}
	//.wait(200);
	?holding(H);
	if (H >0) {
	!move(0,0);
	!drop_garbage;
	}
	?num_moves(N);
	.send(incinerator, achieve, tally_moves(N)).
