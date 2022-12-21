LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY VGA_image_viewer_tl IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N : OUT STD_LOGIC;
        VGA_R, VGA_G, VGA_B : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        hps_io_hps_io_emac1_inst_TX_CLK : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CLK
        hps_io_hps_io_emac1_inst_TXD0 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD0
        hps_io_hps_io_emac1_inst_TXD1 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD1
        hps_io_hps_io_emac1_inst_TXD2 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD2
        hps_io_hps_io_emac1_inst_TXD3 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD3
        hps_io_hps_io_emac1_inst_RXD0 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD0
        hps_io_hps_io_emac1_inst_MDIO : INOUT STD_LOGIC := 'X'; -- hps_io_emac1_inst_MDIO
        hps_io_hps_io_emac1_inst_MDC : OUT STD_LOGIC; -- hps_io_emac1_inst_MDC
        hps_io_hps_io_emac1_inst_RX_CTL : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CTL
        hps_io_hps_io_emac1_inst_TX_CTL : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CTL
        hps_io_hps_io_emac1_inst_RX_CLK : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CLK
        hps_io_hps_io_emac1_inst_RXD1 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD1
        hps_io_hps_io_emac1_inst_RXD2 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD2
        hps_io_hps_io_emac1_inst_RXD3 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD3
        hps_io_hps_io_qspi_inst_IO0 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO0
        hps_io_hps_io_qspi_inst_IO1 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO1
        hps_io_hps_io_qspi_inst_IO2 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO2
        hps_io_hps_io_qspi_inst_IO3 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO3
        hps_io_hps_io_qspi_inst_SS0 : OUT STD_LOGIC; -- hps_io_qspi_inst_SS0
        hps_io_hps_io_qspi_inst_CLK : OUT STD_LOGIC; -- hps_io_qspi_inst_CLK
        hps_io_hps_io_sdio_inst_CMD : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_CMD
        hps_io_hps_io_sdio_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D0
        hps_io_hps_io_sdio_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D1
        hps_io_hps_io_sdio_inst_CLK : OUT STD_LOGIC; -- hps_io_sdio_inst_CLK
        hps_io_hps_io_sdio_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D2
        hps_io_hps_io_sdio_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D3
        hps_io_hps_io_usb1_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D0
        hps_io_hps_io_usb1_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D1
        hps_io_hps_io_usb1_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D2
        hps_io_hps_io_usb1_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D3
        hps_io_hps_io_usb1_inst_D4 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D4
        hps_io_hps_io_usb1_inst_D5 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D5
        hps_io_hps_io_usb1_inst_D6 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D6
        hps_io_hps_io_usb1_inst_D7 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D7
        hps_io_hps_io_usb1_inst_CLK : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_CLK
        hps_io_hps_io_usb1_inst_STP : OUT STD_LOGIC; -- hps_io_usb1_inst_STP
        hps_io_hps_io_usb1_inst_DIR : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_DIR
        hps_io_hps_io_usb1_inst_NXT : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_NXT
        hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
        hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
        hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
        hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
        hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
        hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
        hps_io_hps_io_i2c0_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SDA
        hps_io_hps_io_i2c0_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SCL
        hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
        hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
        hps_io_hps_io_gpio_inst_GPIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO53
        hps_io_hps_io_gpio_inst_GPIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO54
        memory_mem_a : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); -- mem_a
        memory_mem_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- mem_ba
        memory_mem_ck : OUT STD_LOGIC; -- mem_ck
        memory_mem_ck_n : OUT STD_LOGIC; -- mem_ck_n
        memory_mem_cke : OUT STD_LOGIC; -- mem_cke
        memory_mem_cs_n : OUT STD_LOGIC; -- mem_cs_n
        memory_mem_ras_n : OUT STD_LOGIC; -- mem_ras_n
        memory_mem_cas_n : OUT STD_LOGIC; -- mem_cas_n
        memory_mem_we_n : OUT STD_LOGIC; -- mem_we_n
        memory_mem_reset_n : OUT STD_LOGIC; -- mem_reset_n
        memory_mem_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- mem_dq
        memory_mem_dqs : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs
        memory_mem_dqs_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs_n
        memory_mem_odt : OUT STD_LOGIC; -- mem_odt
        memory_mem_dm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- mem_dm
        memory_oct_rzqin : IN STD_LOGIC := 'X'; -- oct_rzqin
        pixel_data_export : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); -- export
        pixel_status_write_export : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- export
        reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
        pixel_row_export : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => 'X'); -- export
        pixel_status_read_export : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- export
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0) -- reset_n
    );
END ENTITY VGA_image_viewer_tl;

ARCHITECTURE rtl OF VGA_image_viewer_tl IS

    -- Constants
    CONSTANT HD : INTEGER := 640;
    CONSTANT HFP : INTEGER := 16;
    CONSTANT HSP : INTEGER := 96;
    CONSTANT HBP : INTEGER := 48;

    CONSTANT VD : INTEGER := 480;
    CONSTANT VFP : INTEGER := 10;
    CONSTANT VSP : INTEGER := 2;
    CONSTANT VBP : INTEGER := 33;

    -- Signals
    SIGNAL pixel_data_s : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL pixel_status_write_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL pixel_status_read_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL pixel_row_s : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL pixel_tick : STD_LOGIC := '0'; -- tick for when to render a pixel
    SIGNAL pm_blank : STD_LOGIC := '0'; -- blank signal for pixel memory
    SIGNAL pixel_x, pixel_y : STD_LOGIC_VECTOR(9 DOWNTO 0); -- pixel x and y coordinates

    -- Registers for pixel memory
    SIGNAL row_reg_1_r, row_reg_1_g, row_reg_1_b : STD_LOGIC_VECTOR((HD - 1) * 8 DOWNTO 0);
    SIGNAL row_reg_2_r, row_reg_2_g, row_reg_2_b : STD_LOGIC_VECTOR((HD - 1) * 8 DOWNTO 0);
    COMPONENT VGA_sync
        GENERIC (
            HD : INTEGER := HD; --  640   Horizontal Display (640)
            HFP : INTEGER := HFP; --   16   Right border (front porch)
            HSP : INTEGER := HSP; --   96   Sync pulse (Retrace)
            HBP : INTEGER := HBP; --   48   Left boarder (back porch)

            VD : INTEGER := VD; --  480   Vertical Display (480)
            VFP : INTEGER := VFP; --   10   Right border (front porch)
            VSP : INTEGER := VSP; --    2   Sync pulse (Retrace)
            VBP : INTEGER := VBP --   33   Left boarder (back porch)
        );
        PORT (
            CLK, RST : IN STD_LOGIC;
            VCLK, HSYNC, VSYNC, BLANK, SYNC : OUT STD_LOGIC;
            pixel_x, pixel_y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT VGA_sync;
    COMPONENT VGA_image_viewer IS
        PORT (
            clk_clk : IN STD_LOGIC := 'X'; -- clk
            hps_io_hps_io_emac1_inst_TX_CLK : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO : INOUT STD_LOGIC := 'X'; -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC : OUT STD_LOGIC; -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_qspi_inst_IO0 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO0
            hps_io_hps_io_qspi_inst_IO1 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO1
            hps_io_hps_io_qspi_inst_IO2 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO2
            hps_io_hps_io_qspi_inst_IO3 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO3
            hps_io_hps_io_qspi_inst_SS0 : OUT STD_LOGIC; -- hps_io_qspi_inst_SS0
            hps_io_hps_io_qspi_inst_CLK : OUT STD_LOGIC; -- hps_io_qspi_inst_CLK
            hps_io_hps_io_sdio_inst_CMD : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK : OUT STD_LOGIC; -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP : OUT STD_LOGIC; -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO54
            memory_mem_a : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); -- mem_a
            memory_mem_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- mem_ba
            memory_mem_ck : OUT STD_LOGIC; -- mem_ck
            memory_mem_ck_n : OUT STD_LOGIC; -- mem_ck_n
            memory_mem_cke : OUT STD_LOGIC; -- mem_cke
            memory_mem_cs_n : OUT STD_LOGIC; -- mem_cs_n
            memory_mem_ras_n : OUT STD_LOGIC; -- mem_ras_n
            memory_mem_cas_n : OUT STD_LOGIC; -- mem_cas_n
            memory_mem_we_n : OUT STD_LOGIC; -- mem_we_n
            memory_mem_reset_n : OUT STD_LOGIC; -- mem_reset_n
            memory_mem_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- mem_dq
            memory_mem_dqs : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs
            memory_mem_dqs_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs_n
            memory_mem_odt : OUT STD_LOGIC; -- mem_odt
            memory_mem_dm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- mem_dm
            memory_oct_rzqin : IN STD_LOGIC := 'X'; -- oct_rzqin
            pixel_data_export : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); -- export
            pixel_status_write_export : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- export
            reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
            pixel_row_export : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => 'X'); -- export
            pixel_status_read_export : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X') -- export
        );
    END COMPONENT VGA_image_viewer;
BEGIN

    u0 : COMPONENT VGA_image_viewer
        PORT MAP(
            clk_clk => CLOCK_50, --          clk.clk
            hps_io_hps_io_emac1_inst_TX_CLK => hps_io_hps_io_emac1_inst_TX_CLK, --            hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 => hps_io_hps_io_emac1_inst_TXD0, --                  .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 => hps_io_hps_io_emac1_inst_TXD1, --                  .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 => hps_io_hps_io_emac1_inst_TXD2, --                  .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 => hps_io_hps_io_emac1_inst_TXD3, --                  .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 => hps_io_hps_io_emac1_inst_RXD0, --                  .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO => hps_io_hps_io_emac1_inst_MDIO, --                  .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC => hps_io_hps_io_emac1_inst_MDC, --                  .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_io_hps_io_emac1_inst_RX_CTL, --                  .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_io_hps_io_emac1_inst_TX_CTL, --                  .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_io_hps_io_emac1_inst_RX_CLK, --                  .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 => hps_io_hps_io_emac1_inst_RXD1, --                  .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 => hps_io_hps_io_emac1_inst_RXD2, --                  .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 => hps_io_hps_io_emac1_inst_RXD3, --                  .hps_io_emac1_inst_RXD3
            hps_io_hps_io_qspi_inst_IO0 => hps_io_hps_io_qspi_inst_IO0, --                  .hps_io_qspi_inst_IO0
            hps_io_hps_io_qspi_inst_IO1 => hps_io_hps_io_qspi_inst_IO1, --                  .hps_io_qspi_inst_IO1
            hps_io_hps_io_qspi_inst_IO2 => hps_io_hps_io_qspi_inst_IO2, --                  .hps_io_qspi_inst_IO2
            hps_io_hps_io_qspi_inst_IO3 => hps_io_hps_io_qspi_inst_IO3, --                  .hps_io_qspi_inst_IO3
            hps_io_hps_io_qspi_inst_SS0 => hps_io_hps_io_qspi_inst_SS0, --                  .hps_io_qspi_inst_SS0
            hps_io_hps_io_qspi_inst_CLK => hps_io_hps_io_qspi_inst_CLK, --                  .hps_io_qspi_inst_CLK
            hps_io_hps_io_sdio_inst_CMD => hps_io_hps_io_sdio_inst_CMD, --                  .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 => hps_io_hps_io_sdio_inst_D0, --                  .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 => hps_io_hps_io_sdio_inst_D1, --                  .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK => hps_io_hps_io_sdio_inst_CLK, --                  .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 => hps_io_hps_io_sdio_inst_D2, --                  .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 => hps_io_hps_io_sdio_inst_D3, --                  .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 => hps_io_hps_io_usb1_inst_D0, --                  .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 => hps_io_hps_io_usb1_inst_D1, --                  .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 => hps_io_hps_io_usb1_inst_D2, --                  .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 => hps_io_hps_io_usb1_inst_D3, --                  .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 => hps_io_hps_io_usb1_inst_D4, --                  .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 => hps_io_hps_io_usb1_inst_D5, --                  .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 => hps_io_hps_io_usb1_inst_D6, --                  .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 => hps_io_hps_io_usb1_inst_D7, --                  .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK => hps_io_hps_io_usb1_inst_CLK, --                  .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP => hps_io_hps_io_usb1_inst_STP, --                  .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR => hps_io_hps_io_usb1_inst_DIR, --                  .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT => hps_io_hps_io_usb1_inst_NXT, --                  .hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK => hps_io_hps_io_spim1_inst_CLK, --                  .hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI => hps_io_hps_io_spim1_inst_MOSI, --                  .hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO => hps_io_hps_io_spim1_inst_MISO, --                  .hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 => hps_io_hps_io_spim1_inst_SS0, --                  .hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX => hps_io_hps_io_uart0_inst_RX, --                  .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX => hps_io_hps_io_uart0_inst_TX, --                  .hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA => hps_io_hps_io_i2c0_inst_SDA, --                  .hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL => hps_io_hps_io_i2c0_inst_SCL, --                  .hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA => hps_io_hps_io_i2c1_inst_SDA, --                  .hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL => hps_io_hps_io_i2c1_inst_SCL, --                  .hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO53 => hps_io_hps_io_gpio_inst_GPIO53, --                  .hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54 => hps_io_hps_io_gpio_inst_GPIO54, --                  .hps_io_gpio_inst_GPIO54
            memory_mem_a => memory_mem_a, --            memory.mem_a
            memory_mem_ba => memory_mem_ba, --                  .mem_ba
            memory_mem_ck => memory_mem_ck, --                  .mem_ck
            memory_mem_ck_n => memory_mem_ck_n, --                  .mem_ck_n
            memory_mem_cke => memory_mem_cke, --                  .mem_cke
            memory_mem_cs_n => memory_mem_cs_n, --                  .mem_cs_n
            memory_mem_ras_n => memory_mem_ras_n, --                  .mem_ras_n
            memory_mem_cas_n => memory_mem_cas_n, --                  .mem_cas_n
            memory_mem_we_n => memory_mem_we_n, --                  .mem_we_n
            memory_mem_reset_n => memory_mem_reset_n, --                  .mem_reset_n
            memory_mem_dq => memory_mem_dq, --                  .mem_dq
            memory_mem_dqs => memory_mem_dqs, --                  .mem_dqs
            memory_mem_dqs_n => memory_mem_dqs_n, --                  .mem_dqs_n
            memory_mem_odt => memory_mem_odt, --                  .mem_odt
            memory_mem_dm => memory_mem_dm, --                  .mem_dm
            memory_oct_rzqin => memory_oct_rzqin, --                  .oct_rzqin
            pixel_data_export => pixel_data_s, --        pixel_data.export
            pixel_status_write_export => pixel_status_write_s, --      pixel_status.export
            reset_reset_n => KEY(0), --             reset.reset_n
            pixel_row_export => pixel_row_s, --         pixel_row.export
            pixel_status_read_export => pixel_status_read_s -- pixel_status_read.export
        );

        pm_VGA_sync : VGA_sync
        GENERIC MAP(
            HD => HD,
            HFP => HFP,
            HSP => HSP,
            HBP => HBP,
            VD => VD,
            VFP => VFP,
            VSP => VSP,
            VBP => VBP
        )
        PORT MAP(
            CLK => CLOCK_50,
            RST => KEY(0),
            VCLK => pixel_tick,
            HSYNC => VGA_HS,
            VSYNC => VGA_VS,
            BLANK => pm_blank,
            SYNC => VGA_SYNC_N,
            pixel_x => pixel_x,
            pixel_y => pixel_y
        );

        render : PROCESS (pixel_tick)
            VARIABLE prev_pixel_y : INTEGER := 0;
            VARIABLE pixel_x_v : INTEGER;
            VARIABLE pixel_y_v : INTEGER;
        BEGIN
            IF (rising_edge(pixel_tick)) THEN
                pixel_x_v := to_integer(unsigned(pixel_x));
                pixel_y_v := to_integer(unsigned(pixel_y));
                IF (pm_blank = '1') THEN
                    IF (to_integer(unsigned(pixel_y)) MOD 2 = 0) THEN
                        VGA_R <= row_reg_1_r((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8)); -- add all objects with or.
                        VGA_G <= row_reg_1_g((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8));
                        VGA_B <= row_reg_1_b((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8));
                        -- counter := counter + 1;
                    ELSE
                        VGA_R <= row_reg_2_r((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8)); -- add all objects with or.
                        VGA_G <= row_reg_2_g((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8));
                        VGA_B <= row_reg_2_b((pixel_x_v * 8) + 7 DOWNTO (pixel_x_v * 8));
                    END IF;
                END IF;
            END IF;
            IF (pixel_y_v = prev_pixel_y) THEN
                pixel_status_read_s <= "0000";
            ELSE
                pixel_status_read_s <= "0001";
                prev_pixel_y := pixel_y_v;
            END IF;

        END PROCESS;

        -- port map clock and blank
        VGA_CLK <= pixel_tick;
        VGA_BLANK_N <= pm_blank;

        draw_row_data : PROCESS (pixel_status_write_s)
            VARIABLE pixel_in_row_index : INTEGER RANGE 0 TO HD - 1; -- 0 to 639
        BEGIN
            IF (pixel_status_write_s = "0001") THEN
                IF (to_integer(unsigned(pixel_y)) MOD 2 = 1) THEN
                    row_reg_1_r((pixel_in_row_index * 8) + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(7 DOWNTO 0);
                    row_reg_1_g((pixel_in_row_index * 8) + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(15 DOWNTO 8);
                    row_reg_1_b((pixel_in_row_index * 8) + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(23 DOWNTO 16);
                ELSE
                    row_reg_2_r(pixel_in_row_index * 8 + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(7 DOWNTO 0);
                    row_reg_2_g(pixel_in_row_index * 8 + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(15 DOWNTO 8);
                    row_reg_2_b(pixel_in_row_index * 8 + 7 DOWNTO (pixel_in_row_index * 8)) <= pixel_data_s(23 DOWNTO 16);
                END IF;
                pixel_in_row_index := pixel_in_row_index + 1;
            END IF;
        END PROCESS;
        pixel_row_s <= std_logic_vector(resize(unsigned(pixel_y),16)); -- write vertical pos to row register
    END ARCHITECTURE;