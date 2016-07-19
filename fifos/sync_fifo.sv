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

    // TODO: JOHN, use the ram.sv module for the memory for the fifo.

endmodule
