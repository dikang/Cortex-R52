#ifndef MAILBOX_H
#define MAILBOX_H

#include <stdint.h>

#define HPPS_RTPS_MBOX_BASE 	((volatile uint32_t *)0xf9220000)
#define HPPS_TRCH_MBOX_BASE 	((volatile uint32_t *)0xf9230000)
#define RTPS_TRCH_MBOX_BASE	((volatile uint32_t *)0x3000a000)

#define RTPS_TRCH_MBOX_HAVE_DATA_IRQ    162
#define HPPS_TRCH_MBOX_HAVE_DATA_IRQ    164
#define HPPS_RTPS_MBOX_HAVE_DATA_IRQ    166

#define MBOX_MAIL0 0x80
#define MBOX_MAIL1 0xA0

#define MBOX_REG_MAIL0     (MBOX_MAIL0 + 0x00)
#define MBOX_REG_MAIL1     (MBOX_MAIL1 + 0x00)
#define MBOX_REG_MAIL0_CNF (MBOX_MAIL0 + 0x1C)
#define MBOX_REG_MAIL1_CNF (MBOX_MAIL1 + 0x1C)

#define MBOX_BIT_IHAVEDATAIRQEN 0x1

void mbox_init(volatile uint32_t *base);
void mbox_send(volatile uint32_t *base, uint8_t msg);
uint8_t mbox_receive(volatile uint32_t *base);

#endif // MAILBOX_H
