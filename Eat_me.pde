class Eat_me
{
  float size;
  color c;
  float x;
  float y;
  //constructor
  Eat_me()
  {
    size = 10;
    c = color(random(255), random(255), random(255));
    x = random(width);
    y = random(height);
  }
  
  void render()
  {
    noStroke();
    fill(c);
    ellipse(x, y, size, size); // Placing the circle
  }
}