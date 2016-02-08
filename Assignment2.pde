//void setup()
//{
//  size (500, 500);
//  background(255);
//}


ArrayList <Eat_me> lBall = new ArrayList <Eat_me> (); //Make array list for the balls.
ArrayList <Stay_away> evilBall = new ArrayList <Stay_away> ();

PVector theBallPosition;
PVector theBallVelocity;  

int mode;
boolean dead;

void setup()
{
  smooth();
  frameRate(60);
  size(800, 800);

  player = new Player();
  dead = false;

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
  
  println(mouseX, mouseY);
  background (255);

  switch(mode)
  {
  case 0:
    {
      menu();
      break;
    }// End case 0

  case 1:
    {
      //adds more eat_me
      if (lBall.size()< 60)
      {
        Eat_me eat_me = new Eat_me();
        lBall.add(eat_me);
      }

      //eat me hitbox
      for (int i = 0; i < lBall.size(); i++)
      {
        if (dist(lBall.get(i).x, lBall.get(i).y, mouseX, mouseY) < (player.size/2))
        {
          //println("remove");
          lBall.remove(i);

          player.increase();
        }
      }

      // shows eat me
      for (int i = 0; i < lBall.size(); i++)
        lBall.get(i).render();

      //** Evil Ball **//
      for (int i = 0; i < evilBall.size(); i++)
      {
        if (dist(evilBall.get(i).pos.x, evilBall.get(i).pos.y, mouseX, mouseY) < (player.size/2))
        {
          //println("remove");
          evilBall.remove(i);

          dead = true;
        }
      }

      for (int i = 0; i < evilBall.size(); i++)
      {
        evilBall.get(i).render();
        evilBall.get(i).update();
      }

      if (dead != true)
        player.render();

      if (dead)
        gameOver();
      break;
    }
  }
}

void menu()
{
  //boolean overPlay = false;
  float bx = 200;
  float by= height/3;
  
  rect(bx, by, (bx*2), 100);
  fill (0);
  text("testing" , width/2, 318);
  fill (255);
  
  //if (mouseX > bx) && mouseX < (bx*2) &&
  //   mouseY > (200, 369) && mouseY < (600, 369) )
  //   {
  //   overPlay = true;
  //   }
  // Menu
  //textAlign(CENTER);
  //stroke(0);
  //textSize(50);
  //fill (255);
  //text(" Menu ", width/2, height/2 - 100);
  //textSize(20);
  //fill(random(255), random(255), random(255));
  //text(" Press 1 to play!", width/2, height/2 - 50);
}

void gameOver()
{

  background(255, 0, 0);
  textAlign(CENTER);
  fill(255);
  textSize(50);
  text("Game Over", width/2, height/2 - 100);
}

void keyPressed() // User's graph selection
{
  if (key >= '0' && key <='3')
  {
    mode = key - '0';
  }// end if
  println(mode);
}// end keyPressed()