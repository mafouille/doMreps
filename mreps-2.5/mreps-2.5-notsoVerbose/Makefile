# Makefile


#CC	=	gcc  -Wall -g -lm  
#CC	=	gcc  -g -lm  
CC	=	gcc  -O3
#LDFLAGS = 	 -L/usr/openwin/lib""	
#LDFLAGS =       -L/usr/X11R6/lib  
#LIBS	=       -lm -lX11

##########

all: mreps

##########


mreps:	defs.h mreps_acgt.o mainrepets.o kmp.o main_acgt.o ./roman/FndReps.o ./roman/factorizeforGDR.o ./roman/mainsearchforGDR.o ./roman/searchforHeadGDR.o ./roman/finalstageforGDR.o printOutput_acgt.o
	$(CC) -o mreps mreps_acgt.o mainrepets.o kmp.o main_acgt.o  ./roman/FndReps.o ./roman/factorizeforGDR.o ./roman/mainsearchforGDR.o ./roman/searchforHeadGDR.o ./roman/finalstageforGDR.o printOutput_acgt.o -lm


########## 

main_acgt.o:	defs.h main.c
	$(CC) -c -o $@ main.c

mreps_acgt.o: defs.h mreps.c
	$(CC) -c -o $@ mreps.c

kmp.o: defs.h  kmp.c
	$(CC) -c -o $@ kmp.c

printOutput_acgt.o: defs.h printOutput.c
	$(CC) -c -o $@ printOutput.c

./roman/FndReps.o: defs.h ./roman/FndReps.c 
	$(CC) -c -o $@ ./roman/FndReps.c

./roman/factorizeforGDR.o: defs.h  ./roman/factorizeforGDR.c
	$(CC) -c -o $@ ./roman/factorizeforGDR.c

./roman/mainsearchforGDR.o: defs.h ./roman/mainsearchforGDR.c
	$(CC) -c -o $@ ./roman/mainsearchforGDR.c

./roman/searchforHeadGDR.o: defs.h ./roman/searchforHeadGDR.c
	$(CC) -c -o $@ ./roman/searchforHeadGDR.c

./roman/finalstageforGDR.o: defs.h ./roman/finalstageforGDR.c
	$(CC) -c -o $@ ./roman/finalstageforGDR.c


mainrepets.o: defs.h mainrepets.c
	$(CC) -c -o $@ mainrepets.c

##########
