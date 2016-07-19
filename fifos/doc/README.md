# fifos
Basic FIFO modules.

## `sync_fifo`
General purpose synchronous FIFO module.

### Parameter Summary
|Type   |Name         |Description                                                                                          |
|:------|:------------|:----------------------------------|
|`int`  |`FIFO_DEPTH` |FIFO depth in words.               |
|`int`  |`DATA_WIDTH` |Data (word) width of FIFO in bits. |

### Port Summary
|In/Out   |Type                             |Name           |Description        |
|:--------|:--------------------------------|:--------------|:------------------|
|`input`  |`logic`                          |`clk_i`        |Clock.             |
|`input`  |`logic`                          |`we_i`         |Write enable.      |
|`input`  |`logic [DATA_WIDTH-1:0]`         |`data_wr_a_i`  |Write data.        |
|`output` |`logic`                          |`full_o`       |Full flag.         |
|`input`  |`logic`                          |`re_i`         |Read enable.       |
|`output` |`logic [DATA_WIDTH-1:0]`         |`data_o`       |Read data.         |
|`output` |`logic`                          |`empty_o`      |Empty flag.        |
|`output` |`logic [$clog2(FIFO_DEPTH)-1:0]` |`count_o`      |Port B write data. |
