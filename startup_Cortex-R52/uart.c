#include <stdint.h>

#define BASEADDR 0x30001000

/* Register offsets for the UART. */
#define CDNS_UART_CR_OFFSET		0x00  /* Control Register */
#define CDNS_UART_MR_OFFSET		0x04  /* Mode Register */
#define CDNS_UART_IER_OFFSET		0x08  /* Interrupt Enable */
#define CDNS_UART_IDR_OFFSET		0x0C  /* Interrupt Disable */
#define CDNS_UART_IMR_OFFSET		0x10  /* Interrupt Mask */
#define CDNS_UART_ISR_OFFSET		0x14  /* Interrupt Status */
#define CDNS_UART_BAUDGEN_OFFSET	0x18  /* Baud Rate Generator */
#define CDNS_UART_RXTOUT_OFFSET		0x1C  /* RX Timeout */
#define CDNS_UART_RXWM_OFFSET		0x20  /* RX FIFO Trigger Level */
#define CDNS_UART_MODEMCR_OFFSET	0x24  /* Modem Control */
#define CDNS_UART_MODEMSR_OFFSET	0x28  /* Modem Status */
#define CDNS_UART_SR_OFFSET		0x2C  /* Channel Status */
#define CDNS_UART_FIFO_OFFSET		0x30  /* FIFO */
#define CDNS_UART_BAUDDIV_OFFSET	0x34  /* Baud Rate Divider */
#define CDNS_UART_FLOWDEL_OFFSET	0x38  /* Flow Delay */
#define CDNS_UART_IRRX_PWIDTH_OFFSET	0x3C  /* IR Min Received Pulse Width */
#define CDNS_UART_IRTX_PWIDTH_OFFSET	0x40  /* IR Transmitted pulse Width */
#define CDNS_UART_TXWM_OFFSET		0x44  /* TX FIFO Trigger Level */
#define CDNS_UART_RXBS_OFFSET		0x48  /* RX FIFO byte status register */

/* Control Register Bit Definitions */
#define CDNS_UART_CR_STOPBRK	0x00000100  /* Stop TX break */
#define CDNS_UART_CR_STARTBRK	0x00000080  /* Set TX break */
#define CDNS_UART_CR_TX_DIS	0x00000020  /* TX disabled. */
#define CDNS_UART_CR_TX_EN	0x00000010  /* TX enabled */
#define CDNS_UART_CR_RX_DIS	0x00000008  /* RX disabled. */
#define CDNS_UART_CR_RX_EN	0x00000004  /* RX enabled */
#define CDNS_UART_CR_TXRST	0x00000002  /* TX logic reset */
#define CDNS_UART_CR_RXRST	0x00000001  /* RX logic reset */
#define CDNS_UART_CR_RST_TO	0x00000040  /* Restart Timeout Counter */

/* RX FIFO byte status Register it Definitions */
#define CDNS_UART_RXBS_PARITY    0x00000001 /* Parity error status */
#define CDNS_UART_RXBS_FRAMING   0x00000002 /* Framing error status */
#define CDNS_UART_RXBS_BRK       0x00000004 /* Overrun error status */

/*
 * Mode Register:
 * The mode register (MR) defines the mode of transfer as well as the data
 * format. If this register is modified during transmission or reception,
 * data validity cannot be guaranteed.
 */
#define CDNS_UART_MR_CLKSEL		0x00000001  /* Pre-scalar selection */
#define CDNS_UART_MR_CHMODE_L_LOOP	0x00000200  /* Local loop back mode */
#define CDNS_UART_MR_CHMODE_NORM	0x00000000  /* Normal mode */
#define CDNS_UART_MR_CHMODE_MASK	0x00000300  /* Mask for mode bits */

#define CDNS_UART_MR_STOPMODE_2_BIT	0x00000080  /* 2 stop bits */
#define CDNS_UART_MR_STOPMODE_1_BIT	0x00000000  /* 1 stop bit */

#define CDNS_UART_MR_PARITY_NONE	0x00000020  /* No parity mode */
#define CDNS_UART_MR_PARITY_MARK	0x00000018  /* Mark parity mode */
#define CDNS_UART_MR_PARITY_SPACE	0x00000010  /* Space parity mode */
#define CDNS_UART_MR_PARITY_ODD		0x00000008  /* Odd parity mode */
#define CDNS_UART_MR_PARITY_EVEN	0x00000000  /* Even parity mode */

#define CDNS_UART_MR_CHARLEN_6_BIT	0x00000006  /* 6 bits data */
#define CDNS_UART_MR_CHARLEN_7_BIT	0x00000004  /* 7 bits data */
#define CDNS_UART_MR_CHARLEN_8_BIT	0x00000000  /* 8 bits data */

/*
 * Interrupt Registers:
 * Interrupt control logic uses the interrupt enable register (IER) and the
 * interrupt disable register (IDR) to set the value of the bits in the
 * interrupt mask register (IMR). The IMR determines whether to pass an
 * interrupt to the interrupt status register (ISR).
 * Writing a 1 to IER Enables an interrupt, writing a 1 to IDR disables an
 * interrupt. IMR and ISR are read only, and IER and IDR are write only.
 * Reading either IER or IDR returns 0x00.
 * All four registers have the same bit definitions.
 */
#define CDNS_UART_IXR_TOUT	0x00000100 /* RX Timeout error interrupt */
#define CDNS_UART_IXR_PARITY	0x00000080 /* Parity error interrupt */
#define CDNS_UART_IXR_FRAMING	0x00000040 /* Framing error interrupt */
#define CDNS_UART_IXR_OVERRUN	0x00000020 /* Overrun error interrupt */
#define CDNS_UART_IXR_TXFULL	0x00000010 /* TX FIFO Full interrupt */
#define CDNS_UART_IXR_TXEMPTY	0x00000008 /* TX FIFO empty interrupt */
#define CDNS_UART_ISR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt */
#define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
#define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
#define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
#define CDNS_UART_IXR_MASK	0x00003FFF /* Valid bit mask */

/* Goes in read_status_mask for break detection as the HW doesn't do it*/
#define CDNS_UART_IXR_BRK	0x00002000

#define CDNS_UART_RXBS_SUPPORT BIT(1)
/*
 * Modem Control register:
 * The read/write Modem Control register controls the interface with the modem
 * or data set, or a peripheral device emulating a modem.
 */
#define CDNS_UART_MODEMCR_FCM	0x00000020 /* Automatic flow control mode */
#define CDNS_UART_MODEMCR_RTS	0x00000002 /* Request to send output control */
#define CDNS_UART_MODEMCR_DTR	0x00000001 /* Data Terminal Ready */

/*
 * Channel Status Register:
 * The channel status register (CSR) is provided to enable the control logic
 * to monitor the status of bits in the channel interrupt status register,
 * even if these are masked out by the interrupt mask register.
 */
#define CDNS_UART_SR_RXEMPTY	0x00000002 /* RX FIFO empty */
#define CDNS_UART_SR_TXEMPTY	0x00000008 /* TX FIFO empty */
#define CDNS_UART_SR_TXFULL	0x00000010 /* TX FIFO full */
#define CDNS_UART_SR_RXTRIG	0x00000001 /* Rx Trigger */

/* baud dividers min/max values */
#define CDNS_UART_BDIV_MIN	4
#define CDNS_UART_BDIV_MAX	255
#define CDNS_UART_CD_MAX	65535

#define cdns_uart_readl(offset)		(*((volatile uint32_t *)BASEADDR + (offset/4)))
#define cdns_uart_writel(val, offset)	do { *((volatile uint32_t *)BASEADDR + (offset/4)) = val; } while (0)

/**
 * cdns_uart_startup - Called when an application opens a cdns_uart port
 * @port: Handle to the uart port structure
 *
 * Return: 0 on success, negative errno otherwise
 */
int cdns_uart_startup()
{
        int retval = 0;

	/* Disable the TX and RX */
	cdns_uart_writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
						CDNS_UART_CR_OFFSET);

	/* Set the Control Register with TX/RX Enable, TX/RX Reset,
	 * no break chars.
	 */
	cdns_uart_writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
				CDNS_UART_CR_OFFSET);

	while (cdns_uart_readl(CDNS_UART_CR_OFFSET) &
		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST));

	uint32_t status = cdns_uart_readl(CDNS_UART_CR_OFFSET);

	/* Clear the RX disable and TX disable bits and then set the TX enable
	 * bit and RX enable bit to enable the transmitter and receiver.
	 */
	cdns_uart_writel((status & ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS))
			| (CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN |
			CDNS_UART_CR_STOPBRK), CDNS_UART_CR_OFFSET);

	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
	 * no parity.
	 */
	cdns_uart_writel(CDNS_UART_MR_CHMODE_NORM | CDNS_UART_MR_STOPMODE_1_BIT
		| CDNS_UART_MR_PARITY_NONE | CDNS_UART_MR_CHARLEN_8_BIT,
		 CDNS_UART_MR_OFFSET);

	/*
	 * Set the RX FIFO Trigger level to use most of the FIFO, but it
	 * can be tuned with a module parameter
	 */
        int rx_trigger_level = 56;
	cdns_uart_writel(rx_trigger_level, CDNS_UART_RXWM_OFFSET);

	/*
	 * Receive Timeout register is enabled but it
	 * can be tuned with a module parameter
	 */
        int rx_timeout = 10;
	cdns_uart_writel(rx_timeout, CDNS_UART_RXTOUT_OFFSET);

	/* Clear out any pending interrupts before enabling them */
	cdns_uart_writel(cdns_uart_readl(CDNS_UART_ISR_OFFSET),
			CDNS_UART_ISR_OFFSET);

	/*
	 * Set the Interrupt Registers with desired interrupts. Do not
	 * enable parity error interrupt for the following reason:
	 * When parity error interrupt is enabled, each Rx parity error always
	 * results in 2 events. The first one being parity error interrupt
	 * and the second one with a proper Rx interrupt with the incoming data.
	 * Disabling parity error interrupt ensures better handling of parity
	 * error events. With this change, for a parity error case, we get a
	 * Rx interrupt with parity error set in ISR register and we still
	 * handle parity errors in the desired way.
	 */
	cdns_uart_writel(CDNS_UART_IXR_TXEMPTY |
		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
		CDNS_UART_IER_OFFSET);
#if 0
	if (is_brk_support) {
		status = cdns_uart_readl(CDNS_UART_IMR_OFFSET);
		cdns_uart_writel((status | CDNS_UART_IXR_BRK),
					CDNS_UART_IER_OFFSET);
	}
#endif

	return retval;
}

void _putchar(char c)
{

#if 0
	u32 imr;
	/* Disable all interrupts */
	imr = cdns_uart_readl(CDNS_UART_IMR_OFFSET);
	cdns_uart_writel(imr, CDNS_UART_IDR_OFFSET);
#endif

	/* Wait until FIFO is empty */
	while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEMPTY));

	/* Write a character */
	cdns_uart_writel(c, CDNS_UART_FIFO_OFFSET);

	/* Wait until FIFO is empty */
	while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEMPTY));

#if 0
	/* Enable interrupts */
	cdns_uart_writel(imr, CDNS_UART_IER_OFFSET);
#endif

	return;
}
