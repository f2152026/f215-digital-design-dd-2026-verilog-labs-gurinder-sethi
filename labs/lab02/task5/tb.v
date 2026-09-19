module tb;

    reg [3:0] t_a;
    reg [3:0] t_b;
    reg t_op;
    wire [3:0] t_result;
    reg [3:0] exp_result;
    integer i, j, k;
    integer errors;
    integer total_tests;

    alu DUT(
        .a (t_a),
        .b (t_b),
        .op (t_op),
        .result (t_result)
    );

    string vcd_file;
    initial begin
        if($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    initial begin
        
        errors = 0;
        total_tests = 0;
        for(i=0; i<16; i++) begin
            for(j=0; j<16; j++) begin
                for(k=0; k<2; k++) begin
                    t_a = i;
                    t_b = j;
                    t_op = k;
                    #5;

                    if(t_op == 0) begin
                        exp_result = t_a + t_b;
                    end else begin
                        exp_result = t_a - t_b;
                    end
                    total_tests++;
                    if(t_result !== exp_result) begin
                        $display("FAIL: a=%d b=%d op=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
                        errors++;
                    end
                end
            end
        end

        if(errors == 0) begin
            $display("SUCCESS: All %0d test cases passed.", total_tests);
        end else begin
            $display("FAILED: %0d out of %0d test cases failed.", errors, total_tests);
        end
        $finish;
    end
endmodule