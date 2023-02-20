import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobigic_test/routes/route_names.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RouteNames.rowColumn);
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/splash/logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
