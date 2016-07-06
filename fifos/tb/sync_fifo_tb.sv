/*  Test Bench for General-purpose Synchronous FIFO
 *
 *  Description:
 *      Test bench for the general-purpose Synchronous FIFO module.
 *
 *  Synthesizable:
 *      No.
 *
 *  References:
 *      None.
 *
 *  Notes:
 *      None.
 *
 */

module sync_fifo_tb #(
        parameter int FIFO_DEPTH = 8,
        parameter int DATA_WIDTH = 8
    );

    logic clk;

    // Clock A generator.
    initial
        begin
        clk = 0;
        forever #10ns clk = !clk;
    end

endmodule
