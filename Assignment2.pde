//imports minim library to allow music file
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
  }//end for

  for (int i = 0; i < numeBall; i++)
  {
    Stay_away stay_away = new Stay_away(i);
    evilBall.add(stay_away);
  }//end for

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

// Press mouse to go into different cases
void mousePressed()
{
  // If mouse pressed when over "Start Game" change level to be first and game mode to be playing
  if (mouseX > width * 0.25f && mouseX < width * 0.75f && mouseY > (height/3) && mouseY < height/3 + by)
  {
    level = 1;
    mode = 1;
    dead = false;
  }//end if

  // If mouse pressed when over "Instructions", goes to case 3 (instruction method)
  if (mouseX > width * 0.25f && mouseX < width * 0.75f && mouseY > height * 0.52f && mouseY < height * 0.52f + by)
  {
    mode = 3;
  }//end if

  // If mouse pressed when over "Play Again", allows user to enter game again
  textSize(40);
  float tWidth = textWidth("Play Again");
  if (mouseX > width/2 - tWidth && mouseX < width/2 + tWidth && 
    mouseY < 325 && mouseY > 265)
  {
    // Reset all variables back to initial values for restart of game
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
    }//end for
  }//end if

  // If mouse pressed when over "Back to Menu", switches back to the menu case
  if (mouseX > width * 0.9 - textWidth("Back to Menu") && mouseX < width * 0.9 + textWidth("Back to Menu") &&
    mouseY > height * 0.9 - textWidth ("Back to Menu") && mouseY < height * 0.9 + textWidth ("Back to Menu"))
  {
    mode = 0;
  }//end if
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
    }//end case 1
  case 2:
    {
      gameOver();
      break;
    }//end case 2
  case 3:
    {
      instructions();
      break;
    }//end case 3
  }//end switch
}//end draw()


void menu()
{
  // calls menu background
  menuBackground();

  // draws rect and texts to allow user to click into options
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

// method to make the menu background look purty
void menuBackground()
{
  background (235);
  fill(255, 0, 0, 240);

  // calling render method for each edible ball
  for (int i = 0; i < lBall.size(); i++)
    lBall.get(i).render();

  // calling render + update method for each evil ball
  for (int i = 0; i < evilBall.size(); i++)
  {
    evilBall.get(i).render();
    evilBall.get(i).update();
  }//end for
}//end menuBackgrpund()

// instruction method, tells user how to play game. Allows user to go back to menu.
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
}//end instructions()

// Game over method called when dead = true. Allows user to restart or go back to menu
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
}//end gameOver()

int counter = 1;
void playGame()
{
  textAlign(CENTER);
  fill(0);
  textSize(35);
  // Shows user what level they are on
  text("Level: " + level, width * 0.5f, height * 0.05f); 
  textSize(15);
  // Tells user how many balls to eat until level up
  text("Balls until level up: " + (100 - counter), width * 0.85f, height * 0.95f);

  //switch statement to change levels
  switch (level)
  {
  //level 1
  case 1:
    {
      // If ball setup for this level has not yet been completed
      if (levelSetting == 0)
      {
        // Call function that will ensure there is correct number of balls to start the level
        ballSetup(numlBall);        
        // Update value of levelSetting, so that this if statement won't execute again while on this level
        levelSetting = 1;
        // Update number of eatable balls for next level
        numlBall = 80;
      }//end if

      if (levelStart == false)
        levelCountdown();

      // Ensures there is always n number of eat me balls onscreen for this level
      minNumBalls(60);
      break;
    }//end case 1

  //level 2
  case 2:  
    {
      if (levelSetting == 1)
      {
        //levelTimer = 0;
        ballSetup(numlBall);        
        levelSetting = 2;
        numlBall = 60;
        player.size -= 15;
        // Increase number of evil balls
        numeBall = 6;
      }//end if

      if (levelStart == false)
        levelCountdown();

      minNumBalls(40);
      break;
    }//end case 2
    
  //level 3
  case 3:
    {
      if (levelSetting == 2)
      {
        ballSetup(numlBall);        
        levelSetting = 3;
        // Increase number of evil balls
        numeBall = 8;
        player.size -= 15;
      }//end if

      if (levelStart == false)
        levelCountdown();

      minNumBalls(30);
      break;
    }//end case 3
  } // End Switch

  // Every 100 balls eaten, go up a level
  if (counter == 100)
  {
    level++;
    counter = 1;
    levelStart = false;
  }//end if

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
      }//end if
    }//end for
  }//end if

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
  }//end for

  // If number of evil balls is less than it should be, add more (this happens on level up, when more evil balls are required)
  if (evilBall.size() < numeBall)
  {
    // Find how many more balls are required by taking the current number away from the desired amount
    // Then loop (and add) that many evil balls
    for (int i = 0; i < numeBall - evilBall.size(); i++)
    {
      Stay_away stay_away = new Stay_away(5); //5 is speed
      evilBall.add(stay_away);
    }//end for
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

// Makes sure number of edible balls are up to date
void ballSetup(int numberBalls)
{
  // Adds or takes away edible balls, until there is the correct number for the level
  if (lBall.size() > numberBalls)
  {
    for (int i = lBall.size() -1; i > numberBalls; i--)
    {
      lBall.remove(i);
    }//end for
  } //end if
  else if (lBall.size() < numberBalls)
  {
    for (int i = lBall.size(); i < numberBalls; i++)
    {
      Eat_me eat_me = new Eat_me();
      lBall.add(eat_me);
    }//end for
  }//end else if
}//end ballSetup()

//Gives breaks between different levels
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
  }//end if
}//end levelCountdown()

//add edible balls if not enough
void minNumBalls(int numberBalls)
{
  if (lBall.size() < numberBalls)
  {
    Eat_me eat_me = new Eat_me();
    lBall.add(eat_me);
  }//end if
}//end minNumBalls()