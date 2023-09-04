struct ProgramFilesData{
    char extension[32];
    int rows;
    int empty_rows;
    int non_empty_rows;
    int rows_with_comment;
    int rows_with_import;
    int characters;
    int digits;
    int numbers;
    int symbols;
    int whitespaces;
    int total_size;
};

struct TableProgram{
    Array<ProgramFilesData> data;
    int total_rows;
    int total_empty_rows;
    int total_non_empty_rows;
    int total_rows_with_comment;
    int total_rows_with_import;
    int total_characters;
    int total_digits;
    int total_numbers;
    int total_symbols;
    int total_whitespaces;
    int total_of_total_size;
};
