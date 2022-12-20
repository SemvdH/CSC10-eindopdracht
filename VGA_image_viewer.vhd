LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY VGA_image_viewer IS
    PORT (
        extern_clk : IN STD_LOGIC;
        VCLK, HSYNC, VSYNC, BLANK, SYNC : OUT STD_LOGIC;
        R, G, B : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
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
        memory_oct_rzqin : IN STD_LOGIC := 'X'; -- oct_rzqin]
        reset_reset_n : IN STD_LOGIC := 'X' -- reset_n
    );
END ENTITY VGA_image_viewer;

ARCHITECTURE rtl OF VGA_image_viewer IS

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
    SIGNAL pixel_data_s : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL pixel_status_s : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL pixel_tick : STD_LOGIC := '0'; -- tick for when to render a pixel
    SIGNAL pm_blank : STD_LOGIC := '0'; -- blank signal for pixel memory
    SIGNAL pixel_x, pixel_y : STD_LOGIC_VECTOR(9 DOWNTO 0); -- pixel x and y coordinates
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
            pixel_data_export : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- export
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
            reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
            pixel_status_export : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X') -- export
        );
    END COMPONENT VGA_image_viewer;
BEGIN

    u0 : COMPONENT VGA_image_viewer
        PORT MAP(
            clk_clk => clk_clk, --          clk.clk
            hps_io_hps_io_emac1_inst_TX_CLK => hps_io_hps_io_emac1_inst_TX_CLK, --       hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 => hps_io_hps_io_emac1_inst_TXD0, --             .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 => hps_io_hps_io_emac1_inst_TXD1, --             .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 => hps_io_hps_io_emac1_inst_TXD2, --             .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 => hps_io_hps_io_emac1_inst_TXD3, --             .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 => hps_io_hps_io_emac1_inst_RXD0, --             .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO => hps_io_hps_io_emac1_inst_MDIO, --             .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC => hps_io_hps_io_emac1_inst_MDC, --             .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_io_hps_io_emac1_inst_RX_CTL, --             .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_io_hps_io_emac1_inst_TX_CTL, --             .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_io_hps_io_emac1_inst_RX_CLK, --             .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 => hps_io_hps_io_emac1_inst_RXD1, --             .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 => hps_io_hps_io_emac1_inst_RXD2, --             .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 => hps_io_hps_io_emac1_inst_RXD3, --             .hps_io_emac1_inst_RXD3
            hps_io_hps_io_qspi_inst_IO0 => hps_io_hps_io_qspi_inst_IO0, --             .hps_io_qspi_inst_IO0
            hps_io_hps_io_qspi_inst_IO1 => hps_io_hps_io_qspi_inst_IO1, --             .hps_io_qspi_inst_IO1
            hps_io_hps_io_qspi_inst_IO2 => hps_io_hps_io_qspi_inst_IO2, --             .hps_io_qspi_inst_IO2
            hps_io_hps_io_qspi_inst_IO3 => hps_io_hps_io_qspi_inst_IO3, --             .hps_io_qspi_inst_IO3
            hps_io_hps_io_qspi_inst_SS0 => hps_io_hps_io_qspi_inst_SS0, --             .hps_io_qspi_inst_SS0
            hps_io_hps_io_qspi_inst_CLK => hps_io_hps_io_qspi_inst_CLK, --             .hps_io_qspi_inst_CLK
            hps_io_hps_io_sdio_inst_CMD => hps_io_hps_io_sdio_inst_CMD, --             .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 => hps_io_hps_io_sdio_inst_D0, --             .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 => hps_io_hps_io_sdio_inst_D1, --             .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK => hps_io_hps_io_sdio_inst_CLK, --             .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 => hps_io_hps_io_sdio_inst_D2, --             .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 => hps_io_hps_io_sdio_inst_D3, --             .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 => hps_io_hps_io_usb1_inst_D0, --             .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 => hps_io_hps_io_usb1_inst_D1, --             .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 => hps_io_hps_io_usb1_inst_D2, --             .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 => hps_io_hps_io_usb1_inst_D3, --             .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 => hps_io_hps_io_usb1_inst_D4, --             .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 => hps_io_hps_io_usb1_inst_D5, --             .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 => hps_io_hps_io_usb1_inst_D6, --             .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 => hps_io_hps_io_usb1_inst_D7, --             .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK => hps_io_hps_io_usb1_inst_CLK, --             .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP => hps_io_hps_io_usb1_inst_STP, --             .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR => hps_io_hps_io_usb1_inst_DIR, --             .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT => hps_io_hps_io_usb1_inst_NXT, --             .hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK => hps_io_hps_io_spim1_inst_CLK, --             .hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI => hps_io_hps_io_spim1_inst_MOSI, --             .hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO => hps_io_hps_io_spim1_inst_MISO, --             .hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 => hps_io_hps_io_spim1_inst_SS0, --             .hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX => hps_io_hps_io_uart0_inst_RX, --             .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX => hps_io_hps_io_uart0_inst_TX, --             .hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA => hps_io_hps_io_i2c0_inst_SDA, --             .hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL => hps_io_hps_io_i2c0_inst_SCL, --             .hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA => hps_io_hps_io_i2c1_inst_SDA, --             .hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL => hps_io_hps_io_i2c1_inst_SCL, --             .hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO53 => hps_io_hps_io_gpio_inst_GPIO53, --             .hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54 => hps_io_hps_io_gpio_inst_GPIO54, --             .hps_io_gpio_inst_GPIO54
            pixel_data_export => pixel_data_s, --   pixel_data.export
            memory_mem_a => memory_mem_a, --       memory.mem_a
            memory_mem_ba => memory_mem_ba, --             .mem_ba
            memory_mem_ck => memory_mem_ck, --             .mem_ck
            memory_mem_ck_n => memory_mem_ck_n, --             .mem_ck_n
            memory_mem_cke => memory_mem_cke, --             .mem_cke
            memory_mem_cs_n => memory_mem_cs_n, --             .mem_cs_n
            memory_mem_ras_n => memory_mem_ras_n, --             .mem_ras_n
            memory_mem_cas_n => memory_mem_cas_n, --             .mem_cas_n
            memory_mem_we_n => memory_mem_we_n, --             .mem_we_n
            memory_mem_reset_n => memory_mem_reset_n, --             .mem_reset_n
            memory_mem_dq => memory_mem_dq, --             .mem_dq
            memory_mem_dqs => memory_mem_dqs, --             .mem_dqs
            memory_mem_dqs_n => memory_mem_dqs_n, --             .mem_dqs_n
            memory_mem_odt => memory_mem_odt, --             .mem_odt
            memory_mem_dm => memory_mem_dm, --             .mem_dm
            memory_oct_rzqin => memory_oct_rzqin, --             .oct_rzqin
            reset_reset_n => reset_reset_n, --        reset.reset_n
            pixel_status_export => pixel_status_s -- pixel_status.export
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
            CLK => extern_clk,
            RST => reset_reset_n,
            VCLK => extern_clk,
            HSYNC => HSYNC,
            VSYNC => VSYNC,
            BLANK => pm_blank,
            SYNC => SYNC,
            pixel_x => pixel_x,
            pixel_y => pixel_y
        );

        render : PROCESS (pixel_tick)
        BEGIN
            IF (rising_edge(pixel_tick)) THEN
                IF (pm_blank = '1') THEN
                    R <= pixel_data_s(7 DOWNTO 0); -- add all objects with or.
                    G <= pixel_data_s(15 DOWNTO 8);
                    B <= pixel_data_s(23 DOWNTO 16);
                END IF;
            END IF;
        END PROCESS;
    END ARCHITECTURE;