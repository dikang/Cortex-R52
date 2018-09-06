#ifndef MAILBOX_H
#define MAILBOX_H

/* External IRQ numbering (i.e. vector #16 has index 0). */
#define MBOX_HAVE_DATA_IRQ 164

#define HPPS_RTPC_MBOX_BASE     0xF9230000
#define HPPS_TRCH_MBOX_BASE     0xF9220000
/* #define RTPS_TRCH_MBOX_BASE     0x3000A000 */
#define RTPS_TRCH_MBOX_BASE     0xF9240000

//#define MBOX_MAIL0 0x80
//#define MBOX_MAIL1 0xA0
#define MBOX_MAIL0 0xA0
#define MBOX_MAIL1 0x80

#define MBOX_REG_MAIL0     (MBOX_MAIL0 + 0x00)
#define MBOX_REG_MAIL1     (MBOX_MAIL1 + 0x00)
#define MBOX_REG_MAIL0_CNF (MBOX_MAIL0 + 0x1C)
#define MBOX_REG_MAIL1_CNF (MBOX_MAIL1 + 0x1C)

#define MBOX_BIT_IHAVEDATAIRQEN 0x1

void mbox_init();
void mbox_send(uint8_t msg);
uint8_t mbox_receive();

#endif // MAILBOX_H
