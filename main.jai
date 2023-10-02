#import "Basic"()(MEMORY_DEBUGGER = true);
#import "String";
#import "File";
#import "File_Utilities";
#import "Compiler";

vec2 :: struct{
    x, y: float;
}

#load "src/analyzers/audio.jai";
#load "src/analyzers/image.jai";
#load "src/analyzers/video.jai";
#load "src/analyzers/general.jai";
#load "src/analyzers/program.jai";
#load "src/parser.jai";
#load "src/printer.jai";

table_general: TableGeneral;
table_program: TableProgram;
table_image:   TableImage;
table_audio:   TableAudio;
table_video:   TableVideo;

main :: () {
    // Todo(Quattro) change this file to support workspaces (for optimization and multiple platforms)
    
    path: string;
    if __command_line_arguments.count == 1 {
        path = "tests";
    } else {
        path = to_string(__command_line_arguments.data[1]);
    }
    
    parse_files(path);
    print_tables();
    
    // report_memory_leaks();
}
