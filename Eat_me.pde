//Class for edible balls
class Eat_me
{
  //initialise size, color 
  float size;
  color c;
  float x;
  float y;
  
  //constructor
  Eat_me()
  {
    //sets initial size and color
    size = 10;
    c = color(random(255), random(255), random(255));
    x = random(width);
    y = random(height);
  }
  
  // render method to be called in main
  void render()
  {
    noStroke();
    fill(c);
    //rect(x, y, size, size);
    ellipse(x, y, size, size); // Placing the circle
  }
}