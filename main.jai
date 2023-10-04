#if FULL_DEBUG {
    #import "Basic"()(MEMORY_DEBUGGER = true);
} else {
    #import "Basic";
}

#import "String";
#import "File";
#import "File_Utilities";
#import "Compiler";

vec2 :: struct {
    x, y: float;
}

#load "src/analyzers/general.jai";
#load "src/analyzers/program.jai";
#load "src/analyzers/image.jai";
#load "src/analyzers/audio.jai";
#load "src/analyzers/video.jai";
#load "src/parser.jai";
#load "src/printer.jai";

table_general: Table(GeneralFilesData);
table_program: Table(ProgramFilesData);
table_image:   Table(ImageFilesData);
table_audio:   Table(AudioFilesData);
table_video:   Table(VideoFilesData);

// Todo(Quattro) this should be a variable, not a costant (so the user could change it from the vargs)
exclusions :: string.[".git", ".build", "exe"];

main :: () {
    path: string;
    args := get_command_line_arguments();
    // Todo(Quattro) change this to support multiple inputs
    path = ifx args.count == 1 then "." else args.data[1];
    
    parse_files(path);
    print_tables();
    
    #if FULL_DEBUG {
        report_memory_leaks();
    }
}
