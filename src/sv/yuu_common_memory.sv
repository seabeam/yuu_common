/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_MEMORY_SV
`define YUU_COMMON_MEMORY_SV

class yuu_common_memory extends yuu_common_base;
  protected yuu_common_mem_data_t val[yuu_common_mem_addr_t];

  yuu_common_mem_pattern_e  init_pattern;
  boolean                   enable_byte_align = True;
  int unsigned              addr_width = `YUU_COMMON_MEM_ADDR_WIDTH;
  int unsigned              data_width = `YUU_COMMON_MEM_DATA_WIDTH;
  
  function void write(yuu_common_mem_addr_t   addr, 
                      yuu_common_mem_data_t   data, 
                      yuu_common_mem_strob_t  strob = -'h1);
    if (enable_byte_align) begin
      bit [7:0] addr_aligned;
      yuu_common_tools::is_byte_align(addr_width, addr, addr_aligned);
      addr[7:0] = addr_aligned;
    end

    for (int i=0; i<data_width/8; i++) begin
      if (strob[i])
        val[addr][i*8+:8] = data[i*8+:8];
    end
  endfunction

  task read(input yuu_common_mem_addr_t addr, output yuu_common_mem_data_t data);
    if (enable_byte_align) begin
      bit [7:0] addr_aligned;
      yuu_common_tools::is_byte_align(addr_width, addr, addr_aligned);
      addr[7:0] = addr_aligned;
    end

    if (val.exists(addr))
      data = val[addr];
    else begin
      case(init_pattern)
        PATTERN_ALL_0:  data = 'h0;
        PATTERN_ALL_1:  data = -'h1;
        PATTERN_55:     for (int i=0; i<$ceil(real'(data_width)/real'(32)); i++) begin
                          data |= 32'h5555_5555<<(i*32);
                        end
        PATTERN_AA:     for (int i=0; i<$ceil(real'(data_width)/real'(32)); i++) begin
                          data |= 32'hAAAA_AAAA<<(i*32);
                        end
        PATTERN_5A:     for (int i=0; i<$ceil(real'(data_width)/real'(32)); i++) begin
                          data |= 32'h55AA_55AA<<(i*32);
                        end
        PATTERN_A5:     for (int i=0; i<$ceil(real'(data_width)/real'(32)); i++) begin
                          data |= 32'hAA55_AA55<<(i*32);
                        end
        PATTERN_ADDRESS:data = addr;
        PATTERN_RANDOM: for (int i=0; i<$ceil(real'(data_width)/real'(32)); i++) begin
                          data |= $random()<<(i*32);
                        end
        default:        data = 'h0;
      endcase
    end
  endtask
endclass

`endif
