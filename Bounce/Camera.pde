class Camera {
  private float xOffset;
  private float xLowerThreshold;
  private float xUpperThreshold;
  private float yOffset;
  private float yLowerThreshold;
  private float yUpperThreshold;
  private int xUpperBound;
  private int yUpperBound;
  private float initialXOffset;
  private float initialYOffset;
  
  Camera(float xLowerThreshold, float xUpperThreshold,
         float yLowerThreshold, float yUpperThreshold,
         int xUpperBound, int yUpperBound) {
    this.xLowerThreshold = xLowerThreshold;
    this.xUpperThreshold = xUpperThreshold;
    this.yLowerThreshold = yLowerThreshold;
    this.yUpperThreshold = yUpperThreshold;
    this.xUpperBound = xUpperBound;
    this.yUpperBound = yUpperBound;
    xOffset = 0;
    yOffset = 0;
    initialXOffset = xOffset;
    initialYOffset = yOffset;
  }
  
  Camera(float xLowerThreshold, float xUpperThreshold, float xOffset,
         float yLowerThreshold, float yUpperThreshold, float yOffset,
         int xUpperBound, int yUpperBound) {
    this.xLowerThreshold = xLowerThreshold;
    this.xUpperThreshold = xUpperThreshold;
    this.xOffset = xOffset;
    this.yLowerThreshold = yLowerThreshold;
    this.yUpperThreshold = yUpperThreshold;
    this.yOffset = yOffset;
    this.xUpperBound = xUpperBound;
    this.yUpperBound = yUpperBound;
    initialXOffset = xOffset;
    initialYOffset = yOffset;
  }
  
  public float getXOffset() {
    return xOffset;
  }
  
  public float getYOffset() {
    return yOffset;
  }
  
  public void update(Vector position) {
    if (position.getX() <= xLowerThreshold) {
      xOffset = 0;
    } else if (position.getX() >= xUpperBound - (width - xUpperThreshold)) {
      xOffset = width - xUpperBound;
    } else if (position.getX() > xUpperThreshold - xOffset) {
      xOffset -= position.getX() - (xUpperThreshold - xOffset);
    } else if (position.getX() < xLowerThreshold - xOffset) {
      xOffset -= position.getX() - (xLowerThreshold - xOffset);
    }

    if (position.getY() <= yLowerThreshold) {
      yOffset = 0;
    } else if (position.getY() >= yUpperBound - (height - yUpperThreshold)) {
      yOffset = height - yUpperBound;
    } else if (position.getY() > yUpperThreshold - yOffset) {
      yOffset -= position.getY() - (yUpperThreshold - yOffset);
    } else if (position.getY() < yLowerThreshold - yOffset) {
      yOffset -= position.getY() - (yLowerThreshold - yOffset);
    }
  }
  
  public void reset() {
    xOffset = initialXOffset;
    yOffset = initialYOffset;
  }
}
