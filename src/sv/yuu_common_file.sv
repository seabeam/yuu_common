`ifndef YUU_COMMON_FILE_SV
`define YUU_COMMON_FILE_SV

class yuu_common_file;
  string  name;
  string  mode;
  boolean closed = False;
  boolean eof = False;
  int fid = 0;

  local static yuu_common_file self;

  local function new();
  endfunction

  function void close();
    $fclose(this.fid);
    this.closed = True;
  endfunction

  function string read(int size=-1);
    string line;

    if (size == -1) begin
      while(1) begin
        string s = string'($fgetc(this.fid));

        if (byte'(s) != -1) begin
          line = {line, s};
        end
        else
          break;
      end
    end
    else begin
      for (int cnt=0; cnt<size; cnt++) begin
        string s = string'($fgetc(this.fid));

        if (byte'(s) != -1) begin
          line = {line, s};
        end
        else
          break;
      end
    end

    this.eof = True;

    return line;
  endfunction

  function string readline();
    string line;
    int code;

    code = $fgets(line, this.fid);
    if (code == 0)
      this.eof = True;
    else
      this.eof = False;
    
    return line;
  endfunction

  function void readlines(output string lines[$]);
    while(!$feof(this.fid)) begin
      string line;

      void'($fgets(line, this.fid));
      lines.push_back(line);
    end
    this.eof = True;
    lines.pop_back();
  endfunction

  function void write(string line);
    $fdisplay(this.fid, line);
  endfunction

  function void write_lines(string lines[$]);
    foreach(lines[i])
      write(lines[i]);
  endfunction

  function void seek(int offset, int whence=0);
    int code;

    code = $fseek(this.fid, offset, whence);
  endfunction

  function int tell();
    return $ftell(this.fid);
  endfunction

  static function yuu_common_file open(string name, string mode="r");
    if (self == null) begin
      self = new;
      self.fid = $fopen(name, mode);
      if (self.fid == 0)
        $fclose(self.fid);

      self.name = name;
      self.mode = mode;
    end

    return self;
  endfunction
endclass

`endif
