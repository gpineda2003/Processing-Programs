void setup() {
  int[][] numbers = new int[6][9];
 
  for(int i = 0; i < 6; i++){
    for(int j = 0; j < 9; j++){
      numbers[i][j] = round(random(0,20));
      print(numbers[i][j] + "\t");
    }
    println();
  }
  println();
  
  for(int j = 0; j < numbers[0].length; j++) {
    int sumColumn = 0;
    
    for(int i = 0; i < numbers.length; i++) {
      sumColumn = sumColumn + numbers[i][j];
    }
    println("The sum of column " + (j+1) + " is " + sumColumn + ".");
  }
  
  println();
  
  for(int i = 0; i < numbers.length; i++) {
    int sumRow = 0;
    
    for(int j = 0; j < numbers[0].length; j++) {
      sumRow = sumRow + numbers[i][j];
    }
    println("The sum of row " + (i+1) + " is " + sumRow + ".");
  }
}
