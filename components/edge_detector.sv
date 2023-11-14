module edge_detector(clk, rst, in, positive_edge, negative_edge);

input wire clk, rst, in;
output logic positive_edge, negative_edge;

logic d, q;

always_ff @(posedge clk or posedge rst) begin : edge_detector_ff
    q <= d;
end

always_comb begin : edge_detector
    d = in & ~rst;
    positive_edge = d & ~q;
    negative_edge = q & ~d;
end

endmodule
