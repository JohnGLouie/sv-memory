# rams
Basic RAM modules.

## `ram`
General purpose true dual-port RAM module.

### Parameter Summary
|Type   |Name         |Description                                                                                          |
|:------|:------------|:----------------------------------------------------------------------------------------------------|
|`int`  |`ADDR_WIDTH` |Address width of RAM in bits. Note that the number of words in the RAM is 2<sup>`ADDR_WIDTH`</sup>.  |
|`int`  |`DATA_WIDTH` |Data (word) width of RAM in bits.                                                                    |

### Port Summary
|In/Out   |Type                     |Name               |Description                    |
|:--------|:------------------------|:------------------|:------------------------------|
|`input`  |`logic`                  |`clk_a_i`          |Port A clock.                  |
|`input`  |`logic [ADDR_WIDTH-1:0]` |`addr_a_i`         |Port A address.                |
|`output` |`logic [DATA_WIDTH-1:0]` |`data_rd_a_o`      |Port A asynchronous read data. |
|`output` |`logic [DATA_WIDTH-1:0]` |`data_rd_a_reg_o`  |Port A synchronous read data.  |
|`input`  |`logic`                  |`we_a_i`           |Port A write enable.           |
|`input`  |`logic [DATA_WIDTH-1:0]` |`data_wr_a_i`      |Port A write data.             |
|`input`  |`logic`                  |`clk_b_i`          |Port B clock.                  |
|`input`  |`logic [ADDR_WIDTH-1:0]` |`addr_b_i`         |Port B address.                |
|`output` |`logic [DATA_WIDTH-1:0]` |`data_rd_b_o`      |Port B asynchronous read data. |
|`output` |`logic [DATA_WIDTH-1:0]` |`data_rd_b_reg_o`  |Port B synchronous read data.  |
|`input`  |`logic`                  |`we_b_i`           |Port B write enable.           |
|`input`  |`logic [DATA_WIDTH-1:0]` |`data_wr_b_i`      |Port B write data.             |
