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

typedef enum bit[2:0] {
  PATTERN_ALL_0,
  PATTERN_ALL_1,
  PATTERN_55,
  PATTERN_AA,
  PATTERN_5A,
  PATTERN_A5,
  PATTERN_ADDRESS,
  PATTERN_RANDOM
  } yuu_common_mem_pattern_e;

typedef bit[`YUU_COMMON_MEM_ADDR_WIDTH-1:0]   yuu_common_mem_addr_t;
typedef bit[`YUU_COMMON_MEM_DATA_WIDTH-1:0]   yuu_common_mem_data_t;
typedef bit[`YUU_COMMON_MEM_STROB_WIDTH-1:0]  yuu_common_mem_strob_t;

`endif
