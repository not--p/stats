#!/bin/bash

CC=gcc -ansi -Wall

all :
	make test_libcentral
	make test_libvariance
	make libcentral.o
	make libvariance.o
	make central
	make variance

central : central.o
	$(CC) -o bin/central build/helpers.o build/libcentral.o build/central.o -lm

variance : helpers.o central.o variance.o
	$(CC) -o bin/variance build/helpers.o build/libcentral.o build/libvariance.o build/variance.o -lm

test_libcentral : helpers.o
	$(CC) -o bin/tests/test_libcentral build/helpers.o test/libcentral.c -lm

test_libvariance : libcentral.o helpers.o
	$(CC) -o bin/tests/test_libvariance build/helpers.o build/libcentral.o test/libvariance.c -lm

central.o :
	$(CC) -c src/central.c
	mv central.o build/

variance.o :
	$(CC) -c src/variance.c 
	mv variance.o build/

helpers.o : src/helpers.h
	$(CC) -c src/helpers.c
	mv helpers.o build/

libcentral.o : src/libcentral.h src/libcentral.c
	$(CC) -c src/libcentral.c
	mv libcentral.o build/

libvariance.o : src/libvariance.h src/libvariance.c
	$(CC) -c src/libvariance.c
	mv libvariance.o build/

clean :
	rm bin/central
	rm bin/variance
	rm bin/tests/test_lib*
	rm build/*.o
