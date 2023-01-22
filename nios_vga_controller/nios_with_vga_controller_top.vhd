LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY nios_with_vga_controller_top IS
    PORT (
        clk_clk : IN STD_LOGIC := 'X'; -- clk
        reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
        vga_vclk : OUT STD_LOGIC; -- export_vclk
        vga_hsync : OUT STD_LOGIC; -- export_hsync
        vga_vsync : OUT STD_LOGIC; -- export_vsync
        vga_blank : OUT STD_LOGIC; -- export_blank
        vga_sync : OUT STD_LOGIC; -- export_sync
        vga_r : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_r
        vga_g : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_g
        vga_b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_b
        key : IN STD_LOGIC_VECTOR(3 DOWNTO 0) -- export
    );
END nios_with_vga_controller_top;

ARCHITECTURE rtl OF nios_with_vga_controller_top IS

    COMPONENT vga_image_viewer_system IS
        PORT (
            clk_clk : IN STD_LOGIC := 'X'; -- clk
            reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
            vga_export_vclk : OUT STD_LOGIC; -- export_vclk
            vga_export_hsync : OUT STD_LOGIC; -- export_hsync
            vga_export_vsync : OUT STD_LOGIC; -- export_vsync
            vga_export_blank : OUT STD_LOGIC; -- export_blank
            vga_export_sync : OUT STD_LOGIC; -- export_sync
            vga_export_r : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_r
            vga_export_g : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_g
            vga_export_b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- export_b
            key_export : IN STD_LOGIC_VECTOR(3 DOWNTO 0) -- export
        );
    END COMPONENT vga_image_viewer_system;

BEGIN

    u0 : COMPONENT vga_image_viewer_system
        PORT MAP(
            clk_clk => clk_clk,
            reset_reset_n => reset_reset_n,
            vga_export_vclk => vga_vclk,
            vga_export_hsync => vga_hsync,
            vga_export_vsync => vga_vsync,
            vga_export_blank => vga_blank,
            vga_export_sync => vga_sync,
            vga_export_r => vga_r,
            vga_export_g => vga_g,
            vga_export_b => vga_b,
            key_export => key
        );

    END ARCHITECTURE;