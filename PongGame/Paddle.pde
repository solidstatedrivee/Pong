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
