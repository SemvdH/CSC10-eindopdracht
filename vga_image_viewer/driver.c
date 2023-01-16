#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/sched.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/jiffies.h>
//clock speed: 800MHz

MODULE_LICENSE("GPL");

#define HW_REGS_BASE 0xff200000
#define HW_REGS_SPAN 0x00200000
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )
#define PIXEL_DATA_BASE 0x000000030
#define PIXEL_STATUS_READ_BASE 0x000000010
#define PIXEL_STATUS_WRITE_BASE 0x000000020
#define PIXEL_ROW_BASE 0x000000000

#define DEVNAME "Mijn Module"

void * LW_virtual; // Lightweight bridge base address
volatile int *PIXEL_data_ptr; // virtual addresses
volatile int *PIXEL_status_r_ptr;
volatile int *PIXEL_status_w_ptr;
volatile int *PIXEL_row_ptr;
int i = 0;
int width = 640;
int heigth = 480;

int irq_amount = 0;
int jiffies_set = 0;
int timestamp = 0;

irq_handler_t irq_handler (int irq, void *dev_id, struct pt_regs * regs)
{
        printk(KERN_ALERT "In de IRQqqqqqqqqqqqqqqqqqqqqq!");
        return (irq_handler_t) IRQ_HANDLED;
}

static int init_handler(struct platform_device * pdev)
{
        int irq_num,ret;

        //Koppel fysiek geheugenbereik aan pointer
        LW_virtual = ioremap(HW_REGS_BASE, HW_REGS_SPAN);

        PIXEL_status_r_ptr = LW_virtual + PIXEL_STATUS_READ_BASE; //offset naar PIO registers
	PIXEL_status_w_ptr = LW_virtual + PIXEL_STATUS_WRITE_BASE;
	PIXEL_data_ptr = LW_virtual + PIXEL_DATA_BASE;

	*(PIXEL_status_r_ptr + 2) = 0xF; // enable irq interrupts
        irq_num = platform_get_irq(pdev,0);
        printk(KERN_ALERT DEVNAME ": IRQ %d wordt geregistreert!\n", irq_num);

//	*(PIXEL_status_w_ptr) = 0b0001;
//	*(PIXEL_data_ptr) = 0xF0F;
//	printk(KERN_ALERT DEVNAME": PIXEL STATUS GEZET! %d\n",*(PIXEL_status_w_ptr));
        ret = request_irq(irq_num, (irq_handler_t) irq_handler, 0, DEVNAME, NULL);
//	free(img_data);
        return ret;
}
static int  clean_handler(struct platform_device *pdev)
{
        int irq_num;
        irq_num=platform_get_irq(pdev,0);
        printk(KERN_ALERT DEVNAME ": IRQ %d wordt vrijgegeven!\n", irq_num);

        iounmap (LW_virtual); //mapping ongedaan maken
        free_irq(irq_num, NULL);
        return 0;
}


/*
* Hierin beschrijven we welk device we willen koppelen
* aan onze module. Deze moet in de device-tree overeen-
* komen!
*/
static const struct of_device_id mijn_module_id[] ={
        {.compatible = "altr,pixel_status_read"},
        {}
};

//handlers e.d. koppelen
static struct platform_driver mijn_module_driver = {
        .driver = {
                .name = DEVNAME,
                .owner = THIS_MODULE,
                .of_match_table = of_match_ptr(mijn_module_id),
        },
        .probe = init_handler,
        .remove = clean_handler
};

//module registreren
module_platform_driver(mijn_module_driver);
