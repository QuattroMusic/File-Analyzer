FULL_DEBUG_ON :: #string DONE
FULL_DEBUG :: true;
DONE

FULL_DEBUG_OFF :: #string DONE
FULL_DEBUG :: false;
DONE

#import "File";
#import "Basic";
#import "Compiler";

BuildOption :: enum {
    DEBUG;
    FULL_DEBUG;
    RELEASE;
}

build :: () {
    build_option := BuildOption.DEBUG;
    
    args := get_build_options().compile_time_command_line;
    if args.count == 0 {
        print("Unprovided build option. Compiling with debug\n");
    } else {
        if args[0] == "DEBUG" || args[0] == "D" {
            build_option = BuildOption.DEBUG;
            print("Recognized parameter DEBUG. Compiling\n");
        }
        else if args[0] == "FULL_DEBUG" || args[0] == "FD" {
            build_option = BuildOption.FULL_DEBUG;
            print("Recognized parameter FULL_DEBUG. Compiling\n");
        }
        else if args[0] == "RELEASE" || args[0] == "R" {
            build_option = BuildOption.RELEASE;
            print("Recognized parameter RELEASE. Compiling\n");
        } else {
            print("Unrecognized option, available are DEBUG (D), FULL_DEBUG (FD) or RELEASE (R)\nCompiling with parameter D");
            build_option = BuildOption.DEBUG;
        }
    }
    
    w := compiler_create_workspace();
    options := get_build_options();
    options.output_executable_name = "analyzer";
    
    if build_option == {
        case BuildOption.DEBUG; {
            set_optimization(*options, .DEBUG);
            set_build_options(options, w);
            add_build_string(FULL_DEBUG_OFF, w);
        }
        case BuildOption.FULL_DEBUG; {
            set_optimization(*options, .DEBUG);
            set_build_options(options, w);
            add_build_string(FULL_DEBUG_ON, w);
        }
        case BuildOption.RELEASE; {
            set_optimization(*options, .VERY_OPTIMIZED);
            set_build_options(options, w);
            add_build_string(FULL_DEBUG_OFF, w);
        }
    }
    
    add_build_file("main.jai", w);
    set_build_options_dc(.{do_output=false});
}

#run build();
