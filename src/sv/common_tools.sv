/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef COMMON_TOOLS_SV
`define COMMON_TOOLS_SV

// Print object based on string type which used to common object printer.
// The content arranged with 2D array.
class common_print_object;
  // Data member
  string item[][];
  string tp_item[][];

  bit has_transposed = 1'b0;
  int unsigned row, col;

  // Method
  function new(int unsigned row, int unsigned col);
    this.row = row;
    this.col = col;

    init_item(row, col);
    init_tp_item(row, col);
  endfunction

  protected function void init_item(int unsigned row, int unsigned col);
    item = new[row];
    foreach (item[i])
      item[i] = new[col];
  endfunction

  protected function void init_tp_item(int unsigned row, int unsigned col);
    tp_item = new[col];
    foreach (tp_item[i])
      tp_item[i] = new[row];
  endfunction

  function int get_max_length(int unsigned col);
    string max_q[$];

    if (!has_transposed)
      transpose();
    max_q = tp_item[col].max() with (item.len());

    return max_q[0].len();
  endfunction

  local function void transpose();
    foreach (item[i,j])
      tp_item[j][i] = item[i][j];

    has_transposed = 1'b1;
  endfunction

  function void copy(common_print_object rhs);
    if (rhs == null) begin
      $display("Error", "rhs print object haven't been allocated");
      return;
    end

    this.row = rhs.row;
    this.col = rhs.col;

    init_item(row, col);
    foreach (item[i, j])
      item[i][j]  = rhs.item[i][j];

    init_tp_item(row, col);
    transpose();
  endfunction
endclass: common_print_object


class common_printer;
  static local common_printer m_inst;

  protected common_print_object object;
  protected int col_width_queue[$];
  
  local function new();
  endfunction

  static function common_printer get_printer();
    if (m_inst == null)
      m_inst = new;
    
    return m_inst;
  endfunction

  function void set_object(common_print_object rhs);
    this.object = new(1, 1);
    this.object.copy(rhs);
    col_width_queue.delete();
  endfunction

  function void print();
    string line;
    string cross_divider;

    if (this.object == null) begin
      $display("Error", "Call set_object() to set print object first");;
      return;
    end

    set_col_width();

    foreach (col_width_queue[i]) begin
      cross_divider = {cross_divider, "+", {(col_width_queue[i]+2){"-"}}};
    end
    cross_divider = {cross_divider, "+\n"};
   
    // Header
    line = cross_divider;
    foreach (object.item[0][j]) begin
      int gap = col_width_queue[j]+1-object.item[0][j].len();
      line = {line, "|", " ", object.item[0][j], {gap{" "}}};
    end
    line = {line, "|\n"};
    line = {line, cross_divider};

    // Body
    begin
      for (int i=1; i<object.item.size(); i++) begin
        for (int j=0; j<object.item[i].size(); j++) begin
          int gap = col_width_queue[j]+1-object.item[i][j].len();
          line = {line, "|", " ", object.item[i][j], {gap{" "}}};
        end
        line = {line, "|\n"};
      end
    end
    line = {line, cross_divider};

    $display(line);
  endfunction

  function void set_col_width();
    for (int i=0; i<object.col; i++) begin
      col_width_queue.push_back(object.get_max_length(i));
    end
  endfunction
endclass: common_printer


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
class common_config_parser;
  static local common_config_parser m_inst;
  protected string value[string];

  static function common_config_parser get_config_parser();
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
endclass : common_config_parser

`endif
