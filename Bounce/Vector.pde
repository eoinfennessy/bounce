class Vector {
  private float x;
  private float y;
  
  Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
    this.y = y;
  }
  
  public void set(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public void add(Vector a) {
    x += a.getX();
    y += a.getY();
  }
  
  public void add(float x, float y) {
    this.x += x;
    this.y += y;
  }
  
  public void mult(float n) {
    this.x *= n;
    this.y *= n;
  }
  
  // Returns a deep copy of the instance
  public Vector copy() {
    return new Vector(this.getX(), this.getY());
  }
}
