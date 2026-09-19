module tb;

    reg [1:0] t_a;
    reg [1:0] t_b;
    wire t_gt;
    wire t_lt;
    wire t_eq;
    reg exp_gt;
    reg exp_lt;
    reg exp_eq;
    integer errors;
    integer total_tests;
    integer i, j;

    comp2 DUT(
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
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

        for(i=0; i<4; i++) begin
            for(j=0; j<4; j++) begin
                t_a = i;
                t_b = j;
                #5;
                exp_gt = (t_a > t_b);
                exp_lt = (t_a < t_b);
                exp_eq = (t_a == t_b);
                total_tests++;

                if({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
                    $display("FAIL at time %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b", $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
                    errors++;
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
