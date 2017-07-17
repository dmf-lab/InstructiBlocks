
void loadDatabase(String filename) {

  // first load the CSV file into a Table object
  csv_table = loadTable(filename, "header");  

  // set size of bricks array to the number of rows in the CSV file
  bricks = new brick[csv_table.getRowCount()];

  // now iterate through all rows in the table
  int rowCount = 0;
  for (TableRow row : csv_table.rows()) {
    // You can access the fields via their column name (or index)
    String rfid_ = row.getString("rfid");
    String type_ = row.getString("type");
    String info_ = row.getString("info");
    String name1_ = row.getString("name1");
    String rule1_ = row.getString("rule1");
    String name2_ = row.getString("name2");
    String rule2_ = row.getString("rule2");
    String name3_ = row.getString("name3");
    String rule3_ = row.getString("rule3");
    String rule4_ = row.getString("rule4");

    // Make a bricks object out of the data read
    bricks[rowCount] = new brick(rfid_, type_, info_, name1_, rule1_, name2_, rule2_, name3_, rule3_, rule4_);
    rowCount++;
  }
}