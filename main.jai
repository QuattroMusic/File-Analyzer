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

main :: () {
    args := get_command_line_arguments();
    exclusions_ext : [..] string;
    
    // Todo(Quattro) change this to support multiple inputs
    paths: [..] string;
    if args.count == 1 {
        array_add(*paths, ".");
    } else {
        for args {
            if it_index == 0 then continue;
            if begins_with(it, "-") {
                if begins_with(it, "-e") {
                    excl := it;
                    excl.data += 2;
                    excl.count -= 2;
                    if excl.data[0] == #char "." {
                        // Note(Quattro) the extension to be added is not '.exe', but 'exe'
                        excl.data += 1;
                        excl.count -= 1;
                    }
                    array_add_if_unique(*exclusions_ext, excl);
                }
            } else {
                array_add_if_unique(*paths, it);
            }
        }
    }
    
    to_expand := paths;
    for path: to_expand {
        if is_directory(path) {
            // Perf(Quattro) implement this by my own, so, filter directly inside
            ctx := context;
            ctx.allocator = temp;
            all_files : [] string;
            push_context ctx {
                all_files = file_list(path, recursive=true);
            }
            for all_files array_add(*paths, it);
        } else if file_exists(path) {
            // ignore the file is the folder begins with '.'
            array_add(*paths, path);
        } else {
            print("File or path % does not exists or can't be readed, aborting\n", path);
        }
    }
    
    // Note(Quattro) filter paths. the basic filter is "if the folder starts with '.', ignore it"
    for paths {
        ext, success := path_extension(it);
        for excl: exclusions_ext {
            if (success && ext == excl) {
                remove it;
                continue it;
            }
        }
        for dir: parse_path(it).words {
            if begins_with(dir, ".") && !begins_with(dir, "..") {
                remove it;
                continue it;
            }
        }
    }
    // Note(Quattro) remove same paths
    
    parse_files(paths);
    print_tables();
    
    array_free(paths);
    array_free(args);
    array_free(exclusions_ext);

    reset_temporary_storage();
    #if FULL_DEBUG {
        report_memory_leaks();
    }
}
