module async_fifo #(parameter DSIZE = 8, parameter ASIZE = 4)(
    input  wire             wclk,
    input  wire             wrst_n,
    input  wire             winc,
    input  wire [DSIZE-1:0] wdata,
    output wire             wfull,

    input  wire             rclk,
    input  wire             rrst_n,
    input  wire             rinc,
    output wire [DSIZE-1:0] rdata,
    output wire             rempty
);
    wire [ASIZE-1:0] waddr, raddr;
    wire [ASIZE:0]   wptr, rptr;
    wire [ASIZE:0]   wq2_rptr, rq2_wptr;

    sync_ptr #(ASIZE) u_sync_r2w (
        .clk    (wclk),
        .rst_n  (wrst_n),
        .ptr_in (rptr),
        .ptr_out(wq2_rptr)
    );

    sync_ptr #(ASIZE) u_sync_w2r (
        .clk    (rclk),
        .rst_n  (rrst_n),
        .ptr_in (wptr),
        .ptr_out(rq2_wptr)
    );

    wptr_full #(ASIZE) u_wptr_full (
        .wfull  (wfull),
        .waddr  (waddr),
        .wptr   (wptr),
        .wq2_rptr(wq2_rptr),
        .winc   (winc),
        .wclk   (wclk),
        .wrst_n (wrst_n)
    );

    rptr_empty #(ASIZE) u_rptr_empty (
        .rempty (rempty),
        .raddr  (raddr),
        .rptr   (rptr),
        .rq2_wptr(rq2_wptr),
        .rinc   (rinc),
        .rclk   (rclk),
        .rrst_n (rrst_n)
    );

    fifo_mem #(DSIZE, ASIZE) u_fifo_mem (
        .wclk  (wclk),
        .wclken(winc),
        .wfull (wfull),
        .wdata (wdata),
        .waddr (waddr),
        .raddr (raddr),
        .rclk  (rclk),
        .rinc  (rinc),
        .rempty(rempty),
        .rrst_n(rrst_n),
        .rdata (rdata)
    );
endmodule