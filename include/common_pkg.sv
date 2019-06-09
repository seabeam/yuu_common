/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef COMMAN_PKG_SV
`define COMMAN_PKG_SV

package common_pkg;
  typedef enum bit {
    False,
    True
  } boolean;

  `include "common_tools.sv"
endpackage

`endif
