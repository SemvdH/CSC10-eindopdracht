	component vga_image_viewer_system is
		port (
			clk_clk          : in  std_logic                    := 'X';             -- clk
			key_export       : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			reset_reset_n    : in  std_logic                    := 'X';             -- reset_n
			vga_export_vclk  : out std_logic;                                       -- export_vclk
			vga_export_hsync : out std_logic;                                       -- export_hsync
			vga_export_vsync : out std_logic;                                       -- export_vsync
			vga_export_blank : out std_logic;                                       -- export_blank
			vga_export_sync  : out std_logic;                                       -- export_sync
			vga_export_r     : out std_logic_vector(7 downto 0);                    -- export_r
			vga_export_g     : out std_logic_vector(7 downto 0);                    -- export_g
			vga_export_b     : out std_logic_vector(7 downto 0)                     -- export_b
		);
	end component vga_image_viewer_system;

	u0 : component vga_image_viewer_system
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --   clk.clk
			key_export       => CONNECTED_TO_key_export,       --   key.export
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    -- reset.reset_n
			vga_export_vclk  => CONNECTED_TO_vga_export_vclk,  --   vga.export_vclk
			vga_export_hsync => CONNECTED_TO_vga_export_hsync, --      .export_hsync
			vga_export_vsync => CONNECTED_TO_vga_export_vsync, --      .export_vsync
			vga_export_blank => CONNECTED_TO_vga_export_blank, --      .export_blank
			vga_export_sync  => CONNECTED_TO_vga_export_sync,  --      .export_sync
			vga_export_r     => CONNECTED_TO_vga_export_r,     --      .export_r
			vga_export_g     => CONNECTED_TO_vga_export_g,     --      .export_g
			vga_export_b     => CONNECTED_TO_vga_export_b      --      .export_b
		);

