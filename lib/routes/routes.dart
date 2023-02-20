import 'package:flutter/material.dart';
import 'package:mobigic_test/routes/route_names.dart';
import 'package:mobigic_test/views/create_grid/alphabets.dart';
import 'package:mobigic_test/views/create_grid/row_column.dart';
import 'package:mobigic_test/views/search_word/search_word.dart';

class AppRoutes {
  static final routes = {
    RouteNames.rowColumn: (_) => RowColumn(),
  };

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    final errorOccuredRoute = MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            "Error occured",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );

    switch (name) {
      // for alphabets
      case RouteNames.alphabets:
        try {
          final map = args as Map;
          return MaterialPageRoute(
            builder: (context) => Alphabets(row: map['row'], col: map['col']),
          );
        } catch (e) {
          return errorOccuredRoute;
        }

      case RouteNames.searchWord:
        try {
          final map = args as Map;
          return MaterialPageRoute(
            builder: (context) => SearchWord(
              strGrid: map['strGrid'],
              col: map['col'],
              comList: map['comList'],
            ),
          );
        } catch (e) {
          return errorOccuredRoute;
        }

      default:
        return errorOccuredRoute;
    }
  }

  //
}
