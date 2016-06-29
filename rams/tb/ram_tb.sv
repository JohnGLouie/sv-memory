/*  Test Bench for General-purpose RAM Module
 *
 *  Description:
 *      Test bench for the general-purpose RAM module.
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

module ram_tb #(
        parameter int ADDR_WIDTH = 8,
        parameter int DATA_WIDTH = 8
    );

    logic clk_a;
    logic [ADDR_WIDTH-1:0] addr_a;
    logic [DATA_WIDTH-1:0] data_rd_a;
    logic [DATA_WIDTH-1:0] data_rd_a_reg;
    logic we_a;
    logic [DATA_WIDTH-1:0] data_wr_a;

    logic clk_b;
    logic [ADDR_WIDTH-1:0] addr_b;
    logic [DATA_WIDTH-1:0] data_rd_b;
    logic [DATA_WIDTH-1:0] data_rd_b_reg;
    logic we_b;
    logic [DATA_WIDTH-1:0] data_wr_b;

    logic port_a_done = 0;
    logic port_b_done = 0;

    // Clock A generator.
    initial
        begin
        clk_a = 0;
        forever #10ns clk_a = !clk_a;
    end

    // Clock B generator.
    initial
        begin
        clk_b = 0;
        forever #10ns clk_b = !clk_b;
    end

    initial
        begin
        // Wait a clock edge to let things settle.
        @(negedge clk_a);

        for (int i = 0; i < 2**ADDR_WIDTH; i++)
            begin
            // Write only to even addresses.
            if (i % 2 == 0)
                begin
                // Write i to addr i
                addr_a = i;
                data_wr_a = i;
                we_a = 1;
                @(negedge clk_a);
            end
        end

        we_a = 0;

        for (int i = 0; i < 2**ADDR_WIDTH; i++)
            begin
            // Read only from odd addresses.
            if (i % 2 == 1)
                begin
                // Read addr i
                addr_a = i;
                @(negedge clk_a);
                assert (data_rd_a == i) else $error("Read data on port A incorrect.");
            end
        end

        port_a_done = 1;
        $stop;
    end

    initial
        begin
        // Wait a few clock edges to let things settle and for writes to start.
        @(negedge clk_b);

        for (int i = 0; i < 2**ADDR_WIDTH; i++)
            begin
            // Write only to odd addresses.
            if (i % 2 == 1)
                begin
                // Write i to addr i
                addr_b = i;
                data_wr_b = i;
                we_b = 1;
                @(negedge clk_b);
            end
        end

        we_b = 0;

        for (int i = 0; i < 2**ADDR_WIDTH; i++)
            begin
            // Read only from even addresses.
            if (i % 2 == 0)
                begin
                // Read addr i
                addr_b = i;
                @(negedge clk_b);
                assert (data_rd_b == i) else $error("Read data on port B incorrect.");
            end
        end

        port_b_done = 1;
        $stop;
    end

    initial
        begin
        if (port_b_done && port_b_done)
            begin
            $stop;
        end
    end

    ram #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    )
    uut (
        .clk_a_i(clk_a),
        .addr_a_i(addr_a),
        .data_rd_a_o(data_rd_a),
        .data_rd_a_reg_o(data_rd_a_reg),
        .we_a_i(we_a),
        .data_wr_a_i(data_wr_a),

        .clk_b_i(clk_b),
        .addr_b_i(addr_b),
        .data_rd_b_o(data_rd_b),
        .data_rd_b_reg_o(data_rd_b_reg),
        .we_b_i(we_b),
        .data_wr_b_i(data_wr_b)
    );

endmodule
