
ARMGNU = arm-none-eabi
#ARMGNU = aarch64-linux-gnu
#ARMGNU = aarch64-poky-linux

AOPS = --warn --fatal-warnings -mcpu=cortex-r52
AOPSR5 = --warn --fatal-warnings -mcpu=cortex-r5
COPS = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding  -mcpu=cortex-r52
COPSR5 = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding  -mcpu=cortex-r5


all : r52uart.bin  r52fsb.bin r5fsb.bin r5uart.bin
#r52fsb.bin r52resetA53.elf

clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list

vectors.o : vectors.s
	$(ARMGNU)-as $(AOPS) vectors.s -o vectors.o

r52uart.o : r52uart.c
	$(ARMGNU)-gcc $(COPS) -c r52uart.c -o r52uart.o
#	$(ARMGNU)-gcc $(COPS) -mthumb -c r52uart.c -o r52uart.o

r52uart.bin : uart-memmap vectors.o r52uart.o
	$(ARMGNU)-ld -o r52uart.elf -T uart-memmap r52uart.o
	$(ARMGNU)-objdump -D r52uart.elf > r52uart.list
	$(ARMGNU)-objcopy r52uart.elf r52uart.bin -O binary
#	$(ARMGNU)-ld -o r52uart.elf -T uart-memmap vectors.o r52uart.o

r5uart.o : r52uart.c
	$(ARMGNU)-gcc $(COPSR5) -c r52uart.c -o r5uart.o

r5uart.bin : uart-memmap vectors.o r5uart.o
	$(ARMGNU)-ld -o r5uart.elf -T uart-memmap r5uart.o
	$(ARMGNU)-objdump -D r5uart.elf > r5uart.list
	$(ARMGNU)-objcopy r5uart.elf r5uart.bin -O binary


r5fsb.o: r52fsb.S
	$(ARMGNU)-as $(AOPSR5) r52fsb.S -o r5fsb.o

r5fsb.bin : uart-memmap r5fsb.o 
	$(ARMGNU)-ld -o r5fsb.elf -T uart-memmap r5fsb.o 
	$(ARMGNU)-objdump -D r5fsb.elf > r5fsb.list
	$(ARMGNU)-objcopy r5fsb.elf r5fsb.bin -O binary

r52fsb.o : r52fsb.S
	$(ARMGNU)-as $(AOPS) r52fsb.S -o r52fsb.o

r52fsb.bin : uart-memmap r52fsb.o 
	$(ARMGNU)-ld -o r52fsb.elf -T uart-memmap r52fsb.o 
	$(ARMGNU)-objdump -D r52fsb.elf > r52fsb.list
	$(ARMGNU)-objcopy r52fsb.elf r52fsb.bin -O binary

r52resetA53.o : r52resetA53.c
	$(ARMGNU)-gcc $(COPS) -c r52resetA53.c -o r52resetA53.o
#	$(ARMGNU)-gcc $(COPS) -mthumb -c r52resetA53.c -o r52resetA53.o

r52resetA53.elf: resetA53-memmap vectors.o r52resetA53.o
	$(ARMGNU)-ld -o r52resetA53.elf -T resetA53-memmap vectors.o r52resetA53.o
	$(ARMGNU)-objdump -D r52resetA53.elf > r52resetA53.list
	$(ARMGNU)-objcopy r52resetA53.elf r52resetA53.bin -O binary

r52fsb.bin: r52fsb.out
	$(ARMGNU)-objcopy r52fsb.out r52fsb.bin -O binary

r52fsb.out: r52fsb.S
	$(ARMGNU)-as r52fsb.S -o r52fsb.out -mcpu=cortex-r52
