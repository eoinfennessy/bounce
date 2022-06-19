private Level[] getLevels() {
  int numberOfLevels = 4;
  Level[] levels = new Level[numberOfLevels];
  
  /* Character representations:
         b - Land
         s - Spike up
         d - Spike down
         p - Springboard
         C - Coin
         L - Life
         E - End of level
         G - Gravity invert
  */
  
  // ************ Level 0 ************
  
  String[] level0Representation = {
  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                             ssssssssss                                                                          b",
  "b                                                                                                             dddddddddd                                                                          b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                                   C                                                             b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                                                G             C          C                                                       b",
  "b                                                                                        L     C     C     C                                                                                      b",
  "b                                                                                                                                                                                                 b",
  "b                                                                                      bbbbbbbbbbbbbbbbbbbbbbb                     sss                                                            b",
  "b                                                                                                                          C       bbb       C                                                    b",
  "b                                                                                                                                  bbb                                                            b",
  "b                                      C                                                                                           bbb                                                            b",
  "b                                                                                                                                  bbb                                                            b",
  "b                                                                                                                                  bbb                                                            b",
  "b                                                                                                                          C       bbb       C                                                    b",
  "b              C                  C         C                        C                        G                                    bbb                                                            b",
  "b                                                                  C   C                                                           bbb                                                            b",
  "b              b                bbbbb     bbbbb                                        bbbbbbbbb                                   bbb                                                            b",
  "b              b                                                                                                           C       bbb       C                                                    b",
  "b              b                                                                                                                   bbb                                                            b",
  "b              b                                                                                                                   bbb                                      C       C         E   b",
  "b              b                                                                                                                   bbb                                                            b",
  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbsssssssssbbbbbbbbbbbbbsssssssssssssssssssssssbbbbbbbbbbbbpppbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  };
  
  Tile[][] level0Terrain = getTerrain(level0Representation);
  
  PowerUp[][] level0PowerUps = getPowerUps(level0Representation);
  
  Ball level0Ball = new Ball(190, 900, 50);
  
  EnemyBall[] level0EnemyBalls = new EnemyBall[2];
  
  level0EnemyBalls[0] = new EnemyBall(6100, 1000, 50, new Vector(0, 0));
  level0EnemyBalls[1] = new EnemyBall(6900, 1100, 50, new Vector(-3, 0));
  
  levels[0] = new Level(level0Terrain, level0Ball, level0PowerUps, level0EnemyBalls);
  
  // ************ Level 1 ************
  
  String[] level1Representation = {
  "bdddddddddddddddddddddddddddddbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  "b                                               bbbbbbb          bb           b",
  "b                                            G  bbbbbbb          bb           b",
  "b                                               bbbbbbb          bb           b",
  "b                                               bbbbbbb          bb           b",
  "b      bbbbb             bbbbb       bbbbbb     bbbbbbb          dd           b",
  "b                                         b     bbbbbbb                       b",
  "b        L                                b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                                         b           b                       b",
  "b                           C             bbbbbbb     b                       b",
  "b                               C               b     b                       b",
  "b                                   C           b     b                       b",
  "b                   C         bbbbb    C        b     b                       b",
  "b                       C                C      b     b                       b",
  "b                                               b     b                       b",
  "b                     bbbbb                     b     b          ss           b",
  "b               C                          C    b     b          bb           b",
  "b                                               b     b          bb           b",
  "b             bbbbb                        G    b     b          bb           b",
  "b          C  b                                 b     b          bb           b",
  "b             b                                 b     b          bb           b",
  "b        bbbbbb                                 b     b          bb           b",
  "b                                               b     b          bb           b",
  "b                                               b                bb           b",
  "b                                               b                bb     E     b",
  "b                                               b                bb           b",
  "bbbbbbbbbbbbbbssssssssssssssssssssssssssssssssssbbbbbbbbbbbbbpppbbbbbbbbbbbbbbb"
  };
  
  Tile[][] level1Terrain = getTerrain(level1Representation);
  
  PowerUp[][] level1PowerUps = getPowerUps(level1Representation);
  
  Ball level1Ball = new Ball(190, 550, 50);
  
  levels[1] = new Level(level1Terrain, level1Ball, level1PowerUps);
  
  // ************ Level 2 ************
  
  String[] level2Representation = {
  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  "b                                               b",
  "b                                               b",
  "b            C  C  C                            b",
  "b                                               b",
  "b          bbbbbbbbbbb               ddddd      b",
  "b                       G                       b",
  "b                                      L        b",
  "b                                      G        b",
  "b                                               b",
  "b                           C              bbbbbb",
  "b                               C               b",
  "b                                    C          b",
  "b                   C         bbbbbb    C       b",
  "b                       C                 C     b",
  "b                               C               b",
  "b               C     bbbbb                     b",
  "b                                           C   b",
  "b             bbbbb     C                       b",
  "b          C  b                                 b",
  "b             b                              G  b",
  "b        bbbbbb C                               b",
  "b        b                                      b",
  "b        b                                      b",
  "b        b  G                         bbbbbbbbbbb",
  "b        b                            b         b",
  "b        b                            b    E    b",
  "b        b     bssssssssssssssssssssssb         b",
  "b        b  C  bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "b        b     bbbbbbbbbbbbbbbbbbbbbbbb    C    b",
  "b        b     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbpppbbb  C  bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb  C  bbbbbbbbbbbbbbbbbbbbbbbb    C    b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb  C  bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb    C    b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb  C  bbbbbbbbbbbbbbbbbbbbbbbb         b",
  "bbbbbbbbbb     bbbbbbbbbbbbbbbbbbbbbbbb    C    b",
  "bbbbbbbbbb                                      b",
  "bbbbbbbbbb  C                              C    b",
  "bbbbbbbbbb                                      b",
  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbpppbbbb"
  };
  
  
  
  Tile[][] level2Terrain = getTerrain(level2Representation);
  
  PowerUp[][] level2PowerUps = getPowerUps(level2Representation);
  
  Ball level2Ball = new Ball(250, 700, 50);
  
  levels[2] = new Level(level2Terrain, level2Ball, level2PowerUps);
  
  // ************ Level 3 ************
  
  String[] level3Representation = {
  "bdddddddddddddddddddddddddddddddddddddddbddddddddddddddddddddddddddddddddddddb",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b        C                           b",
  "b                                       b                                    b",
  "b                                       b                                    b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b    C   b   C                       b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b    C   b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b        b                           b",
  "b                                       b    C   b                           b",
  "b              C        C               b        b                           b",
  "b                                 G     b        b                           b",
  "b          bbbbbbbb    bbb   bbb        b        b                           b",
  "b                                       b        b                           b",
  "b              C        C     C       C b    C   b                           b",
  "b                                       b        b                           b",
  "b                                   bbbbb        b                           b",
  "b                                   ddddd        b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b                                                b                           b",
  "b       C                                    C   b                           b",
  "b                                                b                           b",
  "b     bbbbbb         C                           b                           b",
  "b                                            C   b                           b",
  "b                  bbbbbb     C                  b                           b",
  "b                                            C   b                        E  b",
  "b                           bbbbbb               b                           b",
  "b                                        bbpppppbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  "b                                                                            b",
  "b                                                                            b",
  "b                                                                            b",
  "b                                                                            b",
  "b                                                                            b",
  "b                                                                            b",
  "b                                                                            b",
  "b               G              C                                             b",
  "b                                                                            b",
  "b            bbbbbbb        bbbbbbb  G                                       b",
  "b                                              bbbbb                         b",
  "b                                              bLLLb                         b",
  "b                                      C       bLLLb                         b",
  "b            G                                 bLLLb                         b",
  "b                                    bbbbb     bbbbb                         b",
  "b                                                                            b",
  "b                       C                                           L        b",
  "b                                                                            b",
  "b                                                                 pppppp     b",
  "b                                                                            b",
  "b  bbbbb                                                                     b",
  "b                                                                            b",
  "bssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssb"
    };
  
  
  
  Tile[][] level3Terrain = getTerrain(level3Representation);
  
  PowerUp[][] level3PowerUps = getPowerUps(level3Representation);
  
  Ball level3Ball = new Ball(190, 550, 50);
  
  EnemyBall[] level3EnemyBalls = new EnemyBall[3];
  
  level3EnemyBalls[0] = new EnemyBall(2450, 1000, 50, new Vector(0, 0));
  level3EnemyBalls[1] = new EnemyBall(2600, 1200, 50, new Vector(0, 0));
  level3EnemyBalls[2] = new EnemyBall(2750, 1400, 50, new Vector(0, 0));
  
  levels[3] = new Level(level3Terrain, level3Ball, level3PowerUps, level3EnemyBalls);
  
  return levels;
}

private Tile[][] getTerrain(String[] levelRepresentation) {
  Tile[][] terrain = new Tile[levelRepresentation.length][levelRepresentation[0].length()];
  for (int row = 0; row < terrain.length; row++) {
    for (int col = 0; col < terrain[row].length; col++) {
      if (Character.isLowerCase(levelRepresentation[row].charAt(col))) {
        terrain[row][col] = new Tile(tileSize * col, tileSize * row, tileSize, levelRepresentation[row].charAt(col));
      }
    }
  }
  return terrain;
}

private PowerUp[][] getPowerUps(String[] levelRepresentation) {
  PowerUp[][] powerUps = new PowerUp[levelRepresentation.length][levelRepresentation[0].length()];
  for (int row = 0; row < powerUps.length; row++) {
    for (int col = 0; col < powerUps[row].length; col++) {
      if (Character.isUpperCase(levelRepresentation[row].charAt(col))) {
        powerUps[row][col] = new PowerUp(tileSize * col, tileSize * row, 40, levelRepresentation[row].charAt(col));
      }
    }
  }
  return powerUps;
}
