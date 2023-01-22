/*************************************************************************
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.      *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
**************************************************************************
* Description:                                                           *
* The following is a simple hello world program running MicroC/OS-II.The * 
* purpose of the design is to be a very simple application that just     *
* demonstrates MicroC/OS-II running on NIOS II.The design doesn't account*
* for issues such as checking system call return codes. etc.             *
*                                                                        *
* Requirements:                                                          *
*   -Supported Example Hardware Platforms                                *
*     Standard                                                           *
*     Full Featured                                                      *
*     Low Cost                                                           *
*   -Supported Development Boards                                        *
*     Nios II Development Board, Stratix II Edition                      *
*     Nios Development Board, Stratix Professional Edition               *
*     Nios Development Board, Stratix Edition                            *
*     Nios Development Board, Cyclone Edition                            *
*   -System Library Settings                                             *
*     RTOS Type - MicroC/OS-II                                           *
*     Periodic System Timer                                              *
*   -Know Issues                                                         *
*     If this design is run on the ISS, terminal output will take several*
*     minutes per iteration.                                             *
**************************************************************************/


#include <stdio.h>
#include <stdint.h>
#include <system.h>
#include <io.h>

#include "includes.h"

#include "image.h"

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       512
OS_STK    task1_stk[TASK_STACKSIZE];
OS_STK    task2_stk[TASK_STACKSIZE];

/* Definition of Task Priorities */

#define TASK1_PRIORITY      1
#define TASK2_PRIORITY      2

extern const unsigned char wallpapersden_com_forest_minimal_mountain_landscape_640x480[];

volatile int button_flag = 0;
int button_number = 0;
int zoom_amount = 1;

void button_interrupt(void* context)
{
	button_flag = 1;
}

/* Prints "Hello World" and sleeps for three seconds */
void task1(void* pdata)
{
  while (1)
  { 
	  // get current pixel
	  			uint32_t pixel_reg = IORD(VGA_IMAGE_VIEWER_0_BASE, 0x01);
	  			uint16_t pixel_y = pixel_reg & 0b00000000000000000000001111111111;
	  			uint16_t pixel_x = (pixel_reg & 0b00000000000011111111110000000000) >> 10;

	  			// resize
	  			pixel_y /= zoom_amount;
	  			pixel_x /= zoom_amount;

	  			// print image from array.
	  			if(pixel_y < 200 && pixel_x < 200)
	  			{
	  				uint32_t pixel = wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y * 200 + pixel_x) * 3)]
	  								  + (wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y * 200 + pixel_x) * 3) + 1] << 8)
	  								  + (wallpapersden_com_forest_minimal_mountain_landscape_640x480[((pixel_y * 200 + pixel_x) * 3) + 2] << 16);
	  				IOWR(VGA_IMAGE_VIEWER_0_BASE, 0, pixel);
	  			}
	  			else
	  				IOWR(VGA_IMAGE_VIEWER_0_BASE, 0, 0);
  }
}
/* Prints "Hello World" and sleeps for three seconds */
void task2(void* pdata)
{
  while (1)
  { 
    if(button_flag == 1)
    {
    	int button = IORD(PIO_0_BASE, 0x00);

    	printf("button %d pressed\n", button);
    	button_flag = 0;
    }
  }
}
/* The main function creates two task and starts multi-tasking */
int main(void)
{
	alt_ic_isr_register(PIO_0_IRQ_INTERRUPT_CONTROLLER_ID, PIO_0_IRQ, button_interrupt, NULL, 0);
	alt_ic_irq_enable(PIO_0_IRQ_INTERRUPT_CONTROLLER_ID, PIO_0_IRQ);



  OSTaskCreateExt(task1,
                  NULL,
                  (void *)&task1_stk[TASK_STACKSIZE-1],
                  TASK1_PRIORITY,
                  TASK1_PRIORITY,
                  task1_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);
              
               
  OSTaskCreateExt(task2,
                  NULL,
                  (void *)&task2_stk[TASK_STACKSIZE-1],
                  TASK2_PRIORITY,
                  TASK2_PRIORITY,
                  task2_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);
  OSStart();
  return 0;
}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
