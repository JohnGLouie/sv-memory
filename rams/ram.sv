/*  General-purpose RAM Module
 *
 *  Description:
 *      A general-purpose true-two port RAM module for FPGA synthesis.
 *
 *  Synthesizable:
 *      Yes.
 *
 *  References:
 *      1) http://www.xilinx.com/support/documentation/white_papers/wp231.pdf
 *      2) http://www.xilinx.com/support/documentation/user_guides/ug474_7Series_CLB.pdf
 *      3) http://www.xilinx.com/support/documentation/user_guides/ug473_7Series_Memory_Resources.pdf
 *      4) https://www.altera.com/en_US/pdfs/literature/hb/cyclone-iv/cyiv-51003.pdf
 *      5) https://danstrother.com/2010/09/11/inferring-rams-in-fpgas/
 *      6) http://www.dilloneng.com/inferring-block-ram-vs-distributed-ram-in-xst-and-precision.html#/
 *
 *  Notes:
 *      None.
 *
 */

module ram #(
        parameter int ADDR_WIDTH = -1,  // Address width in bits.
        parameter int DATA_WIDTH = -1   // Data width in bits.
        // TODO: parameter OP_MODE = -1
    )
    (
        // Port A
        input clk_a_i,                                  // Clock A
        input [ADDR_WIDTH-1:0] addr_a_i,                // Address A
        output logic [DATA_WIDTH-1:0] data_rd_a_o,      // Async read (output) data A
        output logic [DATA_WIDTH-1:0] data_rd_a_reg_o,  // Sync read (output) data A
        input we_a_i,                                   // Write enable A
        input [DATA_WIDTH-1:0] data_wr_a_i,             // Write (input) data A

        // Port B
        input clk_b_i,                                  // Clock B
        input [ADDR_WIDTH-1:0] addr_b_i,                // Address B
        output logic [DATA_WIDTH-1:0] data_rd_b_o,      // Async read (output) data B
        output logic [DATA_WIDTH-1:0] data_rd_b_reg_o,  // Sync read (output) data B
        input we_b_i,                                   // Write enable B
        input [DATA_WIDTH-1:0] data_wr_b_i              // Write (input) data B
    );

    logic [DATA_WIDTH-1:0] data_array [0:(2**ADDR_WIDTH)-1];

    logic [DATA_WIDTH-1:0] data_a_read;
    logic [DATA_WIDTH-1:0] data_b_read;

    // Async reads.
    assign data_rd_a_o = data_array[addr_a_i];
    assign data_rd_b_o = data_array[addr_b_i];

    always_ff@(posedge clk_a_i)
        begin
        // If port a write-enabled, perform write.
        if (we_a_i)
            begin
            data_array[addr_a_i] <= data_wr_a_i;
        end

        // TODO: update to allow different opmodes
        // Sync reads.
        data_rd_a_reg_o <= data_rd_a_o;
    end

    always_ff@(posedge clk_b_i)
        begin
        // If port b write-enabled, perform write.
        if (we_b_i)
            begin
            data_array[addr_b_i] <= data_wr_b_i;
        end

        // TODO: update to allow different opmodes
        // Sync reads.
        data_rd_b_reg_o <= data_rd_b_o;
    end

endmodule // ram
