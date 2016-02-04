class Stay_away
{
  float size;
  color c;
  float x;
  float y;
  
  PVector pos;
  PVector move;
  float xMove;
  float yMove;
  
  //constructor
  Stay_away(int speed)
  {
    size = 20;
    c = color(255,0,0);
    x = random(width);
    y = random(height);
    
    pos = new PVector(x, y);
    
    xMove = random(-speed, speed);
    yMove = random(-speed, speed);
    
    if (xMove < 1 && xMove > -1)
      xMove +=3 ;
    //if (yMove < 1 && yMove > -1)
    //  yMove += 3;
    move = new PVector(xMove, yMove);
  }
  
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
  
  void render()
  {
    noStroke();
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, size, size); // Placing the circle
    popMatrix();
    
  }
}