function print_startup_message()

    println("")

    s = """
  
      ███████ ███████ ██████
      ██      ██      ██
      ███████ ███████ ██████
           ██      ██ ██
      ███████ ███████ ██ 
  
      """
    println(s)
end


function print_output(training_setup::Traindata_Settings,num_entries, num_trouble)
    print_startup_message()
    header = (["Setting", "value"])
    data =  [ "number meshes"                length(training_setup.meshes) ;
              "different polydegrees"        length(training_setup.polydegrees);
              "# Entries in Traindataset"    num_entries;
              "good Cells"                   num_entries - num_trouble;
              "Troubled Cells"               num_trouble;];
    pretty_table(data; header = header)
end
