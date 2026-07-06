module wptr_full #(parameter ASIZE = 4)(
    output reg              wfull,
    output wire [ASIZE-1:0] waddr,
    output reg  [ASIZE:0]   wptr,
    input  wire [ASIZE:0]   wq2_rptr,
    input  wire             winc,
    input  wire             wclk,
    input  wire             wrst_n
);
    reg [ASIZE:0] wbin;
    reg [ASIZE:0] wbin_next;
    reg [ASIZE:0] wgray_next;

    assign waddr = wbin[ASIZE-1:0];

    always @(*) begin
        wbin_next  = wbin + (winc && !wfull);
        wgray_next = (wbin_next >> 1) ^ wbin_next;
    end

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wbin  <= {ASIZE+1{1'b0}};
            wptr  <= {ASIZE+1{1'b0}};
            wfull <= 1'b0;
        end else begin
            wbin  <= wbin_next;
            wptr  <= wgray_next;
            wfull <= (wgray_next == {~wq2_rptr[ASIZE:ASIZE-1], wq2_rptr[ASIZE-2:0]});
        end
    end
endmodule