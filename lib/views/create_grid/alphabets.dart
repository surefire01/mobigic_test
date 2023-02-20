import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/providers/grid_provider.dart';
import 'package:mobigic_test/routes/route_names.dart';
import 'package:provider/provider.dart';

class Alphabets extends StatelessWidget {
  Alphabets({super.key, required this.row, required this.col});

  final int row;
  final int col;
  final aplabetsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final gridProvider = Provider.of<GridProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Grid"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "abc",
                style: TextStyle(fontSize: 80, color: Colors.blueAccent),
              ),
              Text(
                "Enter ${row * col} Alphabets to fill the grid",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: TextFormField(
                  maxLength: row * col,
                  maxLines: row * col < 30 ? 1 : row * col ~/ 30,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-z]"))
                  ],
                  controller: aplabetsController,
                  decoration: const InputDecoration(
                      label: Text("Enter Alphabets"),
                      helperText: "only lowercase alphabets"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the alphabets";
                    } else if (value.contains(" ")) {
                      return "avoid blank spaces";
                    } else if (value.length != row * col) {
                      return "please enter ${row * col} alphabets";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      final grid = gridProvider.service
                          .getGridFormString(aplabetsController.text, row, col);

                      final comList = gridProvider.service
                          .getGridComponentList(aplabetsController.text);

                      Navigator.pushNamed(context, RouteNames.searchWord,
                          arguments: {
                            'strGrid': grid,
                            'comList': comList,
                            'col': col,
                          });
                    }
                  },
                  child: const Text(
                    "Create Grid",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
