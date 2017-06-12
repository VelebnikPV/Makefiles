CC=gcc
CFLAGS=-c -Wall
INCLUDE=-Iinclude
INCLUDE_M1=-Isrc/m1/include
INCLUDE_M2=-Isrc/m2/include
ODIR=output

all: hello

hello: main.o module.o m1.o m2.o
	$(CC) $(ODIR)/main.o $(ODIR)/module.o $(ODIR)/m1.o $(ODIR)/m2.o -o $(ODIR)/hello

main.o: src/main.c
	$(CC) $(INCLUDE) $(INCLUDE_M1) $(INCLUDE_M2) $(CFLAGS) src/main.c -o output/main.o
	$(CC) $(INCLUDE) $(INCLUDE_M1) $(INCLUDE_M2) -S src/main.c -o output/main.s

module.o: src/module.c 
	$(CC) $(INCLUDE) $(CFLAGS) src/module.c -o output/module.o

m1.o: src/m1/m1.c
	$(CC) $(INCLUDE_M1) $(CFLAGS) src/m1/m1.c -o output/m1.o

m2.o: src/m1/m1.c
	$(CC) $(INCLUDE_M2) $(CFLAGS) src/m2/m2.c -o output/m2.o



install: hello
	install -D output/hello /home/$(USER)/bin

install-strip: hello
	install -D -s output/hello /home/$(USER)/bin

uninstall:
	-rm /home/$(USER)/bin

.PHONY : clean
clean :
	rm *.o
