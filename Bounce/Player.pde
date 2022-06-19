import javax.swing.JOptionPane;  

class Player {
  private String name;
  private int numberOfLives = 3;
  private int numberOfCoins = 0;
  private int currentLevel = 0;

  Player() {
    // Prevent asking player for name on initial game setup
    setName();
  }
  
  Player(boolean setNameOnInit) {
    // Prevent asking player for name on initial game setup
    if (setNameOnInit) {
      setName();
    }
  }
  
  Player(int playerIndex) {
    setName(playerIndex);
  }
  
  public int getCurrentLevel() {
    return currentLevel;
  }
  
  public int getNumberOfLives() {
    return numberOfLives;
  }
  
  public String getName() {
    return name;
  }
  
  public int getScore() {
    return numberOfCoins + numberOfLives*20;
  }
  
  public void setCurrentLevel(int currentLevel) {
    this.currentLevel = currentLevel;
  }
  
  public void loseLife() {
    numberOfLives -= 1;
  }
  
  public void addCoin() {
    if (numberOfCoins == 19) {
      numberOfCoins = 0;
      numberOfLives++;
    } else {
      numberOfCoins += 1;
    }
  }
  
  public void incrementNumberOfLives() {
    numberOfLives++;
  }
  
  public void displayInGameStats() {
    textAlign(LEFT, TOP);
    textSize(45);
    fill(#b82b00);
    text("Lives: " + numberOfLives, 60, 40);
    text("Coins: " + numberOfCoins, 60, 85);
  }
  
  public void displayName() {
    textAlign(RIGHT, TOP);
    text(name, width - 200, 40);
  }
  
  public void incrementCurrentLevel() {
    currentLevel++;
  }
  
  public void setName() {
    do {
      name = JOptionPane.showInputDialog("Enter your name/initials (maximum 3 characters):");
      if (name == null) {
        setName();
        return;
      }
    } while (name.length() > 3);
    name = name.toUpperCase();
  }
  
  public void setName(int playerIndex) {
    do {
      name = JOptionPane.showInputDialog("Enter Player " + (playerIndex + 1) + "'s name/initials (maximum 3 characters):");
      if (name == null) {
        setName(playerIndex);
        return;
      }
    } while (name.length() > 3);
    name = name.toUpperCase();
  }
}
