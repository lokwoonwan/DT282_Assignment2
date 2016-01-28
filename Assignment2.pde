//void setup()
//{
//  size (500, 500);
//  background(255);
//}

//void draw()
//{
//  menu();
//}


PVector theBallPosition;
PVector theBallVelocity;
 
void setup()
{
  smooth();
  frameRate(60);
  size(800,800); 
  
}


Player player;
 
void draw()
{
  player = new Player();
}