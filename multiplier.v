//*****Booth multiplier*****
module multiplier(p,a,b);
	input[3:0] a;
	input[3:0] b;
	output[7:0] p;
	reg[7:0] s1,s2,s3,s4;
	reg[7:0] p;
	always @(*) begin
		if ({a[0],1'b0}==2'b00) s1=8'b00000000;
		else if ({a[0],1'b0}==2'b01) s1={4'b0000,b};
		else if ({a[0],1'b0}==2'b10) begin
			if (b==4'b0000) s1=8'b00000000;
			else s1={4'b1111,~b+4'b0001};
		end
		else if ({a[0],1'b0}==2'b11) s1={4'b0000,4'b0000};
	end
	always @(*) begin
		if ({a[1],a[0]}==2'b00) s2=8'b00000000;
		else if ({a[1],a[0]}==2'b01) s2={3'b000,b,1'b0};
		else if ({a[1],a[0]}==2'b10) begin
			if (b==4'b0000) s2=8'b00000000;
			else s2={3'b111,~b+4'b0001,1'b0};
		end
		else if ({a[1],a[0]}==2'b11) s2={4'b0000,4'b0000};
	end
	always @(*) begin
		if ({a[2],a[1]}==2'b00) s3=8'b00000000;
		else if ({a[2],a[1]}==2'b01) s3={2'b00,b,2'b00};
		else if ({a[2],a[1]}==2'b10) begin
			if (b==4'b0000) s3=8'b00000000;
			else s3={2'b11,~b+4'b0001,2'b00};
		end
		else if ({a[2],a[1]}==2'b11) s3={4'b0000,4'b0000};
	end
	always @(*) begin
		if ({a[3],a[2]}==2'b00) s4=8'b00000000;
		else if ({a[3],a[2]}==2'b01) s4={1'b0,b,3'b000};
		else if ({a[3],a[2]}==2'b10) begin
			if (b==4'b000) s4=8'b00000000;
			else s4={1'b1,~b+4'b0001,3'b000};
		end
		else if ({a[3],a[2]}==2'b11) s4={4'b0000,4'b0000};
	end
	always @(*) begin
		p=s1+s2+s3+s4;
		
	end

endmodule

module tb_multiplier();
	reg signed[3:0] a;
	reg signed[3:0] b;
	wire signed[7:0] p;
multiplier U1(.a(a),.b(b),.p(p));
integer i;
integer j;
integer count;
initial count =0;
initial begin
	for (i=-8;i<=7;i=i+1) begin
		for (j=0;j<=15;j=j+1) begin
			a=i;
			b=j;
			#10;
			if (i*j==p) count=count+1;
			else $display("Error : %4d x %4d = %4d",a,b,p);
			#90;
		end
	end
	$display("success = %4d , errors = %4d",count,count-256);
	$finish;
end
initial begin
	$dumpfile("database.vcd");
	$dumpvars(0,tb_multiplier);
end
//always @(*) $display("%4d x %4d = %4d",a,b,p);
endmodule



		
