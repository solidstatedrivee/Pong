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
