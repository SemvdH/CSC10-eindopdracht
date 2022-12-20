	component VGA_image_viewer is
		port (
			clk_clk             : in std_logic                     := 'X';             -- clk
			pixel_data_export   : in std_logic_vector(31 downto 0) := (others => 'X'); -- export
			pixel_status_export : in std_logic_vector(31 downto 0) := (others => 'X')  -- export
		);
	end component VGA_image_viewer;

	u0 : component VGA_image_viewer
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --          clk.clk
			pixel_data_export   => CONNECTED_TO_pixel_data_export,   --   pixel_data.export
			pixel_status_export => CONNECTED_TO_pixel_status_export  -- pixel_status.export
		);

