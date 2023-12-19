`default_nettype none

module sra(in,shamt,out);

parameter N=32;

input wire [N-1:0] in;
input wire [$clog2(N)-1:0] shamt;
output wire [N-1:0] out;

mux32 #(.N(1)) mux0 (
	.in0(in[31]),
	.in1(in[31]),
	.in2(in[31]),
	.in3(in[31]),
	.in4(in[31]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[31])
);

mux32 #(.N(1)) mux1 (
	.in0(in[30]),
	.in1(in[31]),
	.in2(in[31]),
	.in3(in[31]),
	.in4(in[31]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[30])
);

mux32 #(.N(1)) mux2 (
	.in0(in[29]),
	.in1(in[30]),
	.in2(in[31]),
	.in3(in[31]),
	.in4(in[31]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[29])
);

mux32 #(.N(1)) mux3 (
	.in0(in[28]),
	.in1(in[29]),
	.in2(in[30]),
	.in3(in[31]),
	.in4(in[31]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[28])
);

mux32 #(.N(1)) mux4 (
	.in0(in[27]),
	.in1(in[28]),
	.in2(in[29]),
	.in3(in[30]),
	.in4(in[31]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[27])
);

mux32 #(.N(1)) mux5 (
	.in0(in[26]),
	.in1(in[27]),
	.in2(in[28]),
	.in3(in[29]),
	.in4(in[30]),
	.in5(in[31]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[26])
);

mux32 #(.N(1)) mux6 (
	.in0(in[25]),
	.in1(in[26]),
	.in2(in[27]),
	.in3(in[28]),
	.in4(in[29]),
	.in5(in[30]),
	.in6(in[31]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[25])
);

mux32 #(.N(1)) mux7 (
	.in0(in[24]),
	.in1(in[25]),
	.in2(in[26]),
	.in3(in[27]),
	.in4(in[28]),
	.in5(in[29]),
	.in6(in[30]),
	.in7(in[31]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[24])
);

mux32 #(.N(1)) mux8 (
	.in0(in[23]),
	.in1(in[24]),
	.in2(in[25]),
	.in3(in[26]),
	.in4(in[27]),
	.in5(in[28]),
	.in6(in[29]),
	.in7(in[30]),
	.in8(in[31]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[23])
);

mux32 #(.N(1)) mux9 (
	.in0(in[22]),
	.in1(in[23]),
	.in2(in[24]),
	.in3(in[25]),
	.in4(in[26]),
	.in5(in[27]),
	.in6(in[28]),
	.in7(in[29]),
	.in8(in[30]),
	.in9(in[31]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[22])
);

mux32 #(.N(1)) mux10 (
	.in0(in[21]),
	.in1(in[22]),
	.in2(in[23]),
	.in3(in[24]),
	.in4(in[25]),
	.in5(in[26]),
	.in6(in[27]),
	.in7(in[28]),
	.in8(in[29]),
	.in9(in[30]),
	.in10(in[31]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[21])
);

mux32 #(.N(1)) mux11 (
	.in0(in[20]),
	.in1(in[21]),
	.in2(in[22]),
	.in3(in[23]),
	.in4(in[24]),
	.in5(in[25]),
	.in6(in[26]),
	.in7(in[27]),
	.in8(in[28]),
	.in9(in[29]),
	.in10(in[30]),
	.in11(in[31]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[20])
);

mux32 #(.N(1)) mux12 (
	.in0(in[19]),
	.in1(in[20]),
	.in2(in[21]),
	.in3(in[22]),
	.in4(in[23]),
	.in5(in[24]),
	.in6(in[25]),
	.in7(in[26]),
	.in8(in[27]),
	.in9(in[28]),
	.in10(in[29]),
	.in11(in[30]),
	.in12(in[31]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[19])
);

mux32 #(.N(1)) mux13 (
	.in0(in[18]),
	.in1(in[19]),
	.in2(in[20]),
	.in3(in[21]),
	.in4(in[22]),
	.in5(in[23]),
	.in6(in[24]),
	.in7(in[25]),
	.in8(in[26]),
	.in9(in[27]),
	.in10(in[28]),
	.in11(in[29]),
	.in12(in[30]),
	.in13(in[31]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[18])
);

mux32 #(.N(1)) mux14 (
	.in0(in[17]),
	.in1(in[18]),
	.in2(in[19]),
	.in3(in[20]),
	.in4(in[21]),
	.in5(in[22]),
	.in6(in[23]),
	.in7(in[24]),
	.in8(in[25]),
	.in9(in[26]),
	.in10(in[27]),
	.in11(in[28]),
	.in12(in[29]),
	.in13(in[30]),
	.in14(in[31]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[17])
);

mux32 #(.N(1)) mux15 (
	.in0(in[16]),
	.in1(in[17]),
	.in2(in[18]),
	.in3(in[19]),
	.in4(in[20]),
	.in5(in[21]),
	.in6(in[22]),
	.in7(in[23]),
	.in8(in[24]),
	.in9(in[25]),
	.in10(in[26]),
	.in11(in[27]),
	.in12(in[28]),
	.in13(in[29]),
	.in14(in[30]),
	.in15(in[31]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[16])
);

mux32 #(.N(1)) mux16 (
	.in0(in[15]),
	.in1(in[16]),
	.in2(in[17]),
	.in3(in[18]),
	.in4(in[19]),
	.in5(in[20]),
	.in6(in[21]),
	.in7(in[22]),
	.in8(in[23]),
	.in9(in[24]),
	.in10(in[25]),
	.in11(in[26]),
	.in12(in[27]),
	.in13(in[28]),
	.in14(in[29]),
	.in15(in[30]),
	.in16(in[31]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[15])
);

mux32 #(.N(1)) mux17 (
	.in0(in[14]),
	.in1(in[15]),
	.in2(in[16]),
	.in3(in[17]),
	.in4(in[18]),
	.in5(in[19]),
	.in6(in[20]),
	.in7(in[21]),
	.in8(in[22]),
	.in9(in[23]),
	.in10(in[24]),
	.in11(in[25]),
	.in12(in[26]),
	.in13(in[27]),
	.in14(in[28]),
	.in15(in[29]),
	.in16(in[30]),
	.in17(in[31]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[14])
);

mux32 #(.N(1)) mux18 (
	.in0(in[13]),
	.in1(in[14]),
	.in2(in[15]),
	.in3(in[16]),
	.in4(in[17]),
	.in5(in[18]),
	.in6(in[19]),
	.in7(in[20]),
	.in8(in[21]),
	.in9(in[22]),
	.in10(in[23]),
	.in11(in[24]),
	.in12(in[25]),
	.in13(in[26]),
	.in14(in[27]),
	.in15(in[28]),
	.in16(in[29]),
	.in17(in[30]),
	.in18(in[31]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[13])
);

mux32 #(.N(1)) mux19 (
	.in0(in[12]),
	.in1(in[13]),
	.in2(in[14]),
	.in3(in[15]),
	.in4(in[16]),
	.in5(in[17]),
	.in6(in[18]),
	.in7(in[19]),
	.in8(in[20]),
	.in9(in[21]),
	.in10(in[22]),
	.in11(in[23]),
	.in12(in[24]),
	.in13(in[25]),
	.in14(in[26]),
	.in15(in[27]),
	.in16(in[28]),
	.in17(in[29]),
	.in18(in[30]),
	.in19(in[31]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[12])
);

mux32 #(.N(1)) mux20 (
	.in0(in[11]),
	.in1(in[12]),
	.in2(in[13]),
	.in3(in[14]),
	.in4(in[15]),
	.in5(in[16]),
	.in6(in[17]),
	.in7(in[18]),
	.in8(in[19]),
	.in9(in[20]),
	.in10(in[21]),
	.in11(in[22]),
	.in12(in[23]),
	.in13(in[24]),
	.in14(in[25]),
	.in15(in[26]),
	.in16(in[27]),
	.in17(in[28]),
	.in18(in[29]),
	.in19(in[30]),
	.in20(in[31]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[11])
);

mux32 #(.N(1)) mux21 (
	.in0(in[10]),
	.in1(in[11]),
	.in2(in[12]),
	.in3(in[13]),
	.in4(in[14]),
	.in5(in[15]),
	.in6(in[16]),
	.in7(in[17]),
	.in8(in[18]),
	.in9(in[19]),
	.in10(in[20]),
	.in11(in[21]),
	.in12(in[22]),
	.in13(in[23]),
	.in14(in[24]),
	.in15(in[25]),
	.in16(in[26]),
	.in17(in[27]),
	.in18(in[28]),
	.in19(in[29]),
	.in20(in[30]),
	.in21(in[31]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[10])
);

mux32 #(.N(1)) mux22 (
	.in0(in[9]),
	.in1(in[10]),
	.in2(in[11]),
	.in3(in[12]),
	.in4(in[13]),
	.in5(in[14]),
	.in6(in[15]),
	.in7(in[16]),
	.in8(in[17]),
	.in9(in[18]),
	.in10(in[19]),
	.in11(in[20]),
	.in12(in[21]),
	.in13(in[22]),
	.in14(in[23]),
	.in15(in[24]),
	.in16(in[25]),
	.in17(in[26]),
	.in18(in[27]),
	.in19(in[28]),
	.in20(in[29]),
	.in21(in[30]),
	.in22(in[31]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[9])
);

mux32 #(.N(1)) mux23 (
	.in0(in[8]),
	.in1(in[9]),
	.in2(in[10]),
	.in3(in[11]),
	.in4(in[12]),
	.in5(in[13]),
	.in6(in[14]),
	.in7(in[15]),
	.in8(in[16]),
	.in9(in[17]),
	.in10(in[18]),
	.in11(in[19]),
	.in12(in[20]),
	.in13(in[21]),
	.in14(in[22]),
	.in15(in[23]),
	.in16(in[24]),
	.in17(in[25]),
	.in18(in[26]),
	.in19(in[27]),
	.in20(in[28]),
	.in21(in[29]),
	.in22(in[30]),
	.in23(in[31]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[8])
);

mux32 #(.N(1)) mux24 (
	.in0(in[7]),
	.in1(in[8]),
	.in2(in[9]),
	.in3(in[10]),
	.in4(in[11]),
	.in5(in[12]),
	.in6(in[13]),
	.in7(in[14]),
	.in8(in[15]),
	.in9(in[16]),
	.in10(in[17]),
	.in11(in[18]),
	.in12(in[19]),
	.in13(in[20]),
	.in14(in[21]),
	.in15(in[22]),
	.in16(in[23]),
	.in17(in[24]),
	.in18(in[25]),
	.in19(in[26]),
	.in20(in[27]),
	.in21(in[28]),
	.in22(in[29]),
	.in23(in[30]),
	.in24(in[31]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[7])
);

mux32 #(.N(1)) mux25 (
	.in0(in[6]),
	.in1(in[7]),
	.in2(in[8]),
	.in3(in[9]),
	.in4(in[10]),
	.in5(in[11]),
	.in6(in[12]),
	.in7(in[13]),
	.in8(in[14]),
	.in9(in[15]),
	.in10(in[16]),
	.in11(in[17]),
	.in12(in[18]),
	.in13(in[19]),
	.in14(in[20]),
	.in15(in[21]),
	.in16(in[22]),
	.in17(in[23]),
	.in18(in[24]),
	.in19(in[25]),
	.in20(in[26]),
	.in21(in[27]),
	.in22(in[28]),
	.in23(in[29]),
	.in24(in[30]),
	.in25(in[31]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[6])
);

mux32 #(.N(1)) mux26 (
	.in0(in[5]),
	.in1(in[6]),
	.in2(in[7]),
	.in3(in[8]),
	.in4(in[9]),
	.in5(in[10]),
	.in6(in[11]),
	.in7(in[12]),
	.in8(in[13]),
	.in9(in[14]),
	.in10(in[15]),
	.in11(in[16]),
	.in12(in[17]),
	.in13(in[18]),
	.in14(in[19]),
	.in15(in[20]),
	.in16(in[21]),
	.in17(in[22]),
	.in18(in[23]),
	.in19(in[24]),
	.in20(in[25]),
	.in21(in[26]),
	.in22(in[27]),
	.in23(in[28]),
	.in24(in[29]),
	.in25(in[30]),
	.in26(in[31]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[5])
);

mux32 #(.N(1)) mux27 (
	.in0(in[4]),
	.in1(in[5]),
	.in2(in[6]),
	.in3(in[7]),
	.in4(in[8]),
	.in5(in[9]),
	.in6(in[10]),
	.in7(in[11]),
	.in8(in[12]),
	.in9(in[13]),
	.in10(in[14]),
	.in11(in[15]),
	.in12(in[16]),
	.in13(in[17]),
	.in14(in[18]),
	.in15(in[19]),
	.in16(in[20]),
	.in17(in[21]),
	.in18(in[22]),
	.in19(in[23]),
	.in20(in[24]),
	.in21(in[25]),
	.in22(in[26]),
	.in23(in[27]),
	.in24(in[28]),
	.in25(in[29]),
	.in26(in[30]),
	.in27(in[31]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[4])
);

mux32 #(.N(1)) mux28 (
	.in0(in[3]),
	.in1(in[4]),
	.in2(in[5]),
	.in3(in[6]),
	.in4(in[7]),
	.in5(in[8]),
	.in6(in[9]),
	.in7(in[10]),
	.in8(in[11]),
	.in9(in[12]),
	.in10(in[13]),
	.in11(in[14]),
	.in12(in[15]),
	.in13(in[16]),
	.in14(in[17]),
	.in15(in[18]),
	.in16(in[19]),
	.in17(in[20]),
	.in18(in[21]),
	.in19(in[22]),
	.in20(in[23]),
	.in21(in[24]),
	.in22(in[25]),
	.in23(in[26]),
	.in24(in[27]),
	.in25(in[28]),
	.in26(in[29]),
	.in27(in[30]),
	.in28(in[31]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[3])
);

mux32 #(.N(1)) mux29 (
	.in0(in[2]),
	.in1(in[3]),
	.in2(in[4]),
	.in3(in[5]),
	.in4(in[6]),
	.in5(in[7]),
	.in6(in[8]),
	.in7(in[9]),
	.in8(in[10]),
	.in9(in[11]),
	.in10(in[12]),
	.in11(in[13]),
	.in12(in[14]),
	.in13(in[15]),
	.in14(in[16]),
	.in15(in[17]),
	.in16(in[18]),
	.in17(in[19]),
	.in18(in[20]),
	.in19(in[21]),
	.in20(in[22]),
	.in21(in[23]),
	.in22(in[24]),
	.in23(in[25]),
	.in24(in[26]),
	.in25(in[27]),
	.in26(in[28]),
	.in27(in[29]),
	.in28(in[30]),
	.in29(in[31]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[2])
);

mux32 #(.N(1)) mux30 (
	.in0(in[1]),
	.in1(in[2]),
	.in2(in[3]),
	.in3(in[4]),
	.in4(in[5]),
	.in5(in[6]),
	.in6(in[7]),
	.in7(in[8]),
	.in8(in[9]),
	.in9(in[10]),
	.in10(in[11]),
	.in11(in[12]),
	.in12(in[13]),
	.in13(in[14]),
	.in14(in[15]),
	.in15(in[16]),
	.in16(in[17]),
	.in17(in[18]),
	.in18(in[19]),
	.in19(in[20]),
	.in20(in[21]),
	.in21(in[22]),
	.in22(in[23]),
	.in23(in[24]),
	.in24(in[25]),
	.in25(in[26]),
	.in26(in[27]),
	.in27(in[28]),
	.in28(in[29]),
	.in29(in[30]),
	.in30(in[31]),
	.in31(in[31]),
	.s(shamt),
	.out(out[1])
);

mux32 #(.N(1)) mux31 (
	.in0(in[0]),
	.in1(in[1]),
	.in2(in[2]),
	.in3(in[3]),
	.in4(in[4]),
	.in5(in[5]),
	.in6(in[6]),
	.in7(in[7]),
	.in8(in[8]),
	.in9(in[9]),
	.in10(in[10]),
	.in11(in[11]),
	.in12(in[12]),
	.in13(in[13]),
	.in14(in[14]),
	.in15(in[15]),
	.in16(in[16]),
	.in17(in[17]),
	.in18(in[18]),
	.in19(in[19]),
	.in20(in[20]),
	.in21(in[21]),
	.in22(in[22]),
	.in23(in[23]),
	.in24(in[24]),
	.in25(in[25]),
	.in26(in[26]),
	.in27(in[27]),
	.in28(in[28]),
	.in29(in[29]),
	.in30(in[30]),
	.in31(in[31]),
	.s(shamt),
	.out(out[0])
);

endmodule