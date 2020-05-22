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
