VideoFilesData :: struct{
    name: string;
    min_length: float;
    max_length: float;
    total_frames: float;
    min_resolution: vec2;
    max_resolution: vec2;
}
TableVideo :: struct{
    using table: Table(VideoFilesData);
    total: VideoFilesData;
    total.name = "Total";
}

is_mp4_video :: (ext: string) -> bool{
    return ext == ".mp4";
}
