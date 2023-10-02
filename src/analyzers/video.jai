VideoFilesData :: struct{
    ext: string;
    min_length: float;
    max_length: float;
    total_frames: float;
    min_resolution: vec2;
    max_resolution: vec2;
}
TableVideo :: struct{
    data: [..]VideoFilesData;
    total_min_length: float;
    total_max_length: float;
    total_of_total_frames: float;
    total_min_resolution: vec2;  // Check(Quattro)
    total_max_resolution: vec2;  // Check(Quattro)
}

is_mp4_video :: (ext: string) -> bool{
    return ext == ".mp4";
}
