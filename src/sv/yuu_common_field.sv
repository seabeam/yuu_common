/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2020 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_FIELD_SV
`define YUU_COMMON_FIELD_SV

typedef class yuu_common_register;
class yuu_common_field;
  yuu_common_register parent;
  
  local string    m_name;
        bit[7:0]  value;
        string    access = "RW";
        int       size = 1;
        int       lsb;

  function new(string name); 
    m_name = name;
  endfunction

  function string get_name();
    return m_name;
  endfunction

  function void configure(yuu_common_register parent,
                          string              access,
                          int                 size,
                          int                 lsb,
                          bit[7:0]            reset_value);
    this.parent = parent;
    this.value  = value;
    this.access = access;
    this.size   = size;
    this.lsb    = lsb;

    parent.add_field(this);
  endfunction
  
  function void write(bit[7:0] value);
    if (access != "RO") begin
      for (int i=0; i<size; i++)
        this.value[i] = value[i];
    end
    else
      `ifdef YUU_UVM
      `uvm_error("write", "Atempt to write a Read ONLY field")
      `else
      $display("[Error] Atempt to write a Read ONLY field");
      `endif
  endfunction

  function void read(output bit[7:0] value);
    if (access != "WO") begin
      value = 0;
      for (int i=0; i<size; i++)
        value[i] = this.value[i];
    end
    else
      `ifdef YUU_UVM
      `uvm_error("write", "Atempt to write a Write ONLY field")
      `else
      $display("[Error] Atempt to write a Write ONLY field");
      `endif
  endfunction
endclass

`endif