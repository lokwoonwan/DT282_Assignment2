//void setup()
//{
//  size (500, 500);
//  background(255);
//}

//void draw()
//{
//  menu();
//}

//void menu()
//{
//  background (0);
//  textAlign(CENTER);
//  stroke(0);
//  text ("Menu", width/2, height/2 - 100);
  
//}

PVector theBallPosition;
PVector theBallVelocity;
 
void setup(){
  smooth();
  frameRate(60);
  size(400,400);
 
  theBallPosition = new PVector(width/2,height/2); 
  theBallVelocity = new PVector(1.3,1); 
}
 
void draw(){
  noStroke();
  background(100,0,200); // Background color
  ellipseMode(CENTER);
  ellipse(mouseX,mouseY,30,30); // Placing the circle
}