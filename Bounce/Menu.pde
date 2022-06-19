class Menu {
  private String[] options;
  private char[] controls = {'w', 's', ENTER};
  private KeyControl keyController;
  private boolean isActive = false;
  private int focusedOption = 0;
  private boolean isOptionSelected = false;
  private String optionSelected;
  
  Menu(String[] options) {
    this.options = options;
    keyController = new KeyControl(controls.clone());
  }
  
  Menu(String[] options, boolean isActive) {
    this.options = options;
    keyController = new KeyControl(controls.clone());
    this.isActive = isActive;
  }
  
  public boolean isActive() {
    return isActive;
  }
  
  public boolean isOptionSelected() {
    return isOptionSelected;
  }
  
  public String getOptionSelected() {
    return optionSelected;
  }
  
  public void setIsActive(boolean isActive) {
    this.isActive = isActive;
  }
  
  public void setIsOptionSelected(boolean isOptionSelected) {
    this.isOptionSelected = isOptionSelected;
  }
  
  public void display() {
    background(#B8EEFF);
    
    // Draw game title
    textSize(192);
    fill(#E03400);
    textAlign(CENTER, TOP);
    text("Bounce!", width/2, 150);
    
    // Draw menu options
    textSize(60);
    for (int i = 0; i < options.length; i++) {
      if (i == focusedOption) {
        fill(#309a1d);
      } else {
        fill(#3d5139);
      }
      text(options[i], width/2, 375 + i*75);
    }
  }
  
  public void keyPressed() {
    keyController.keyPressed();
    keyHandler();
  }
  
  private void keyHandler() {
    for (int i = 0; i < controls.length; i++) {
      if (keyController.getControlsThatArePressed(i)) {
        if (controls[i] == 'w') {
          if (focusedOption == 0) {
            focusedOption = options.length - 1;
          } else {
            focusedOption--;
          }
        } else if (controls[i] == 's') {
          if (focusedOption == options.length - 1) {
            focusedOption = 0;
          } else {
            focusedOption++;
          }
        } else if (controls[i] == ENTER) {
          isOptionSelected = true;
          optionSelected = options[focusedOption];
        }
        // Immediately set control press to false to prevent changes being made every frame
        keyController.setControlsThatArePressed(i, false);
      }
    }
  }
}
