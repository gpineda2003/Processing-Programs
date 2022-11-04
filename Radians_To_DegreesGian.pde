// Enter the radian input here
String input = "11pi/135";
PFont f;

void setup() {
  size(500, 500);
  background(0);
  f = createFont("Cambria", 20);
  textFont( f );
  
  String numString, denString;
  float numerator, denominator;
  
  int xC = width / 5;
  int yC = height / 2;
  
  int pi = input.indexOf("pi");

  if (pi == 0) 
      numerator = 1;
    
  else {
      numString = input.substring(0, pi);
      numerator = int( numString );
  }

  if (input.indexOf("/") == -1) 
    denominator = 1;
    
  else {
    denString = input.substring( pi+3 );
    denominator = int( denString );
  }

  float angle = 180*numerator/denominator;
  String answerString = numerator + "\u03C0" + "/" + denominator + " radians" + " = " + angle + "\u00B0";
  drawAnswer(answerString, xC, yC);
  drawAngle(angle);
}
  void drawAnswer(String answer , int x, int y) {
    fill(255);
    text(answer, x, y);
  }
  
  void drawAngle( float angle) {
  noFill();

  stroke(255);
  ellipse(250, 350, 100, 100);
  
  fill(0,255,0);
  arc(250, 350, 100, 100, 2*PI-radians(angle), 2*PI);
  }
