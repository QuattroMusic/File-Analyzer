ProgramFilesData :: struct {
    name: string;
    rows: int;
    empty_rows: int;
    non_empty_rows: int;
    rows_with_comment: int;
    rows_with_import: int;
    characters: int;
    digits: int;
    numbers: int;
    symbols: int;
    whitespaces: int;
    total_size: int;
}

is_c_code :: inline (ext: string) -> bool   { return ext == "c" || ext == "cpp" || ext == "h" || ext == "hpp"; }
is_py_code :: inline (ext: string) -> bool  { return ext == "py"; }
is_jai_code :: inline (ext: string) -> bool { return ext == "jai"; }

analyze_code :: (path: string, data: *ProgramFilesData, single_line_comment: string, opening_multi_line_comment: string, closing_multi_line_comment: string, imports: .. string) {
    // Check(Quattro) performance of this
    //                version 2 (maybe faster) with a state machine
    text, success := read_entire_file(path);
    if !success then return;
    defer free(text);
    
    analyze: string;
    next := text;
    res := true;
    is_inside_string := false;
    is_inside_multiline_comment := false;
    new_rows := 0;
    
    while res {
        res, analyze, next = split_from_left(next, #char "\n");
        new_rows += 1;
        if is_inside_multiline_comment then data.rows_with_comment += 1;
        for imports if begins_with(analyze, it) then data.rows_with_import += 1;
        
        idx := 0;
        while idx < analyze.count {
            c := analyze.data[idx];
            if is_alpha(c) then data.characters += 1;
            else if is_space(c) then data.whitespaces += 1;
            else if is_digit(c) {
                while is_digit(c) || c == #char "." || c == #char "e" {
                    c := analyze.data[idx];
                    if is_digit(c) then data.digits += 1;
                    else if c == #char "." then data.symbols += 1;
                    else if c == #char "e" then data.characters += 1;
                    else {
                        data.numbers += 1;
                        idx -= 1;
                        break;
                    }
                    idx += 1;
                }
            } else {
                data.symbols += 1;
                offset_row := analyze;
                offset_row.count -= idx;
                offset_row.data += idx;
                
                if c == #char "\"" && analyze.data[idx - 1] != #char "\\"{
                    is_inside_string = !is_inside_string;
                }
                if !is_inside_string{
                    if begins_with(offset_row, single_line_comment) {
                        data.rows_with_comment += 1;
                    }
                    if opening_multi_line_comment && begins_with(offset_row, opening_multi_line_comment){
                        data.rows_with_comment += 1;
                        is_inside_multiline_comment = true;
                    }
                    if closing_multi_line_comment && begins_with(offset_row, closing_multi_line_comment){
                        is_inside_multiline_comment = false;
                    }
                }
            }
            idx += 1;
        }
        trim_str := trim_left(analyze);
        if trim_str.count == 0 then data.empty_rows += 1;
    }
    
    data.rows += new_rows;
    data.whitespaces += (new_rows - 1);
    data.total_size += text.count;
    data.non_empty_rows = (data.rows - data.empty_rows);
}

parse_prog_language :: (path: string, ext: string, display_name: string, slc: string, omlc: string, cmlc: string, imports: .. string) -> bool {
    data: ProgramFilesData;
    data_ptr: *ProgramFilesData = *data;
    
    is_already_present := false;
    for table_program.data {
        if it.name == display_name {
            is_already_present = true;
            data_ptr = *it;
            break;
        }
    }
    
    analyze_code(path, data_ptr, slc, omlc, cmlc, ..imports);
    
    if(!is_already_present){
        data.name = copy_string(display_name);
        array_add(*table_program.data, data);
    }
    
    return true;
}

AnalyzerLanguage :: struct {
    check: (ext: string) -> (bool);
    display_name: string;
    slc: string;
    omlc: string;
    cmlc: string;
    imports: []string;
}

LANGUAGE_TABLE :: AnalyzerLanguage.[
    .{is_jai_code, "Jai", "//", "/*", "*/", .["#import", "#load"]},
    .{is_c_code, "C / C++", "//", "/*", "*/", .["#include"]},
    .{is_py_code, "Python", "#", "", "", .["import", "from"]}
    // Todo(Quattro) add more languages
];
