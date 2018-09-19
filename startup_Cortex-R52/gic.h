#ifndef GIC_H
#define GIC_H

typedef enum {
    IRQ_TYPE_LEVEL = 0,
    IRQ_TYPE_EDGE  = 1
} irq_type_t;

void gic_enable_irq(unsigned irq, irq_type_t type);

#endif // GIC_H
