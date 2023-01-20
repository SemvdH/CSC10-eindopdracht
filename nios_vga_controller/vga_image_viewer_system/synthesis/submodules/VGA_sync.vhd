LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY VGA_sync IS
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
END ENTITY VGA_sync;

ARCHITECTURE implementation OF VGA_sync IS

    SIGNAL clk25 : STD_LOGIC := '0';

    SIGNAL hPos : unsigned(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vPos : unsigned(9 DOWNTO 0) := (OTHERS => '0');

    SIGNAL hs : STD_LOGIC := '0'; -- register to account for pixel data delay
    SIGNAL vs : STD_LOGIC := '0'; -- register to account for pixel data delay
    SIGNAL de : STD_LOGIC := '0'; -- register for blank delay

BEGIN

    -- outputs
    SYNC <= '0';
    VCLK <= clk25;

    clk_div : PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            clk25 <= NOT clk25;
        END IF;
    END PROCESS;

    Horizontal_position_counter : PROCESS (clk25, RST)
    BEGIN
        IF (RST = '0') THEN
            hpos <= (OTHERS => '0');
        ELSIF (rising_edge(clk25)) THEN
            IF (hPos = (HD + HFP + HSP + HBP - 1)) THEN
                hPos <= (OTHERS => '0');
            ELSE
                hPos <= hPos + 1;
            END IF;
        END IF;
    END PROCESS;

    Vertical_position_counter : PROCESS (clk25, RST)
    BEGIN
        IF (RST = '0') THEN
            vPos <= (OTHERS => '0');
        ELSIF (rising_edge(clk25)) THEN
            IF (hPos = (HD + HFP + HSP + HBP - 1)) THEN
                IF (vPos = (VD + VFP + VSP + VBP - 1)) THEN
                    vPos <= (OTHERS => '0');
                ELSE
                    vPos <= vPos + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    Horizontal_Synchronisation : PROCESS (clk25, RST)
    BEGIN
        IF (RST = '0') THEN
            hs <= '0';
            HSYNC <= '0';
        ELSIF (rising_edge(clk25)) THEN
            IF ((hPos >= (HD + HFP)) AND (hPos < HD + HFP + HSP)) THEN
                hs <= '0';
            ELSE
                hs <= '1';
            END IF;
            HSYNC <= hs; -- delay one clock to account for pixel data delay
        END IF;
    END PROCESS;

    Vertical_Synchronisation : PROCESS (clk25, RST)
    BEGIN
        IF (RST = '0') THEN
            vs <= '0';
            VSYNC <= '0';
        ELSIF (rising_edge(clk25)) THEN
            IF ((vPos >= (VD + VFP)) AND (vPos < VD + VFP + VSP)) THEN
                vs <= '0';
            ELSE
                vs <= '1';
            END IF;
            VSYNC <= vs; -- delay one clock to account for pixel data delay
        END IF;
    END PROCESS;

    blanking : PROCESS (clk25, RST)
    BEGIN
        IF (RST = '0') THEN
            de <= '0';
            BLANK <= '0';
        ELSIF (rising_edge(clk25)) THEN
            IF (hPos < HD AND vPos < VD) THEN
                de <= '1';
            ELSE
                de <= '0';
            END IF;
            BLANK <= de; -- delay one clock to align with pixel data
        END IF;
    END PROCESS;

    pixel_x <= STD_LOGIC_VECTOR(hPos);
    pixel_y <= STD_LOGIC_VECTOR(vPos);

END;