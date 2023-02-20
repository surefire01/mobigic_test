import 'package:flutter/material.dart';
import 'package:mobigic_test/models/grid_component.dart';
import 'package:mobigic_test/services/grid_processing_service.dart';

class GridProvider with ChangeNotifier {
  GridProvider(this.service);
  final GridProcessingService service;

  List<int> foundList = [];

  void searchWord(
      List<List<String>> strGrid, String word, List<GridComponent> comList) {
    service.cleanPrevious(foundList, comList);

    foundList = service.searchWord(strGrid, word, comList);

    //print(foundList);

    for (int index in foundList) {
      comList[index].found = true;
    }

    notifyListeners();
  }
}
