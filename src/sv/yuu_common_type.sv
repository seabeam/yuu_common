/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_TYPE_SV
`define YUU_COMMON_TYPE_SV

  typedef enum bit {
    False,
    True
  } boolean;

  typedef enum bit[3:0] {
    PATTERN_ALL_0,
    PATTERN_ALL_1,
    PATTERN_55,
    PATTERN_AA,
    PATTERN_5A,
    PATTERN_A5,
    PATTERN_ADDRESS,
    PATTERN_RANDOM,
    PATTERN_ALL_X,
    PATTERN_ALL_Z
    } yuu_common_mem_pattern_e;

  typedef bit[`YUU_COMMON_ADDR_WIDTH-1:0]   yuu_common_addr_t;
  typedef bit[`YUU_COMMON_DATA_WIDTH-1:0]   yuu_common_data_t;
  typedef bit[`YUU_COMMON_STROB_WIDTH-1:0]  yuu_common_strob_t;

`endif
