import 'package:flutter/material.dart';
import 'package:mobigic_test/models/grid_component.dart';
import 'package:mobigic_test/services/pattern_search.dart';

class GridProcessingService {
  final _patterSearchService = PatterSearchService();

  List<List<String>> getGridFormString(String str, int row, int col) {
    List<List<String>> toReturn = [];

    for (int i = 0; i < str.length - col + 1; i = i + col) {
      toReturn.add(str.substring(i, i + col).split(""));
    }
    return toReturn;
  }

  List<GridComponent> getGridComponentList(String str) {
    return str.split("").map((e) => GridComponent(str: e)).toList();
  }

  List<Widget> createWidgetList(List<GridComponent> list) {
    return list
        .map(
          (e) => Container(
            decoration: BoxDecoration(
                color: e.found
                    ? Colors.green.withOpacity(0.35)
                    : Colors.orange.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                e.str,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        )
        .toList();
  }

  List<int> _gridIndexToListIndex(List<List<int>> result, int row, int col) {
    List<int> toReturn = [];
    for (List<int> e in result) {
      toReturn.add(e[0] * col + e[1]);
    }
    return toReturn;
  }

  void cleanPrevious(List<int> prevRes, List<GridComponent> comList) {
    for (int index in prevRes) {
      if (index >= comList.length) {
        continue;
      }
      comList[index].found = false;
    }

    prevRes = [];
  }

  List<int> searchWord(
      List<List<String>> strGrid, String word, List<GridComponent> comList) {
    // to clean previous seaech results

    final res = _patterSearchService.patternSearch(strGrid, word);

    //print(strGrid);

    return _gridIndexToListIndex(res, strGrid.length, strGrid[0].length);
  }
}
