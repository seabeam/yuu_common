/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2020 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_REGISTER_SV
`define YUU_COMMON_REGISTER_SV

class yuu_common_register;
  local string    m_name;
        bit[7:0]  offset;
        string    access = "RW";
  
  yuu_common_field fields[$];

  function new(string name);
    m_name = name;
  endfunction

  function string get_name();
    return m_name;
  endfunction

  function void configure(string access, bit[7:0] offset);
    this.offset = offset;
    this.access = access;
  endfunction

  function void write(bit[7:0] value);
    if (access != "RO") begin
      foreach (fields[i]) begin
        for (int j=0; j<fields[i].size; j++)
          fields[i].value[j] = value[fields[i].lsb+j];
      end
    end
    else begin
      `ifdef YUU_UVM
      `uvm_error("write", "Atempt to write a Read ONLY register")      
      `else
      $display("[Error] Atempt to write a Read ONLY register");
      `endif
    end
  endfunction

  function void read(output bit[7:0] value);
    if( access != "WO") begin
      value = 0;
      foreach (fields[i]) begin
        for (int j=0; j<fields[i].size; j++)
          value[fields[i].lsb+j] = fields[i].value[j];
      end
    end
    else begin
      `ifdef YUU_UVM
      `uvm_error("read", "Atempt to write a Write ONLY register")
      `else
      $display("[Error] Atempt to write a Write ONLY register");
      `endif
    end
  endfunction

  function void add_field(yuu_common_field field);
    fields.push_back(field);
  endfunction
endclass

`endif