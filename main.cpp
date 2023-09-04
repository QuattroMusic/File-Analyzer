#include <raylib.h>
#include <raygui.h>

#include <string.h>
#include <stdlib.h>

#include "src/utils/utils.h"
#include "src/platform.h"
#include "src/gui.h"
#include "src/parser.h"

#include "src/analyzers/general.h"
#include "src/analyzers/program.h"
#include "src/analyzers/image.h"
#include "src/analyzers/video.h"
#include "src/analyzers/audio.h"

Viewport vp;
TableAudio   table_audio;
TableGeneral table_general;
TableImage   table_image;
TableProgram table_program;
TableVideo   table_video;

#include "src/gui.cpp"
#include "src/analyzers/general.cpp"
#include "src/analyzers/program.cpp"
#include "src/analyzers/image.cpp"
#include "src/analyzers/video.cpp"
#include "src/analyzers/audio.cpp"
#include "src/parser.cpp"

int main(/*Todo(Quattro) int argc, char* argv[]*/){
    vp.width = 800;
    vp.height = 600;
    
    Panel p;
    strcpy(p.title, "General");
    
    InitWindow(vp.width, vp.height, "File Analyzer");
    SetTargetFPS(60);
    
    table_audio.data   = array_new<AudioFilesData>  (1);
    table_general.data = array_new<GeneralFilesData>(1);
    table_image.data   = array_new<ImageFilesData>  (1);
    table_program.data = array_new<ProgramFilesData>(1);
    table_video.data   = array_new<VideoFilesData>  (1);
    
    parse_files("test.c");
    
    while(!WindowShouldClose()){
        vp.width = GetScreenWidth();
        vp.height = GetScreenHeight();
        BeginDrawing();
            ClearBackground(BLACK);
            draw_gui(p);
        EndDrawing();
    }
    CloseWindow();
    
    array_free_all(&table_audio.data);
    array_free_all(&table_general.data);
    array_free_all(&table_image.data);
    array_free_all(&table_program.data);
    array_free_all(&table_video.data);
    return 0;
}
