#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <system.h>
#include <io.h>
#include <image.h>

extern const unsigned char wallpapersden_com_forest_minimal_mountain_landscape_640x480[];

int main(void)
{
		while (1)
		{
			// get current pixel
			uint32_t pixel_reg = IORD(VGA_IMAGE_VIEWER_0_BASE, 0x01);
			uint16_t pixel_y = pixel_reg & 0b00000000000000000000001111111111;
			uint16_t pixel_x = (pixel_reg & 0b00000000000011111111110000000000) >> 10;

			// resize
			pixel_y /= 2;
			pixel_x /= 2;

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

