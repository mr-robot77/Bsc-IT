HomeWork4.out:hello.out
hello.out: main.o factorial.o hello.o
	g++ -o hello.out  main.o factorial.o hello.o
main.o:main.cpp
	g++ -c main.cpp 
factorial.o:factorial.cpp
	 g++ -c factorial.cpp
hello.o:hello.cpp
	g++ -c hello.cpp
install:HomeWork4.out
	install -T *.out HomeWork4.out
clean:
	rm -rf *.o hello.out HomeWork4.out



