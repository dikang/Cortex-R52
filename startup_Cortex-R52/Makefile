#m Copyright (c) 2016 Arm Limited (or its affiliates). All rights reserved.
# Use, modification and redistribution of this file is subject to your possession of a
# valid End User License Agreement for the Arm Product of which these examples are part of 
# and your compliance with all applicable terms and conditions of such licence agreement.
#
# This makefile is intended to allow command-line users to build this project outside of Eclipse
# This makefile is NOT used by the Eclipse managed builder project (which creates its own makefiles)
#
# This makefile is intended for use with GNU make
# This example is intended to be built with Arm Compiler 6


TARGET=startup_Cortex-R52.axf

CC=arm-none-eabi-gcc
OBJDUMP=arm-none-eabi-objdump
AS=arm-none-eabi-as
LD=arm-none-eabi-ld
AR=aarm-none-eabi-ar
FE=fromelf

# Select build rules based on Windows or Unix
ifdef WINDIR
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then echo Build completed.; fi
RM=rm -f $(1)
endif
endif

ASM_OBJS = \
	startup.o \

C_OBJS = \
	main.o \
	sorts.o \
	uart.o \
	printf.o \
	mailbox.o \
	command.o \
	float.o


all: $(TARGET)
	$(call DONE,$(TARGET))

rebuild: clean all

clean:
	$(call RM,*.o,*.d)
	$(call RM,$(TARGET))


CORE=cortex-r52
# If hardware floating point is either not present or not required, add -mfpu=none to the compile step
CCOPT =-g -O0 -mthumb -mfloat-abi=hard -mfpu=vfpv3 -I. -nostdlib -nostartfiles -ffreestanding
#original below
#CCOPT =-g -O1 -mthumb -I./libmspprintf/src/include 
#CCOPT =-g -O1 -mthumb -I./libmspprintf/src/include -mfloat-abi=hard
AOPT = --warn -mthumb -mfloat-abi=hard -mfpu=vfpv3 --fatal-warnings -mcpu=$(CORE)
LDFLAG = -mfloat-abi=hard -mfpu=vfpv3
# original below
#AOPT = --warn --fatal-warnings -mcpu=$(CORE)

# Enable use of TCM in assembler code with -DTCM

#$(TARGET) : main.o sorts.o startup.o scatter.scat
$(TARGET) : startup.ld $(ASM_OBJS) $(C_OBJS)
	$(CC) -T $^ --entry=Start -o $(TARGET) -mcpu=$(CORE) $(LDFLAG) -lgcc -lc -lrdimon -Wl,--gc-sections -static
	$(OBJDUMP) $(TARGET) -D > all.dis.s
	$(OBJDUMP) startup.o  -D > startup.dis.s
#	$(CC) main.o sorts.o startup.o -T startup.ld --entry=Start -o $(TARGET) -mcpu=$(CORE) -lc -lrdimon -nostartfiles -Wl,--gc-sections
#	$(CC) main.o sorts.o startup.o -T startup.ld -o $(TARGET) -mcpu=$(CORE) -lc -lrdimon
#-L/home/dkang/WORK/R52/gcc-arm-none-eabi-7-2018-q2-update/lib/gcc/arm-none-eabi/7.3.1 -lgcc 
#-L/home/dkang/WORK/R52/gcc-arm-none-eabi-7-2018-q2-update/arm-none-eabi/lib -lg -lstdc++ -lc -lm
#	$(LD) main.o sorts.o startup.o --scatter=scatter.scat --entry=Start -o $(TARGET) --info=totals --info=unused

%.o : %.c
	$(CC) -MMD -c $(CCOPT) -mcpu=$(CORE) -o $@ $<

%.o : %.s
	$(CC) -c $(CCOPT) -mcpu=$(CORE) -x assembler-with-cpp -o $@ $<
#	$(AS) $(AOPT) -o $@ $^

-include $(C_OBJS:.o=.d)
