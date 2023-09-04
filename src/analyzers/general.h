struct GeneralFilesData{
    char extension[32];
    int min_size;
    int max_size;
    float average_size;
    int total_size;
    int amount;
};

struct TableGeneral{
    Array<GeneralFilesData> data;
    int total_min_size;
    int total_max_size;
    float total_average_size;
    int total_of_total_size;
    int total_amount;
};
