//class for the player/user
class Player
{
  
  Player()
  {
  theBallPosition = new PVector(width/2,height/2); 
  theBallVelocity = new PVector(1.3,1);
  }
  
  void render()
  {
  noStroke();
  background(255); // Background color
  fill(100, 0, 100);
  ellipseMode(CENTER);
  ellipse(mouseX ,mouseY,30,30); // Placing the circle
  }
  
}