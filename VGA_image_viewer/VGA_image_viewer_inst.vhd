	component VGA_image_viewer is
		port (
			clk_clk       : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component VGA_image_viewer;

	u0 : component VGA_image_viewer
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n  -- reset.reset_n
		);

