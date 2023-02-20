import 'package:flutter/material.dart';
import 'package:mobigic_test/providers/grid_provider.dart';
import 'package:mobigic_test/routes/routes.dart';
import 'package:mobigic_test/services/grid_processing_service.dart';
import 'package:mobigic_test/theme/theme.dart';
import 'package:mobigic_test/views/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GridProvider>(
      create: (context) => GridProvider(GridProcessingService()),
      builder: (context, child) {
        return MaterialApp(
          title: 'Mobigic Test',
          routes: AppRoutes.routes,
          onGenerateRoute: (settings) => AppRoutes.onGenerateRoutes(settings),
          theme: AppTheme.theme,
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          // ),
          home: const Splash(),
        );
      },
    );
  }
}
