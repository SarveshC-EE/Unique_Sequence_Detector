module RGB_NonOv(out,inp,clk,rst);

input inp,clk,rst;
output reg out;
parameter S0=3'b000,G=3'b001,B=3'b010,R=3'b011,GR=3'b100,GB=3'b101,BR=3'b110,RGB=3'b111;
parameter g=2'b00,b=2'b01,r=2'b10;
reg[2:0] pr_st,nx_st;

    always@(posedge clk) begin
    if(rst)
        pr_st <= S0;
    else
        pr_st <= nx_st;
    end

    always@(inp,pr_st) begin
    case(pr_st)
        S0: if(inp==g) nx_st=G;
            else if(inp==b) nx_st=B;
            else if(inp==r) nx_st=R;
        G: if(inp==b) nx_st=GB;
           else if(inp==r) nx_st=GR;
           else nx_st=S0;
        B: if(inp==g) nx_st=GB;
           else if(inp==r) nx_st=BR;
           else nx_st=S0;
        R: if(inp==g) nx_st=GR;
           else if(inp==b) nx_st=BR;
           else nx_st=S0;
        GR: nx_st=S0;
        GB: nx_st=S0;
        BR: nx_st=S0;
        default: nx_st=S0;
    endcase
    end
    
    always@(inp,pr_st) begin
    case(pr_st)
        S0: out=0;
        G: out=0;
        B: out=0;
        R: out=0;
        GR: if(inp==b) out=1;
            else out=0;
        GB: if(inp==r) out=1;
            else out=0;
        BR: if(inp==g) out=1;
            else out=0;
        default: out=0;
    endcase
    end
endmodule

