//class for evil ball
class Stay_away
{
  //initialising variables
  float size;
  color c;
  float x;
  float y;
  
  //position of player
  PVector pos;
  PVector move;
  float xMove;
  float yMove;
  
  //constructor
  Stay_away(int speed)
  {
    //sets size and color of evil Ball
    size = 30;
    c = color(255,0,0);
    x = random(width);
    y = random(height);
    
    //position of circle
    pos = new PVector(x, y);
    
    //allows circle to move at random
    xMove = random(-speed, speed);
    yMove = random(-speed, speed);
    
    if (xMove < 1 && xMove > -1)
      xMove +=3 ;
    //if (yMove < 1 && yMove > -1)
    //  yMove += 3;
    move = new PVector(xMove, yMove);
  }
  
  //keeps evil ball within game
  void update()
  {
    pos.add(move);
    
    if (pos.x < 0)
      pos.x = width;
    if (pos.x > width)
      pos.x = 0;
    if (pos.y < 0)
      pos.y = height;
    if (pos.y > height)
      pos.y = 0;
  }
  
  //for evil Ball to be called in main
  void render()
  {
    noStroke();
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y);
    //rect(0, 0, size, size);
    ellipse(0, 0, size, size); // Placing the circle
    popMatrix();
    
  }
}