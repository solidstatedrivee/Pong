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
      if (((targetBall.xLocation + targetBall.ballRadius) >= thisLocation - brickWidth) && ((targetBall.xLocation + targetBall.ballRadius) <= extendLocation)) {
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
