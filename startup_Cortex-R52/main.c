/*
** Copyright (c) 2016-2017 Arm Limited (or its affiliates). All rights reserved.
** Use, modification and redistribution of this file is subject to your possession of a
** valid End User License Agreement for the Arm Product of which these examples are part of 
** and your compliance with all applicable terms and conditions of such licence agreement.
*/

/* This file contains the main() program that displays a welcome message, enables the caches,
   performs a float calculation to demonstrate floating point, then runs the main application (sorts) */

#include "printf.h"
#include "uart.h"
#include "float.h"
#include "mailbox.h"

#define TEST_FLOAT
// #define TEST_SORT
#define TEST_MAILBOX
// #define TEST_SOFT_RESET

extern unsigned char _text_start;
extern unsigned char _text_end;
extern unsigned char _data_start;
extern unsigned char _data_end;
extern unsigned char _bss_start;
extern unsigned char _bss_end;

extern void enable_caches(void);
extern void compare_sorts(void);

void enable_interrupts (void)
{
	unsigned long temp;
	__asm__ __volatile__("mrs %0, cpsr\n"
			     "bic %0, %0, #0x80\n"
			     "msr cpsr_c, %0"
			     : "=r" (temp)
			     :
			     : "memory");
}

void soft_reset (void) 
{
	unsigned long temp;
	__asm__ __volatile__("mov r1, #2\n"
			     "mcr p15, 4, r1, c12, c0, 2\n"); 
}

int main(void)
{
//    asm(".global __use_hlt_semihosting");
    cdns_uart_startup(); 	// init UART
    printf("R52 is alive\r\n");


    /* Display a welcome message via semihosting */
    printf("Cortex-R52 bare-metal startup example\r\n");

    /* Enable the caches */
    enable_caches();

    /* Enable GIC */
/*    printf("start of arm_gic_setup()\n");
    arm_gic_setup();
    printf("end of arm_gic_setup()\n");
*/
    enable_interrupts();


#ifdef TEST_FLOAT
    float_test();
#endif // TEST_FLOAT

#ifdef TEST_SORT
    /* Run the main application (sorts) */
    compare_sorts();
#endif // TEST_SORT

#ifdef TEST_MAILBOX
    /* Enables mailbox */
    mbox_init(RTPS_TRCH_MBOX0_BASE);
    mbox_send(RTPS_TRCH_MBOX1_BASE, 0xA5);
#endif // TEST_MAILBOX

    printf("Done.\r\n");

#ifdef TEST_SOFT_RESET
    printf("Resetting...\r\n");
    /* this will generate "Undefined Instruction exception because HRMR is accessible only at EL2 */
    soft_reset();
    printf("ERROR: reached unrechable code: soft reset failed\r\n");
#endif // TEST_SOFT_RESET

    printf("Waiting for interrupt...\r\n");
    while (1) {
        asm("wfi");
    }
    
    return 0;
}

void irq_handler() {
    printf("irq\r\n");
}

// These are in main, not in mailbox.c, because different users of mailbox.c
// (sender vs. receiver) receive from different indexes. This way mailbox.c
// can be shared between sender and receiver.
void mbox_trch_have_data_isr()
{
     uint8_t msg = mbox_have_data_isr(RTPS_TRCH_MBOX0_BASE);
}
void mbox_hpps_have_data_isr()
{
     uint8_t msg = mbox_have_data_isr(HPPS_RTPS_MBOX0_BASE);
}
