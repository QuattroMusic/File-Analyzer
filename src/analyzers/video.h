struct VideoFilesData{
    char extension[32];
    float min_length;
    float max_length;
    float total_frames;
    Vector2 min_resolution;
    Vector2 max_resolution;
};

struct TableVideo{
    Array<VideoFilesData> data;
    float total_min_length;
    float total_max_length;
    float total_of_total_frames;
    Vector2 total_min_resolution;
    Vector2 total_max_resolution;
};
