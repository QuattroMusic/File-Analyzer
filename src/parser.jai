parse_files :: (path: string){
    files_to_analyze: [..] string;
    is_dir := is_directory(path);
    
    if is_dir {
        view := file_list(path, recursive=true);
        files_to_analyze.count = view.count;
        files_to_analyze.data = view.data;
    } else if file_exists(path) {
        array_add(*files_to_analyze, path);
    } else {
        print("File or path given does not exists or can't be readed, aborting\n");
    }
    
    for file: files_to_analyze {
        ext := path_extension(file);
        for lang: LANGUAGE_TABLE {
            if lang.check(ext) {
                parse_prog_language(file, ext, lang.display_name, lang.slc, lang.omlc, lang.cmlc, ..lang.imports);
                continue lang;
            }
        }
        
    }
    
    if is_dir {
        for files_to_analyze free(it);
    }
    array_free(files_to_analyze);
    
    print_table();
}

print_table :: () {
    
}
