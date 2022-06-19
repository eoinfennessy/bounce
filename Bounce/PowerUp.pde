class PowerUp {
  private float positionX;
  private float positionY;
  private float diameter;
  private char type;
  private boolean isDisplayed = true;
  
  PowerUp(float positionX, float positionY, float diameter, char type) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.diameter = diameter;
    this.type = type;
  }
  
  public float getPositionX() {
    return positionX;
  }
  
  public float getPositionY() {
    return positionY;
  }

  public float getDiameter() {
    return diameter;
  }
  
  public boolean isDisplayed() {
    return isDisplayed;
  }
  
  public char getType() {
    return type;
  }
  
  public void handleCollision() {
    isDisplayed = false;
  }
  
  public void display() {
    if (type == 'C') {
      stroke(#b8b100);
      fill(#e6de00);
    } else if (type == 'G') {
      noStroke();
      fill(#6e00bd);
    } else if (type == 'E') {
      noStroke();
      fill(#007bbd);
    } else if (type == 'L') {
      noStroke();
      fill(#FF0000);
    }
    ellipse(positionX + diameter/2, positionY + diameter/2, diameter, diameter);
  }
  
  public void deathReset() {
    if (type == 'G') {
      isDisplayed = true;
    }
  }
  
  public void reset() { //<>//
    isDisplayed = true;
  }
}
