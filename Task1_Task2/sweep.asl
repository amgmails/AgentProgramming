{include("move.asl")}
num_moves(0).

!sweep.

+!sweep <-
?at(X,Y);
.print("at",X,Y);
for (.range(11,I)) {
    for (.range(11,J)) {
        if ( not visited(I,J) ) {
	    if (I mod 2 == 0){
	        !move(I, J);
	    }
	    if (I mod 2 == 1){
	        !move(I, 10 - J);
	    }
        }
    }
}.
