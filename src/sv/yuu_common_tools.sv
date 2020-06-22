/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_TOOLS_SV
`define YUU_COMMON_TOOLS_SV

// Utilities class
class yuu_common_tools;
  static function boolean is_byte_align(int width, bit[7:0] addr, ref bit[7:0] addr_aligned);
    bit[7:0] byte_num = width/8;
    bit[7:0] tmp = addr<<(8-$clog2(byte_num));

    if (tmp != 0) begin
      `ifdef YUU_UVM
      `uvm_warning("is_byte_align", $sformatf("Address (0x%h) is not byte aligned while width is %0d", addr, width))
      `else
      $display("[Warning] %s", $sformatf("Address (0x%h) is not byte aligned while width is %0d", addr, width));
      `endif
      addr_aligned = addr;
      for (int i=0; i<$clog2(byte_num); i++)
        addr_aligned[i] = 1'b0;
      return False;
    end
    else begin
      addr_aligned = addr;
      return True;
    end
  endfunction
endclass

`endif