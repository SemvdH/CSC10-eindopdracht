#include <stdio.h>

#include "jpeg.h"


int main()
{
	int width = 640;
	int height = 480;
	char *imgdata = loadjpeg("./bird.jpg",&width,&height);

	printf("imgdata %s \n",imgdata);

	return 0;
	
}
