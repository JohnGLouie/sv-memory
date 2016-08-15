/*  General-purpose Synchronous FIFO
 *
 *  Description:
 *      A general-purpose Synchronous FIFO.
 *
 *  Synthesizable:
 *      Yes.
 *
 *  Notes:
 *      None.
 *
 */

module sync_fifo #(
        parameter int FIFO_DEPTH = -1,  // Depth of the fifo in elements.
        parameter int DATA_WIDTH = -1   // Data width in bits.
        // TODO: add almost empty and almost full values.
    )
    (
        input clk_i,
        input rst,

        input we_i,
        input [DATA_WIDTH-1:0] data_i,
        output logic full_o,

        input re_i,
        output logic [DATA_WIDTH-1:0] data_o,
        output logic empty_o,

        output logic [$clog2(FIFO_DEPTH):0] count_o

        // TODO: add almost empty and almost full flags.
    )

    localparam int ADDR_WIDTH = $clog2(FIFO_DEPTH);     // Address width for RAM.
    													// Personal Note for John: $clog is built in function, Log base 2 of (x)

    // TODO: JOHN, use the ram.sv module for the memory for the fifo.

	logic [ADDR_WIDTH - 1:0] w_pointer;
	logic [ADDR_WIDTH - 1:0] r_pointer;
	logic [DATA_WIDTH - 1:0] ram_data; 

    assign full_o = (count_o == (ADDR_WIDTH - 1));
    assign empty_o = (count_o == 0);

    always_ff@(posedge clk_i)
    	begin : Write_Pointer
    	if (rst) begin
            w_pointer <= 0;
        end else if (we_i) begin
    		w_pointer <= w_pointer + 1;
    	end
    end

    always_ff@(posedge clk_i)
    	begin : Read_Pointer
    	if (rst) begin
            data_o <= 0;
            r_pointer <= 0;
        end else if (re_i) begin
    		data_o <= ram_data;
    		r_pointer <= r_pointer + 1;
    	end
    end

    always_ff @ (posedge clk_i)
    	begin : Status_Counter
    	//Read but no write
    	if (rst) begin
            count_o = 0;
        end else if ((re_i) &&  !(we_i) && (count_o !=0)) begin
    		count_o <= count_o - 1;
    	end
    	else if ((we_i) && (re_i) && (count_o)) begin
    		count_o <= count_o + 1;
    	end
    end

    ram #(ADDR_WIDTH, DATA_WIDTH) ram(
        .addr_a_i           ((w_pointer & we_i) | (r_pointer & re_i)),
        .data_rd_a_reg_o    (ram_data),
        .data_rd_a_o        (ram_data)
	);


endmodule
