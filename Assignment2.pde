//void setup()
//{
//  size (500, 500);
//  background(255);
//}

//void draw()
//{
//  menu();
//}

ArrayList <Eat_me> lBall = new ArrayList <Eat_me> (); //Make array list for the balls.
ArrayList <Stay_away> evilBall = new ArrayList <Stay_away> ();

PVector theBallPosition;
PVector theBallVelocity;

void setup()
{
  smooth();
  frameRate(60);
  size(800, 800);
  
  player = new Player();

  for (int i = 0; i < 50; i++)
  {
     Eat_me eat_me = new Eat_me();
     lBall.add(eat_me);
  }
  
   for (int i = 0; i < 5; i++)
   {
     Stay_away stay_away = new Stay_away(i);
     evilBall.add(stay_away);
   }
}



Player player;


void draw()
{
  player.render();
  for (int i = 0; i < 50; i++)
    lBall.get(i).render();
    
   for (int i = 0; i < 5; i++)
   {
     evilBall.get(i).render();
     evilBall.get(i).update();
   }
}