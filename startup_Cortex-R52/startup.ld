
MEMORY
{
    TCM_A (RWX) :         ORIGIN = 0x00000000, LENGTH = 0x10000
    TCM_B (RWX) :         ORIGIN = 0x00020000, LENGTH = 0x10000
    /* TODO: TCM C (not in device tree) */
    /* TODO: DDR */
}

/* For now we put everything in TCM A */
SECTIONS
{
    .text : { 
         __text_start__ = .;
         *(.text*) 
         *(.init*) 
         *(.fini) 
         *(.rodata*) /* Could define a separate MPU region for RO data */
         . = ALIGN(64);
         __text_end__ = .;
    } > TCM_A
    .data BLOCK(64) : {
        __data_start__ = .;
        *(.data*)
    } > TCM_A
    .bss BLOCK(64) : {
        *(.bss)
         . = ALIGN(64);
        __data_end__ = .;
    } > TCM_A
    end = .;
    __stack_start__ = __data_end__;
    __stack_end__ = LENGTH(TCM_A) - 4;

   __tcm_a_start__ = ORIGIN(TCM_A);
   __tcm_a_end__ = ORIGIN(TCM_A) + LENGTH(TCM_A);
   __tcm_b_start__ = ORIGIN(TCM_B);
   __tcm_b_end__ = ORIGIN(TCM_B) + LENGTH(TCM_B);
}
