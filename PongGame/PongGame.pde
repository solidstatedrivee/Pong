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
