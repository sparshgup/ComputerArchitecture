`default_nettype none

module srl(in, shamt, out);

parameter N=32;

input wire [N-1:0] in;
input wire [$clog2(N)-1:0] shamt;
output wire [N-1:0] out;

mux32 #(.N(N)) MUX_SRL (
    .in0(in[N-1:0]), 
    .in1({1'b0, in[N-1:1]}), 
    .in2({2'b0, in[N-1:2]}), 
    .in3({3'b0, in[N-1:3]}), 
    .in4({4'b0, in[N-1:4]}), 
    .in5({5'b0, in[N-1:5]}), 
    .in6({6'b0, in[N-1:6]}), 
    .in7({7'b0, in[N-1:7]}), 
    .in8({8'b0, in[N-1:8]}),
    .in9({9'b0, in[N-1:9]}), 
    .in10({10'b0, in[N-1:10]}), 
    .in11({11'b0, in[N-1:11]}), 
    .in12({12'b0, in[N-1:12]}), 
    .in13({13'b0, in[N-1:13]}), 
    .in14({14'b0, in[N-1:14]}), 
    .in15({15'b0, in[N-1:15]}), 
    .in16({16'b0, in[N-1:16]}),
    .in17({17'b0, in[N-1:17]}), 
    .in18({18'b0, in[N-1:18]}), 
    .in19({19'b0, in[N-1:19]}), 
    .in20({20'b0, in[N-1:20]}), 
    .in21({21'b0, in[N-1:21]}), 
    .in22({22'b0, in[N-1:22]}), 
    .in23({23'b0, in[N-1:23]}), 
    .in24({24'b0, in[N-1:24]}),
    .in25({25'b0, in[N-1:25]}),
    .in26({26'b0, in[N-1:26]}), 
    .in27({27'b0, in[N-1:27]}), 
    .in28({28'b0, in[N-1:28]}), 
    .in29({29'b0, in[N-1:29]}), 
    .in30({30'b0, in[N-1:30]}), 
    .in31({31'b0, in[N-1:31]}),
    .s(shamt), 
    .out(out)
);

endmodule
