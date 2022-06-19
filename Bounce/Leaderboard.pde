class Leaderboard {
  // Two associated arrays: playerScores[n] is the score for playerNames[n]
  private String[] playerNames;
  private int[] playerScores;
  private boolean isActive = false;
  private char[] controls = {ENTER};
  private KeyControl keyController;
  
  Leaderboard(int maxNumberOfEntries) {
    playerNames = new String[maxNumberOfEntries];
    playerScores = new int[maxNumberOfEntries];
    keyController = new KeyControl(controls.clone());
    
    for (int i = 0; i < playerNames.length; i++) {
      playerNames[i] = "---";
      playerScores[i] = 0;
    }
  }
  
  public boolean isActive() {
    return isActive;
  }
  
  public void setIsActive(boolean isActive) {
    this.isActive = isActive;
  }
  
  public void display() {
    background(#B8EEFF);
    
    // Draw heading
    textSize(110);
    fill(#E03400);
    textAlign(CENTER, TOP);
    text("Leaderboard", width/2, 100);
    
    // Draw player names
    textSize(75);
    fill(#309a1d);
    textAlign(LEFT, TOP);
    for (int i = 0; i < playerNames.length; i++) {
      text(playerNames[i], width/2 - 250, 260 + i*90);
    }
    
    // Draw scores
    fill(#3d5139);
    textAlign(RIGHT, TOP);
    for (int i = 0; i < playerScores.length; i++) {
      text(playerScores[i], width/2 + 250, 260 + i*90);
    }
    
    // Draw footer instruction
    textSize(40);
    fill(#E03400);
    textAlign(BOTTOM, LEFT);
    text("Press Enter to go back to menu", 50, height - 50);
  }
  
  public boolean isScoreHighEnoughToGetPlaced(int score) {
    for (int existingScore : playerScores) {
      if (existingScore < score) {
        return true;
      }
    }
    return false;
  }
  
  public void addEntry(String name, int score) {
    if (getLowestScore() < score) {
      int lowestScoreIndex = getLowestScoreIndex();
      playerScores[lowestScoreIndex] = score;
      playerNames[lowestScoreIndex] = name;
      sort();
    }
  }
  
  private int getLowestScore() {
    int lowestScore = playerScores[0];
    for (int i = 0; i < playerScores.length; i++) {
      if (playerScores[i] < lowestScore) {
        lowestScore = playerScores[i];
      }
    }
    return lowestScore;
  }
  
  private int getLowestScoreIndex() {
    int lowestScore = playerScores[0];
    int lowestScoreIndex = 0;
    for (int i = 0; i < playerScores.length; i++) {
      if (playerScores[i] < lowestScore) {
        lowestScore = playerScores[i];
        lowestScoreIndex = i;
      }
    }
    return lowestScoreIndex;
  }
  
  // Sort name and score arrays by score using selection sort algorithm
  private void sort() {
    for (int swapIndex = 0; swapIndex < playerScores.length - 1; swapIndex++) {
      int currentHighestScoreIndex = swapIndex;
      int currentHighestScore = playerScores[swapIndex];
      for (int i = swapIndex + 1; i < playerScores.length; i++) {
        if (playerScores[i] > currentHighestScore) {
          currentHighestScore = playerScores[i];
          currentHighestScoreIndex = i;
        }
      }
      // Swap name & score at index of highest score found on this loop and name & score at the start index of this loop
      String tempName = playerNames[currentHighestScoreIndex];
      playerNames[currentHighestScoreIndex] = playerNames[swapIndex];
      playerScores[currentHighestScoreIndex] = playerScores[swapIndex];
      playerNames[swapIndex] = tempName;
      playerScores[swapIndex] = currentHighestScore;
    }
  }
  
  public void keyPressed() {
    keyController.keyPressed();
    keyHandler();
  }
  
  private void keyHandler() {
    for (int i = 0; i < controls.length; i++) {
      if (keyController.getControlsThatArePressed(i)) {
        if (controls[i] == ENTER) {
          isActive = false;
          keyController.setControlsThatArePressed(i, false);
        }
      }
    }
  }
}
