struct AudioFilesData{
    char extension[32];
    int min_length;
    int max_length;
    int total_length;
};

struct TableAudio{
    Array<AudioFilesData> data;
    int total_min_length;
    int total_max_length;
    int total_of_total_length;
};
