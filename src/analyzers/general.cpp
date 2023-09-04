void analyze_general(const char* file, const char* ext){
    // Todo(Quattro) check if it's already present in table
    int file_size = GetFileLength(file);
    
    for(int i = 0; i < table_general.data.size; i++){
        GeneralFilesData* data = &table_general.data[i];
        if(strcmp(ext, data->extension)){
            if(file_size < data->min_size){
                data->min_size = file_size;
            }
            if(file_size > data->max_size){
                data->max_size = file_size;
            }
            data->total_size += file_size;
            data->amount++;
            data->average_size = (float)data->total_size / data->amount;
            return;
        }
    }
    
    GeneralFilesData data = {};
    strcpy_s(data.extension, ext);
    data.min_size = file_size;
    data.max_size = file_size;
    data.average_size = (float)file_size;
    data.total_size = file_size;
    data.amount++;
    array_append(&table_general.data, data);
}
