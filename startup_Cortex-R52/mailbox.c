#include <stdint.h>

#include "printf.h"
#include "mailbox.h"
#include "command.h"

// Mailbox has two slots:
//   Slot 0: outgoing direction (send writes to #0)
//   Slot 1: incoming direction (receive reads from #1)
// So neither endpoint ever reads and writes to the same slot.

// Layout of message inside a slot:
//   bits 4-8 bits are the payload
//   Bits 0-4 designate channel index (leftover from BCM2835 mbox)

#define OFFSET_PAYLOAD 4

void mbox_init()
{
    volatile uint32_t *addr = (volatile uint32_t *)(RTPS_TRCH_MBOX_BASE + MBOX_REG_MAIL1_CNF);
    uint32_t val = MBOX_BIT_IHAVEDATAIRQEN;
    printf("mbox_init: rcv irq en: %p <- %08lx\r\n", addr, val);
    *addr = val;
}

void mbox_send(uint8_t msg)
{
    volatile uint32_t *slot = (volatile uint32_t *)(RTPS_TRCH_MBOX_BASE + MBOX_REG_MAIL0);
    uint32_t val = msg << OFFSET_PAYLOAD; // see layout above
    printf("mbox_send: %p <- %08lx\r\n", slot, val);
    *slot = val;
}

uint8_t mbox_receive()
{
    volatile uint32_t *slot = (volatile uint32_t *)(RTPS_TRCH_MBOX_BASE + MBOX_REG_MAIL1);
    uint32_t val = *slot;
    printf("mbox_receive: %p -> %08lx\r\n", slot, val);
    uint8_t msg = val >> OFFSET_PAYLOAD; // see layout above
    return msg;
}

void mbox_have_data_isr()
{
    uint8_t msg = mbox_receive();
    printf("MBOX ISR: rcved msg %x\r\n", msg);
    cmd_handle(msg);
}
