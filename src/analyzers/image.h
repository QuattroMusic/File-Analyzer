struct ImageFilesData{
    char extension[32];
    Vector2 min_resolution;
    Vector2 max_resolution;
};

struct TableImage{
    Array<ImageFilesData> data;
    Vector2 total_min_resolution;
    Vector2 total_max_resolution;
};
