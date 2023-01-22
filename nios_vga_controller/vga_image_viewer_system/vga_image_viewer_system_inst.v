	vga_image_viewer_system u0 (
		.clk_clk          (<connected-to-clk_clk>),          //   clk.clk
		.key_export       (<connected-to-key_export>),       //   key.export
		.reset_reset_n    (<connected-to-reset_reset_n>),    // reset.reset_n
		.vga_export_vclk  (<connected-to-vga_export_vclk>),  //   vga.export_vclk
		.vga_export_hsync (<connected-to-vga_export_hsync>), //      .export_hsync
		.vga_export_vsync (<connected-to-vga_export_vsync>), //      .export_vsync
		.vga_export_blank (<connected-to-vga_export_blank>), //      .export_blank
		.vga_export_sync  (<connected-to-vga_export_sync>),  //      .export_sync
		.vga_export_r     (<connected-to-vga_export_r>),     //      .export_r
		.vga_export_g     (<connected-to-vga_export_g>),     //      .export_g
		.vga_export_b     (<connected-to-vga_export_b>)      //      .export_b
	);

