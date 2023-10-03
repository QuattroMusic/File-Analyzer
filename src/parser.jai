parse_files :: (path: string){
    files_to_analyze: [..] string;
    is_dir := is_directory(path);
    
    if is_dir {
        // Perf(Quattro) implement this by my own, so, filter directly inside
        view := file_list(path, recursive=true);
        files_to_analyze.count = view.count;
        files_to_analyze.data = view.data;
    } else if file_exists(path) {
        // ignore the file is the folder begins with '.'
        array_add(*files_to_analyze, path);
    } else {
        print("File or path given does not exists or can't be readed, aborting\n");
    }
    
    // Temp(Quattro) filter
    for files_to_analyze {
        for dir: parse_path(it).words {
            ext, success := path_extension(it);
            for excl: exclusions {
                if begins_with(dir, excl) || (success && ext == excl) {
                    free(it);
                    remove it;
                    continue it;
                }
            }
        }
    }
    
    for file: files_to_analyze {
        ext, success := path_extension(file);
        if !success then continue;
        analyze_general(file, ext);
        
        for lang: LANGUAGE_TABLE {
            if lang.check(ext) {
                parse_prog_language(file, ext, lang.display_name, lang.slc, lang.omlc, lang.cmlc, ..lang.imports);
                continue file;
            }
        }
        // for aud: LANGUAGE_AUDIO {
        //     if aud.check(ext) {
        //         parse_audio(file, ...);
        //         continue file;
        //     }
        // }
        
    }
    
    if is_dir {
        for files_to_analyze free(it);
    }
    array_free(files_to_analyze);
    
    // Note(Quattro) calculate the total
    for table_program.data {
        table_program.total.rows += it.rows;
        table_program.total.empty_rows += it.empty_rows;
        table_program.total.non_empty_rows += it.non_empty_rows;
        table_program.total.rows_with_comment += it.rows_with_comment;
        table_program.total.rows_with_import += it.rows_with_import;
        table_program.total.characters += it.characters;
        table_program.total.digits += it.digits;
        table_program.total.numbers += it.numbers;
        table_program.total.symbols += it.symbols;
        table_program.total.whitespaces += it.whitespaces;
        table_program.total.total_size += it.total_size;
    }
    for table_general.data {
        table_general.total.min_size += it.min_size;
        table_general.total.max_size += it.max_size;
        table_general.total.average_size += it.average_size;
        table_general.total.total_size += it.total_size;
        table_general.total.amount += it.amount;
    }
}
