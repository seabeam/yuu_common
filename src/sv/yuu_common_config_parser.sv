/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_COMMON_CONFIG_PARSER_SV
`define YUU_COMMON_CONFIG_PARSER_SV

// Configuration file parser.
// The key value must be formated as:
//
//    key = value
//
// and with the header line
//
//    ## Config start
//
// and tail line
//
//    ## Config end
// The comment is also supported but with no =' symbol

class yuu_common_config_parser;
  static local yuu_common_config_parser m_inst;
  protected string value[string];

  static function yuu_common_config_parser get_config_parser();
    if (m_inst == null)
      m_inst = new;

    return m_inst;
  endfunction

  function void parser_config(string config_file);
    int handle = $fopen(config_file, "r");
    string key;
    int rtn;

    if (handle == 0)
      return;

    do begin
      rtn = $fscanf(handle, "%s = %s", key, value[key]);
      if (rtn != 2) begin
        value.delete(key);
      end
    end
    while (rtn != -1);

    $fclose(handle);
  endfunction

  function string get(string key);
    if (!value.exists(key))
      value[key] = "";
    return value[key];
  endfunction
endclass

`endif
