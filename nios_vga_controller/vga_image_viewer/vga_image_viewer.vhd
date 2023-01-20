LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY vga_image_viewer IS
    PORT (
        csi_clock, rsi_resetn : IN STD_LOGIC;
        read, write, chipselect, address : IN STD_LOGIC;
        writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        coe_vclk, coe_hsync, coe_vsync, coe_blank, coe_sync : OUT STD_LOGIC;
        coe_r, coe_g, coe_b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END vga_image_viewer;

ARCHITECTURE rtl OF vga_image_viewer IS

    -- Constants
    CONSTANT HD : INTEGER := 640;
    CONSTANT HFP : INTEGER := 16;
    CONSTANT HSP : INTEGER := 96;
    CONSTANT HBP : INTEGER := 48;

    CONSTANT VD : INTEGER := 480;
    CONSTANT VFP : INTEGER := 10;
    CONSTANT VSP : INTEGER := 2;
    CONSTANT VBP : INTEGER := 33;

    COMPONENT vga_sync
        GENERIC (
            HD : INTEGER := 640; --  640   Horizontal Display (640)
            HFP : INTEGER := 16; --   16   Right border (front porch)
            HSP : INTEGER := 96; --   96   Sync pulse (Retrace)
            HBP : INTEGER := 48; --   48   Left boarder (back porch)

            VD : INTEGER := 480; --  480   Vertical Display (480)
            VFP : INTEGER := 10; --   10   Right border (front porch)
            VSP : INTEGER := 2; --    2   Sync pulse (Retrace)
            VBP : INTEGER := 33 --   33   Left boarder (back porch)
        );
        PORT (
            CLK, RST : IN STD_LOGIC;
            VCLK, HSYNC, VSYNC, BLANK, SYNC : OUT STD_LOGIC;
            pixel_x, pixel_y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL local_pixel_x_s, local_pixel_y_s : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL local_vclk_s, local_hsync_s, local_vsync_s, local_blank_s, local_sync_s : STD_LOGIC;

    SIGNAL local_r_s, local_g_s, local_b_s : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    --------------------------------------------------------------------------------------------

    COMPONENT reg32 IS
        PORT (
            clock, resetn : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END component reg32;

    SIGNAL local_to_rgb_reg_s, local_from_rgb_reg_s : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL local_rgb_reg_byte_enable_s : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    SIGNAL local_to_pixel_reg_s, local_from_pixel_reg_s : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL local_pixel_reg_byteenable_s : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');


BEGIN

    pm_reg32 : reg32 PORT MAP(
        clock => csi_clock,
        resetn => rsi_resetn,
        D => local_to_rgb_reg_s,
        byteenable => local_rgb_reg_byte_enable_s,
        Q => local_from_rgb_reg_s
    );

    pm_reg32_2 : reg32 PORT MAP(
        clock => csi_clock,
        resetn => rsi_resetn,
        D => local_to_pixel_reg_s,
        byteenable => local_pixel_reg_byteenable_s,
        Q => local_from_pixel_reg_s
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
        CLK => csi_clock,
        RST => rsi_resetn,
        VCLK => local_vclk_s,
        HSYNC => local_hsync_s,
        VSYNC => local_vsync_s,
        BLANK => local_blank_s,
        SYNC => local_sync_s,
        pixel_x => local_pixel_x_s,
        pixel_y => local_pixel_y_s
    );

    WITH (chipselect AND write AND NOT address) SELECT
    local_rgb_reg_byte_enable_s <= byteenable WHEN '1', "0000" WHEN OTHERS;

    local_to_rgb_reg_s <= writedata;

    local_pixel_reg_byteenable_s <= "1111";
    local_to_pixel_reg_s <= "000000000000" & local_pixel_x_s & local_pixel_y_s WHEN read = '0';

    readdata <= local_from_rgb_reg_s WHEN address = '0' AND read = '1' ELSE local_from_pixel_reg_s;

    --------------------------------------------------------------------------------------------

    local_r_s <= local_from_rgb_reg_s(7 DOWNTO 0);
    local_g_s <= local_from_rgb_reg_s(15 DOWNTO 8);
    local_b_s <= local_from_rgb_reg_s(23 DOWNTO 16);
    
    coe_vclk <= local_vclk_s;
    coe_hsync <= local_hsync_s;
    coe_vsync <= local_vsync_s;
    coe_blank <= local_blank_s;
    coe_sync <= local_sync_s;
    
    render : PROCESS (local_vclk_s)
    BEGIN
        IF (rising_edge(local_vclk_s)) THEN
            IF (local_blank_s = '1') THEN
                coe_r <= local_r_s;
                coe_g <= local_g_s;
                coe_b <= local_b_s;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;