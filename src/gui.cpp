void draw_gui(Panel &p){
    GuiPanel({0, 0, vp.width, vp.height + 2}, p.title);
    const float spacing_between_buttons = 40;
    const float left_padding = 40;
    
    // Todo(Quattro) show those buttons only if necessary
    if(table_general.data.size != 0 && GuiButton({left_padding, 24 + 20, 80, 20}, "General")){
        strcpy(p.title, "General");
    }
    if(table_program.data.size != 0 && GuiButton({left_padding + 80 + spacing_between_buttons, 24 + 20, 140, 20}, "Programming Languages")){
        strcpy(p.title, "Programming Languages");
    }
    if(table_image.data.size != 0 && GuiButton({left_padding + 80 + 140 + spacing_between_buttons * 2, 24 + 20, 80, 20}, "Images")){
        strcpy(p.title, "Images");
    }
    if(table_video.data.size != 0 && GuiButton({left_padding + 80 + 140 + 80 + spacing_between_buttons * 3, 24 + 20, 80, 20}, "Videos")){
        strcpy(p.title, "Videos");
    }
    if(table_audio.data.size != 0 && GuiButton({left_padding + 80 + 140 + 80 + 80 + spacing_between_buttons * 4, 24 + 20, 80, 20}, "Audios")){
        strcpy(p.title, "Audios");
    }
    
    if(GuiButton({vp.width - 100, 2, 80, 20}, "Select Files")){
        
    }
    
}
