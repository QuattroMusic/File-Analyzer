#include <raylib.h>
#include <raygui.h>

int main(){
    InitWindow(800, 600, "File Analyzer");
    SetTargetFPS(60);
    
    while(!WindowShouldClose()){
        BeginDrawing();
            ClearBackground(BLACK);
            
        EndDrawing();
    }
    CloseWindow();
    return 0;
}
