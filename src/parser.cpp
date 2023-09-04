void parse_files(const char* file){
    // Todo(Quattro) check if it's a folder, a file or multiple files
    
    const char* extension = GetFileExtension(file);
    
    analyze_general(file, extension);
    
    if(parse_prog_language(file, extension)) {}
    
    // if(is_a_programming_language(extension)){
        
    // }else if(is_an_image(extension)){
        
    // }else if(is_a_video(extension)){
        
    // }else if(is_an_audio(extension)){
        
    // }else{
    //     log("Unrecognized extension %s", extension);
    // }
    
    // Todo(Quattro) update table, but when? always?
    
    // str text = LoadFileText(file);
    // free(text.ptr);
}
