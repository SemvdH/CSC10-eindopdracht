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

void pad_with_zeros(char* imgdata, char* newimgdata) {
	for (int i = 0; i < sizeof(imgdata)/sizeof(imgdata[0]); i+= 4) {
		newimgdata[i] = imgdata[i];
		newimgdata[i+1] = imgdata[i+1];
		newimgdata[i+2] = imgdata[i+2];
		newimgdata[i+3] = 0;
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
	unsigned char *paddedImage = (unsigned char*) malloc(480*640*4);

	pad_with_zeros(bitmapData,paddedImage);

	free(bitmapData);


	//printf("Image data:\n");

	print_raw_bmp(bitmapData);
	return 0;
}
