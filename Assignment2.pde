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

  for (int i = 0; i < 100; i++)
  {
     Eat_me eat_me = new Eat_me();
     lBall.add(eat_me);
  }
  
   for (int i = 0; i < 4; i++)
   {
     Stay_away stay_away = new Stay_away(i);
     evilBall.add(stay_away);
   }
}



Player player;


void draw()
{
  background (255);
  
  if (lBall.size()< 60)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }
  
  for (int i = 0; i < lBall.size(); i++)
   {
    if (dist(lBall.get(i).x, lBall.get(i).y, mouseX, mouseY) < (player.size/2))
    {
      println("remove");
      lBall.remove(i);
      
      player.update();
    }
   }
  
  for (int i = 0; i < lBall.size(); i++)
    lBall.get(i).render();
    
   for (int i = 0; i < 4; i++)
   {
     evilBall.get(i).render();
     evilBall.get(i).update();
   }
   
   player.render();
   
   
   
}