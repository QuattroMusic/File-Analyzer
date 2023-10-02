AudioFilesData :: struct{
    name: string;
    min_length: int;
    max_length: int;
    total_length: int;
}
TableAudio :: struct{
    using table: Table(AudioFilesData);
    total: AudioFilesData;
    total.name = "Total";
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
