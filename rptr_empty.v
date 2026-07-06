module rptr_empty #(parameter ASIZE = 4)(
    output reg              rempty,
    output wire [ASIZE-1:0] raddr,
    output reg  [ASIZE:0]   rptr,
    input  wire [ASIZE:0]   rq2_wptr,
    input  wire             rinc,
    input  wire             rclk,
    input  wire             rrst_n
);
    reg [ASIZE:0] rbin;
    reg [ASIZE:0] rbin_next;
    reg [ASIZE:0] rgray_next;

    assign raddr = rbin[ASIZE-1:0];

    always @(*) begin
        rbin_next  = rbin + (rinc && !rempty);
        rgray_next = (rbin_next >> 1) ^ rbin_next;
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rbin   <= {ASIZE+1{1'b0}};
            rptr   <= {ASIZE+1{1'b0}};
            rempty <= 1'b1;
        end else begin
            rbin   <= rbin_next;
            rptr   <= rgray_next;
            rempty <= (rgray_next == rq2_wptr);
        end
    end
endmodule