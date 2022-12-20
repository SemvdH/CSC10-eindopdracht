
module VGA_image_viewer (
	clk_clk,
	pixel_data_export,
	pixel_status_export);	

	input		clk_clk;
	input	[31:0]	pixel_data_export;
	input	[31:0]	pixel_status_export;
endmodule
