module fifo_mem #(parameter DSIZE = 8, parameter ASIZE = 4)(
    input  wire             wclk,
    input  wire             wclken,
    input  wire             wfull,
    input  wire [DSIZE-1:0] wdata,
    input  wire [ASIZE-1:0] waddr,
    input  wire [ASIZE-1:0] raddr,
    input  wire             rclk,
    input  wire             rinc,
    input  wire             rempty,
    input  wire             rrst_n,
    output reg  [DSIZE-1:0] rdata
);
    localparam DEPTH = (1 << ASIZE);
    reg [DSIZE-1:0] mem [0:DEPTH-1];

    always @(posedge wclk) begin
        if (wclken && !wfull)
            mem[waddr] <= wdata;
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n)
            rdata <= {DSIZE{1'b0}};
        else if (!rempty && rinc)
            rdata <= mem[raddr];
    end
endmodule