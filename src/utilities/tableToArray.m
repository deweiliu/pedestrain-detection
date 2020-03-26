function array = tableToArray(table)
    array = table;

    if istable(table)
        array = table2array(array);
    end

end
