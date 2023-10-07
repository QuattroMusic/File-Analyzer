parse_files :: (paths: [] string) {
    for file: paths {
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
    
    // Note(Quattro) calculate the total
    for table_program.data {
        using table_program.total;
        rows += it.rows;
        empty_rows += it.empty_rows;
        non_empty_rows += it.non_empty_rows;
        rows_with_comment += it.rows_with_comment;
        rows_with_import += it.rows_with_import;
        characters += it.characters;
        digits += it.digits;
        numbers += it.numbers;
        symbols += it.symbols;
        whitespaces += it.whitespaces;
        total_size += it.total_size;
    }
    for table_general.data {
        using table_general.total;
        min_size += it.min_size;
        max_size += it.max_size;
        average_size += it.average_size;
        total_size += it.total_size;
        amount += it.amount;
    }
}
