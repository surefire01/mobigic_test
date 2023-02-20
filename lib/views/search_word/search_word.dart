import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/models/grid_component.dart';
import 'package:mobigic_test/providers/grid_provider.dart';
import 'package:mobigic_test/routes/route_names.dart';
import 'package:provider/provider.dart';

class SearchWord extends StatelessWidget {
  SearchWord(
      {super.key,
      required this.strGrid,
      required this.comList,
      required this.col});

  final List<List<String>> strGrid;
  final List<GridComponent> comList;
  final int col;
  final searchWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final gridProvider = Provider.of<GridProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Word"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(RouteNames.rowColumn));
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: const Text(
              "Reset",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Enter Word to Search",
                style: TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                        ],
                        controller: searchWordController,
                        decoration:
                            const InputDecoration(label: Text("Enter Word")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter the alphabets";
                          } else if (value.contains(" ")) {
                            return "avoid blank spaces";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            gridProvider.searchWord(
                                strGrid, searchWordController.text, comList);

                            if (gridProvider.foundList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    "No such sequence in the grid",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("Search"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: col * MediaQuery.of(context).size.width * 0.1,
                child: GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: col,
                  children: gridProvider.service.createWidgetList(comList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
