bool is_jpg_image(const char* ext){
    return has_extension(".jpg") || has_extension(".jpeg");
}
bool is_png_image(const char* ext){
    return has_extension(".png");
}
