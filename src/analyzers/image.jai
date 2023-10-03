ImageFilesData :: struct{
    name: string;
    min_resolution: vec2;
    max_resolution: vec2;
}

is_jpg_image :: (ext: string) -> bool{
    return ext == "jpg" || ext == "jpeg";
}
is_png_image :: (ext: string) -> bool{
    return ext == "png";
}
