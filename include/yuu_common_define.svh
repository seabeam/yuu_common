/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_DEFINE_SVH
`define YUU_COMMON_DEFINE_SVH

  `ifndef YUU_COMMON_MEM_ADDR_WIDTH
  `define YUU_COMMON_MEM_ADDR_WIDTH 32
  `endif
  
  `ifndef YUU_COMMON_MEM_DATA_WIDTH
  `define YUU_COMMON_MEM_DATA_WIDTH 32
  `endif

  `define YUU_COMMON_MEM_STROB_WIDTH `YUU_COMMON_MEM_DATA_WIDTH/8

`endif
