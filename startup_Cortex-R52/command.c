#include <stdint.h>

#include "printf.h"
#include "mailbox.h"

#include "command.h"

void send_cmd(volatile uint32_t *mbox_base, unsigned cmd, unsigned arg)
{
    uint32_t msg = ((cmd & 0x3) << 2) | (arg & 0x3);
    printf("CMD send cmd %x arg %x: msg %x\r\n", cmd, arg, msg);
    mbox_send(mbox_base, msg);
}

void cmd_handle(volatile uint32_t *mbox_base, unsigned msg)
{
    unsigned cmd = (msg & 0xc) >> 2;
    unsigned arg = (msg & 0x3);

    printf("CMD handle cmd %x arg %x\r\n", cmd, arg);

    switch (cmd) {
        case CMD_ECHO:
            printf("ECHO %x\r\n", arg);
            send_cmd(mbox_base, CMD_ECHO_REPLY, arg);
            break;
        default:
            printf("ERROR: unknown cmd: %x\r\n", cmd);
    }
}
