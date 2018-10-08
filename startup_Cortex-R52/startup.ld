
MEMORY
{
    TCM_A (RWX) :         ORIGIN = 0x60000000, LENGTH = 0x1000000
    TCM_B (RWX) :         ORIGIN = 0x61000000, LENGTH = 0x1000000
    /* TODO: TCM C (not in device tree) */
    /* TODO: DDR */
}

/* For now we put everything in TCM A */
SECTIONS
{
    .text : { 
         __text_start__ = 0x60000000;
         *(.text*) 
         *(.init*) 
         *(.fini) 
         *(.rodata*) /* Could define a separate MPU region for RO data */
         . = ALIGN(64);
         __text_end__ = 0x60100000;
    } > TCM_A
    .data BLOCK(64) : {
        __data_start__ = 0x60100000;
        *(.data*)
    } > TCM_A
    .bss BLOCK(64) : {
        *(.bss)
         . = ALIGN(64);
        __data_end__ = 0x60200000;
    } > TCM_A
    end = 0x60200000;
    __stack_start__ = __data_end__;
    /* __stack_end__ = __sys_stack_end__ - 0x2000; */ /* 0x200 * 5 (ABT,IRQ,FIQ,UNDEF,SVC) = 0xA00, and per-CPU offset 0x1000 * cpuidx */
    __stack_end__ = ORIGIN(TCM_A) + LENGTH(TCM_A) - 4;

   __tcm_a_start__ = ORIGIN(TCM_A);
   __tcm_a_end__ = ORIGIN(TCM_A) + LENGTH(TCM_A);
   __tcm_b_start__ = ORIGIN(TCM_B);
   __tcm_b_end__ = ORIGIN(TCM_B) + LENGTH(TCM_B);
}
