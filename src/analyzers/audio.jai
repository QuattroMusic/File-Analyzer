AudioFilesData :: struct{
    name: string;
    min_length: int;
    max_length: int;
    total_length: int;
}
TableAudio :: struct{
    data: [..]AudioFilesData;
    total_min_length: int;
    total_max_length: int;
    total_of_total_length: int;
}

is_mp3_audio :: (ext: string) -> bool{
    return ext == ".mp3";
}
is_wav_audio :: (ext: string) -> bool{
    return ext == ".wav";
}
is_flac_audio :: (ext: string) -> bool{
    return ext == ".flac";
}
is_ogg_audio :: (ext: string) -> bool{
    return ext == ".ogg";
}
