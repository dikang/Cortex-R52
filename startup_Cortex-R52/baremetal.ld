
MEMORY
{
    TCM_A (RWX) :         ORIGIN = 0x40000000, LENGTH = 0x02000000
    TCM_B (RWX) :         ORIGIN = 0x42000000, LENGTH = 0x02000000
    /* TODO: TCM C (not in device tree) */
    /* TODO: DDR */
}

/* For now we put everything in TCM A */
SECTIONS
{
    .text : { 
         __text_start__ = 0x40000000;
         *(.text*) 
         *(.init*) 
         *(.fini) 
         *(.rodata*) /* Could define a separate MPU region for RO data */
         . = ALIGN(64);
         __text_end__ = .;
    } > TCM_A
    .data BLOCK(64) : {
        __data_start__ = 0x40010000;
        *(.data*)
    } > TCM_A
    .bss BLOCK(64) : {
        *(.bss)
         . = ALIGN(64);
        __data_end__ = .;
    } > TCM_A
    end = .;
    __stack_start__ = 0x41000000;
    /* __stack_end__ = __sys_stack_end__ - 0x2000; */ /* 0x200 * 5 (ABT,IRQ,FIQ,UNDEF,SVC) = 0xA00, and per-CPU offset 0x1000 * cpuidx */
    __stack_end__ = ORIGIN(TCM_A) + LENGTH(TCM_A) - 4;

   __tcm_a_start__ = ORIGIN(TCM_A);
   __tcm_a_end__ = ORIGIN(TCM_A) + LENGTH(TCM_A);
   __tcm_b_start__ = ORIGIN(TCM_B);
   __tcm_b_end__ = ORIGIN(TCM_B) + LENGTH(TCM_B);
}
