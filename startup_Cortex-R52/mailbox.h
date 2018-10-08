#ifndef MAILBOX_H
#define MAILBOX_H

#include <stdint.h>

#define RTPS_TRCH_MBOX_BASE	((volatile uint32_t *)0x3000a000)
#define HPPS_RTPS_MBOX_BASE 	((volatile uint32_t *)0xfff60000)
#define HPPS_TRCH_MBOX_BASE 	((volatile uint32_t *)0xfff50000)

#define RTPS_TRCH_MAILBOX_IRQ_0		161
#define RTPS_TRCH_MAILBOX_IRQ_1		162
#define HPPS_TRCH_MAILBOX_IRQ_0		163
#define HPPS_TRCH_MAILBOX_IRQ_1		164
#define HPPS_RTPS_MAILBOX_IRQ_0		165
#define HPPS_RTPS_MAILBOX_IRQ_1		166


#define RTPS_TRCH_MBOX0_BASE	((volatile uint32_t *)((uint8_t *)RTPS_TRCH_MBOX_BASE + MBOX_MAIL0))
#define RTPS_TRCH_MBOX1_BASE	((volatile uint32_t *)((uint8_t *)RTPS_TRCH_MBOX_BASE + MBOX_MAIL1))

#define HPPS_TRCH_MBOX0_BASE 	((volatile uint32_t *)((uint8_t *)HPPS_TRCH_MBOX_BASE + MBOX_MAIL0))
#define HPPS_TRCH_MBOX1_BASE 	((volatile uint32_t *)((uint8_t *)HPPS_TRCH_MBOX_BASE + MBOX_MAIL1))

#define HPPS_RTPS_MBOX0_BASE 	((volatile uint32_t *)((uint8_t *)HPPS_RTPS_MBOX_BASE + MBOX_MAIL0))
#define HPPS_RTPS_MBOX1_BASE 	((volatile uint32_t *)((uint8_t *)HPPS_RTPS_MBOX_BASE + MBOX_MAIL1))


#define MBOX_MAIL0 0x80
#define MBOX_MAIL1 0xA0

#define MBOX_REG_MAIL     0x00
#define MBOX_REG_CNF      0x1C

#define MBOX_BIT_IHAVEDATAIRQEN 0x1

void mbox_init(volatile uint32_t *base);
void mbox_send(volatile uint32_t *base, uint8_t msg);
uint8_t mbox_receive(volatile uint32_t *base);
uint8_t mbox_have_data_isr(volatile uint32_t *base);

#endif // MAILBOX_H
