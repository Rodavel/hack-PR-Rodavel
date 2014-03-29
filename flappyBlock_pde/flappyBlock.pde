color exampleColor = color(255,255,0);
Block example;
Block target;


float x = 100;
float y = 0;
float speed = 0;
float speed2 = 0;
float gravity = .1;

float enemyX = 500;
float enemyY = random(500);
float enemySpeed = -3;

int squareSize=0;
int score = 0;
float wait=0;

int enemyColorR=0;
int enemyColorG=0;
int enemyColorB=0;

void setup(){
  size(500,500);
  squareSize = int (width*.05);
  example = new Block(color(255,255,0), 300, 100, squareSize, squareSize, 0.0);
  target = new Block(color(100,100,100), 300, 300, squareSize, squareSize, 0.0);
  //frameRate(30);
}

void draw(){
  background(255);
  fill(0);
  text(score, 50,50);
  //text(millis(), 100, 100);
  noStroke();
  
  
  //player  
  rectMode(CENTER);
  
  rect(x,y,squareSize,squareSize);
  target.display();
  example.display();
  
  
  y = y + speed;
  example.moveWallStop(speed2);
  //print("y: ");
  //print(y);
  
  speed = speed + gravity;
  speed2 += gravity;
  if (example.blockCollision(target)){
    target.changeColor(color(255,0,0));
  }
  else{
    target.changeColor(color(0,0,255));
  }
  //print(" - speed: ");
  //println(speed);
  
  if(y > height){
    speed = 0;
  }
  if (example.hitWall){
    speed2 = 0;
  }
  
  if((keyPressed && key == 's') || mousePressed){
    speed = speed-.3;
    speed2 = speed2 - .3;
  }
//    flappybird's action is more like 
//    speed = -3;
  
  //enemy
  stroke(0);
  fill(enemyColorR, enemyColorG, enemyColorB);
  rect(enemyX,enemyY, squareSize,squareSize);
  target.moveWallRandom(enemySpeed);
  enemyX = enemyX + enemySpeed;
  
  if(enemyX < 0){
    enemyX = 500;
    enemyY = random(500);
    enemyColorR = int(random(255));
    enemyColorG = int(random(255));
    enemyColorB = int(random(255));
  }
  if(x+(squareSize/2)>= enemyX-(squareSize/2) && x-(squareSize/2)<= enemyX+(squareSize/2) && y+(squareSize/2) >= enemyY-(squareSize/2) && y-(squareSize/2)<=enemyY+(squareSize/2)){
    //println("hit");
    if(wait >= 30){
      score++;
      wait=0;
    }
  }
  if(wait<30)
    wait++;
  //println(wait);
  
}

class Block {
  int xpos;
  int ypos;
  int blockWidth;
  int blockHeight;
  float blockSpeed;
  color blockColor;
  boolean hitWall;
  boolean targetHit;

  
    Block(color tempC, int tempXpos, int tempYpos, int tempW, int tempH, float tempSpeed ){
      xpos = tempXpos;
      ypos = tempYpos;
      blockWidth = tempW;
      blockHeight = tempH;
      blockSpeed = tempSpeed;
      blockColor = tempC;
      hitWall = false;
      targetHit = false;
    }  
    
    void display() {
      stroke(0);
      fill(blockColor);
      rectMode(CENTER);
      rect(xpos, ypos, blockWidth, blockHeight);
    }
    
    void changeColor(color tempC){
      blockColor = tempC;
      return;
    }    
    
    void move(float deltaX, float deltaY) {
      ypos += deltaY;
      xpos += deltaX;
      return;
    }
    
    void moveWallRandom(float deltaX){
      xpos += deltaX;
      if (xpos < 0){
        xpos = width;
        ypos = int (random(width));
      }
      return;
    }
    
    void moveWallStop(float deltaY){
      float fMovement = deltaY + ypos;
      if(fMovement > height - blockHeight/2 ){
        ypos = height - blockHeight/2;
        hitWall = true;
      }
      else if(fMovement < blockHeight/2){
        ypos = blockHeight/2;
        hitWall = true;
      }
      else{
        hitWall = false;
        ypos += deltaY;
      }
  
      return;
    }
   boolean blockCollision(Block other){
     int x1Left = xpos - blockWidth/2;
     int y1Top = ypos - blockHeight/2;
     int x1Right = xpos + blockWidth/2;
     int y1Bottom = ypos + blockHeight/2;
     
     int x2Left = other.xpos - other.blockWidth/2;
     int y2Top = other.ypos - other.blockHeight/2;
     int x2Right = other.xpos + other.blockWidth/2;
     int y2Bottom = other.ypos + other.blockHeight/2;
     if (!(x1Left > x2Right || x1Right < x2Left || y1Top > y2Bottom || y1Bottom < y2Top )){
       targetHit = true;
       return true;
     }
     else{
       return false;
     }

   }
    
}
