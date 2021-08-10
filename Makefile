decode : fix.o bypass.o decode.o libcypher.so Makefile
	gcc -m32 fix.o bypass.o decode.o -L. -Wl,-rpath='$$ORIGIN' -lcypher -o decode

bypass.o : bypass.c
	gcc -m32 -c $< -o $@

fix.o: fix.S
	as -32 $< -o $@

.PHONY : clean dist

clean :
	rm -f decode bypass.o fix.o

dist :
	tar zcvf decode.tar.gz Makefile fix.S bypass.c decode.o libcypher.so

run1: decode
	./decode -d -k ABC crypt1.dat decryp1.dat

run2: decode
	./decode -d -k ABC crypt2.dat decryp2.dat