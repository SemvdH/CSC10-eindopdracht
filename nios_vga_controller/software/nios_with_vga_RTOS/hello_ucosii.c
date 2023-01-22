

#include <stdio.h>
#include <stdint.h>
#include <system.h>
#include <io.h>

#include "includes.h"

#include "image.h"

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       512
OS_STK task1_stk[TASK_STACKSIZE];
OS_STK task2_stk[TASK_STACKSIZE];

/* Definition of Task Priorities */

#define VGA_TASK_PRIO      2
#define BUTTON_TASK_PRIO      1

extern const unsigned char wallpapersden_com_forest_minimal_mountain_landscape_640x480[];

volatile int button_flag = 0;
int button_number = 0;
int zoom_amount = 1;

/* Prints "Hello World" and sleeps for three seconds */
void vga_task(void* pdata) {
	printf("starting task vga\n");
	while (1) {
		// get current pixel
//		printf("drawing\n");
		uint32_t pixel_reg = IORD(VGA_IMAGE_VIEWER_0_BASE, 0x01);
		uint16_t pixel_y = pixel_reg & 0b00000000000000000000001111111111;
		uint16_t pixel_x = (pixel_reg & 0b00000000000011111111110000000000)
				>> 10;

		// resize
		pixel_y /= zoom_amount;
		pixel_x /= zoom_amount;

		// print image from array.
		if (pixel_y < 200 && pixel_x < 200) {
			uint32_t pixel =
					wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y
							* 200 + pixel_x) * 3)]
							+ (wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y
									* 200 + pixel_x) * 3) + 1] << 8)
							+ (wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y
									* 200 + pixel_x) * 3) + 2] << 16);
			IOWR(VGA_IMAGE_VIEWER_0_BASE, 0, pixel);
		} else
			IOWR(VGA_IMAGE_VIEWER_0_BASE, 0, 0);
	}
}
/* Prints "Hello World" and sleeps for three seconds */
void button_task(void* pdata) {

	printf("starting task button\n");
	while (1) {
		printf("checking for button\n");
		int button = IORD(PIO_0_BASE, 0x0);
		if (button == 13) {
			zoom_amount += 1;
			if (zoom_amount >= 5) {
				zoom_amount = 5;
			}
			printf("zoom amount +, %d\n", zoom_amount);
		} else if (button == 11) {
			zoom_amount -= 1;
			if (zoom_amount <= 1) {
				zoom_amount = 1;
			}
			printf("zoom amount -, %d\n", zoom_amount);
		}
		OSTimeDly(300);
	}
}
/* The main function creates two task and starts multi-tasking */
int main(void) {

	printf("hello!\n");

	OSTaskCreateExt(vga_task,
	NULL, (void *) &task1_stk[TASK_STACKSIZE - 1],
	VGA_TASK_PRIO, 1, task1_stk,
	TASK_STACKSIZE,
	NULL, 0);
//
//
	OSTaskCreateExt(button_task,
	NULL, (void *) &task2_stk[TASK_STACKSIZE - 1],
	BUTTON_TASK_PRIO, 1, task2_stk,
	TASK_STACKSIZE,
	NULL, 0);

	OSStart();
	return 0;
}
