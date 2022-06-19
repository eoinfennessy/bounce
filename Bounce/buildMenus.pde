/* 
Available Menu Options:
      - New Game
      - New Tournament
      - Exit Game
      - Continue - Only usable when a game is actively being played
      - Leaderboard
*/

private void buildMenus() {
  int numberOfMenus = 2;
  menus = new Menu[numberOfMenus];
  
  // ============ Main Menu ============
  
  String[] mainMenuOptions = {"New Game", "New Tournament", "Leaderboard", "Exit Game"};
  menus[0] = new Menu(mainMenuOptions, true);
  
  // ============ Pause Menu ============
  
  String[] pauseMenuOptions = {"Continue", "New Game", "Leaderboard", "Exit Game"};
  menus[1] = new Menu(pauseMenuOptions);
}
