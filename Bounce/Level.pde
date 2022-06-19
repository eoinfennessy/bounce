public class Level {
  private Tile[][] terrain;
  private Vector[] forces;
  private PowerUp[][] powerUps;
  private int tileSize;
  private float halfTileSize;
  private EnemyBall[] enemyBalls;
  //private Boid[] boids;
  private Ball ball;
  private Camera camera;
  private Vector initialGravity;
  private boolean isBeingPlayed = false;
  private boolean isPaused = false;
  private boolean hasDeathOccured = false;
  private KeyControl keyController;
  private char[] controls = {'p'};
  private String activePowerUps;
  
  Level(Tile[][] terrain, Ball ball, PowerUp[][] powerUps) {
    this.terrain = terrain;
    this.ball = ball;
    this.powerUps = powerUps;
    this.tileSize = terrain[0][0].getSize();
    this.halfTileSize = tileSize / 2;
    
    // Default gravity force
    forces = new Vector[] {new Vector(0, 0.37)};
    camera = new Camera(width/2 - width/8, width/2 + width/8,
                        height/2 - height/8, height/2 + height/8,
                        terrain[0].length*tileSize, terrain.length*tileSize);
    initialGravity = forces[0].copy();
    keyController = new KeyControl(controls.clone());
  }
  
  Level(Tile[][] terrain, Ball ball, PowerUp[][] powerUps, EnemyBall[] enemyBalls) {
    this.terrain = terrain;
    this.ball = ball;
    this.powerUps = powerUps;
    this.enemyBalls = enemyBalls;
    this.tileSize = terrain[0][0].getSize();
    this.halfTileSize = tileSize / 2;
    
    // Default gravity force
    forces = new Vector[] {new Vector(0, 0.37)};
    camera = new Camera(width/2 - width/8, width/2 + width/8,
                        height/2 - height/8, height/2 + height/8,
                        terrain[0].length*tileSize, terrain.length*tileSize);
    initialGravity = forces[0].copy();
    keyController = new KeyControl(controls.clone());
  }
  
  public boolean isBeingPlayed() {
    return isBeingPlayed;
  }
  
  public boolean isPaused() {
    return isPaused;
  }
  
  public boolean hasDeathOccured() {
    return hasDeathOccured;
  }
  
  public Tile[][] getTerrain() {
    return terrain.clone();
  }
  
  public Vector getForce(int i) {
    return forces[i].copy();
  }
  
  public String getActivePowerUps() {
    return activePowerUps;
  }
  
  public void setActivePowerUps(String activePowerUps) {
    this.activePowerUps = activePowerUps;
  }
  
  public void setIsBeingPlayed(boolean isBeingPlayed) {
    this.isBeingPlayed = isBeingPlayed;
  }
  
  public void setIsPaused(boolean isPaused) {
    this.isPaused = isPaused;
  }
  
  public void setHasDeathOccured(boolean hasDeathOccured) {
    this.hasDeathOccured = hasDeathOccured;
  }
  
  public void display() {
    translate(camera.getXOffset(), camera.getYOffset());
    background(#B8EEFF);
    
    // Calculate which tiles are currently within view
    int startRow = max(floor(camera.getYOffset() * -1) / tileSize, 0);
    int endRow = min(ceil((camera.getYOffset() * -1) / tileSize + (height/tileSize)) + 1, terrain.length);
    int startCol = max(floor(camera.getXOffset() * -1) / tileSize, 0);
    int endCol = min(ceil((camera.getXOffset() * -1) / tileSize + (width/tileSize)) + 1, terrain[0].length);

    // Display currently-viewable tiles and power-ups
    for (int row = startRow; row < endRow; row++) {
      for (int col = startCol; col < endCol; col++) {
        if (terrain[row][col] != null) {
          terrain[row][col].display();
        }
        if (powerUps[row][col] != null) {
          if (powerUps[row][col].isDisplayed()) {
            powerUps[row][col].display();
          }
        }
      }
    }
    
    ball.display();
    
    if (enemyBalls != null) {
      for (EnemyBall enemyBall : enemyBalls) {
        if (enemyBall.isActive()) {
          enemyBall.display();
        }
      }
    }
    
    // Remove camera offests in order to display absolute-positioned items elsewhere
    translate(-camera.getXOffset(), -camera.getYOffset());
  }
  
  public void update() {
    // Apply forces to ball, update ball state, and check for and handle ball/terrain collisions
    for (Vector force : forces) {
      ball.applyForce(force);
    }
    ball.update();
    
    /* 
    Get start & end columns and rows to be used to check for collisions.
    Only indeces where a collision with the ball is possible (given its current position) should be checked.
    */
    int startCol = getStartColToCheckForCollisions(ball);
    int endCol = getEndColToCheckForCollisions(ball);
    int startRow = getStartRowToCheckForCollisions(ball);
    int endRow = getEndRowToCheckForCollisions(ball);
    
    // Check for and handle ball-tile and ball-powerUp collisions
    for (int row = startRow; row < endRow; row++) {
      for (int col = startCol; col < endCol; col++) {
        if (terrain[row][col] != null) {
          handleBallTerrainCollisions(terrain[row][col]);
        }
        if (powerUps[row][col] != null) {
          PowerUp powerUp = powerUps[row][col];
          if (powerUp.isDisplayed()) {
            if (areBallAndPowerUpColliding(ball, powerUp)) {
              powerUp.handleCollision();
              activePowerUps += powerUp.getType();
            }
          }
        }
      }
    }
    
    // Check for and handle ball-tile and ball-powerUp collisions
    if (enemyBalls != null) {
      for (EnemyBall enemyBall : enemyBalls) {
        // Check if enemy ball is on screen and update enemy ball's "isActive" field accordingly
        if ((enemyBall.getPositionX() - enemyBall.getRadius()) + camera.getXOffset() > width
            || (enemyBall.getPositionX() + enemyBall.getRadius()) + camera.getXOffset() < 0) {
          enemyBall.setIsActive(false);
        } else {
          enemyBall.setIsActive(true);
        }
        // Apply forces to and update enemy balls
        if (enemyBall.isActive()) {
          for (Vector force : forces) {
            enemyBall.applyForce(force);
          }
          enemyBall.update();
            
          // Check/handle enemy ball collisions with terrain
          startCol = getStartColToCheckForCollisions(enemyBall.getBall());
          endCol = getEndColToCheckForCollisions(enemyBall.getBall());
          startRow = getStartRowToCheckForCollisions(enemyBall.getBall());
          endRow = getEndRowToCheckForCollisions(enemyBall.getBall());
          
          for (int row = startRow; row < endRow; row++) {
            for (int col = startCol; col < endCol; col++) {
              if (terrain[row][col] != null) {
                Tile tile = terrain[row][col];
                float yDistance = abs((tile.getPositionY() + halfTileSize) - enemyBall.getPositionY())
                                  - (enemyBall.getRadius() + halfTileSize);
                if (yDistance < 0) {
                  enemyBall.bounce(yDistance);
                }
              }
            }
          }
          
          // Check for and handle ball-enemy ball collisions
          if (isCircleIntersectingCircle(ball.getPositionX(), ball.getPositionY(), ball.getRadius(),
                                         enemyBall.getPositionX(), enemyBall.getPositionY(), enemyBall.getRadius())) {
            hasDeathOccured = true;
            reset();
          }
        }
      }
    }
    
    camera.update(ball.getPosition());
    
    keyHandler();
  }
  
  public void keyPressed() {
    if (key == ' ') {
      // Calls ball's overloaded keyPressed method specifically for jumping, which requires copies of the terrain and the gravity force
      ball.keyPressed(getTerrain(), forces[0].copy());
    }
    keyController.keyPressed();
    ball.keyPressed();
  }
  
  public void keyReleased() {
    keyController.keyReleased();
    ball.keyReleased();
  }
  
  private int getStartColToCheckForCollisions(Ball ball) {
    return max(floor((ball.getPositionX() - ball.getRadius()) / tileSize), 0);
  }
  
  private int getEndColToCheckForCollisions(Ball ball) {
    return min(ceil((ball.getPositionX() + ball.getRadius()) / tileSize), terrain[0].length);
  }
  
  private int getStartRowToCheckForCollisions(Ball ball) {
    return max(floor((ball.getPositionY() - ball.getRadius()) / tileSize), 0);
  }
  
  private int getEndRowToCheckForCollisions(Ball ball) {
    return min(ceil((ball.getPositionY() + ball.getRadius()) / tileSize), terrain.length);
  }
  
  private void handleBallTerrainCollisions(Tile tile) {   
    Vector intersection = getCircleRectangleIntersection(ball.getPositionX(), ball.getPositionY(),
                                                         ball.getRadius(), tile.getPositionX(),
                                                         tile.getPositionY(), tileSize, tileSize);    
    // If there is an intersection on either axis
    if (intersection.getX() != 0 || intersection.getY() != 0) {
      if (tile.isFatal()) {
        hasDeathOccured = true;
        reset();
      }
      // If there is an intersection on both axes (a corner intersection)
      if (intersection.getX() != 0 && intersection.getY() != 0) {
        handleBallTileCornerCollision(tile, intersection);
      } else {
        handleBallTileSideCollision(tile, intersection);
      }
    }
  }
  
  /* Calculates and sets ball's new position using intersection vector,
     then calculates and sets ball's velocity using the tile's bounciness and friction */
  private void handleBallTileSideCollision(Tile tile, Vector intersection) {
    // if ball has collided with top or bottom of tile
    if (intersection.getY() != 0) {
      ball.setPositionY(ball.getPositionY() - intersection.getY() - (intersection.getY() * tile.getBounciness()));
      
      ball.setVelocityY(ball.getVelocityY() * -1 * tile.getBounciness());
      ball.setVelocityX(ball.getVelocityX() * tile.getFriction());
      
      // if ball has collided with left or right side of tile
    } else if (intersection.getX() != 0) {
      ball.setPositionX(ball.getPositionX() - intersection.getX() - (intersection.getX() * tile.getBounciness()));
      
      ball.setVelocityX(ball.getVelocityX() * -1 * tile.getBounciness());
      ball.setVelocityY(ball.getVelocityY() * tile.getFriction());
    }
  }
  
  // Sets ball's new position using intersection vector, then applies tile's friction to ball's velocity
  private void handleBallTileCornerCollision(Tile tile, Vector intersection) {
    ball.setPositionX(ball.getPositionX() - intersection.getX());
    ball.setPositionY(ball.getPositionY() - intersection.getY());
    
    ball.setVelocityX(ball.getVelocityX() * tile.getFriction());
    ball.setVelocityY(ball.getVelocityY() * tile.getFriction());
  }
  
  private void reset() {
    ball.reset();
    camera.reset();
    for (PowerUp[] row: powerUps) {
      for (PowerUp powerUp : row) {
        if (powerUp != null) {
          if (hasDeathOccured) {
            powerUp.deathReset();
          } else {
            powerUp.reset();
          }
        }
      }
    }
    forces[0] = initialGravity.copy();
  }
  
  public void invertGravity() {
    // Gravity is always found at index 0 of forces
    forces[0].mult(-1);
    
    // Invert jumpForce
    ball.setJumpForce(ball.getJumpForce() * -1);
  }
  
  private boolean areBallAndPowerUpColliding(Ball ball, PowerUp powerUp) {
    return isCircleIntersectingCircle(powerUp.getPositionX() + halfTileSize,
                                      powerUp.getPositionY() + halfTileSize, powerUp.getDiameter()/2,
                                      ball.getPositionX(), ball.getPositionY(), ball.getRadius());
  }
  
  private boolean isCircleIntersectingCircle(float x1, float y1, float r1, float x2, float y2, float r2) {
    return dist(x1, y1, x2, y2) < (r1 + r2);
  }

  boolean isCircleIntersectingRectangle(float circleX, float circleY, float radius,
                                        float rectX, float rectY, float rectWidth, float rectHeight) {
    float rectMidpointX = rectX + rectWidth/2;
    float rectMidpointY = rectY + rectHeight/2;
    
    float distanceX = abs(rectMidpointX - circleX);
    float distanceY = abs(rectMidpointY - circleY);
    
    if (distanceX > rectWidth/2 + radius) {
      return false;
    }
    if (distanceY > rectHeight/2 + radius) {
      return false;
    }
    
    if (distanceX <= rectWidth/2) {
      return true;
    }
    if (distanceY <= rectHeight/2) {
      return true;
    }
    
    if (pow(distanceX - rectWidth/2, 2) + pow(distanceY - rectHeight/2, 2) <= pow(radius, 2)) {
      return true;
    }
    return false;
  }
  
  /* Checks for intersection and returns a 2d vector containing the length of intersection
     between the circle and rectangle on each axis. Returns vector(0, 0) if no intersection occurs */
  Vector getCircleRectangleIntersection(float circleX, float circleY, float radius,
                                        float rectX, float rectY, float rectWidth, float rectHeight) {
    float rectMidpointX = rectX + rectWidth/2;
    float rectMidpointY = rectY + rectHeight/2;
    
    float distanceX = abs(rectMidpointX - circleX);
    float distanceY = abs(rectMidpointY - circleY);
    
    Vector vector = new Vector(0, 0);
    
    if (distanceX > rectWidth/2 + radius) {
      return vector;
    }
    if (distanceY > rectHeight/2 + radius) {
      return vector;
    }
    
    // Circle intersects rectangle on y axis
    if (distanceX <= rectWidth/2) {
      if (circleY < rectMidpointY) {
        vector.setY((rectHeight/2 + radius) - distanceY);
      } else {
        vector.setY(distanceY - (rectHeight/2 + radius));
      }
      return vector;
    }
    
    // If circle intersects rectangle on x axis
    if (distanceY <= rectHeight/2) {
      if (circleX < rectMidpointX) {
        vector.setX((rectWidth/2 + radius) - distanceX);
      } else {
        vector.setX(distanceX - (rectWidth/2 + radius));
      }
      return vector;
    }
    
    if (pow(distanceX - rectWidth/2, 2) + pow(distanceY - rectHeight/2, 2) <= pow(radius, 2)) {
       //Get coordinates of corner
        float cornerX;
        float cornerY;
        if (circleX < rectMidpointX) {
          cornerX = rectX;
        } else {
          cornerX = rectX + rectWidth;
        }
        if (circleY < rectMidpointY) {
          cornerY = rectY;
        } else {
          cornerY = rectY + rectHeight;
        }
        // Get length of line h, a division of the circle's radius from the corner of the rectangle to the edge of the circle
        float h = radius - dist(circleX, circleY, cornerX, cornerY);
        // Get A, the angle between the y axis and h
        float A = atan2(cornerX - circleX, cornerY - circleY);
        /* Get length of line a, the side opposite the angle A in the right-angled triangle made
           up of sides h, a (parellel to the x axis), and b (parallel to y axis) */
        float a = sin(A) * h;
        // Get length of side b, the side adjacent to the angle A
        float b = cos(A) * h;
        
        // a and b are equal to the intersection on the x and y axes respectively
        vector.setX(a);
        vector.setY(b);
      return vector;
    }
    return vector;
  }
  
  private void keyHandler() {
    for (int i = 0; i < controls.length; i++) {
      if (keyController.getControlsThatArePressed(i)) {
        if (controls[i] == 'p') {
          keyController.setControlsThatArePressed(i, false);
          isPaused = true;
          isBeingPlayed = false;
        }
      }
    }
  }
}
