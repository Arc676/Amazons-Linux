# Game of the Amazons

A frontend for Game of the Amazons using the [Amazons library](https://github.com/Arc676/Amazons) for Ubuntu Touch. Inspired by [this Numberphile video](https://www.youtube.com/watch?v=kjSOSeRZVNg).

## Rules

Two players move Amazons on a board. The Amazons can move any number of squares in any direction, like queens in chess. After moving, Amazons must shoot an arrow (or, in this implementation, a spear). The arrow can also move in any direction. Amazons and arrows cannot move across squares that are already occupied by another Amazon or arrow. The last player able to make a legal move wins. Equivalently, the first player unable to make a legal move loses.

The standard initial configuration is a 10x10 board, but the game can be set up with any starting configuration. Players can control any number of Amazons and the board can be of any size.

## Controls

Player 1's Amazons are represented as bows. Player 2's Amazons are represented as spears. The first move is always made by Player 1.

To make a move, three squares need to be tapped in order:
1) The Amazon to move (highlighted in green)
2) The destination square (highlighted in red)
3) The square to which to shoot the arrow (will not be highlighted; the turn will be passed to the other player)

You can tap the undo button in the menu bar before shooting the arrow to undo your selection(s) and pick different squares. At each of the above steps, the following selections are invalid and will have no effect:
1) Clicking a square that is not currently occupied by an Amazon controlled by the current player
2) Clicking a square to which the selected Amazon cannot move
3) Clicking a square to which the selected Amazon cannot shoot an arrow/spear from the destination square

### Custom configurations

You can start a game with an arbitrary initial configuration. Specify the number of Amazons to be controlled by each player and the board size. Once the board has been resized (if necessary) and cleared, tap the initial starting positions of the Amazons one at a time. Specify the starting positions for Player 1 first.

## Licensing

Project available under GPLv3. See `LICENSE` for full license text. Application icon and sprites available under CC BY-NC-SA 4.0, adapted from [CC0 assets by rcorre](https://opengameart.org/content/rpg-itemterraincharacter-sprites-ice-insignia). See `CREDITS` for more details.
