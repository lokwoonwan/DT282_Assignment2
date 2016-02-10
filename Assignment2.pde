import ddf.minim.*;

// Arraylist of balls to be eaten
ArrayList <Eat_me> lBall = new ArrayList <Eat_me> ();
// Arraylist of evil balls, those that kill the player
ArrayList <Stay_away> evilBall = new ArrayList <Stay_away> ();

//PVector theBallPosition;
//PVector theBallVelocity;  

// Variable for the game mode: Intro screen, playing game & game over
int mode;
// Boolean to determine if player is dead
boolean dead = false;
// Variable to control level of game
int level = 0;
// Variable to control operations upon level up
// Having this variable ensures certain operations are only executed once per time spent on level
int levelSetting = 1;

// Variable to time entry to next level
int levelTimer = 180;
int levelCountdown = 3;
boolean levelStart = false;

// Number of eatable balls
int numlBall = 150;
// Number of evil balls
int numeBall = 4;

// Music library for game
Minim minim;
AudioPlayer HMusic;



void setup()
{
  smooth();
  frameRate(60);
  size(800, 800);
  bx = width * 0.5f;
  by = height * 0.12f;
  
  // Loading custom font
  PFont font;
  font = loadFont("AmericanTypewriter-48.vlw");
  textFont(font, 48);

  // Creating new player
  player = new Player();
  dead = false;

  // Adding new dots to the initial game
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
  
  // Creates the sound file
  minim = new Minim(this);
  
  // Plays music file
  HMusic = minim.loadFile("HMusic.mp3");
  HMusic.play();
  // Loops the sound file so that it replays
  HMusic.loop();
}//end setup()

Player player;

// Size of "start game" box
float bx;
float by;

//bx, by, (bx*2), (by+70)

//rect((width/4), (height/3+150), (bx*2), (by+70)
void mousePressed()
{
  //****** PLAY IN MENU *******//
  if (mouseX > width * 0.25f && mouseX < width * 0.75f && mouseY > (height/3) && mouseY < height/3 + by)
  {
   level = 1;
   mode = 1;
   dead = false;
  }
  //instruction box
  if (mouseX > width * 0.25f && mouseX < width * 0.75f && mouseY > height * 0.52f && mouseY < height * 0.52f + by)
  {
   mode = 3;
  }

  //******* PLAY AGAIN *******//
  textSize(40);
  float tWidth = textWidth("Play Again");
  //******* PLAY AGAIN *******//
  if (mouseX > width/2 - tWidth && mouseX < width/2 + tWidth && 
    mouseY < 325 && mouseY > 265)
  {
    println("this");
    // Reset all variables for restart of game
    mode = 1;
    counter = 1;
    level = 1;
    levelSetting = 0;
    levelTimer = 180;
    levelCountdown = 3;
    levelStart = false;
    dead = false;
    player.size = 20;
    numlBall = 100;
    numeBall = 4;

    lBall.clear();
    evilBall.clear();
    for (int i = 0; i <= numlBall; i++)
    {
      Eat_me eat_me = new Eat_me();
      lBall.add(eat_me);
    }
  }

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
  rectMode(CORNER);
  rect(width * 0.25f, height/3, bx, by);
  rect(width * 0.25f, height * 0.52f, bx, by);
   //for instructions
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

void gameOver()
{
  background(255, 0, 0);
  textAlign(CENTER);
  fill(255);
  textSize(60);
  text("Game Over", width/2, height * 0.1);
  textSize(40);
  text("Play again!", width/2, 325);
  textSize(20);
  textAlign(RIGHT);
  text("Back to Menu", width * 0.9, height * 0.9);
  dead = false;
}

int counter = 1;
void playGame()
{
  textAlign(CENTER);
  fill(0);
  textSize(35);
  text("Level: " + level, width * 0.5f, height * 0.05f); 
  textSize(15);
  text("Balls until level up: " + (100 - counter), width * 0.85f, height * 0.95f);

  switch (level)
  {
  case 1:
    // If ball setup for this level has not yet been completed
    if (levelSetting == 0)
    {
      // Call function that will ensure there is correct number of balls to start the level
      ballSetup(numlBall);        
      // Update value of levelSetting, so that this if statement won't execute again while on this level
      levelSetting = 1;
      // Update number of eatable balls for next level
      numlBall = 80;
    }

    if (levelStart == false)
      levelCountdown();

    // Ensures there is always n number of eat me balls onscreen for this level
    minNumBalls(60);
    break;

  case 2:  
    if (levelSetting == 1)
    {
      //levelTimer = 0;
      ballSetup(numlBall);        
      levelSetting = 2;
      numlBall = 60;
      player.size -= 15;
      // Increase number of evil balls
      numeBall = 6;
    }

    if (levelStart == false)
      levelCountdown();

    minNumBalls(40);
    break;

  case 3:
    if (levelSetting == 2)
    {
      ballSetup(numlBall);        
      levelSetting = 3;
      // Increase number of evil balls
      numeBall = 8;
      player.size -= 15;
    }

    if (levelStart == false)
      levelCountdown();

    minNumBalls(30);
    break;
  } // End Switch

  // Every 100 balls eaten, go up a level
  if (counter == 100)
  {
    level++;
    counter = 1;
    levelStart = false;
  }

  if (levelStart)
  {
    // If player ball is touching an eatable ball, remove the eatable ball, increase the eaten counter and increase the size of the player
    for (int i = 0; i < lBall.size(); i++)
    {
      if (dist(lBall.get(i).x, lBall.get(i).y, mouseX, mouseY) < (player.size/2))
      {
        lBall.remove(i);
        counter ++;
        player.increase();
      }
    }
  }

  // Display all eat me balls
  for (int i = 0; i < lBall.size(); i++)
    lBall.get(i).render();

  // Show and move evil balls
  for (int i = 0; i < evilBall.size(); i++)
  {
    evilBall.get(i).render();
    // Only move balls if level has started
    if (levelStart)
      evilBall.get(i).update();
  }

  // If number of evil balls is less than it should be, add more (this happens on level up, when more evil balls are required)
  if (evilBall.size() < numeBall)
  {
    // Find how many more balls are required by taking the current number away from the desired amount
    // Then loop (and add) that many evil balls
    for (int i = 0; i < numeBall - evilBall.size(); i++)
    {
      Stay_away stay_away = new Stay_away(5); //5 is speed
      evilBall.add(stay_away);
    }
  }//end if

  // If player ball is touching an evil ball, set dead to be true, mode to be game over (2) and reset eaten counter
  for (int i = 0; i < evilBall.size(); i++)
  {
    if (dist(evilBall.get(i).pos.x, evilBall.get(i).pos.y, mouseX, mouseY) < (player.size/2))
    {
      //evilBall.remove(i);

      dead = true;
      mode = 2;
    }//end if
  }//end for

  // Show the player ball if they are not dead
  if (dead != true)
    player.render();
}//end playGame()

void ballSetup(int numberBalls)
{
  // Adds or takes away eatable balls, until there is the correct number for the level
  if (lBall.size() > numberBalls)
  {
    for (int i = lBall.size() -1; i > numberBalls; i--)
    {
      lBall.remove(i);
    }
  } else if (lBall.size() < numberBalls)
  {
    for (int i = lBall.size(); i < numberBalls; i++)
    {
      Eat_me eat_me = new Eat_me();
      lBall.add(eat_me);
    }
  }
}

void levelCountdown()
{ 
  textSize(45);
  fill(0);
  text(levelCountdown + ". . ", width * 0.5f, height * 0.5f);
  levelTimer--;
  if (levelTimer % 60 == 0)
    levelCountdown--;
  if (levelTimer == 0)
  {
    levelStart = true;
    levelTimer = 180;
    levelCountdown = 3;
  }
}

void minNumBalls(int numberBalls)
{
  if (lBall.size() < numberBalls)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }//end if
}


//void keyPressed() // User's graph selection
//{
//  if (key >= '0' && key <='3')
//  {
//    mode = key - '0';
//  }// end if
//  println(mode);
//}// end keyPressed()