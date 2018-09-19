//----------------------------------------------------------------
// Cortex-R52 Embedded example - Startup Code
//
// Copyright (c) 2016-2018 Arm Limited (or its affiliates). All rights reserved.
// Use, modification and redistribution of this file is subject to your possession of a
// valid End User License Agreement for the Arm Product of which these examples are part of 
// and your compliance with all applicable terms and conditions of such licence agreement.
//----------------------------------------------------------------

#define DK_GIC
#ifdef DK_GIC
#define GICD_BASE 0xF9A00000
#define GICR_BASE 0xF9B00000

/* Distributor Registers */
#define GICD_CTLR		0x0000
#define GICD_TYPER		0x0004
#define GICD_IIDR		0x0008
#define GICD_STATUSR		0x0010
#define GICD_SETSPI_NSR		0x0040
#define GICD_CLRSPI_NSR		0x0048
#define GICD_SETSPI_SR		0x0050
#define GICD_CLRSPI_SR		0x0058
#define GICD_SEIR		0x0068
#define GICD_IGROUPRn		0x0080
#define GICD_ISENABLERn		0x0100
#define GICD_ICENABLERn		0x0180
#define GICD_ISPENDRn		0x0200
#define GICD_ICPENDRn		0x0280
#define GICD_ISACTIVERn		0x0300
#define GICD_IGROUPMODRn        0x0d00

#define GICR_TYPER              0x0008
#define GICR_WAKER              0x0014

#define GICR_IGROUPRn           0x0080
#define GICR_ISENABLERn         0x0100
#define GICR_IGROUPMODRn        0x0d00
#endif
// MPU region defines

// Protection Base Address Register
#define Execute_Never 0b1         // Bit 0
#define RW_Access 0b01            // AP[2:1]
#define RO_Access 0b11
#define Non_Shareable 0b00        // SH[1:0]
#define Outer_Shareable 0x10
#define Inner_Shareable 0b11

// Protection Limit Address Register
#define ENable 0b1                // Bit 0
#define AttrIndx0 0b000           // AttrIndx[2:0]
#define AttrIndx1 0b001
#define AttrIndx2 0b010
#define AttrIndx3 0b011
#define AttrIndx4 0b100
#define AttrIndx5 0b101
#define AttrIndx6 0b110
#define AttrIndx7 0b111

//----------------------------------------------------------------

// Define some values
#define Mode_USR 0x10
#define Mode_FIQ 0x11
#define Mode_IRQ 0x12
#define Mode_SVC 0x13
#define Mode_MON 0x16
#define Mode_ABT 0x17
#define Mode_UND 0x1B
#define Mode_SYS 0x1F
#define Mode_HYP 0x1A
#define I_Bit 0x80 // when I bit is set, IRQ is disabled
#define F_Bit 0x40 // when F bit is set, FIQ is disabled

//----------------------------------------------------------------

/*    .section  VECTORS,"ax"
    .align 3
    .cfi_sections .debug_frame  // put stack frame info into .debug_frame instead of .eh_frame
*/

//----------------------------------------------------------------
// Entry point for the Reset handler
//----------------------------------------------------------------

    .global Start
    .type Start, "function"

Start:
//----------------------------------------------------------------
// EL2 Exception Vector Table
//----------------------------------------------------------------
// Note: LDR PC instructions are used here, though branch (B) instructions
// could also be used, unless the exception handlers are >32MB away.

EL2_Vectors:
        LDR PC, EL2_Reset_Addr
        LDR PC, EL2_Undefined_Addr
        LDR PC, EL2_HVC_Addr
        LDR PC, EL2_Prefetch_Addr
        LDR PC, EL2_Abort_Addr
        LDR PC, EL2_HypModeEntry_Addr
        LDR PC, EL2_IRQ_Addr
        LDR PC, EL2_FIQ_Addr


EL2_Reset_Addr:         .word    EL2_Reset_Handler
EL2_Undefined_Addr:     .word    EL2_Undefined_Handler
EL2_HVC_Addr:           .word    EL2_HVC_Handler
EL2_Prefetch_Addr:      .word    EL2_Prefetch_Handler
EL2_Abort_Addr:         .word    EL2_Abort_Handler
EL2_HypModeEntry_Addr:  .word    EL2_HypModeEntry_Handler
EL2_IRQ_Addr:           .word    EL2_IRQ_Handler
EL2_FIQ_Addr:           .word    EL2_FIQ_Handler


//----------------------------------------------------------------
// EL2 Exception Handlers
//----------------------------------------------------------------

.type EL2_Undefined_Handler, "function"
EL2_Undefined_Handler:
        B   EL2_Undefined_Handler
.type EL2_HVC_Handler, "function"
EL2_HVC_Handler:
        B   EL2_HVC_Handler
.type EL2_Prefetch_Handler, "function"
EL2_Prefetch_Handler:
        B   EL2_Prefetch_Handler
.type EL2_Abort_Handler, "function"
EL2_Abort_Handler:
        B   EL2_Abort_Handler
.type EL2_HypModeEntry_Handler, "function"
EL2_HypModeEntry_Handler:
        B   EL2_HypModeEntry_Handler
.type EL2_IRQ_Handler, "function"
EL2_IRQ_Handler:
        B   EL2_IRQ_Handler
.type EL2_FIQ_Handler, "function"
EL2_FIQ_Handler:
        B   EL2_FIQ_Handler

//----------------------------------------------------------------
// EL1 Exception Vector Table
//----------------------------------------------------------------
// Note: LDR PC instructions are used here, though branch (B) instructions
// could also be used, unless the exception handlers are >32MB away.

    .align 5
EL1_Vectors:
        LDR PC, EL1_Reset_Addr
        LDR PC, EL1_Undefined_Addr
        LDR PC, EL1_SVC_Addr
        LDR PC, EL1_Prefetch_Addr
        LDR PC, EL1_Abort_Addr
        LDR PC, EL1_Reserved
        LDR PC, EL1_IRQ_Addr
        LDR PC, EL1_FIQ_Addr


EL1_Reset_Addr:     .word    EL1_Reset_Handler
EL1_Undefined_Addr: .word    EL1_Undefined_Handler
EL1_SVC_Addr:       .word    EL1_SVC_Handler
EL1_Prefetch_Addr:  .word    EL1_Prefetch_Handler
EL1_Abort_Addr:     .word    EL1_Abort_Handler
EL1_Reserved_Addr:  .word    EL1_Reserved
EL1_IRQ_Addr:       .word    EL1_IRQ_Handler
EL1_FIQ_Addr:       .word    EL1_FIQ_Handler


//----------------------------------------------------------------
// EL1 Exception Handlers
//----------------------------------------------------------------

.type EL1_Undefined_Handler, "function"
EL1_Undefined_Handler:
        B   EL1_Undefined_Handler
.type EL1_SVC_Handler, "function"
EL1_SVC_Handler:
        B   EL1_SVC_Handler
.type EL1_Prefetch_Handler, "function"
EL1_Prefetch_Handler:
        B   EL1_Prefetch_Handler
.type EL1_Abort_Handler, "function"
EL1_Abort_Handler:
        B   EL1_Abort_Handler
EL1_Reserved:
        B   EL1_Reserved
.type EL1_IRQ_Handler, "function"
EL1_IRQ_Handler:
        SUB lr, #4  // undo auto offset to get preferred ret address (ARMv8-A/R Reference, Table B1-7, IRQ/FIQ row)
        SRSDB sp!, #0b10010
        PUSH {r0} // save, because we are going to use
        MRC p15, 0, r0, c12, c12, 0 // r1 <- IRCC_IAR1 (INTID)	// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}
        PUSH {r0} // save INTID before we modify it and before irq_handler clobbers it
        SUB r0, #32 /* convert INTID to IRQ # (as in Qemu device tree) TODO: does this offset have a name? */
        BL irq_handler // arg passed in r0 (IRQ #)
        POP {r0} // restore INTID
        MCR p15, 0, r0, c12, c12, 1 // ICC_EOIR1 <- r0 (INTID)	// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}
        POP {r0} // restore the registers we used
        RFEIA sp!
.type EL1_FIQ_Handler, "function"
EL1_FIQ_Handler:
        B   EL1_FIQ_Handler

//----------------------------------------------------------------
// EL2 Reset Handler
//----------------------------------------------------------------
/*
    .section  RESET,"ax"
    .align 3
*/
#ifdef __THUMB__
    .thumb
#endif

.type EL2_Reset_Handler, "function"
EL2_Reset_Handler:

    // Change EL2 exception base address
        LDR r0, =EL2_Vectors
        MCR p15, 4, r0, c12, c0, 0      //  Write to HVBAR

    // Init HSCTLR  
        LDR r0, =0x30C5180C             // See TRM for decoding
        MCR p15, 4, r0, c1, c0, 0       // Write to HSCTLR

	/* DK's test for EL2 MPU */

        // Region 0 - Code
        LDR     r1, =__text_start__
	mov     r1, #0x0
        LDR     r2, =((Non_Shareable<<3) | (RO_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c8, 0                   // write HPRBAR0
        LDR     r1, =__text_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c8, 1                   // write HPRLAR0

        // Region 1 - Data
        LDR     r1, =__data_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c8, 4                   // write HPRBAR1
        LDR     r1, =__data_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c8, 5                   // write HPRLAR1

        // Region 2 - Stack-Heap
        LDR     r1, =__stack_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c9, 0                   // write HPRBAR2
        LDR     r1, =__stack_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c9, 1                   // write HPRLAR2

        // Region 7 - Peripherals
        LDR     r1, =0x30000000
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c11, 4                   // write HPRBAR7
        LDR     r1, =0xFFFFFF00
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 4, r1, c6, c11, 5                   // write HPRLAR7

        LDR r0, =0x30C5180d             // DK's test. Enable EL2 MPU. 
        MCR p15, 4, r0, c1, c0, 0       // Write to HSCTLR

	MRC p15, 4, r0, c1, c1, 0	// Read HCR
	ORR	r0, r0, #1		// Enable VM
	MCR p15, 4, r0, c1, c1, 0	// Write HCR

	/* end of tests */

#ifdef PMEV_TEST
/* DK: CPR registers testing */
	MRC p15, 0, r0, c14, c8, 0	// Read PMEVCNTR0
	MCR p15, 0, r0, c14, c8, 0	// Write PMEVCNTR0
	MRC p15, 0, r0, c14, c8, 1	// Read PMEVCNTR1
	MCR p15, 0, r0, c14, c8, 1	// Write PMEVCNTR1
	MRC p15, 0, r0, c14, c8, 2	// Read PMEVCNTR2
	MCR p15, 0, r0, c14, c8, 2	// Write PMEVCNTR2
	MRC p15, 0, r0, c14, c8, 3	// Read PMEVCNTR3
	MCR p15, 0, r0, c14, c8, 3	// Write PMEVCNTR3
	MRC p15, 0, r0, c14, c12, 0	// Read PMEVTYPER0
	MCR p15, 0, r0, c14, c12, 0	// Write PMEVTYPER0
	MRC p15, 0, r0, c14, c12, 1	// Read PMEVTYPER1
	MCR p15, 0, r0, c14, c12, 1	// Write PMEVTYPER1
	MRC p15, 0, r0, c14, c12, 2	// Read PMEVTYPER2
	MCR p15, 0, r0, c14, c12, 2	// Write PMEVTYPER2
	MRC p15, 0, r0, c14, c12, 3	// Read PMEVTYPER3
	MCR p15, 0, r0, c14, c12, 3	// Write PMEVTYPER3
/* end of tests */
#endif
    // Enable EL1 access to all IMP DEF registers
        LDR r0, =0x7F81
	DSB
        MCR p15, 4, r0, c1, c0, 1       // Write to HACTLR
	ISB
    // Change EL1 exception base address
        LDR r0, =EL1_Vectors
        MCR p15, 0, r0, c12, c0, 0      // Write to VBAR

    // DK test for reading HVBAR
        MRC p15, 4, r0, c12, c0, 0      // Read from HVBAR
        
    // DK test for HRMR
//	MOV r1, #2
//	MCR p15, 4, r1, c12, c0, 2
 
    // Go to SVC mode
	MRS r0, apsr	// DK test
        MRS r0, cpsr
        MOV r1, #Mode_SVC
        BFI r0, r1, #0, #5
#ifdef __THUMB__
        ORR r0, r0, #(0x1 << 5)         // Set T bit
#endif
//        MSR spsr_abt, r0		// DK: test
        MSR spsr_hyp, r0		// DK: Not work yet
        LDR r0, =EL1_Reset_Handler
        MSR elr_hyp, r0			// DK: Not work yet
        DSB
        ISB
        ERET
// DK dummy for testing
        ORR r0, r0, #(0x1 << 5)         // Set T bit
        ORR r0, r0, #(0x1 << 5)         // Set T bit
        ORR r0, r0, #(0x1 << 5)         // Set T bit
// DK end
    .global __use_two_region_memory

EL1_Reset_Handler:

//----------------------------------------------------------------
// Disable MPU and caches
//----------------------------------------------------------------

    // Disable MPU and cache in case it was left enabled from an earlier run
    // This does not need to be done from a cold reset

        MRC p15, 0, r0, c1, c0, 0       // Read System Control Register
        BIC r0, r0, #0x05               // Disable MPU (M bit) and data cache (C bit)
        BIC r0, r0, #0x1000             // Disable instruction cache (I bit)
        DSB                             // Ensure all previous loads/stores have completed
        MCR p15, 0, r0, c1, c0, 0       // Write System Control Register
        ISB                             // Ensure subsequent insts execute wrt new MPU settings


//----------------------------------------------------------------
// Cortex-R52 implementation-specific configuration
//----------------------------------------------------------------
#ifdef ENABLE_R52_SPECIFIC_CONFIG
        LDR r1,=0x3C                    // SIZE field mask

        MRC p15, 0, r0, c15, c0, 1      // Read from FLASHIFREGIONR
        ANDS r2, r0, r1                 // Extract SIZE and set flags
        BEQ 1f
        ORR r0, r0, #0x1                // Set enable bit if SIZE=!0x0
        MCR p15, 0, r0, c15, c0, 1      // Write r0 to FLASHIFREGIONR if SIZE=!0x0
1:
        MRC p15, 0, r0, c15, c0, 0      // Read from PERIPHPREGIONR
        ANDS r2, r0, r1                 // Extract SIZE and set flags
        BEQ 2f
        ORR r0, r0, #0x1                // Set enable bit if SIZE=!0x0
        MCR p15, 0, r0, c15, c0, 0      // Write r0 to PERIPHPREGIONR if SIZE=!0x0
2:
#endif

//----------------------------------------------------------------
// Initialize Stacks using Linker symbol from scatter file.
// ABT, IRQ, FIQ, UNDEF size = STACKSIZE, SVC the rest.
// Stacks must be 8 byte aligned.
//----------------------------------------------------------------

#define STACKSIZE 512
        //
        // Setup the stack(s) for this CPU
        // the scatter file allocates 2^14 bytes per stack
        //
        MRC  p15, 0, r1, c0, c0, 5      // Read CPU ID register
        AND  r1, r1, #0x03              // Mask off, leaving the CPU ID field
        LDR  r0, =__stack_end__
        SUB  r0, r0, r1, lsl #14

        CPS #Mode_ABT
        MOV SP, r0

        CPS #Mode_IRQ
        SUB r0, r0, #STACKSIZE
        MOV SP, r0

        CPS #Mode_FIQ
        SUB r0, r0, #STACKSIZE
        MOV SP, r0

        CPS #Mode_SVC
        SUB r0, r0, #STACKSIZE
        MOV SP, r0


//----------------------------------------------------------------
// Cache invalidation. However Cortex-R52 provides CFG signals to 
// invalidate cache automatically out of reset (CFGL1CACHEINVDISx)
//----------------------------------------------------------------

        DSB             // Complete all outstanding explicit memory operations

        MOV r0, #0

        MCR p15, 0, r0, c7, c5, 0       // Invalidate entire instruction cache

        // Invalidate Data/Unified Caches

        MRC     p15, 1, r0, c0, c0, 1      // Read CLIDR
        ANDS    r3, r0, #0x07000000        // Extract coherency level
        MOV     r3, r3, LSR #23            // Total cache levels << 1
        BEQ     Finished                   // If 0, no need to clean

        MOV     r10, #0                    // R10 holds current cache level << 1
Loop1:  ADD     r2, r10, r10, LSR #1       // R2 holds cache "Set" position 
        MOV     r1, r0, LSR r2             // Bottom 3 bits are the Cache-type for this level
        AND     r1, r1, #7                 // Isolate those lower 3 bits
        CMP     r1, #2
        BLT     Skip                       // No cache or only instruction cache at this level

        MCR     p15, 2, r10, c0, c0, 0     // Write the Cache Size selection register
        ISB                                // ISB to sync the change to the CacheSizeID reg
        MRC     p15, 1, r1, c0, c0, 0      // Reads current Cache Size ID register
        AND     r2, r1, #7                 // Extract the line length field
        ADD     r2, r2, #4                 // Add 4 for the line length offset (log2 16 bytes)
        LDR     r4, =0x3FF
        ANDS    r4, r4, r1, LSR #3         // R4 is the max number on the way size (right aligned)
        CLZ     r5, r4                     // R5 is the bit position of the way size increment
        LDR     r7, =0x7FFF
        ANDS    r7, r7, r1, LSR #13        // R7 is the max number of the index size (right aligned)

Loop2:  MOV     r9, r4                     // R9 working copy of the max way size (right aligned)

#ifdef __THUMB__
Loop3:  LSL     r12, r9, r5
        ORR     r11, r10, r12              // Factor in the Way number and cache number into R11
        LSL     r12, r7, r2
        ORR     r11, r11, r12              // Factor in the Set number
#else
Loop3:  ORR     r11, r10, r9, LSL r5       // Factor in the Way number and cache number into R11
        ORR     r11, r11, r7, LSL r2       // Factor in the Set number
#endif
        MCR     p15, 0, r11, c7, c6, 2     // Invalidate by Set/Way
        SUBS    r9, r9, #1                 // Decrement the Way number
        BGE     Loop3
        SUBS    r7, r7, #1                 // Decrement the Set number
        BGE     Loop2
Skip:   ADD     r10, r10, #2               // Increment the cache number
        CMP     r3, r10
        BGT     Loop1

Finished:

//----------------------------------------------------------------
// TCM Configuration
//----------------------------------------------------------------

// Cortex-R52 optionally provides three Tightly-Coupled Memory (TCM) blocks (ATCM, BTCM and CTCM) 
//    for fast access to code or data.

// The following illustrates basic TCM configuration, as the basis for exploration by the user
#define TCM
#ifdef TCM

        MRC p15, 0, r0, c0, c0, 2       // Read TCM Type Register
        // r0 now contains TCM availability

        MRC p15, 0, r0, c9, c1, 0       // Read ATCM Region Register
        // r0 now contains ATCM size in bits [5:2]
# DK       LDR r0, =Image$$ATCM$$Base      // Set ATCM base address
	LDR r0, =0x00000014
        ORR r0, r0, #1                  // Enable it
        MCR p15, 0, r0, c9, c1, 0       // Write ATCM Region Register

        MRC p15, 0, r0, c9, c1, 1       // Read BTCM Region Register
        // r0 now contains BTCM size in bits [5:2]
#DK        LDR r0, =Image$$BTCM$$Base      // Set BTCM base address
	LDR r0, =0x00004014
        ORR r0, r0, #1                  // Enable it
        MCR p15, 0, r0, c9, c1, 1       // Write BTCM Region Register

        MRC p15, 0, r0, c9, c1, 2       // Read CTCM Region Register
        // r0 now contains CTCM size in bits [5:2]
#DK        LDR r0, =Image$$CTCM$$Base      // Set CTCM base address
	LDR r0, =0x00008014
        ORR r0, r0, #1                  // Enable it
        MCR p15, 0, r0, c9, c1, 2       // Write CTCM Region Register

#endif


//----------------------------------------------------------------
// MPU Configuration
//----------------------------------------------------------------

// Notes:
// * Regions apply to both instruction and data accesses.
// * Each region base address must be a multiple of its size
// * Any address range not covered by an enabled region will abort
// * The region at 0x0 over the Vector table is needed to support semihosting

// Region 0: Code          Base = See scatter file  Limit = Based on usage   Normal  Non-shared  Read-only    Executable
// Region 1: Data          Base = See scatter file  Limit = Based on usage   Normal  Non-shared  Full access  Not Executable
// Region 2: Stack/Heap    Base = See scatter file  Limit = Based on usage   Normal  Non-shared  Full access  Not Executable
// Region 3: Peripherals   Base = 0x9A000000        Limit = 0xAFFFFFC0       Device              Full access  Not Executable
// Region 4: ATCM          Base = Configurable      Limit = Based on usage   Normal  Non-shared  Full access  Executable
// Region 5: BTCM          Base = Configurable      Limit = Based on usage   Normal  Non-shared  Full access  Executable
// Region 6: CTCM          Base = Configurable      Limit = Based on usage   Normal  Non-shared  Full access  Executable
// DK: Region 7: Peripherals Base = 0x30000000      Limit = 0xFFFFFFFF	     Device              Full access  Executable

        LDR     r0, =64
        // Region 0 - Code
        LDR     r1, =__text_start__
        LDR     r2, =((Non_Shareable<<3) | (RO_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c8, 0                   // write PRBAR0
        LDR     r1, =__text_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c8, 1                   // write PRLAR0

        // Region 1 - Data
        LDR     r1, =__data_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c8, 4                   // write PRBAR1
        LDR     r1, =__data_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c8, 5                   // write PRLAR1

        // Region 2 - Stack-Heap
        LDR     r1, =__stack_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c9, 0                   // write PRBAR2
        LDR     r1, =__stack_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c9, 1                   // write PRLAR2

        // Region 3 - Peripherals
        LDR     r1, =0x9A000000
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c9, 4                   // write PRBAR3
        LDR     r1, =0xAFFFFFC0
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c9, 5                   // write PRLAR3

#ifdef TCM
#if 0 // Disabling this definition of ATCM, because the above .text, .data, and stack are in TCM A
        // Region 4 - ATCM
	LDR	r1, =__tcm_a_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c10, 0                  // write PRBAR4
	LDR	r1, =__tcm_a_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx1<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c10, 1                  // write PRLAR4
#endif // ATCM

        // Region 5 - BTCM
	LDR	r1, =__tcm_b_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c10, 4                  // write PRBAR5
	LDR	r1, =__tcm_b_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c10, 5                  // write PRLAR5

#if 0 // Disabling CTCM because not in device tree
        // Region 6 - CTCM
	LDR	r1, =__tcm_c_start__
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c11, 0                  // write PRBAR6
	LDR	r1, =__tcm_c_end__
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c11, 1                  // write PRLAR6
#endif // CTCM
#endif // TCM

        // Region 7 - Peripherals
        LDR     r1, =0x30000000
        LDR     r2, =((Non_Shareable<<3) | (RW_Access<<1))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c11, 4                   // write PRBAR7
        LDR     r1, =0xFFFFFF00
        ADD     r1, r1, #63
        BFC     r1, #0, #6                              // align Limit to 64bytes
        LDR     r2, =((AttrIndx0<<1) | (ENable))
        ORR     r1, r1, r2
        MCR     p15, 0, r1, c6, c11, 5                   // write PRLAR7

    // MAIR0 configuration
        MRC p15, 0, r0, c10, c2, 0      // Read MAIR0 into r0
        LDR r1, =0xBB                   // Normal inner/outer RW cacheable, write-through
        BFI r0, r1, #0, #8              // Update Attr0
        LDR r1, =0x04                   // Device nGnRnE
        BFI r0, r1, #8, #8              // Update Attr1
        MCR p15,0,r0,c10,c2,0           // Write r0 to MAIR0
#ifdef __ARM_FP
//----------------------------------------------------------------
// Enable access to VFP by enabling access to Coprocessors 10 and 11.
// Enables Full Access i.e. in both privileged and non privileged modes
//----------------------------------------------------------------

        MRC     p15, 0, r0, c1, c0, 2      // Read Coprocessor Access Control Register (CPACR)
        ORR     r0, r0, #(0xF << 20)       // Enable access to CP 10 & 11
        MCR     p15, 0, r0, c1, c0, 2      // Write Coprocessor Access Control Register (CPACR)
        ISB

//----------------------------------------------------------------
// Switch on the VFP hardware
//----------------------------------------------------------------

        MOV     r0, #0x40000000
        VMSR    FPEXC, r0                   // Write FPEXC register, EN bit set
#endif


#ifdef DK_GIC /* gotten from U-boot for GICV3 */
/*	B ret_secure_percpu */
	B	gic_init_secure
ret_secure:
	B 	gic_init_secure_percpu
ret_secure_percpu:
#endif
//----------------------------------------------------------------
// Enable MPU and branch to C library init
// Leaving the caches disabled until after scatter loading.
//----------------------------------------------------------------

        MRC     p15, 0, r0, c1, c0, 0       // Read System Control Register
        ORR     r0, r0, #0x01               // Set M bit to enable MPU
        DSB                                 // Ensure all previous loads/stores have completed
        MCR     p15, 0, r0, c1, c0, 0       // Write System Control Register
        ISB                                 // Ensure subsequent insts execute wrt new MPU settings
			// DK: this ISB instruction causes exception.

//Check which CPU I am
        MRC p15, 0, r0, c0, c0, 5       // Read MPIDR
        ANDS r0, r0, #0xF
//        ANDS r0, r0, 0xF		// DK: Original code
        BEQ cpu0                        // If CPU0 then initialise C runtime
        CMP r0, #1
        BEQ loop_wfi                    // If CPU1 then jump to loop_wfi
        CMP r0, #2
        BEQ loop_wfi                    // If CPU2 then jump to loop_wfi
        CMP r0, #3
        BEQ loop_wfi                    // If CPU3 then jump to loop_wfi
error:
        B error                         // else.. something is wrong

loop_wfi:
        DSB SY      // Clear all pending data accesses
        WFI         // Go to sleep
        B loop_wfi


cpu0:
#       .global     __main
#        B       __main
       .global     main
#DK's test to switch from SVC mode to User mode. it works.
# but it is disabled for now.
#	MSR     CPSR_c, #0x10
#DK's test to set up stack poointer
        LDR     r13, =__stack_end__ - 0x2000 /* 0x200 (STACKSIZE) * 5 (ABT,IRQ,FIQ,UNDEF,SVC) = 0xA00, and per-CPU offset 0x1000 * cpuidx */
        B       main

//    .size Reset_Handler, . - Reset_Handler	// Original

#ifdef DK_GIC
gic_init_secure:
	/*
	 * Initialize Distributor
	 * r0: Distributor Base
	 */
	ldr	r0, =GICD_BASE
	mov	r9, #0x37		/* EnableGrp0 | EnableGrp1NS */
					/* EnableGrp1S | ARE_S | ARE_NS */
	str	r9, [r0, #GICD_CTLR]	/* Secure GICD_CTLR */
	ldr	r9, [r0, #GICD_TYPER]
	and	r10, r9, #0x1f		/* ITLinesNumber */
/*	cbz	r10, 1f */			/* No SPIs */
	cmp	r10, #0
	beq	1f
	add	r11, r0, #(GICD_IGROUPRn + 4) 
/*	add	r12, r0, #(GICD_IGROUPMODRn + 4) */
	add	r12, r0, #0xd00
	add	r12, r12, #0x4
	mov	r9, #~0
0:	str	r9, [r11], #0x4
	mov	r7, #0
	str	r7, [r12], #0x4	/* Config SPIs as Group1NS */
	sub	r10, r10, #0x1
/*	cbnz	r10, 0b */
	cmp	r10, #0
	bne	0b
1:
	b 	ret_secure

gic_init_secure_percpu:
	/*
	 * Initialize ReDistributor
	 * r0: ReDistributor Base
	 */
	ldr	r0, =GICR_BASE
//	mrs	r10, mpidr
        MRC p15, 0, r10, c0, c0, 5       // Read MPIDR
	lsr	r9, r10, #32
	bfi	r10, r9, #24, #8	/* r5 is aff3:aff2:aff1:aff0 */
	mov	r9, r0
1:	ldr	r11, [r9, #GICR_TYPER]
	lsr	r11, r11, #32		/* r6 is aff3:aff2:aff1:aff0 */
	cmp	r10, r11
	beq	2f
	add	r9, r9, #(2 << 16)
	b	1b

	/* r9: ReDistributor Base Address of Current CPU */
2:	mov	r5, #~0x2
	ldr	r6, [r9, #GICR_WAKER]
	and	r6, r6, r5		/* Clear ProcessorSleep */
	str	r6, [r9, #GICR_WAKER]
	dsb	st
	isb
3:	ldr	r5, [r9, #GICR_WAKER]
/*	tbnz	r5, #2, 3b */		/* Wait Children be Alive */
	and	r6, r5, #0x4
	cmp	r6, #0x4
	beq	3b

	add	r10, r9, #(1 << 16)	/* SGI_Base */
	mov	r6, #~0
	str	r6, [r10, #GICR_IGROUPRn]
	mov	r7, #0
	str	r7, [r10, #GICR_IGROUPMODRn]	/* SGIs|PPIs Group1NS */
	mov	r6, #0x1		/* Enable SGI 0 */
	str	r6, [r10, #GICR_ISENABLERn]

	/* Initialize Cpu Interface */
#ifdef GIC_ORG__
	mrs	r10, ICC_SRE
	orr	r10, r10, #0x7		/* SRE & Disable IRQ/FIQ Bypass & */
					/* Allow EL1 access to ICC_SRE_EL1 */
/*	msr	ICC_SRE, r10 */
	MCR p15, 0, r10, c12, c12, 5		// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}	
	isb
#endif
	mov	r10, #0x1		/* DK added: EnableGrp0NS */
/*	msr	ICC_IGRPEN0, r10 */
	MCR p15, 0, r10, c12, c12, 6		// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}	
	isb

	mov	r10, #0x1		/* EnableGrp1NS */
/*	msr	ICC_IGRPEN1, r10 */
	MCR p15, 0, r10, c12, c12, 7		// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}	
	isb

/*	msr	ICC_CTLR, xzr */	/* NonSecure ICC_CTLR_EL1 */ 
	mov	r10, #0
	MCR p15, 0, r10, c12, c12, 4		// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}	
	isb

	mov	r10, #0x1 << 7		/* Non-Secure access to ICC_PMR_EL1 */
/*	msr	ICC_PMR, r10 */
	MCR p15, 0, r10, c4, c6, 0		// coproc, #opcode1, Rt, CRn, CRm{, #opcode2}	
	isb
	b	ret_secure_percpu

#endif
//----------------------------------------------------------------
// Global Enable for Instruction and Data Caching
//----------------------------------------------------------------

    .global enable_caches
    .type enable_caches, "function"
    .cfi_startproc
enable_caches:

        MRC     p15, 0, r0, c1, c0, 0       // read System Control Register
        ORR     r0, r0, #(0x1 << 12)        // enable I Cache
        ORR     r0, r0, #(0x1 << 2)         // enable D Cache
        MCR     p15, 0, r0, c1, c0, 0       // write System Control Register
        ISB

        BX    lr
    .cfi_endproc

    .size enable_caches, . - enable_caches

