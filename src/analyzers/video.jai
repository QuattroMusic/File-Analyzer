VideoFilesData :: struct{
    name: string;
    min_length: float;
    max_length: float;
    total_frames: float;
    min_resolution: Vector2;
    max_resolution: Vector2;
}

is_mp4_video :: (ext: string) -> bool{
    return ext == "mp4";
}
