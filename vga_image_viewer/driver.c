#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/module.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/uaccess.h>
#include <linux/fs.h>
#include <linux/platform_device.h>
#include <linux/sched.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/jiffies.h>
// clock speed: 800MHz

// Hz per row on fpga: 52000
//  VGA horizontal blanking time: 6.3 us
MODULE_LICENSE("GPL");

#define HW_REGS_BASE 0xff200000
#define HW_REGS_SPAN 0x00200000
#define HW_REGS_MASK (HW_REGS_SPAN - 1)
#define PIXEL_DATA_BASE 0x001000030
#define PIXEL_STATUS_READ_BASE 0x001000010
#define PIXEL_STATUS_WRITE_BASE 0x001000020
#define PIXEL_ROW_BASE 0x001000000
#define IMAGE_RAM_BASE 0x00000000

#define width 640
#define heigth 480

#define DEVNAME "Mijn Module"


static int vga_img_viewer_open(struct inode *inode, struct file *file);
static int vga_img_viewer_release(struct inode *inode, struct file *file);
static long vga_img_viewer_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
static ssize_t vga_img_viewer_read(struct file *file, char __user *buf, size_t count, loff_t *offset);
static ssize_t vga_img_viewer_write(struct file *file, const char __user *buf, size_t count, loff_t *offset);

void *LW_virtual;             // Lightweight bridge base address
volatile int *PIXEL_data_ptr; // virtual addresses
volatile int *PIXEL_status_r_ptr;
volatile int *PIXEL_status_w_ptr;
volatile int *PIXEL_row_ptr;
volatile int *image_ram_ptr;

static const struct file_operations vga_img_viewer_fops = {
    .owner = THIS_MODULE,
    .open = vga_img_viewer_open,
    .release = vga_img_viewer_release,
    .unlocked_ioctl = vga_img_viewer_ioctl,
    .read = vga_img_viewer_read,
    .write = vga_img_viewer_write};

struct vga_img_viewer_device_data
{
        struct cdev cdev;
};

static struct task_struct *taak = NULL;

static int dev_major = 0;
static struct class *vga_img_viewer_class = NULL;
static struct vga_img_viewer_device_data vga_img_viewer_data = {0};

//static uint8_t frame_data[width*heigth*3] = {0}; // whole frame

uint16_t rows[480] = {0};
int rowcounter = 0;
int timestamp = 0;
static int vga_img_viewer_uevent(struct device *dev, struct kobj_uevent_env *env)
{
        add_uevent_var(env, "DEVMODE=%#o", 0666);
        return 0;
}

irq_handler_t irq_handler(int irq, void *dev_id, struct pt_regs *regs)
{
        int i = 0;
/*	rows[*PIXEL_row_ptr] = *(PIXEL_row_ptr);
	rowcounter++;
	if (rowcounter >= 479) {
		rowcounter = 0;
		while (rowcounter < 479) {
			printk(KERN_CONT "%d ",rows[rowcounter]);
			rowcounter++;
		}
		rowcounter = 0;
	}*/
/*        while (i < width-1)
        {
                *(PIXEL_status_w_ptr) = 0;
                uint8_t r = frame_data[((*(PIXEL_row_ptr)) * width * 3) + i];
                uint8_t g = frame_data[((*(PIXEL_row_ptr)) * width * 3) + i + 1];
                uint8_t b = frame_data[((*(PIXEL_row_ptr)) * width * 3) + i + 2];

                *(PIXEL_data_ptr) = (b << 16) | (g << 8) | r;
                //			*(PIXEL_data_ptr) = *(PIXEL_row_ptr) < 240 ? 0xFFFFFF : 0x0;
                *(PIXEL_status_w_ptr) = 1;
	        int timestamp = jiffies;

                i++;
                //			long timestamp = jiffies;
                //			while (jiffies - timestamp < 1000);
        }
*/
        //	int jf = jiffies - timestamp;
        //	printk(KERN_ALERT DEVNAME "setting took %d ticks",jf);
	//printk(KERN_ALERT DEVNAME "interrupt");
        return (irq_handler_t)IRQ_HANDLED;
}

static int init_handler(struct platform_device *pdev)
{
        int irq_num, ret;
        dev_t dev;

        // Koppel fysiek geheugenbereik aan pointer
        LW_virtual = ioremap(HW_REGS_BASE, HW_REGS_SPAN);

        PIXEL_status_r_ptr = LW_virtual + PIXEL_STATUS_READ_BASE; // offset naar PIO registers
        PIXEL_status_w_ptr = LW_virtual + PIXEL_STATUS_WRITE_BASE;
        PIXEL_data_ptr = LW_virtual + PIXEL_DATA_BASE;
        PIXEL_row_ptr = LW_virtual + PIXEL_ROW_BASE;
        image_ram_ptr = LW_virtual + IMAGE_RAM_BASE;

        *(PIXEL_status_r_ptr + 2) = 0xF; // enable irq interrupts
        irq_num = platform_get_irq(pdev, 0);
        printk(KERN_ALERT DEVNAME ": IRQ %d wordt geregistreert!\n", irq_num);

        ret = request_irq(irq_num, (irq_handler_t)irq_handler, 0, DEVNAME, NULL);

        ret = alloc_chrdev_region(&dev, 0, 1, "vga_img_viewer");

        dev_major = MAJOR(dev);

        vga_img_viewer_class = class_create(THIS_MODULE, "vga_img_viewer");
        vga_img_viewer_class->dev_uevent = vga_img_viewer_uevent;

        cdev_init(&vga_img_viewer_data.cdev, &vga_img_viewer_fops);
        vga_img_viewer_data.cdev.owner = THIS_MODULE;

        cdev_add(&vga_img_viewer_data.cdev, MKDEV(dev_major, 1), 1);

        device_create(vga_img_viewer_class, NULL, MKDEV(dev_major, 1), NULL, "vga_img_viewer");
        return ret;
}
static int clean_handler(struct platform_device *pdev)
{
        int irq_num;
        irq_num = platform_get_irq(pdev, 0);
        printk(KERN_ALERT DEVNAME ": IRQ %d wordt vrijgegeven!\n", irq_num);

        iounmap(LW_virtual); // mapping ongedaan maken
        free_irq(irq_num, NULL);

        device_destroy(vga_img_viewer_class, MKDEV(dev_major, 1));

        class_unregister(vga_img_viewer_class);
        class_destroy(vga_img_viewer_class);

        unregister_chrdev_region(MKDEV(dev_major, 0), MINORMASK);
        return 0;
}

static int vga_img_viewer_open(struct inode *inode, struct file *file)
{
    printk("vga_img_viewer: Device open\n");
    return 0;
}

static int vga_img_viewer_release(struct inode *inode, struct file *file)
{
        printk("vga_img_viewer: Device close\n");

        // struct task_struct * ref_taak = get_current();
        // printk ( KERN_INFO " Device bestand vrijgegeven \n");

        // Taak 0 maken
        // if( ref_taak == taak ) {
        //         taak = NULL;
        // }

        return 0;
}

static long vga_img_viewer_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    printk("vga_img_viewer: Device ioctl\n");

//     if(cmd == _IOW ('a','a', int32_t *))
//     {
//         printk ( KERN_INFO " Taak registreren \n") ;
//         // huidige taak die registratie aanvraagt
//         // taak = get_current();
//     }
    return 0;
}

static ssize_t vga_img_viewer_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
{
    uint8_t data = *(PIXEL_row_ptr);
    size_t datalen = 1;

    printk("Reading device: %d\n", MINOR(file->f_path.dentry->d_inode->i_rdev));

    if (count > datalen) {
        count = datalen;
    }

    if (copy_to_user(buf, &data, count)) {
        return -EFAULT;
    }

    return count;
}

// write image data
static ssize_t vga_img_viewer_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
{
    size_t maxdatalen = 640*480*4, ncopied; // 640x480 pixels, 4 bytes per pixel
    
    printk("Writing device: %d\n", MINOR(file->f_path.dentry->d_inode->i_rdev));

    if (count < maxdatalen) {
        maxdatalen = count;
    }

    ncopied = copy_from_user(*(image_ram_ptr), buf, maxdatalen);

    if (ncopied == 0) {
        printk("Copied %zd bytes from the user\n", maxdatalen);
        // printk("Copied value: %x\n", data);
    } else {
        printk("Could't copy %zd bytes from the user\n", ncopied);
    }

    return count;
}

/*
 * Hierin beschrijven we welk device we willen koppelen
 * aan onze module. Deze moet in de device-tree overeen-
 * komen!
 */
static const struct of_device_id mijn_module_id[] = {
    {.compatible = "altr,pixel_status_read",
     "altr,pixel_row",
     "altr,pixel_status_write",
     "altr,pixel_data"},
    {}};

// handlers e.d. koppelen
static struct platform_driver mijn_module_driver = {
    .driver = {
        .name = DEVNAME,
        .owner = THIS_MODULE,
        .of_match_table = of_match_ptr(mijn_module_id),
    },
    .probe = init_handler,
    .remove = clean_handler};

// module registreren
module_platform_driver(mijn_module_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Sem en Stijn :)");
