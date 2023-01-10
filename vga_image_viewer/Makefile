EXTRA_CFLAGS=-I$(PWD)
obj-m += driver.o

all:
	echo current path is $(PWD)
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
