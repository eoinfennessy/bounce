public class Ball {
  private Vector acceleration;
  private Vector velocity;
  private Vector position;
  private float radius;
  private color colour;
  private KeyControl keyController;
  private char[] controls = {'a', 'd', ' '};
  private float maxVelocityX = 8;
  private float maxVelocityY = 35;
  private float moveForce = 0.2;
  private boolean isJumping;
  private float jumpForce = -13;
  private float initialJumpForce = jumpForce;
  private Vector initialPosition;
  private int jumpBuffer = 5;
  private int maxYVelocityThatAllowsBallToJump = 3;
  
  Ball(float positionX, float positionY, float radius) {
    position = new Vector(positionX, positionY);
    acceleration = new Vector(0, 0);
    velocity = new Vector(0, 0);
    this.radius = radius;
    this.colour = color(#E03400);
    keyController = new KeyControl(controls.clone());
    
    // Keeping copies of data required for reset
    initialPosition = position.copy();
    initialJumpForce = jumpForce;
  }
  
  Ball(float positionX, float positionY, float radius, color colour) {
    position = new Vector(positionX, positionY);
    acceleration = new Vector(0, 0);
    velocity = new Vector(0, 0);
    this.radius = radius;
    this.colour = colour;
    keyController = new KeyControl(controls.clone());
    
    // Keeping copies of data required for reset
    initialPosition = position.copy();
    initialJumpForce = jumpForce;
  }
  
  public float getPositionX() {
    return position.getX();
  }
  
  public float getPositionY() {
    return position.getY();
  }
  
  public Vector getPosition() {
    return position.copy();
  }
  
  public float getVelocityX() {
    return velocity.getX();
  }
  
  public float getVelocityY() {
    return velocity.getY();
  }
  
  public float getRadius() {
    return radius;
  }
  
  public float getJumpForce() {
    return jumpForce;
  }
  
  public void setPosition(Vector position) {
    this.position = position;
  }
  
  public void setPositionX(float x) {
    position.setX(x);
  }
  
  public void setPositionY(float y) {
    position.setY(y);
  }
  
  public void setVelocityX(float x) {
    velocity.setX(x);
  }
  
  public void setVelocityY(float y) {
    velocity.setY(y);
  }
  
  public void setVelocity(float x, float y) {
    velocity.set(x, y);
  }
  
  public void setJumpForce(float jumpForce) {
    this.jumpForce = jumpForce;
  }
  
  public void update() {
    keyHandler();
    velocity.add(acceleration);
    if (abs(velocity.getX()) > maxVelocityX) {
      if (velocity.getX() > 0) {
      velocity.setX(maxVelocityX);
      } else {
        velocity.setX(maxVelocityX * -1);
      }
    }
    if (abs(velocity.getY()) > maxVelocityY) {
      if (velocity.getY() > 0) {
      velocity.setY(maxVelocityY);
      } else {
        velocity.setY(maxVelocityY * -1);
      }
    }
    position.add(velocity);
    // Reset acceleration before applying next frame's forces
    acceleration.setX(0);
    acceleration.setY(0);
  }
  
  public void display() {
    stroke(#661800);
    fill(colour);
    ellipse(position.getX(), position.getY(), radius*2, radius*2);
  }
  
  public void applyForce(Vector force) {
    acceleration.add(force);
  }
  
  public void applyForce(float x, float y) {
    acceleration.add(x, y);
  }
  
  public void keyPressed() {
    keyController.keyPressed();
  }
  
  // Overloaded method to be called when jump control is pressed
  public void keyPressed(Tile[][] terrain, Vector gravity) {
    keyController.keyPressed();
    Tile tileUnderneathBall = getTileUnderneathBall(terrain, gravity);
    isJumping = isJumping(tileUnderneathBall);
    jump();
  }
  
  public void keyReleased() {
    keyController.keyReleased();
  }
  
  private void jump() {
    if (!isJumping) {
      this.applyForce(0, jumpForce);
      isJumping = true;
    }
  }
  
  /* 
    Takes distance between ball and ground as well as magnitude of ball's y velocity
    and checks if both numbers are below the thresholds given.
    If they are, the isJumping variable to false
  */
  private boolean isJumping(Tile tile) {
    if (tile != null) {
      int halfTileSize = tile.getSize() / 2;
      // If the distance between the terrain and the ball is less than the jump buffer and the y velocity is within the range a jump is permitted
      if (abs(tile.getPositionY() + halfTileSize - (position.getY())) < (radius + halfTileSize + jumpBuffer)
          && abs(velocity.getY()) < maxYVelocityThatAllowsBallToJump) {
        return false;
      }
    }
    return true;
  }
  
  // Finds and returns tile underneath ball, while taking direction of gravity into account
  private Tile getTileUnderneathBall(Tile[][] terrain, Vector gravity) {
    int tileX = floor((position.getX()) / tileSize);
    int tileY;
    int tileSize = terrain[0][0].getSize();
    if (gravity.getY() < 0) {
      tileY = floor((position.getY() - radius) / tileSize) - 1;
    } else {
      tileY = ceil((position.getY() + radius) / tileSize);
    }
    //fill(255, 0, 127, 127);
    //rect(tileX*tileSize, tileY*tileSize, tileSize, tileSize);
    return terrain[tileY][tileX];
  }
  
  private void keyHandler() {
    for (int i = 0; i < controls.length; i++) {
      if (keyController.getControlsThatArePressed(i)) {
        if (controls[i] == 'a') {
          this.applyForce(-moveForce, 0);
        } else if (controls[i] == 'd') {
          this.applyForce(moveForce, 0);
        }
      }
    }
  }
  
  public void reset() {
    position = initialPosition.copy();
    jumpForce = initialJumpForce;
    velocity.set(0, 0);
  }
}
