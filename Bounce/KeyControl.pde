class KeyControl {
  private char[] controls;
  private boolean[] controlsThatArePressed;
  
  /*
  Initialises two associated arrays: 'controls', an array of chars corresponding to the keys 
  to listen for presses/releases, and 'controlsArePressed' a boolean array that records whether 
  or not the key at the same index in 'controls' is pressed or released.
  */
  KeyControl(char[] controls) {
    this.controls = controls;
    controlsThatArePressed = new boolean[controls.length];
    for (int i = 0; i < controls.length; i++) {
      this.controls[i] = controls[i];
      controlsThatArePressed[i] = false;
    }
  }
  
  public void keyPressed() {
    for (int i = 0; i < controls.length; i++) {
      if (key == controls[i]) {
        controlsThatArePressed[i] = true;
      }
    }
  }
  
  public void keyReleased() {
    for (int i = 0; i < controls.length; i++) {
      if (key == controls[i]) {
        controlsThatArePressed[i] = false;
      }
    }
  }
  
  public boolean getControlsThatArePressed(int i) {
    return controlsThatArePressed[i];
  }
  
  public void setControlsThatArePressed(int i, boolean value) {
    controlsThatArePressed[i] = value;
  }
}
