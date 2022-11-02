class Marker{ //these are the lines that mark where the robot turns
  //Useful variable (these are x and y coordinates for each line)
  int mX; 
  int mY;
  int mY2;
  
  //Constructor
  Marker(int x, int y, int y2){
    mX = x;
    mY = y;
    mY2 = y2;
    markerList.add(this); //Adding to the marker list which will be redrawn in order to show robot progress
  }
  
  void printMarker(){ //simply prints the marker, not much to it.
    line(mX,mY,mX,mY2);
  }
}
