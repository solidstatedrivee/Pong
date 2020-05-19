color bgColor, paddleColor, ballColor, scoreColor;
int paddleLength, xSpeed, xDirection, ySpeed, yDirection, score;
boolean hitPaddle, hitEdge, missed;
Paddle p;
Ball b;
ScoreBoard s;
BrickCollection collection;

void setup() {
  size(800, 500);
  colorMode(HSB, 360, 100, 100);
  bgColor = color(10, 76, 90);
  paddleColor = color(40, 76, 95);
  ballColor = color(56, 42, 100);
  scoreColor = color(350, 94, 52);
  p = new Paddle();
  paddleLength = 100;
  b = new Ball();
  s = new ScoreBoard();
  xDirection = 1;
  yDirection = 1;
  xSpeed = 3;
  ySpeed = 2;
  collection = new BrickCollection();
  for (int i = 0; i < 10; i++) {
    collection.addBrick();
  }
}

void draw() {
  background(bgColor);
  noCursor();
  textSize(24);
  fill(scoreColor);
  text(score, width-75, height-12.5);
  p.initPaddle();
  b.initBall();
  b.moveBall();
  b.checkEdges();
  b.checkMissed();
  b.checkCollision(p);
  s.incrementScore();
  s.resetScore();
  collection.initBrickCollection();
  collection.checkHit(b);
  collection.resetBricks();
}

class Paddle {
  int mapMouse; 

  Paddle() {
  }

  void initPaddle() {
    noStroke();
    fill(paddleColor);
    rectMode(CENTER);
    mapMouse = int(map(mouseX, 0, width, paddleLength/4, width - (paddleLength/4)));
    rect(mapMouse, 450, paddleLength, 15);
  }
}

class Ball {
  int xLocation, yLocation, ballDiam, ballRadius;
  Ball() {
    xLocation = int(random(width));
    yLocation = int(random(height/2));
    ballDiam = 15;
    ballRadius = ballDiam / 2;
  }

  void initBall() {
    noStroke();
    fill(ballColor);
    ellipse(xLocation, yLocation, ballDiam, ballDiam);
  }

  void moveBall() {
    xLocation += (xSpeed * xDirection);
    yLocation += (ySpeed * yDirection);
  }

  void checkEdges() {
    hitEdge = false;
    if (xLocation >= width - ballRadius || xLocation <= ballRadius) {
      xDirection *= -1;
      hitEdge = true;
    }
    if (yLocation >= height - ballRadius || yLocation <= ballRadius) {
      yDirection *= -1;
      hitEdge = true;
    }
  }

  void checkMissed() {
    missed = false;
    if (yLocation > height - ballDiam) {
      xLocation = int(random(width));
      yLocation = int(random(height/2));
      yDirection *= -1;
      missed = true;
    }
  }

  void checkCollision(Paddle p) {
    hitPaddle = false;
    if (yLocation >= 435 && xLocation > (p.mapMouse - paddleLength/2) && xLocation < (p.mapMouse + paddleLength/2)) {
      yDirection *= -1;
      hitPaddle = true;
    }
  } 

  int getX() {
    return xLocation;
  }

  int getY() {
    return yLocation;
  }
}

class ScoreBoard {
  ScoreBoard() {
    score = 0;
    fill(scoreColor);
    text(score, width-75, height-12.5);
  }

  void incrementScore() {
    if (hitPaddle == true) {
      score += 2;
    }
    if (hitEdge == true) {
      score++;
    }
  }

  void resetScore() {
    if (missed == true) {
      score = 0;
    }
  }
}

class Brick {
  int xloc, yloc, mapXLoc;
  int brickWidth = 50;
  int brickHeight = 25;
  Brick() {
    xloc = int(random(width));
    yloc = int(random(height)) / 2;
  }

  void initBrick() {
    noStroke();    
    fill(scoreColor);
    rectMode(CENTER);
    //mapXLoc = int(map(xloc, 0, width, brickWidth/2, width - brickWidth/2));
    rect(xloc, yloc, brickWidth, brickHeight);
  }

  boolean detectCollision(Ball targetBall) {
    boolean hasCollided = false;
    int thisLocation = int(xloc);
    int extendLocation = int(thisLocation + brickWidth);
    if (((targetBall.yLocation + targetBall.ballRadius) >= yloc - brickHeight) && ((targetBall.yLocation + targetBall.ballRadius) <= yloc + brickHeight)) {
      if ((targetBall.xLocation >= thisLocation) && targetBall.xLocation <= extendLocation) {
        hasCollided = true;
      } else {
        hasCollided = false;
      }
    } else {
      hasCollided = false;
    }

    return hasCollided;
  }
}

class BrickCollection {
  ArrayList<Brick> bricks;

  BrickCollection() {
    bricks = new ArrayList<Brick>();
  }

  void initBrickCollection() {
    for (int i = 0; i < bricks.size(); i++) {
      Brick getBrick = bricks.get(i);
      getBrick.initBrick();
    }
  }

  void addBrick() {
    bricks.add(new Brick());
  }

  void checkHit(Ball target) {
    int numBricks = bricks.size();
    for (int i = numBricks - 1; i >= 0; i--) {
      Brick getBrick = bricks.get(i);
      if (getBrick.detectCollision(target)) {
        yDirection *= -1;
        score += 3;
        bricks.remove(i);
      }
    }
  }

  void resetBricks() {
    if (missed) {
      for (int i = bricks.size() - 1; i >= 0; i--) {
        bricks.remove(i);
      }
      for (int i = 0; i < 10; i++) {
        bricks.add(new Brick());
      }
      score = 0;
    }
  }
}
