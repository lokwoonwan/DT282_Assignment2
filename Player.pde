//class for the player/user
class Player
{
  float size;
  
  Player()
  {
  theBallPosition = new PVector(width/2,height/2); 
  theBallVelocity = new PVector(1.3,1);
  size = 30;
  }
  
  void render()
  {
  noStroke();
  //background(255); // Background color
  fill(100, 0, 300);
  
  //rectMode(CENTER);
  ellipseMode(CENTER);
  //rect(mouseX ,mouseY,30,30);
  ellipse(mouseX ,mouseY,size,size); // Placing the circle
  }
  
  void update()
  {
    if (size < 59)
    {
      size += 2;
    }
    
    else if (size >= 60)
    {
      size += .2;
    }
  }
  
}