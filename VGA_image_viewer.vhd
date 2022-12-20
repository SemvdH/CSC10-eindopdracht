LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY VGA_image_viewer IS
    PORT (
        clk_clk : IN STD_LOGIC := 'X'; -- clk
        pixel_data_export : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- export
        pixel_status_export : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X') -- export
    );
END ENTITY VGA_image_viewer;

ARCHITECTURE rtl OF VGA_image_viewer IS
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
BEGIN
END ARCHITECTURE;