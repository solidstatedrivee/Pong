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
