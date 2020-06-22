/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_ADDR_MAP_SV
`define YUU_COMMON_ADDR_MAP_SV

`ifdef YUU_UVM
class yuu_common_addr_map extends uvm_object;
`else
class yuu_common_addr_map;
`endif
  protected yuu_common_addr_t high;
  protected yuu_common_addr_t low;

  `ifdef YUU_UVM
  `uvm_object_utils_begin(yuu_common_addr_map)
    `uvm_field_int(high, UVM_DEFAULT)
    `uvm_field_int(low, UVM_DEFAULT)
  `uvm_object_utils_end
  `endif

  function new(string name="yuu_common_addr_map");
    `ifdef YUU_UVM
    super.new(name);
    `endif
  endfunction

  function void set_map(yuu_common_addr_t low, yuu_common_addr_t high);
    if (low > high) begin
      `ifdef YUU_UVM
      `uvm_fatal("set_map", $sformatf("Low address(0x%0h) exceeds the high boundary(0x%0h) is forbidden", low, high))
      `else
      $display("[Fatal] Low address(0x%0h) exceeds the high boundary(0x%0h) is forbidden", low, high);
      return;
      `endif
    end
    this.high = high;
    this.low  = low;
  endfunction

  function yuu_common_addr_t get_low();
    return this.low;
  endfunction

  function yuu_common_addr_t get_high();
    return this.high;
  endfunction

  function boolean is_contain(yuu_common_addr_t addr);
    if (addr inside {[low:high]})
      return True;
    else
      return False;
  endfunction
endclass

`endif
