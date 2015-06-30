CC=gcc
#OPT=-Ofast
CFLAGS=-std=gnu99 -Wno-unused-result -lm -g
WARNING=-Wall
TARGET= Intmm
OBJS=intmm.o
all: $(TARGET)

%.o: %.c 
	$(CC) -c $(CFLAGS) $(OPT) $^ -o $@

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

run: 
	perf stat ./Intmm
diff:
	./Intmm > intmm.txt && diff intmm.txt result.txt && rm -f intmm.txt
clean:  
	rm -f *.o Intmm intmm.txt
