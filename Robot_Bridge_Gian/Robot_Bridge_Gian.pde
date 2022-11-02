//WARNING! The restart button on the GUI needs to be clicked a couple of times in order to work

import g4p_controls.*; //Importing GUI thingymajiggy

boolean paused = false; //Set this boolean to false to get the program running

int frame = 1; //Our frame counter

//Array Lists which hold our many objects!
ArrayList<Robot> robotList = new ArrayList<Robot>();
ArrayList<Marker> markerList = new ArrayList<Marker>();

//Variables that connect to the GUI
int CGbotX;
int DMbotX;
int CGbotSS;
int DMbotSS;
int CGbotWS;
int DMbotWS;

//Beginning Robots (no user input yet)
//Robot parameters: x-value of starting location, y-value of start, stepsize, speed, algorithm (1 = constant growth, 2 = doubling), direction
Robot tim = new Robot(800,200,25,5,1,1);
Robot rob = new Robot(800,600,25,5,2,1);

//Setting up canvas, GUI, and loading png images that will form our movement animation
void setup(){
  background(0);
  size(1600,800);
  createGUI();
  tim.loadSprites();
  rob.loadSprites();
}

//Where the magic happens
void draw(){
  frameRate(60); //Variable framerate if your machine can't handle 60 fps
  
  //Drawing/Redrawing background to reset every frame of animation
  //Drawing Top Land
  fill(#007b00);
  rect(0,0,width,300);
  //Drawing River
  fill(#33ccff);
  rect(0,300,width,200);
  //Drawing Bottom Land
  fill(#007b00);
  rect(0,500,width,300);
  //Draw Bridge
  for(int i = 0; i < 6; i++){
    fill(#663300);
    rect(20,280+(i*40),70,40);
  }
  //Redrawing Placed Markers
  for(int i = 0; i < markerList.size(); i++){
    markerList.get(i).printMarker(); //For each marker in the array list, print the marker
  }
  
  //Here is the movement animation
  if(paused != true){ //If not paused
    for(int i = 0; i < 2; i++){ //For each item in robotList (tim and rob)
      robotList.get(i).checkBridgeProximity(); //Check proximity first (if at bridge then animation is finished)
      if(robotList.get(i).movementphase == 1){ //If the bot's movement phase is 1 (calculating mode), perform function calculateStepResult()
        robotList.get(i).calculateStepResult();
      }
      else if(robotList.get(i).movementphase == 2){ //If the bot's movement phase is 2 (actually moving), perform function moveRobot()
        robotList.get(i).moveRobot();
      }
    }
  }
}
