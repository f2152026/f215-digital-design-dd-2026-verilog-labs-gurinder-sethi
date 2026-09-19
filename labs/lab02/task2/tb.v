// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and output
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  reg [7:0] expected_val;

  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT(
    .sel (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i;
  initial begin
    // TODO: apply different input combinations
    for(i = 0; i<8; i++) begin
      t_sel = i;
      expected_val = i*i;
      #5;
  end
  $finish;
end

  initial
    $monitor($time, " sel=%d | actual dout=%d | expected=%d", t_sel, t_dout, expected_val); // change as required

endmodule
