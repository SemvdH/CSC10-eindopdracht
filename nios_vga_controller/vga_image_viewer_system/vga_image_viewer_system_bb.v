
module vga_image_viewer_system (
	clk_clk,
	reset_reset_n,
	vga_export_vclk,
	vga_export_hsync,
	vga_export_vsync,
	vga_export_blank,
	vga_export_sync,
	vga_export_r,
	vga_export_g,
	vga_export_b);	

	input		clk_clk;
	input		reset_reset_n;
	output		vga_export_vclk;
	output		vga_export_hsync;
	output		vga_export_vsync;
	output		vga_export_blank;
	output		vga_export_sync;
	output	[7:0]	vga_export_r;
	output	[7:0]	vga_export_g;
	output	[7:0]	vga_export_b;
endmodule
