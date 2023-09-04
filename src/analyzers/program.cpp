#define is_digit(c) ((c) >= '0' && (c) <= '9')
#define is_white_space(c) ((c) == ' ' || (c) == '\t' || (c) == '\n')
#define is_character(c) (((c) >= 'a' && (c) <= 'z') || ((c) >= 'A' && (c) <= 'Z'))

void analyze_code(const char* file, ProgramFilesData *data, str single_line_comment, str opening_multi_line_comment, str closing_multi_line_comment, str import1){
    // Todo(Quattro) i should take care of \r, even if it sucks
    str text = LoadFileText(file);
    if(text.size == 0){
        return;
    }
    
    str analyze;
    str next = text;
    int previous_size = 0;
    bool res;
    do{
        res = str_split_newline_left(next, &analyze, &next);
        data->rows++;
        int idx = 0;
        if(str_starts_with(analyze, import1)){
            // Todo(Quattro) check if there are multiple imports types
            data->rows_with_import++;
        }
        while(idx < analyze.size){
            u8 c = analyze.ptr[idx];
            if(is_character(c)) data->characters++;
            else if(is_white_space(c)) data->whitespaces++;
            else if(is_digit(c)){
                while(is_digit(c) || c == '.' || c == 'e'){
                    u8 c = analyze.ptr[idx];
                    if(is_digit(c)) data->digits++;
                    else if(c == '.') data->symbols++;
                    else if(c == 'e') data->characters++;
                    else { data->numbers++; idx--; break; }
                    idx++;
                }
            }else{
                data->symbols++;
                // Todo(Quattro) string with comment
                // Todo(Quattro) also check if it's inside a string
                // Todo(Quattro) this is the most atrocious part, in fact i hate it
                // if(strcmp((char*)analyze.ptr + idx, (char*)single_line_comment.ptr) == 0){
                //     log("si");
                // }
            }
            idx++;
        }
        str trim_str = analyze;
        str_trim_left(&trim_str);
        if(trim_str.size == 0){
            data->empty_rows++;
        }
    }while(res == true);
    
    data->rows++;
    data->whitespaces += data->rows - 1;
    data->total_size = GetFileLength(file);
    data->non_empty_rows = data->rows - data->empty_rows;
    
    free(text.ptr);
    return;
}

bool is_c_code(const char* ext){
    return has_extension(".c") || has_extension(".h") || has_extension(".cpp") || has_extension(".hpp");
}
bool is_cs_code(const char* ext){
    return has_extension(".cs");
}
// Todo(Quattro) more languages

bool parse_prog_language(const char* file, const char* ext){
    // Todo(Quattro) check if file is already present in list
    ProgramFilesData data = {};
    ProgramFilesData* data_ptr = &data;
    
    bool is_already_present = false;
    for(int i = 0; i < table_program.data.size; i++){
        ProgramFilesData* d = array_get_ptr(&table_program.data, i);
        if(strcmp(d->extension, ext)){
            is_already_present = true;
            data_ptr = d;
            break;
        }
    }
    
    if(is_c_code(ext)) {
        analyze_code(file, data_ptr, "//", "/*", "*/", "#include");
    // }else if(is_cs_code(ext)){
    //     analyze_code(file, data_ptr, "", "", "", "");
    }else{
        return false;
    }
    // Todo(Quattro) more languages
    
    if(!is_already_present){
        strcpy(data.extension, ext);
        array_append(&table_program.data, data);
    }
    
    return true;
}
