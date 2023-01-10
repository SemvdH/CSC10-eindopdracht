#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>

#define HW_REGS_BASE ( 0xff200000 )
#define HW_REGS_SPAN ( 0x00200000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define PIXEL_DATA_BASE ( 0x000000030 )
#define PIXEL_STATUS_WRITE_BASE (0x000000020)
#define PIXEL_STATUS_READ_BASE ( 0x000000010 )
#define PIXEL_ROW_BASE ( 0x000000000  )

#define HWREG(x) (*((volatile uint32_t *)(x)))

int main(void) {

        volatile unsigned int *h2p_pixel_addr=NULL;
        void *virtual_base;
        int fd;

        // Open /dev/mem
        if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
                        printf( "ERROR: could not open \"/dev/mem\"...\n" );
                        return( 1 );
        }

        // Hiermee koppelen we het fysieke geheugen aan het virtuele geheugen
        // en krijgen we de pointer terug
        virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ),
                                                MAP_SHARED, fd, HW_REGS_BASE );
        if( virtual_base == MAP_FAILED ) {
                printf( "ERROR: mmap() failed...\n" );
                close( fd );
                return(1);
        }

	for (int i = 0; i < 0xFFFFFF; i++) {
		HWREG(virtual_base + PIXEL_DATA_BASE) = i;
	}

//	HWREG(virtual_base + PIXEL_DATA_BASE) = 0xFF00FF;

//	HWREG(virtual_base + PIXEL_STATUS_WRITE_BASE) = 1;

	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
                printf( "ERROR: munmap() failed...\n" );
                close( fd );
                return( 1 );
        }

        close( fd );
	return 0;
}
