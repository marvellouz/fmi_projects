SHELL = /bin/bash
VPATH = .
CXXC = g++ -Wall
CC = g++ -c
TARGETS = main_test
TESTS = *.h
all: $(TARGETS)
clean:
	rm -f *~ *.o *.obj $(TARGETS)
distclean: clean
	rm -f Makefile
run: clean all
	./main_test
%: %.h
