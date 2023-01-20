#!/bin/bash

cd /home/student/CSC10-eindopdracht/vga_image_viewer
make clean && make all
sudo insmod driver.ko
cd readbmp
./gcc.sh
./readbmp > /dev/vga_img_viewer
