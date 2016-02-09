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

  PFont font;
  font = loadFont("AmericanTypewriter-48.vlw");
  textFont(font, 48);

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


float bx = 200;
float by= height/3;

//bx, by, (bx*2), (by+70)

void mousePressed()
{
  //mousepress for menu
  if (mouseX > bx && mouseX < (bx*3) && mouseY > (height/3) && mouseY < (height/3 +70) )
  {
    mode = 1;
  }
  //width/2, height/2 + 50

  if (mouseX > width/2 - textWidth("play again") && mouseX < width/2 + textWidth("play again") && 
    mouseY < (height/2 + 50)&& mouseY > (height/2 - 10))
  {
    mode = 1;
    dead = false;
    player.size = 20;
    
    for (int i = 0; i < 98; i++)
    {
      if (lBall.size() <= 100)
      {
        Eat_me eat_me = new Eat_me();
        lBall.add(eat_me);
      }//end if
    }
 
  }

  //mousepress for game over NOT WORKING
  //width/2, height/2 + 50)
  //if (mouseX > 250 && mouseX < 540 && mouseY > 400 && mouseY < 460 )
  //{
  //  mode = 1;
  //  dead = false;
  //}
}

void draw()
{

  //println(mouseX, mouseY);
  //println(lBall.size());
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
      playGame();
      break;
    }
  case 2:
    {
      gameOver();
      break;
    }
  }
}


void menu()
{
  menuBackground();

  fill (235);
  stroke(0);
  rect(width/4, height/3, (bx*2), (by+70));
  //println("by is " + by);
  textSize (40);
  fill (0);
  text("Play", (width/3 + 90), 325);
}//end menu()

void menuBackground()
{
  background (235);
  fill(255, 0, 0, 240);

  for (int i = 0; i < lBall.size(); i++)
    lBall.get(i).render();

  for (int i = 0; i < evilBall.size(); i++)
  {
    evilBall.get(i).render();
    evilBall.get(i).update();
  }//end for
}//end menuBackgrpund()

void playGame()
{
  //****** lBall ******//
  //adds more eat_me
  if (lBall.size()< 60)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }//end if

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
  
  if (evilBall.size()< 4)
  {
    Stay_away stay_away = new Stay_away(5);
    evilBall.add(stay_away);
  }//end if
  
  for (int i = 0; i < evilBall.size(); i++)
  {
    if (dist(evilBall.get(i).pos.x, evilBall.get(i).pos.y, mouseX, mouseY) < (player.size/2))
    {
      //println("remove");
      evilBall.remove(i);

      dead = true;
    }//end if
  }//end for

  for (int i = 0; i < evilBall.size(); i++)
  {
    evilBall.get(i).render();
    evilBall.get(i).update();
  }

  if (dead != true)
    player.render();

  if (dead)
    mode = 2;
}

void gameOver()
{

  background(255, 0, 0);
  textAlign(CENTER);
  fill(255);
  textSize(50);
  text("Game Over", width/2, height/2 - 100);
  text("Play again!", width/2, height/2 + 50);
  //mode = 1;
  //dead = false;
}

//void keyPressed() // User's graph selection
//{
//  if (key >= '0' && key <='3')
//  {
//    mode = key - '0';
//  }// end if
//  println(mode);
//}// end keyPressed()