ImageFilesData :: struct{
    name: string;
    min_resolution: vec2;
    max_resolution: vec2;
}
TableImage :: struct{
    data: [..]ImageFilesData;
    total_min_resolution: vec2;  // Check(Quattro)
    total_max_resolution: vec2;  // Check(Quattro)
}

is_jpg_image :: (ext: string) -> bool{
    return ext == ".jpg" || ext == ".jpeg";
}
is_png_image :: (ext: string) -> bool{
    return ext == ".png";
}
