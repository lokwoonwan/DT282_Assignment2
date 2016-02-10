//class for the player/user
class Player
{
  float size;
  
  Player()
  {
  //theBallPosition = new PVector(width/2,height/2); 
  //theBallVelocity = new PVector(1.3,1);
  size = 20;
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
  
  //increases size by a certain amount if the current size has reached a certain radius
  void increase()
  {
    if (size <= 75)
    {
      size += 1;
    }
    
    else if (size >= 76)
    {
      size += .2;
    }
    
    //println("Ball size : " + size);
  }
}