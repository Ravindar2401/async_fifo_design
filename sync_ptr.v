module sync_ptr #(parameter ASIZE = 4)(
    input  wire           clk,
    input  wire           rst_n,
    input  wire [ASIZE:0] ptr_in,
    output reg  [ASIZE:0] ptr_out
);
    reg [ASIZE:0] sync1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync1   <= {ASIZE+1{1'b0}};
            ptr_out <= {ASIZE+1{1'b0}};
        end else begin
            sync1   <= ptr_in;
            ptr_out <= sync1;
        end
    end
endmodule