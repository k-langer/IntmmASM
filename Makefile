CC=gcc
OPT=-Ofast -mno-avx -ffp-contract=off -mno-sse
CFLAGS=-std=gnu99 -Wno-unused-result -lm -g
WARNING=-Wall
TARGET= Intmm
OBJS=intmm.o
all: $(TARGET)

%.o: %.c 
	$(CC) -c $(CFLAGS) $(OPT) $^ -o $@

asm: intmm.c
	$(CC) -g $(CFLAGS) $(OPT) $^ && objdump -S a.out > intmm.S && rm -f a.out  
#	$(CC) -S $(CFLAGS) $(OPT) $^

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

run: 
	perf stat ./Intmm
diff:
	./Intmm > intmm.txt && diff intmm.txt result.txt && rm -f intmm.txt
clean:  
	rm -f *.o intmm.s Intmm intmm.txt intmm.S
