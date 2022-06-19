class EnemyBall {
  private Ball ball;
  private Vector initialVelocity;
  private boolean isActive = true;
  private int bounceNumber;
  
  EnemyBall(float positionX, float positionY, float radius, Vector initialVelocity) {
    this.ball = new Ball(positionX, positionY, radius, color(0));
    this.initialVelocity = initialVelocity;
    ball.setVelocityX(initialVelocity.getX());
  }
  
  public float getPositionX() {
    return ball.getPositionX();
  }
  
  public float getPositionY() {
    return ball.getPositionY();
  }
  
  public float getRadius() {
    return ball.getRadius();
  }
  
  public boolean isActive() {
    return isActive;
  }
  
  public Ball getBall() {
    return ball;
  }
  
  public void setIsActive(boolean isActive) {
    this.isActive = isActive;
  }
  
  public void display() {
    ball.display();
  }
  
  public void update() {
    // If ball on screen, update
    ball.update();
  }
  
  public void applyForce(Vector force) {
    ball.applyForce(force);
  }
  
  public void bounce(float yIntersection) {
    ball.setPositionY(ball.getPositionY() + (yIntersection * 2));
    ball.setVelocityY(ball.getVelocityY() * -1);
    if (bounceNumber % 2 == 0) {
      ball.setVelocityX(ball.getVelocityX() * -1);
    }
    bounceNumber++;
  }
}
