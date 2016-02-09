ArrayList <Eat_me> lBall = new ArrayList <Eat_me> (); //Make array list for the balls.
ArrayList <Stay_away> evilBall = new ArrayList <Stay_away> ();

PVector theBallPosition;
PVector theBallVelocity;  

int mode;
int level;
boolean dead;

int numlBall = 100;
int numeBall = 4;


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

  //****** ADDING INITIAL OBJECTS TO START OF GAME *******//
  for (int i = 0; i <= numlBall; i++)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }

  for (int i = 0; i < numeBall; i++)
  {
    Stay_away stay_away = new Stay_away(i);
    evilBall.add(stay_away);
  }
  // ******* ******* //
}



Player player;


float bx = 200;
float by= height/3;

//bx, by, (bx*2), (by+70)

void mousePressed()
{
  //****** PLAY IN MENU *******//
  if (mouseX > bx && mouseX < (bx*3) && mouseY > (height/3) && mouseY < (height/3 +70) )
  {
    level = 1;
    mode = 1;
  }

  //******* PLAY AGAIN *******//
  if (mouseX > width/2 - textWidth("play again") && mouseX < width/2 + textWidth("play again") && 
    mouseY < (height/2 + 50)&& mouseY > (height/2 - 10))
  {
    mode = 1;
    level = 1;
    dead = false;
    player.size = 20;

    for (int i = 0; i < 98; i++)
    {
      if (lBall.size() <= numlBall)
      {
        Eat_me eat_me = new Eat_me();
        lBall.add(eat_me);
      }//end if
    }
  }
}//end mousePressed()

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
    //case 3:
    //{
    //  //instructions bar
    //  //go back to menu bar
    //}
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

int counter = 1;
void playGame()
{
   switch (level)
   {


  case 1:
  {
  //****** lBall ******//
  //adds more eat_me
  if (lBall.size()< 60)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }//end if
 println("Number of lballs " + lBall.size());
  //eat me hitbox
  break;
  }//end case 1

  case 2:
  {

  //sets lball to 80
  if (lBall.size() > 80)
  {
    for (int i = lBall.size() -1; i > 80; i--)
    {
      lBall.remove(i);
    }
  } else if (lBall.size() < 80)
  {
    for (int i = lBall.size(); i < 80; i++)
    {
      Eat_me eat_me = new Eat_me();
      lBall.add(eat_me);
    }
  }
  numeBall = 6;
  //numlBall = numlBall - 10;
break;
  }//end case 2
   }

  //** Evil Ball **//

  // Every 200 balls eaten, go up a level
  if (counter % 100 == 0)
  {
    level++;
  }

for (int i = 0; i < lBall.size(); i++)
  {
    if (dist(lBall.get(i).x, lBall.get(i).y, mouseX, mouseY) < (player.size/2))
    {
      //println("remove");
      lBall.remove(i);

      counter ++;
      println("The number of lBall eaten " + counter);

      player.increase();
    }
  }
  // shows eat me
  for (int i = 0; i < lBall.size(); i++)
    lBall.get(i).render();

  if (evilBall.size()< numeBall)
  {
    Stay_away stay_away = new Stay_away(5); //5 is speed
    evilBall.add(stay_away);
  }//end if


  for (int i = 0; i < evilBall.size(); i++)
  {
    if (dist(evilBall.get(i).pos.x, evilBall.get(i).pos.y, mouseX, mouseY) < (player.size/2))
    {
      //println("remove");
      evilBall.remove(i);

      dead = true;
      counter = 0;
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
  //}
}//end playGame()

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