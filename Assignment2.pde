ArrayList <Eat_me> lBall = new ArrayList <Eat_me> (); //Make array list for the balls.
ArrayList <Stay_away> evilBall = new ArrayList <Stay_away> ();

PVector theBallPosition;
PVector theBallVelocity;  

int mode;
int level;
boolean dead;

int numlBall = 150;
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
}//end setup()



Player player;


float bx = 200;
float by= height/3;

//bx, by, (bx*2), (by+70)

//rect((width/4), (height/3+150), (bx*2), (by+70)
void mousePressed()
{
  //****** PLAY IN MENU *******//
  if (mouseX > bx && mouseX < (bx*3) && mouseY > (height/3) && mouseY < (height/3 +70) )
  {
   level = 1;
   mode = 1;
  }
  //instruction box
    if (mouseX > width/4 - textWidth("Instructions") && mouseX < width/4 + textWidth("Instructions") &&
      mouseY > height/2 +200 - textWidth ("Instrctions") && mouseY < height/3 + 100 + textWidth ("Instructions"))
  {
    mode = 3;
  }

  //******* PLAY AGAIN *******//
  //if (mouseX > bx - textWidth("play again") && mouseX < (bx*3) + textWidth("play again") && 
  //  mouseY < (height/3)&& mouseY > (height/3 + 70))
  //{
  //  mode = 1;
  //  level = 1;
  //  dead = false;
  //  player.size = 20;
  //  counter = 0;
  //  numlBall = 150;
  //  numeBall = 4;

  //  for (int i = 0; i < numlBall - 1; i++)
  //  {
  //    if (lBall.size() <= numlBall)
  //    {
  //      Eat_me eat_me = new Eat_me();
  //      lBall.add(eat_me);
  //    }//end if
  //  }
  //}
  
  //******* Back to Menu ********//
  if (mouseX > width * 0.9 - textWidth("Back to Menu") && mouseX < width * 0.9 + textWidth("Back to Menu") &&
      mouseY > height * 0.9 - textWidth ("Back to Menu") && mouseY < height * 0.9 + textWidth ("Back to Menu"))
      {
        mode = 0;
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
    case 3:
    {
     instructions();
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
  rect((width/4), (height/3+150), (bx*2), (by+70)); //for instructions
  //println("by is " + by);
  textSize (40);
  fill (0);
  textAlign(CENTER);
  text("Play", (width/2), 325);
  
  text("Instructions", (width/2), (height *0.6));
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

void instructions()
{
  textSize(60);
  textAlign(CENTER);
  text("INSTRUCTIONS", (width/2), (height *0.15));
  textSize(40);
  text("Eat as many little dots as possible.\nto get to the next level.\nAvoid the red balls or you will DIE!!", width/2, (height*0.4));
  textSize(20);
  textAlign(RIGHT);
  text("Back to Menu", width * 0.9, height * 0.9);
}

int counter = 1;
int LevelOp=0;
boolean LevelOpB=false;
void playGame()
{
  switch (level)
  {


  case 1:
    {
      //****** lBall ******//
      //adds more eat_me
      if (lBall.size()< 90)
      {
        Eat_me eat_me = new Eat_me();
        lBall.add(eat_me);
      }//end if
      //println("Number of lballs " + lBall.size());
      //eat me hitbox
      break;
    }//end case 1

  case 2:
    {
      //fill(0,LevelOp);
      //textAlign(CENTER);
      //text("NEXT LEVEL",width/2,height/2);
      //if(LevelOpB==true)
      //{
      //  LevelOp=255;
      //  LevelOpB=false;
      //}
      //LevelOp--; 

      //sets lball to 80
      player.size = 20;

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
  if (counter % 200 == 0)
  {
    level++;
    //LevelOpB=true;
    //println("next level");
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
  textSize(60);
  text("Game Over", width/2, height * 0.1);
  textSize(40);
  text("Play again!", width/2, 325);

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