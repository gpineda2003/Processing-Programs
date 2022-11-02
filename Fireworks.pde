/////////////////////////////////////////////////////////////////////////////////////////////////////////
// CONTROLS - CLICK ANYWHERE TO SUMMON A FIREWORK, WAIT UNTIL FIREWORK IS OVER TO CLICK/SUMMON ANOTHER //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//Global Variable Declaration
float cellSize; //bruh 
int peak; //peak of each firework
int xC; //Center point of each explosion's x value
int yC; //Center point of each explosion's y value
int fwsize; //Size of explosion grid for firework
int fadecounter; //Counts amount of squares in "fade" state (used in detecting when updateFade() is done.

//User Modifiable
int n = 80; //User may change Length and height of square grid
int userinputrate = 30; //User may input the max amount that can be subtracted from the colour values (rate value) Range: 1 to 255
int fps = 60; // User may input frames per second

//Global Array Declaration
String[][] cells = new String[n][n]; //Possible states are "sky", "fw" (firework), "explosion".
boolean [][] explosioncells = new boolean[n][n]; //Explosion cells will be marked with booleans to avoid running random colour-setting code on the same cell
int[][] red = new int[n][n]; //Red value of cell
int[][] green = new int[n][n]; //Green
int[][] blue = new int[n][n]; //Blue

boolean[][] fadecells = new boolean[n][n]; //Discerns whether or not a cell has been used in the updateFade() function

//Firework Phase Booleans - determine what phase and functions we use
boolean fwinprogress = false;
boolean fwlaunched = false;
boolean fwexplosion = false;
boolean fwfade = false;
boolean fwreset = false;

//Executes on startup
void setup(){
  size(800,800); //Creates background
  cellSize = width/n; //Determines cell height/width
  frameRate(fps);  //makes framerate equivalent to the user determined fps
  
  generateNightSky(); //Generate "sky" cell states
  generateFalseExplosionCells(); //Set all explosioncells to false
  generateRandomColours(); //Randomly set ally the colours for explosion cells
}

//Runs animation 
void draw() {
  float y = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      float x = j * cellSize;
      if(cells[i][j] == "sky") {
        fill(0);
      }
      else if(cells[i][j] == "fw") {
        fill(0 + ((255/n) * (i - peak)));
      }
      else if(cells[i][j] == "explosion") {
        fill(red[i][j], green[i][j], blue[i][j]); //Use preset random colours that we generated earlier
      }
      else if(cells[i][j] == "fade") {
        //println(red[i][j], green[i][j], blue[i][j]); //Test statement
        fill(red[i][j], green[i][j], blue[i][j]);
        if (i < (n-1)) {
          red[i+1][j] = max(0, (red[i][j] - (max(0,(round(random(0,userinputrate))))))); //Subtract a randomized value (from the range of 0 - userinputrate) from the previous red value (minimum value is 0)
          green[i+1][j] = max(0,(green[i][j] - (max(0,(round(random(0,userinputrate))))))); //^Same for green and blue
          blue[i+1][j] = max(0, (blue[i][j] - (max(0,(round(random(0,userinputrate)))))));
        }
        else { //If no cell below, just set colour to black
          red[i][j] = 0;
          green[i][j] = 0;
          blue[i][j] = 0;
        }
      }
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize; //Increment statement
  }
  detectPhase(); //<---- literally does that
}

//Generates night sky
void generateNightSky() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cells[i][j] = "sky";
      }
    }
}

//Generates false values for explosioncells array
void generateFalseExplosionCells() {
  for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        explosioncells[i][j] = false;
      }
  }
}

//Generates random colours for explosion animation
void generateRandomColours() {
  for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        red[i][j] = round(random(0,255));
        green[i][j] = round(random(0,255));
        blue[i][j] = round(random(0,255));
      }
  }
}

//Main phase detection sequence - alot of phase switching here, boolean values are set in the functions
void detectPhase() {
  if(fwinprogress == true) {
    if(fwlaunched == true) {
      updateLaunch();
    }
    else if(fwexplosion == true) {
      updateExplosion();
    }
    else if(fwfade == true) {
      if(checkFade() == true) {
        fwfade = false;
        fwreset = true;
      }
      updateFade();
    }
    else if(fwreset == true) { //Resets all values used for previous firework
      fwinprogress = false;
      cells = new String[n][n]; //Possible states are "sky", "fw" (firework), "explosion".
      explosioncells = new boolean[n][n];
      red = new int[n][n];
      green = new int[n][n];
      blue = new int[n][n];
      fadecells = new boolean[n][n];
      xC = 0;
      yC = 0;
      
      generateNightSky();
      generateFalseExplosionCells();
      generateRandomColours();
      
    }
  }
}

//Beginning firework sequence on mouse click
void mouseClicked() {
  int mj = int(mouseX / cellSize);
  if(fwinprogress == false) {
    fwsize = round(random(10,15));
    cells[n-1][mj] = "fw";
    peak = int(random(1, ((n/2)))) + fwsize;
    fwinprogress = true;
    fwlaunched = true;
  }
}

//For updating cell states in launch sequence
void updateLaunch() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if(cells[i][j] == "fw") {
        if(i < peak) {
          fwlaunched = false;
          fwexplosion = true;
        }
        else {
          cells[i-1][j] = "fw";
          cells[i][j] = "sky";
        }
      }
    }
  }
}

//For updating cell states in explosion sequence
void updateExplosion() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if(cells[i][j] == "fw" && xC == 0 && yC == 0) {
        xC = j;
        yC = i;
        cells[i][j] = "sky";
      }
    }
  }
  int ecounter = 0;
  for (int u = -fwsize ; u <= fwsize; u++) {
    for (int v = -fwsize ; v <= fwsize; v++) {
      int rn = round(random(0,2));
      try {
        if (explosioncells[yC + u][xC + v] == false && rn == 0) {
          cells[yC + u][xC + v] = "explosion";
        }
      }
      catch(Exception ArrayIndexOutOfBoundsException) {
      }
      try {
        explosioncells[yC + u][xC + v] = true;
      }
      catch(Exception ArrayIndexOutOfBoundsException) {
      }
    }
    ecounter += 1;
  }
  if(ecounter > fwsize) {
      fwfade = true;
      fwexplosion = false;
      explosiontofade();
  }
}

//Converts all explosion cells to fade ones in preparation for next sequence
void explosiontofade() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if(cells[i][j] == "explosion") {
        cells[i][j] = "fade";
      }
    }
  }
}

//Updates fade animation
void updateFade() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      fadecells[i][j] = false;
      try {
      if (cells[i][j] == "fade" && i == 0) {
         cells[i+1][j] = "fade";
         cells[i][j] = "sky";
        }
      else if (cells[i][j] == "fade" && fadecells[i-1][j] == false) {
        cells[i+1][j] = "fade";
        fadecells[i][j] = true;
        cells[i][j] = "sky";
        }
      }
      catch(Exception e) {
      }
    }
  }
}

//Returns true or false depending if all there are remaining fade cells
boolean checkFade() {
  fadecounter = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if(cells[i][j] == "fade") {
        fadecounter += 1;
      }
    }
  }
  if((fadecounter - 70) <= 0) { //An issue I've been having is understanding why my fadecounter never hits 0, so I had to do this for a quick fix. I'm sorry, I need the time.
    return true;
  }
  else {
    return false;
  }
}

      
