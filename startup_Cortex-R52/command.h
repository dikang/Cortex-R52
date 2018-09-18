#ifndef COMMAND_H
#define COMMAND_H

#include <stdbool.h>

// Command field length is limited to 4-bits right now
#define CMD_ECHO       0x1
#define CMD_ECHO_REPLY 0x2
#define CMD_RESET_HPPS 0x3

void cmd_send(volatile uint32_t *mbox_base, unsigned cmd, unsigned arg);
void cmd_handle(volatile uint32_t *mbox_base, unsigned msg);

#endif // COMMAND_H
