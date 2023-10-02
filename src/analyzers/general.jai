GeneralFilesData :: struct {
    name: string;
    min_size: int;
    max_size: int;
    average_size: float;
    total_size: int;
    amount: int;
}

analyze_general ::(content: string, ext: string) {
    size := content.count;
    
    // Note(Quattro) if there's already a file with the same extension
    for * table_general.data{
        data := (<<it);
        if ext == data.name{
            if size < data.min_size then (<<it).min_size = size;
            if size < data.max_size then (<<it).max_size = size;
            (<<it).total_size += size;
            (<<it).amount += 1;
            (<<it).average_size = cast(float)data.total_size / data.amount;
            return;
        }
    }
    
    // if not
    data: GeneralFilesData;
    data.name = copy_string(ext);
    data.min_size = size;
    data.max_size = size;
    data.average_size = cast(float)size;
    data.total_size = size;
    data.amount += 1;
    array_add(*table_general.data, data);
}
