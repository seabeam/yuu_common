/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMAN_PKG_SV
`define YUU_COMMAN_PKG_SV

package yuu_common_pkg;
  typedef enum bit {
    False,
    True
  } boolean;

  `include "yuu_common_tools.sv"
  `include "yuu_common_print.sv"
  `include "yuu_common_config_parser.sv"
endpackage

`endif
