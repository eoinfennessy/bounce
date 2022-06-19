/* Tile types:
       b - standard green block
       s - spike pointing upwards
       d - spike pointing downwards
       p - springboard
*/

public class Tile {
  private char type;
  private boolean isFatal;
  private float positionX;
  private float positionY;
  private int size;
  // Sacrifice small amount of memory to save on many expensive calculations every frame
  private float halfSize;
  private color fillColour;
  private float bounciness;
  private float friction;
  
  Tile(float posX, float posY, int size, char type) {
    this.positionX = posX;
    this.positionY = posY;
    this.size = size;
    halfSize = size / 2;
    this.type = type;
    
    if (type == 'b') {
      this.isFatal = false;
      this.fillColour = color(80, random(100, 150), 50);
      this.bounciness = 0.6;
      this.friction = 0.98;
    } else if (type == 's' || type == 'd') {
      this.isFatal = true;
      this.fillColour = color(random(150, 170));
    } else if (type == 'p') {
      this.isFatal = false;
      this.bounciness = 1.4;
      this.friction = 0.9;
      this.fillColour = color(#FA7500);
    }
  }
  
  public float getPositionX() {
    return positionX;
  }
  
  public float getPositionY() {
    return positionY;
  }
  
  public float getBounciness() {
    return bounciness;
  }
  
  public float getFriction() {
    return friction;
  }
  
  public int getSize() {
    return size;
  }
  
  public boolean isFatal() {
    return isFatal;
  }
  
  public void display() {
    fill(fillColour);
    if (type == 'b') {
      stroke(50, 60, 30);
      rect(positionX, positionY, size, size);
    } else if (type == 's') {
      stroke(60);
      triangle(positionX + halfSize, positionY, positionX, positionY + size, positionX + size, positionY + size);
      return;
    } else if (type == 'd') {
      stroke(60);
      triangle(positionX + halfSize, positionY + size, positionX, positionY, positionX + size, positionY);
      return;
    } else if (type == 'p') {
      stroke(60);
      rect(positionX, positionY, size, size);
      return;
    }
  }
}
