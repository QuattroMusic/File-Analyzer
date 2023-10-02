Table :: struct (T: Type) {
    data: [..] T;
    widths: [..] int;
    names: [..] string;
}

init_table :: (table: *$T) {
    // Note(Quattro) dinamically get the members value, converts them to string to get the max width for each row
    
    // Note(Quattro) we could assume that the biggest number for each column is the total value.
    //               for the longest name, we iterate though the rows
    longest_name: int;
    for table.data if it.name.count > longest_name then longest_name = it.name.count;
    
    array_add(*table.widths, max(longest_name, ifx table.data.count > 1 then "total".count else "name".count));
    array_add(*table.names, "name");
    
    for mem: type_info(type_of(table.total)).members {
        if mem.offset_in_bytes == 0 then continue;
        
        memory := temporary_alloc(mem.type.runtime_size);
        memcpy(memory, (cast(*u8)(*table.total)) + mem.offset_in_bytes, mem.type.runtime_size);
        result: Any;
        result.type = mem.type;
        result.value_pointer = memory;
        len := max(tprint("%", result).count, tprint("%", mem.name).count);
        
        array_add(*table.names, mem.name);  // Todo(Quattro) format the name correctly
        array_add(*table.widths, len);
    }
    print("\n");
}

print_spacer :: (table: *$T) {
    // Note(Quattro) print a separator (e.g. +-----+-----+---+------+---+)
    builder : String_Builder;
    init_string_builder(*builder);
    
    append(*builder, "+");
    for table.widths {
        for 0..it + 1 {
            append(*builder, "-");
        }
        append(*builder, "+");
    }
    
    s := builder_to_string(*builder);
    print("%\n", s);
    free(s);
}

print_names :: (table: *$T) {
    builder : String_Builder;
    init_string_builder(*builder);
    
    /* Check(Quattro) with this implementation, we get the table like this
       +-----+---------+-----+
       | ab  | a       | c   |
       ...
       but what if we wanted to make the text at the center?
    */
    
    append(*builder, "|");
    for table.names {
        s := tprint(" %", it);
        append(*builder, s);
        remainder := table.widths[it_index] - s.count + 1;
        for 0..remainder append(*builder, " ");
        append(*builder, "|");
    }
    
    s := builder_to_string(*builder);
    print("%\n", s);
    free(s);
}

print_row :: (table: *$T, idx: s64) {
    builder : String_Builder;
    init_string_builder(*builder);
    
    append(*builder, "|");

    for mem: type_info(type_of(table.total)).members {
        memory := temporary_alloc(mem.type.runtime_size);
        memcpy(memory, (cast(*u8)*(table.data[idx])) + mem.offset_in_bytes, mem.type.runtime_size);
        result: Any;
        result.type = mem.type;
        result.value_pointer = memory;
        
        s := tprint(" %", result);
        append(*builder, s);
        remainder := table.widths[it_index] - s.count + 1;
        for 0..remainder append(*builder, " ");
        append(*builder, "|");
    }
    
    s := builder_to_string(*builder);
    print("%\n", s);
    free(s);
}

print_total :: (table: *$T) {
    builder : String_Builder;
    init_string_builder(*builder);
    
    append(*builder, "|");

    for mem: type_info(type_of(table.total)).members {
        memory := temporary_alloc(mem.type.runtime_size);
        memcpy(memory, (cast(*u8)*(table.total)) + mem.offset_in_bytes, mem.type.runtime_size);
        result: Any;
        result.type = mem.type;
        result.value_pointer = memory;
        
        s := tprint(" %", result);
        append(*builder, s);
        remainder := table.widths[it_index] - s.count + 1;
        for 0..remainder append(*builder, " ");
        append(*builder, "|");
    }
    
    s := builder_to_string(*builder);
    print("%\n", s);
    free(s);
}

print_tables :: () {
    print_all_table_content :: (table: *$T) {
        init_table(table);
        print_spacer(table);
        print_names(table);
        print_spacer(table);
        for table_program.data print_row(table, it_index);
        print_spacer(table);
        if table_program.data.count > 1 {
            // no need to print the total, if there's only one row
            print_total(table);
            print_spacer(table);
        }
    }
    
    if table_general.data.count then print_all_table_content(*table_general);
    if table_program.data.count then print_all_table_content(*table_program);
    if table_image.data.count then print_all_table_content(*table_image);
    if table_audio.data.count then print_all_table_content(*table_audio);
    if table_video.data.count then print_all_table_content(*table_video);
    
    reset_temporary_storage();
}