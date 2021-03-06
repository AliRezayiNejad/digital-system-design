module dff(input clk,reset,d,output reg q);
  always @(posedge clk or negedge reset)begin
    if(!reset)q=0;
    else q=d;
  end
endmodule
  

module detector1000(input clk,reset,x,output q);
  wire Da,Db,Dc;
  wire A,B,C;
  wire [4:0]l;
  and u0(Da,~A,B,C,~x);
  and u1(l[0],~A,B,~C,~x);
  and u2(l[1],~A,~B,C,~x);
  or (Db,l[0],l[1]);
  and u3(l[2],~A,x);
  and u4(l[3],~A,B,~C);
  and u5(l[4],~B,~C,x);
  or u6(Dc,l[2],l[3],l[4]);
  and u7(q,A,~B,~C);
  dff u8(clk,reset,Da,A);
  dff u9(clk,reset,Db,B);
  dff u10(clk,reset,Dc,C);
endmodule

module detector1000_tester;
reg  reset,clk,x;
wire q;
always@(clk)$monitor("%b",q);
initial repeat(40)#50 clk=~clk;
initial begin
clk=0;
reset=0;
x=0;
#100 reset=1;
#200 x=1;
#200 x=0;
#300 x=1;
end
detector1000 uut(clk,reset,x,q);

endmodule


