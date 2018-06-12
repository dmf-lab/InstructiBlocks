class logFile {
  PrintWriter log_file;
  String time_string;
  String entry;
  String string_to_print;
  String header_line;
  int prev_time;
  int current_time;
  int log_time;
  int selected;
  int prev_page = 0;
  int current_page;


  void init() {
    this.timeString();

    log_file = createWriter("data/log_files/log_file_"+time_string+".tsv");

    //int selected;
    header_line = "time\tparticipant\trule_order";
    log_file.println(header_line);
  }

  void recordEntry() {


    current_page = pageSelected;
    //if (current_page == 0 && prev_page == final_page) {

      participant_string = "P"+ nf(participant, 3);
      entry = entryTimeStamp() + "\t" + participant_string +"\t" + str(rule_order.get(0)) + str(rule_order.get(1)) + str(rule_order.get(2));

      log_file.println(entry);
      log_file.flush();
      println("Log File entry recorded");
    //}
    prev_page = current_page;
  }

  void endLog() {
    // run on escape/exit, add to main sketch;
    /*
    void exit() {
     log.endLog();
     super.exit();
     }
     */
    log_file.flush(); // Writes the remaining data to the file
    log_file.close(); // Finishes the file
    println("Log File Saved...");
  }

  void timeString() {
    String y = str(year());
    String m = str(month());
    String d = str(day());
    String h = str(hour());
    String min = str(minute());
    String s = str(second());
    // Following if statements add leading zeros
    if (h.length() < 2) {
      h = "0" + h;
    }
    if (min.length() < 2) {
      min = "0" + min;
    }
    if (m.length() < 2) {
      m = "0" + m;
    }
    if (d.length() < 2) {
      d = "0" + d;
    }
    if (s.length() < 2) {
      s = "0" + s;
    }

    time_string = y+"-"+m+"-"+d+"_"+h+"-"+min+"-" +s;
  }

  String entryTimeStamp() {
    String h = str(hour());
    String min = str(minute());
    String s = str(second());
    // Following if statements add leading zeros
    if (h.length() < 2) {
      h = "0" + h;
    }
    if (min.length() < 2) {
      min = "0" + min;
    }
    if (s.length() < 2) {
      s = "0" + s;
    }

    String entry_time_stamp = h+":"+min+":"+s;
    return entry_time_stamp;
  }
}