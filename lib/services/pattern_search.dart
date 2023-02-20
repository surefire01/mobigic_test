class PatterSearchService {
  final List<int> _x = [0, 1, 1];
  final List<int> _y = [1, 1, 0];

  List<List<int>> _search2D(
      List<List<int>> grid, int row, int col, String word, int rMax, int cMax) {
    List<List<int>> toReturn = [];
    if (grid[row][col] != word.codeUnitAt(0)) {
      return [];
    }

    int len = word.length;
    for (int dir = 0; dir < 3; dir++) {
      List<List<int>> temp = [];
      temp.add([row, col]);
      int k;
      int rd = (row + _x[dir]);
      int cd = (col + _y[dir]);

      for ((k = 1); k < len; k++) {
        if ((((rd >= rMax) || (rd < 0)) || (cd >= cMax)) || (cd < 0)) {
          temp.clear();
          break;
        }
        if (grid[rd][cd] != word.codeUnitAt(k)) {
          temp.clear();
          break;
        }
        temp.add([rd, cd]);
        rd += _x[dir];
        cd += _y[dir];
      }
      if (k == len) {
        toReturn.addAll(temp);
      }
    }
    return toReturn;
  }

  List<List<int>> patternSearch(List<List<String>> strGrid, String word) {
    final grid =
        strGrid.map((e) => e.map((c) => c.codeUnitAt(0)).toList()).toList();

    List<List<int>> toReturn = [];

    int rMax = grid.length;
    int cMax = grid[0].length;
    for (int row = 0; row < rMax; row++) {
      for (int col = 0; col < cMax; col++) {
        if ((grid[row][col] == word.codeUnitAt(0))) {
          final res = _search2D(grid, row, col, word, rMax, cMax);
          toReturn.addAll(res);
        }
      }
    }

    return toReturn;
  }

  // void main(List<String> args) {
  //   List<List<int>> grid = [
  //     [
  //       'G'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'K'.codeUnitAt(0),
  //       'S'.codeUnitAt(0),
  //       'F'.codeUnitAt(0),
  //       'O'.codeUnitAt(0),
  //       'R'.codeUnitAt(0),
  //       'G'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'K'.codeUnitAt(0),
  //       'S'.codeUnitAt(0)
  //     ],
  //     [
  //       'G'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'K'.codeUnitAt(0),
  //       'S'.codeUnitAt(0),
  //       'Q'.codeUnitAt(0),
  //       'U'.codeUnitAt(0),
  //       'I'.codeUnitAt(0),
  //       'Z'.codeUnitAt(0),
  //       'G'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'K'.codeUnitAt(0)
  //     ],
  //     [
  //       'I'.codeUnitAt(0),
  //       'D'.codeUnitAt(0),
  //       'E'.codeUnitAt(0),
  //       'Q'.codeUnitAt(0),
  //       'A'.codeUnitAt(0),
  //       'P'.codeUnitAt(0),
  //       'R'.codeUnitAt(0),
  //       'A'.codeUnitAt(0),
  //       'C'.codeUnitAt(0),
  //       'T'.codeUnitAt(0),
  //       'I'.codeUnitAt(0),
  //       'C'.codeUnitAt(0),
  //       'E'.codeUnitAt(0)
  //     ]
  //   ];
  //patternSearch(grid, "GEEKS");
  //System.out.println();
  //patternSearch(grid, "EEE");
  // }
}
