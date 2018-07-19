/*
void cPUT32 ( unsigned int addr, unsigned int data)
{
	unsigned int * uart = (unsigned int *) addr;
	* uart = data;
}
*/
//#define UART0BASE 0x4000C000
#define UART0BASE 0xff000000
#define APU_RESET_ADDR 0xfd1a0104
#define APU_RESET_VALUE 0x800000fe

int notmain ( void )
{
//    cPUT32(APU_RESET_ADDR, APU_RESET_VALUE);
    int i;
    unsigned int * uart = (unsigned int *)UART0BASE;
    for(i = 0; i < 32; i++) 
       * uart = 0x21+i;
    asm("wfi");
    while (1) asm("wfi");
}

#ifdef ORG
int irq0 (void) {
    cPUT32(UART0BASE+0x00,0x90);
    return(0);
}

int irq1 (void) {
    cPUT32(UART0BASE+0x00,0x91);
    return(0);
}

int irq2 (void) {
    cPUT32(UART0BASE+0x00,0x92);
    return(0);
}

int irq3 (void) {
    cPUT32(UART0BASE+0x00,0x93);
    return(0);
}

int irq4 (void) {
    cPUT32(UART0BASE+0x00,0x94);
    return(0);
}

int irq5 (void) {
    cPUT32(UART0BASE+0x00,0x95);
    return(0);
}

int irq6 (void) {
    cPUT32(UART0BASE+0x00,0x96);
    return(0);
}

int irq7 (void) {
    cPUT32(UART0BASE+0x00,0x97);
    return(0);
}

int irq8 (void) {
    cPUT32(UART0BASE+0x00,0x98);
    return(0);
}

int irq9 (void) {
    cPUT32(UART0BASE+0x00,0x99);
    return(0);
}

int irq10 (void) {
    cPUT32(UART0BASE+0x00,0x9a);
    return(0);
}

int irq11 (void) {
    cPUT32(UART0BASE+0x00,0x9b);
    return(0);
}

int irq12 (void) {
    cPUT32(UART0BASE+0x00,0x9c);
    return(0);
}

int irq13 (void) {
    cPUT32(UART0BASE+0x00,0x9d);
    return(0);
}

int irq14 (void) {
    cPUT32(UART0BASE+0x00,0x9e);
    return(0);
}

int irq15 (void) {
    cPUT32(UART0BASE+0x00,0x9f);
    return(0);
}

int irq16 (void) {
    cPUT32(UART0BASE+0x00,0xa0);
    return(0);
}

int irq17 (void) {
    cPUT32(UART0BASE+0x00,0xa1);
    return(0);
}

int irq18 (void) {
    cPUT32(UART0BASE+0x00,0xa2);
    return(0);
}

int irq19 (void) {
    cPUT32(UART0BASE+0x00,0xa3);
    return(0);
}
#endif
