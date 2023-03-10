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
	FILE* destFile = fopen("/dev/vga_image_viewer","wb");
	if (destFile == NULL){
		printf("could not open the bird\n");
		return -1;
	}
	FILE* justbirb = fopen("birb","wb");
	BITMAPINFOHEADER bitmapInfoHeader;
	unsigned char *bitmapData;

	bitmapData = LoadBitmapFile("bird.bmp",&bitmapInfoHeader);
	//printf("bird loaded\n");

	if (bitmapData == NULL)
	{
		printf("Shit, the bird bmp could not be read\n");
		return -1;
	}

	fwrite(bitmapData,8,480*640*3,justbirb);
	fclose(justbirb);

	unsigned char *paddedImage = (unsigned char*) malloc(480*640*4);

	//printf("padding that shit\n");
	pad_with_zeros(bitmapData,paddedImage);
	//printf("the bird is fat\n" );

	print_raw_bmp(bitmapData);

	free(bitmapData);

	int bytesWritten = fwrite(paddedImage,8,480*640*4,destFile);

	//printf("Image data:\n");
	//printf("Wrote %d bytes\n",bytesWritten);

	fclose(destFile);
	return 0;
}
