#include <stdio.h>
#include "readbmp.h"

void print_raw_bmp(char* imgdata) {
	char* p = &imgdata[0];
	while(*p != '\0') {
		//process the current char
		printf("%d",*p);
		++p;  //you can increment pointers without assigning an address to them
	}
}

int main()
{
	BITMAPINFOHEADER bitmapInfoHeader;
	unsigned char *bitmapData;

	bitmapData = LoadBitmapFile("bird.bmp",&bitmapInfoHeader);

	if (bitmapData == NULL)
	{
		printf("Shit");
	}


	printf("Image data:\n");

	print_raw_bmp(bitmapData);
	return 0;
}
