import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/routes/route_names.dart';

class RowColumn extends StatelessWidget {
  RowColumn({super.key});

  final rowController = TextEditingController();
  final colController = TextEditingController();
  final scaleFactor = 0.4;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Grid"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                Icons.grid_3x3,
                size: 90,
                color: Colors.blueAccent,
              ),
              const Text(
                "Enter number of Columns and rows for the grid",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    XYTextField(
                      controller: rowController,
                      width: size.width * scaleFactor,
                      label: "Rows",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter number of rows";
                        } else if (int.parse(value) > 10) {
                          return "max is 10";
                        } else if (int.parse(value) < 1) {
                          return "min is 1";
                        }
                        return null;
                      },
                    ),
                    XYTextField(
                      controller: colController,
                      width: size.width * scaleFactor,
                      label: "Columns",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter number of columns";
                        } else if (int.parse(value) > 10) {
                          return "max is 10";
                        } else if (int.parse(value) < 1) {
                          return "min is 1";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                        context,
                        RouteNames.alphabets,
                        arguments: {
                          'row': int.parse(rowController.text),
                          'col': int.parse(colController.text),
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Next",
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

class XYTextField extends StatelessWidget {
  const XYTextField(
      {super.key,
      required this.controller,
      required this.width,
      required this.label,
      required this.validator});

  final double width;
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) => validator(value),
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          helperText: "max 10",
          label: Text(label),
        ),
      ),
    );
  }
}
