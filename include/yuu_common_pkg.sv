/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_PKG_SV
`define YUU_COMMON_PKG_SV

`include "yuu_common_define.svh"

package yuu_common_pkg;
  `include "yuu_common_type.sv"

  `include "yuu_common_tools.sv"
  `include "yuu_common_print.sv"
  `include "yuu_common_config_parser.sv"
  `include "yuu_common_memory.sv"
  `include "yuu_common_field.sv"
  `include "yuu_common_register.sv"
endpackage

`endif
