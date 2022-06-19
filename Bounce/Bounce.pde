private int tileSize = 40;
private Level[] levels;
private Player[] players;
private int currentPlayer;
private Menu[] menus;
private Leaderboard leaderboard;
private PFont font;

void setup() {
  //size(1080, 720);
  fullScreen();
  noCursor();
  font = loadFont("Rockwell-Regular-192.vlw");
  textFont(font);
  players = new Player[1];
  players[0] = new Player(false);
  levels = getLevels();
  leaderboard = new Leaderboard(5);
  buildMenus();
}

void draw() {
  Level currentLevel = levels[players[currentPlayer].getCurrentLevel()];
  if (currentLevel.isBeingPlayed()) {
    if (players[currentPlayer].getNumberOfLives() >= 0) {
      currentLevel.display();
      currentLevel.update();
      
      // Apply effects of power-ups if any have been collected
      if (currentLevel.getActivePowerUps() != null) {
        handlePowerUps(currentLevel.getActivePowerUps());
        currentLevel.setActivePowerUps(null);
      }
      
      // Display number of lives, coins, player name
      players[currentPlayer].displayInGameStats();
      if (players.length > 1) {
        players[currentPlayer].displayName();
      }
      
      // Remove life from current player if a death has occured in the current level
      if (currentLevel.hasDeathOccured()) {
        currentLevel.setHasDeathOccured(false);
        players[currentPlayer].loseLife();
      }
      
      // Activate pause menu
      if (currentLevel.isPaused()) {
        menus[1].setIsActive(true);
      }
      return;
    } else {
      // Display main menu on game over
      currentLevel.setIsBeingPlayed(false);
      menus[0].setIsActive(true);
    }
  }
  
  // Display leaderboard if it is active
  if (leaderboard.isActive()) {
    leaderboard.display();
    return;
  }
  
  // Display any active menu and handle user selection
  for (Menu menu : menus) {
    if (menu.isActive()) {
      menu.display();
      if (menu.isOptionSelected()) {
        handleMenuSelection(menu);
      }
    }
  }
}

// Resets player and levels and activates level 0
private void newGame() {
  players = new Player[1];
  players[0] = new Player();
  currentPlayer = 0;
  levels = getLevels();
  levels[0].setIsBeingPlayed(true);
}

// Gets number of players (between 2 and 4) from user and sets up players and levels. Sets current player to player 0 and activates level 0
private void newTournament() {
  int numberOfPlayers = 0;
  while (numberOfPlayers < 2 || numberOfPlayers > 4) {
    String numberOfPlayersStr = JOptionPane.showInputDialog("How many players are participating in the challenge? (Enter a number between 2 and 4 inclusive)");
    if (numberOfPlayersStr == null) {
      newTournament();
      return;
    }
    numberOfPlayers = parseInt(numberOfPlayersStr);
  }
  players = new Player[numberOfPlayers];
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(i);
  }
  currentPlayer = 0;
  levels = getLevels();
  levels[0].setIsBeingPlayed(true);
}

// Updates various states and calls methods based on what the user has selected in a menu
private void handleMenuSelection(Menu menu) {
  String optionSelected = menu.getOptionSelected();
  if (optionSelected == "Exit Game") {
    exit();
  } else if (optionSelected == "New Game") {
    menu.setIsActive(false);
    newGame();
  } else if (optionSelected == "Continue") {
    menu.setIsActive(false);
    Level currentLevel = levels[players[currentPlayer].getCurrentLevel()];
    currentLevel.setIsBeingPlayed(true);
    currentLevel.setIsPaused(true);
  } else if (optionSelected == "Leaderboard") {
    leaderboard.setIsActive(true);
  } else if (optionSelected == "New Tournament") {
    menu.setIsActive(false);
    newTournament();
  }
  menu.setIsOptionSelected(false);
}

/*
Routes keyPressed() message to appropriate object given game state.
Also converts upper case letters to lower and quits game if escape is pressed
*/
void keyPressed() {
  if (Character.isUpperCase(key)) {
    key = Character.toLowerCase(key);
  }
  if (key == ESC) {
    exit();
  }
  Level currentLevel = levels[players[currentPlayer].getCurrentLevel()];
  if (currentLevel.isBeingPlayed()) {
    currentLevel.keyPressed();
  } else if (leaderboard.isActive()) {
    leaderboard.keyPressed();
  } else {
    for (Menu menu : menus) {
      if (menu.isActive()) {
        menu.keyPressed();
      }
    }
  }
}

// Routes keyReleased() message to appropriate object given game state. Also converts upper case letters to lower
void keyReleased() {
  if (Character.isUpperCase(key)) {
    key = Character.toLowerCase(key);
  }
  int currentLevel = players[currentPlayer].getCurrentLevel();
  if (levels[currentLevel].isBeingPlayed()) {
    levels[currentLevel].keyReleased();
  }
}

// Updates various states and calls methods based on the power-ups collected
private void handlePowerUps(String powerUps) {
  for (int i = 0; i < powerUps.length(); i++) {
    char type = powerUps.charAt(i);
    if (type == 'C') {
      players[currentPlayer].addCoin();
    } else if (type == 'G') {
      Level level = levels[players[currentPlayer].getCurrentLevel()];
      level.invertGravity();
    } else if (type == 'L') {
      players[currentPlayer].incrementNumberOfLives();
    } else if (type == 'E') {
      Level levelCompleted = levels[players[currentPlayer].getCurrentLevel()];
      players[currentPlayer].incrementCurrentLevel();

      // If the final player has completed the level
      if (currentPlayer == players.length - 1) {
        levelCompleted.setIsBeingPlayed(false); //<>// //<>//
        currentPlayer = 0;
        
        // If the level completed was the final level
        if (players[currentPlayer].getCurrentLevel() == levels.length) {
          for (Player player : players) {
            player.setCurrentLevel(0);
            leaderboard.addEntry(player.getName(), player.getScore());
          }
          menus[0].setIsActive(true);
          leaderboard.setIsActive(true);
          return;
        }
        
        Level nextLevel = levels[players[currentPlayer].getCurrentLevel()];
        nextLevel.setIsBeingPlayed(true);
        
        // If there are remaining players waiting to play this level
      } else {
        levelCompleted.reset();
        currentPlayer++;
      }
    }
  }
}
