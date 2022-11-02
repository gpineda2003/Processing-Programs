class Robot{ //The competitors
  //Given - stuff we take from the generic case/user inputs
  int botX;
  int botY;
  int stepSize;
  int speed;
  int algorithm; 
  int direction;
  
  //Self-Determined - generic for each robot 
  PImage[] run = new PImage[8]; //PImage array which will hold all frames of the running animation
  int spriteRun = 0; //Current frame in animation
  int movementphase = 1; //Movement phases: 1 = calculating mode (finding where next marker will be placed) 2: moving mode (travelling to marker destination)
  int factor = 1; //This will determine the size differences between each step
  int xResult; //This is a variable which holds the robot's next x-value destination where they will place a marker
  int remainder; //If the speed/walking speed doesn't fit evenly into the distance that will be walked, then store the remaining number of steps in here
  
  //Constructor
  Robot(int x, int y, int ss, int s, int a, int d){
    this.botX = x;
    this.botY = y;
    this.stepSize = ss;
    this.speed = s;
    this.algorithm = a;
    this.direction = d;
    robotList.add(this); //Adding this bot to the robot list
  }
  
  //This method loads the frames of the running animation into the array
  void loadSprites(){
    for(int i = 0; i <= 7; i++){
      run[i] = loadImage("Run (" + (i) + ").png"); //I'm pretty big brain for this
      run[i].resize(100,100); //Original image is pretty darn large
    }
  }
  
  //This is called when movementphase = 1, this is where the next destination for the marker is calculated
  void calculateStepResult(){
    createMarker(); //places marker
    this.xResult = this.botX + (this.stepSize * this.factor * this.direction); //Finding x-value of next marker location
    int distanceTravelled = int(dist(this.botX, this.botY, this.xResult, this.botY)); //Calculating distance...
    this.remainder = distanceTravelled % speed; //Calculating the remaining amount of steps if walking speed does not fit evenly within the step
    this.movementphase = 2; //After calculations are done, just move on to movement phase 2 (actually moving)
    
    //This is how much the distance walked will grow for each algorithm
    if(this.algorithm == 1){ //Constant growth? Add 1.
      this.factor += 1;
    }
    else if(this.algorithm == 2){ //Doubling Method? Get multiplied by 2!
      this.factor = this.factor * 2;
    }
  }
  
  //Let's actually move this thing!
  void moveRobot(){
    if(this.botX + (this.remainder*this.direction) == this.xResult){ //If the bot's x value plus the remainder is equal to the destination's x-value, just add the remainder, print the robot, reset all values, and go back to calculating next destination
      this.botX = this.botX + (this.remainder*this.direction);
      this.printRobot();
      this.remainder = 0;
      this.direction = this.direction*-1;
      this.movementphase = 1;
    }
    else if(this.botX + (this.remainder*this.direction) != this.xResult){//If the distance is greater than the remainder, just add the movement speed and print the robot like normal.
      this.botX = this.botX + (this.speed*this.direction);
      this.printRobot();
    }
  }
  
  //Prints our animation!
  void printRobot(){
    image(run[this.spriteRun],this.botX-50,this.botY-50); //THIS IS WHY I PUT ALL THE FRAMES IN AN ARRAY! MARVEL AT MY GENIUS! jk, its pretty stinky.
    frame += 1;
    this.spriteRun = this.spriteRun + 1; //Move on to next frame in running animation
    if(this.spriteRun >= 7){ //If the counter surpasses the max amount of frames, reset the count to 0.
      this.spriteRun = 0;
    }
  }
  
  //Creates Marker objects that will become a part of the enivronment
  void createMarker(){
    if(this == robotList.get(0)){ //If belonging to Constant Growth Robot:
      //line(this.botX-50,300,this.botX-50,200);
      new Marker(this.botX, 300, 200);
    }
    else if(this == robotList.get(1)){ //If belonging to Doubling Method Robot:
      //line(this.botX-50,500,this.botX-50,600);
      new Marker(this.botX, 500, 600);
    }
  }
  
  //Checks how close the bridge is for a robot.
  void checkBridgeProximity(){
    if((this.botX >= 20) && (this.botX <= 70)){ //if within the bridge's width, pause the animation.
      paused = true;
    }
  }
}
