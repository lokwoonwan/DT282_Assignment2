//class for the player/user
class Player
{
  
  Player()
  {
  theBallPosition = new PVector(width/2,height/2); 
  theBallVelocity = new PVector(1.3,1);
  
  noStroke();
  background(100,0,200); // Background color
  ellipseMode(CENTER);
  ellipse(mouseX,mouseY,30,30); // Placing the circle
  }
  
}