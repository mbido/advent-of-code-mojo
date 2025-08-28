from time import perf_counter_ns, perf_counter
from algorithm import parallelize

alias adj4 = [(-1, 0), (0, 1), (1, 0), (0, -1)]
alias adj8 = [(-1, 0), (0, 1), (1, 0), (0, -1), (-1, -1), (-1, 1), (1, 1), (1, -1)]

fn char_code(char: String) -> Codepoint:
    if char == "":
        return Codepoint(-1)
    var iterator = char.codepoints()
    return iterator.__next__()

struct Grid(Writable):
    var height: Int 
    var width: Int
    var content: List[Int]

    fn __init__(out self, plain_text: String, r_separator: String = "\n", c_separator: String = ""):
        rows = StringSlice(plain_text).split(r_separator)
        if r_separator == "":
            rows = rows[1:-1]
        self.height = len(rows)

        cols_first = rows[0].split(c_separator)
        if c_separator == "":
            cols_first = cols_first[1:-1]
        self.width = len(cols_first)

        c_sep_code = char_code(c_separator)
        r_sep_code = char_code(r_separator)
        self.content = List[Int](capacity = self.height * self.width)
        for code in plain_text.codepoints():
            if code == c_sep_code or code == r_sep_code:
                continue
            self.content.append(Int(code))

    fn __getitem__(self, i: Int, j : Int) -> Int:
        if i < 0 or i >= self.width or j < 0 or j >= self.height:
            return -1
        return self.content[i + j * self.width]
    
    fn __setitem__(mut self, i: Int, j : Int, value: Int):
        self.content[i + j * self.width] = value
    
    fn __str__(self) -> String:
        var out = String()
        for j in range(self.height):
            for i in range(self.width):
                out += String(self.content[i + j * self.width]) + " "
            out += "\n"
        return out
    
    fn write_to[W: Writer](self, mut writer: W):
        var string = self.__str__()
        writer.write_bytes(string.as_bytes())

